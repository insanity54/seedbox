#!/bin/bash


IPT=/sbin/iptables


# flush all rules
$IPT -F


# policies
$IPT -P OUTPUT ACCEPT
$IPT -P INPUT DROP
$IPT -P FORWARD DROP


# allowed inputs
$IPT -A INPUT --in-interface lo -j ACCEPT
$IPT -A INPUT -p udp --dport 62958 -j ACCEPT # allow deluged
$IPT -A INPUT -p tcp --dport 62958 -j ACCEPT # allow deluged
$IPT -A INPUT -p tcp --dport 22 -j ACCEPT # allow SSH


# allow responses
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

