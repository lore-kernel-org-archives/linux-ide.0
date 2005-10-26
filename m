From: Eugene Crosser <crosser@rol.ru>
Subject: Trying latest sata_mv - and getting freeze
Date: Wed, 26 Oct 2005 17:56:15 +0400
Message-ID: <435F8AFF.3030404@rol.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig31C4397F905E58CEBA835260"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.rol.ru ([194.67.1.9]:3244 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S1751493AbVJZN4f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Oct 2005 09:56:35 -0400
Received: from ariel.sovam.com ([194.67.3.216]:3527 "EHLO [194.67.3.216]"
	smtp-auth: "egc@online.ru" TLS-CIPHER: "DHE-RSA-AES256-SHA keybits
	256/256 version TLSv1/SSLv3" TLS-PEER-CN1: <none>)
	by gnome10.net.rol.ru with ESMTPSA id S2942983AbVJZN4T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Oct 2005 17:56:19 +0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org, multiman@rol.ru

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig31C4397F905E58CEBA835260
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Hello Brett,

I am not really a kernel hacker, but I am a pretty "experienced user";
and right now I am hunting for a problem that apparently(?) happens to
all people who try to run DRBD (http://www.drbd.org/) on top of SATA
disks.  Among other things, I was trying to use a different SATA driver
on my hardware and see if it makes any difference.  So, I checked out
the "libata-dev" tree from git ("upstream" head) and tried to run it.

My hardware is SMP Supermicro with 6 disks on
Marvell MV88SX6081 8-port SATA II PCI-X Controller (rev 03)
and the sata_mv.c is version 0.25 dated 22 Oct 2005

The thing works with "old" mvsata340 driver, but the "new" kernel with
your driver freezes when it starts to probe disks.  Even Magic SysRq
does not work.  The last lines I see on screen are like this:

sata_mv version 0.25
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 56 (level, low) -> IRQ 185
sata_mv(0000:02:03.0) 32 slots 8 ports unknown mode IRQ via MSI
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8C22120 bmdma 0x0 irq 185
ata2: .... <same things>            0xF8C24120 ...
...
ata8: .... <same thing>             0xF8C38120 ...
ATA: abnormal status 0x80 on port 0xF8C2211C
... <five more lines identical to the above>
ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48

- and at this point it freezes hard.
Any suggestions for me?  Any information I can collect to help
troubleshooting?

Thanks.
Eugene

--------------enig31C4397F905E58CEBA835260
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDX4sCtQFsU5rTNjcRAtN0AKCbZX501sda46u5Y/mxmT2elg2W7gCcCpeR
40pVwK/+YiPOAVvweVBvBcM=
=Q0wp
-----END PGP SIGNATURE-----

--------------enig31C4397F905E58CEBA835260--
