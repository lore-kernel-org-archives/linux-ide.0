From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: sata_nv and smartctl -o/-S trigger HSM violation (2.6.21.1, 2.6.20)
Date: Mon, 30 Apr 2007 17:12:33 -0700
Message-ID: <20070501001233.GE7846@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="POjlveFHrWq2ZO+N"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:38663 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422894AbXEAAMc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Apr 2007 20:12:32 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--POjlveFHrWq2ZO+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was working with integrating SMART status into my Nagios checks, and ran =
into
some sata_nv weirdness on two different machines (Tyan S2865 and S2927).
Each machine has a pair of matching disks.

On the latter, it's also occasionally lost the disks and hard-locked the bo=
x if
smartd did the '-S on' on both disks at the same time.

This happens if '-S on' or '-o on' is passed to smartctl/smartd.

Box #1 (2.6.21.1):

a02# smartctl -d ata -S on /dev/sda
=2E..
Model Family:     Seagate NL35 family
Device Model:     ST3250623NS
Serial Number:    5ND29YBT
Firmware Version: 5.01
=2E..

=46rom dmesg:
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 123392 =
in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 123392 =
in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 123392 =
in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
sda: Write Protect is off
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 123392 =
in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
sda: Mode Sense: 00 3a 00 00
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 123392 =
in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 123392 =
in
         res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA

Box #2 (2.6.20):
b01# smartctl -d ata -S on /dev/sda
=2E..
Device Model:     ST3250620NS
Serial Number:    5QE1N0ZD
Firmware Version: 3.AEE
=2E..

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 126976 =
in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 126976 =
in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 126976 =
in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 126976 =
in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 126976 =
in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 126976 =
in
         res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--POjlveFHrWq2ZO+N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGNoXxPpIsIjIzwiwRAsdEAKDk4N5yo9d5kE8ayldRfVtMIyA+aQCgxIFf
EVGhwU901T6/cnNSgcmpUho=
=gvlr
-----END PGP SIGNATURE-----

--POjlveFHrWq2ZO+N--
