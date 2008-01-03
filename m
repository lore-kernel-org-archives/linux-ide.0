From: Paul Neuwirth <mail@paul-neuwirth.de>
Subject: sata_sil[24] / silicon image binary drivers / SiI4726 RAID
Date: Thu, 3 Jan 2008 14:10:49 +0100
Message-ID: <20080103141049.5c7534c8@pane.pane>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cuaAyw6r+SjvheOFb3NsQz/";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server5.northern-solutions.de ([85.10.207.69]:55772 "EHLO
	server5.northern-solutions.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750790AbYACNlf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 08:41:35 -0500
Received: from pane.pane (pD95491AF.dip0.t-ipconnect.de [217.84.145.175])
	by server5.northern-solutions.de (Postfix) with ESMTP id 250AF7911FA
	for <linux-ide@vger.kernel.org>; Thu,  3 Jan 2008 14:11:04 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

--Sig_/cuaAyw6r+SjvheOFb3NsQz/
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hallo,
i hope I am here at the right address. I am using a Silicon Image 3124
SATA-Controller with the Silicon Image 4726 pm /
hardware-RAID product, using the sata_sil24 driver.
The pm is also a hardware raid-controller (not SATARAID - fake, see
docs on http://www.siliconimage.com/products/product.aspx?id=3D74).
For the configuration of hardware raid, you can download a software
from the sii website (SiI4726 Manager). But this software only seems to
work with the precompiled proprietary drivers from sii (e.g.
sii3124.ko), i think there are unimplemented specific commands in the
sil_sata(24) drivers.
Isn't it possible to make a opensource way to configure the hardware
raid controller or make the sil_sata(24) driver be usable with the
sii's RAID manager? (If the hardware would be needed therefor i could
provide)
The binary drivers from sii for their controllers are unfortunately only
available for a very low number of kernels (e.g. suse enterprise, RHEL
kernels, see
http://www.siliconimage.com/support/supportsearchresults.aspx?pid=3D27&cid=
=3D3&ctid=3D2&osid=3D1&).=20
I don't know whom to contact at sii to get specifications or (more
improbably) a suiting driver... Nor am I an kernel programmer...
I only know following:
-for the configuration a "config disk" is provided by the pm (hwinfo is
below)
-the sii configuration manager recognizes all SATA-disks, but doesn't
detect serial numbers or the config disk.

Thanks for advice and help,
Paul Neuwirth


hwinfo
[disk]
IDE 250.0: 10600 Disk
  [Created at block.233]
  UDI: /org/freedesktop/Hal/devices/storage_serial_SATA_Config_Disk_0000000=
_0703517__5_0
  Unique ID: by2M.OswvJFVubC7
  Parent ID: qnJ_.+pLfg7up4B3
  SysFS ID: /block/sde
  SysFS BusID: 2:5:0:0
  SysFS Device
Link: /devices/pci0000:00/0000:00:0d.0/host2/target2:5:0/2:5:0:0
Hardware Class: disk Model: "Config Disk"
  Vendor: "Config"
  Device: "Disk"
  Revision: "PLS1"
  Serial ID: "0000000_0703517__5_0"
  Driver: "sata_sil24", "sd"
  Driver Modules: "sata_sil24"
  Device File: /dev/sde
  Device
Files: /dev/sde, /dev/disk/by-id/scsi-SATA_Config_Disk_0000000_0703517__5_0=
, /dev/disk/by-id/ata-Config_Disk_0000000_0703517__5_0, /dev/disk/by-path/p=
ci-0000:00:0d.0-scsi-2:5:0:0
Device Number: block 8:64-8:79 Geometry (Logical): CHS 0/255/63
  Size: 640 sectors a 512 bytes
  Config Status: cfg=3Dno, avail=3Dyes, need=3Dno, active=3Dunknown
  Attached to: #7 (RAID bus controller)
[pci]
PCI 0d.0: 0104 RAID bus controller
  [Created at pci.301]
  UDI: /org/freedesktop/Hal/devices/pci_1095_3124
  Unique ID: qnJ_.+pLfg7up4B3
  SysFS ID: /devices/pci0000:00/0000:00:0d.0
  SysFS BusID: 0000:00:0d.0
  Hardware Class: storage
  Model: "Silicon Image SiI 3124 PCI-X Serial ATA Controller"
  Vendor: pci 0x1095 "Silicon Image, Inc."
  Device: pci 0x3124 "SiI 3124 PCI-X Serial ATA Controller"
  SubVendor: pci 0x1095 "Silicon Image, Inc."
  SubDevice: pci 0x6124=20
  Revision: 0x02
  Driver: "sata_sil24"
  Driver Modules: "sata_sil24"
  Memory Range: 0xeb008000-0xeb00807f (rw,non-prefetchable)
  Memory Range: 0xeb000000-0xeb007fff (rw,non-prefetchable)
  I/O Ports: 0xb000-0xb00f (rw)
  Memory Range: 0x40000000-0x4007ffff (ro,prefetchable,disabled)
  IRQ: 16 (6136 events)
  Module Alias: "pci:v00001095d00003124sv00001095sd00006124bc01sc04i00"
  Driver Info #0:
    Driver Status: sata_sil24 is active
    Driver Activation Cmd: "modprobe sata_sil24"
  Config Status: cfg=3Dno, avail=3Dyes, need=3Dno, active=3Dunknown


--=20
Teraz mamy jeszcze lepszy spos=F3b by upewni=E6 si=EA, =BFe jeden uszkodzony
plik z danymi rozprzestrzeni si=EA na ca=B3=B1 sie=E6: nazywamy go OLE 2.0.

                    --- Bill Gates (mia=B3 powiedzie=E6)

--Sig_/cuaAyw6r+SjvheOFb3NsQz/
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQFHfN7mUzPtJrIXoaMRAkL8AKDSyBZpa73/GPINzjF0lW+IQ5wbSgCghuN8
YrJqE9MN/tyq0UGtOUqNVpc=
=xHvR
-----END PGP SIGNATURE-----

--Sig_/cuaAyw6r+SjvheOFb3NsQz/--
