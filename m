From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: sata_sil24 performance weirdness
Date: Wed, 27 Dec 2006 05:45:03 -0800
Message-ID: <20061227134503.GD28939@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.isohunt.com ([69.64.61.20]:51104 "EHLO mail.isohunt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932819AbWL0Nve (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Dec 2006 08:51:34 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I forward-ported Tejun's PMP patches to libata#upstream (my first attempt a=
t it
a few weeks ago failed, but this round works fine, tested at each branch
stage), and in using them, I have noticed a bit of oddity.

While dmesg claims that 3.0Gbps was negotiated, the combined performance of=
 the
5 disks never exceeds 1.5Gbps, no matter how I combine them. Is something in
the driver overriding the 3Gbps speed bits somewhere?

My SATA enclosure the 5-disk Fusion 500P from Sonnet (PMP 0x1095:0x3726)

Controller:
Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Co=
ntroller (rev 01)

Drives:
5x Seagate ST3320620AS (7200.10 320Gbyte)

ata9: SATA max UDMA/133 cmd 0xFFFFC20000070000 ctl 0x0 bmdma 0x0 irq 18
ata10: SATA max UDMA/133 cmd 0xFFFFC20000072000 ctl 0x0 bmdma 0x0 irq 18
scsi10 : sata_sil24
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
ata9.00: hard resetting port
ata9.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.01: hard resetting port
ata9.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.02: hard resetting port
ata9.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.03: hard resetting port
ata9.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.04: hard resetting port
ata9.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata9.00: configured for UDMA/133
ata9.01: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata9.01: configured for UDMA/133
ata9.02: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata9.02: configured for UDMA/133
ata9.03: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata9.03: configured for UDMA/133
ata9.04: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata9.04: configured for UDMA/133
ata9: EH complete
scsi11 : sata_sil24
ata10: SATA link down (SStatus 0 SControl 300)
scsi 10:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI:=
 5
SCSI device sdi: 625142448 512-byte hdwr sectors (320073 MB)
sdi: Write Protect is off
sdi: Mode Sense: 00 3a 00 00
(rest of the disks sdi-> sdm all brought up in an identical fashion here).

--=20
Robin Hugh Johnson
Gentoo Linux Developer
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFknjfPpIsIjIzwiwRAvzlAKDq5QEC85tMuKSQ7y6f/69sUWWx7QCg+R5O
WHfOnPohNKnLP1weSGnvZG4=
=akKI
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
