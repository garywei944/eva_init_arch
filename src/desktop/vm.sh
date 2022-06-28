#!/usr/bin/env bash

_virtualbox() {
  _pacin virtualbox virtualbox-host-modules-arch
}

_vagrant() {
  _pacin vagrant
}

_vmware() {
  _yain vmware-workstation
}
