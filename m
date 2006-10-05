From: Michael Rasenberger <miraze@web.de>
Subject: 2.6.19-rc1 scanning a ghost dvd drive at boot
Date: Thu, 05 Oct 2006 15:00:22 +0000
Message-ID: <45251E06.1080503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:44234 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1751451AbWJEM54 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Oct 2006 08:57:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

trying libata with 2.6.19-rc1 produced the follwing at startup:

ata6.00: ATAPI, max UDMA/3
ata6.01: qc timeout (cmd 0xa1)
ata6.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata6: failed to recover some devices, retrying in 5 secs
ata6.01: qc timeout (cmd 0xa1)
ata6.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata6: failed to recover some devices, retrying in 5 secs
ata6.01: qc timeout (cmd 0xa1)
ata6.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata6: failed to recover some devices, retrying in 5 secs

I have nvidia chipset and therefore use pata_amd and sata_nv.
The DVD/RW drive is the only drive on ata6.
The harddisk on ata5 is recognized without problems.

After the above 3 attempts to scan ata6.01 the boot process
continued normally and all drives are working fine (HD and DVD).
It seem that libata thinks there is a drive on ata6.01 but there is none
(->Ghosting?).

I figured there were such issues earlier with other chipset. Is there
something to do about it?


Regards

		Michael
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFJR4GC0GEtIi2MlcRApl/AJwKVMEQqpwKzmx+Of0X9PYaTSRnsgCeLTQJ
QljNzcevm7+NkbO/y8cJkpU=
=/S1W
-----END PGP SIGNATURE-----
