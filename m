From: =?ISO-8859-15?Q?Martin_Ammerm=FCller?=
	<martin.ammermueller@bnro.de>
Subject: [sata_sil]Random timeout error (data loss)
Date: Thu, 13 Apr 2006 17:17:21 +0200
Message-ID: <443E6B81.5090004@bnro.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout08.sul.t-online.com ([194.25.134.20]:43710 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932324AbWDMRde (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Apr 2006 13:33:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

I get these errors at random with a 2.6.15 (ubuntu) kernel and
2.6.16.{4,5} vanilla kernels and sata_sil with an ATI 4379 SATA
controller and a Toshiba MK8032GS harddrive:

ata1: command 0x25 timeout, stat 0x58 host_stat 0x20
ata1: translated ATA stat/err 0x25/00 to SCSI SK/ASC/ASCQ 0x4/00/00
- -----
ata1: command 0x25 timeout, stat 0xd8 host_stat 0x21
ata1: translated ATA stat/err 0xd8/00 to SCSI SK/ASC/ASCQ 0xb/47/00
- -----
ata1: command 0x35 timeout, stat 0x50 host_stat 0x24
- -----
     ACPI-0307: *** Error: No installed handler for fixed event [000000=
00]
ATA: abnormal status 0x58 on port 0xDC82A087
ATA: abnormal status 0x58 on port 0xDC82A087
ATA: abnormal status 0x58 on port 0xDC82A087
ERROR: (device sda3): diRead: i_ino !=3D di_number
ATA: abnormal status 0x58 on port 0xDC82A087
ATA: abnormal status 0x58 on port 0xDC82A087
ATA: abnormal status 0x58 on port 0xDC82A087
ERROR: (device sda3): diRead: i_ino !=3D di_number
ERROR: (device sda3): diRead: i_ino !=3D di_number
ERROR: (device sda3): diRead: i_ino !=3D di_number
ERROR: (device sda3): diRead: i_ino !=3D di_number
- -----

=46or further details please see the attached lspci output.

Unfortunately i was not able to reliably reproduce this error. Sometime=
s
it can occur during a package installation with apt/dpkg but not when i
have a load of 20+ (generated with: "stress --cpu 5 --io 5 --vm 5 --hdd=
 5").

I also tried with an activated "slow_down" module parameter with no suc=
cess.

Help is much appreciated, since I am stranded on windows here.

Regards,
Martin Ammerm=FCller
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPmuBituPSWPX2AIRAq07AKC9TPM6pj0E6M0LpGqSvf0hC7PE3gCgpoNU
9OU09f9LHY4budxJSskD75k=3D
=3DTmdV
-----END PGP SIGNATURE-----
