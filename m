From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: sata_sil24 startup weirdness - long times to start up all PMP sub-links
Date: Thu, 28 Dec 2006 03:41:39 -0800
Message-ID: <20061228114139.GJ28939@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.isohunt.com ([69.64.61.20]:55588 "EHLO mail.isohunt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbWL1Llb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Dec 2006 06:41:31 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Another sata_sil24 issue I noticed, this time in the start up of the PMP, w=
hen
the enclosure was powered off, and turned on after the driver was already
loaded.

Synopsis:
When starting many links on a PMP unit, there is an excessive delay.
Startup sequence is (Port0),(Port0,1),(Port0,1,2),(Port0,1,2,3),(Port0,1,2,=
3,4)

This takes a total of ~25 seconds on my machine.

(At this point, I turn the enclosure on. No devices were detected prior to
this).
ata7: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x42 frozen
ata7: (irq_stat 0x00b00090, PHY RDY changed)
ata7: waiting for device to spin up (8 secs)
ata7: soft resetting port
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
ata7.00: hard resetting port
ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.01: hard resetting port
ata7.01: softreset failed (SRST command error)
ata7.01: follow-up softreset failed, retrying in 5 secs
ata7.01: hard resetting port
ata7.01: hardreset failed (port not ready)
ata7.01: reset failed, giving up
ata7.15: hard resetting port
ata7: controller in dubious state, performing PORT_RST
ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata7.00: hard resetting port
ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.01: hard resetting port
ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.02: hard resetting port
ata7.02: softreset failed (SRST command error)
ata7.02: follow-up softreset failed, retrying in 5 secs
ata7.02: hard resetting port
ata7.02: hardreset failed (port not ready)
ata7.02: reset failed, giving up
ata7.15: hard resetting port
ata7: controller in dubious state, performing PORT_RST
ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata7.00: hard resetting port
ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.01: hard resetting port
ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.02: hard resetting port
ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.03: hard resetting port
ata7.03: softreset failed (SRST command error)
ata7.03: follow-up softreset failed, retrying in 5 secs
ata7.03: hard resetting port
ata7.03: COMRESET failed (errno=3D-5)
ata7.03: reset failed, giving up
ata7.15: hard resetting port
ata7: controller in dubious state, performing PORT_RST
ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata7.00: hard resetting port
ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.01: hard resetting port
ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.02: hard resetting port
ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.03: hard resetting port
ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.04: hard resetting port
ata7.04: softreset failed (SRST command error)
ata7.04: follow-up softreset failed, retrying in 5 secs
ata7.04: hard resetting port
ata7.04: hardreset failed (port not ready)
ata7.04: reset failed, giving up
ata7.15: hard resetting port
ata7: controller in dubious state, performing PORT_RST
ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata7.00: hard resetting port
ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.01: hard resetting port
ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.02: hard resetting port
ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.03: hard resetting port
ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.04: hard resetting port
ata7.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata7.00: configured for UDMA/100
ata7.01: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata7.01: configured for UDMA/100
ata7.02: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata7.02: configured for UDMA/100
ata7.03: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata7.03: configured for UDMA/100
ata7.04: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata7.04: configured for UDMA/100
ata7: EH complete
scsi 8:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
SCSI device sdi: 625142448 512-byte hdwr sectors (320073 MB)
sdi: Write Protect is off
sdi: Mode Sense: 00 3a 00 00
SCSI device sdi: write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
(rest of devices thru sdm detected as usual).

--=20
Robin Hugh Johnson
Gentoo Linux Developer
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFk61zPpIsIjIzwiwRApKhAKCxWxPCyqeHwEE9ObvXzzdZBP9sPgCdFCv2
njhZh0PFZEEsVlA1u+Jx34I=
=YFIN
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--
