From: Sven Ladegast <sven@linux4geeks.de>
Subject: sata_sis and SIS180 in combined mode
Date: Sun, 3 Dec 2006 18:34:13 +0100
Message-ID: <200612031834.16797.sven@linux4geeks.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1335176.QAoBJNOePi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from newton.linux4geeks.de ([193.30.1.1]:26339 "EHLO
	newton.linux4geeks.de") by vger.kernel.org with ESMTP
	id S1758219AbWLCReM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 12:34:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: uwe.koziolek@web.de
Cc: linux-ide@vger.kernel.org

--nextPart1335176.QAoBJNOePi
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Uwe,

I am having problems to access a hard drive connected to a SIS180=20
SATA-RAID controller.

The controller is located on my mainboard (Elitegroup KV2 extreme).
There is only one hard disk drive connected to the PATA port od the=20
controller. Both SATA ports are empty. The BIOS of the controller=20
recognizes the disk and while running Microsoft Windows I can access the=20
disk.

dmesg-output looks like this (kernel 2.6.19):

sata_sis 0000:00:07.0: version 0.6
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 16
sata_sis 0000:00:07.0: Detected SiS 180/181 chipset in combined mode
ata9: SATA max UDMA/133 cmd 0xFF00 ctl 0xFE02 bmdma 0xFB00 irq 16
ata10: SATA max UDMA/133 cmd 0xFD00 ctl 0xFC02 bmdma 0xFB08 irq 16
scsi15 : sata_sis
PM: Adding info for No Bus:host15
ata9: SATA link down (SStatus 0 SControl 300)
scsi16 : sata_sis
PM: Adding info for No Bus:host16
ata10: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xFD07

I do not know the SIS180 chipset. Probably it is a fake-RAID but I do not=20
know if the PATA port is just a SATA-PATA birdge hardwired on the=20
mainboard or if it is a seperate port.

Maybe you have an idea?

Sven

--nextPart1335176.QAoBJNOePi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcwqYaS6OJ1hWpe0RAk70AKDdjyaT3kMSOEtGMtKhQpeBUUaoyQCfawt3
C4l0iclCscxJeNn5/e/nZwc=
=V6lY
-----END PGP SIGNATURE-----

--nextPart1335176.QAoBJNOePi--
