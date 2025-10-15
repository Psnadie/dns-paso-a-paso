#!/bin/bash

echo "=== Iniciando configuración del servidor DNS ==="

# Actualizar repositorios
echo "Actualizando repositorios..."
apt-get update -qq

# Instalar BIND9 y utilidades
echo "Instalando BIND9 y utilidades..."
apt-get install -y bind9 bind9utils bind9-doc dnsutils

# Configurar BIND para usar solo IPv4
echo "Configurando BIND para IPv4..."
cp /vagrant/config/named /etc/default/named

# Copiar archivos de configuración de BIND
echo "Copiando archivos de configuración..."
cp /vagrant/config/named.conf.options /etc/bind/named.conf.options
cp /vagrant/config/named.conf.local /etc/bind/named.conf.local

# Crear directorio para archivos de zona si no existe
mkdir -p /var/lib/bind

# Copiar archivos de zona
echo "Copiando archivos de zona..."
cp /vagrant/config/nicolas.test.dns /var/lib/bind/nicolas.test.dns
cp /vagrant/config/nicolas.test.rev /var/lib/bind/nicolas.test.rev

# Establecer permisos correctos
echo "Estableciendo permisos..."
chown bind:bind /var/lib/bind/nicolas.test.dns
chown bind:bind /var/lib/bind/nicolas.test.rev
chmod 644 /var/lib/bind/nicolas.test.dns
chmod 644 /var/lib/bind/nicolas.test.rev

# Verificar configuración
echo "Verificando configuración..."
named-checkconf /etc/bind/named.conf.options
named-checkzone nicolas.test /var/lib/bind/nicolas.test.dns
named-checkzone 57.168.192.in-addr.arpa /var/lib/bind/nicolas.test.rev

# Reiniciar y habilitar el servicio
echo "Reiniciando servicio BIND9..."
systemctl restart named
systemctl enable named

# Verificar estado del servicio
echo "Estado del servicio:"
systemctl status named --no-pager

echo "=== Configuración completada ==="
echo "Servidor DNS escuchando en 192.168.57.10"
echo "Zona configurada: nicolas.test"