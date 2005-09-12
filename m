From: Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH] sata_sis: Fix typo in sata port2 initialisation
Date: Tue, 13 Sep 2005 00:36:45 +0200
Message-ID: <m3oe6xzzeq.fsf@anduin.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:61700 "EHLO
	anduin.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S932315AbVILWal (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Sep 2005 18:30:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, uwe.koziolek@gmx.net
Cc: linux-ide@vger.kernel.org

--=-=-=


This patch fixes a nasty typo I introduced in my previous patch (commit
f2c853bca542f5ac0b036377637192a74f2091c2). The right offset of the
second port in pure sata mode is 64 and not 0x64.
Thanks to Martin Schuster for pointing this to me

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
 ---


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=sata_sis_typo.patch

diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -289,7 +289,7 @@ static int sis_init_one (struct pci_dev 
 	if (ent->device != 0x182) {
 		if ((pmr & SIS_PMR_COMBINED) == 0) {
 			printk(KERN_INFO "sata_sis: Detected SiS 180/181 chipset in SATA mode\n");
-			port2_start=0x64;
+			port2_start=64;
 		}
 		else {
 			printk(KERN_INFO "sata_sis: Detected SiS 180/181 chipset in combined mode\n");

--=-=-=--

