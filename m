From: Andy Warner <andyw@pobox.com>
Subject: libata - error register patch.
Date: Wed, 29 Sep 2004 17:50:11 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040929175011.L15041@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:11439 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S269196AbUI2WwA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Sep 2004 18:52:00 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It's entirely possible I'm missing something either
very obvious, or very subtle, but I think the reading
of the error register in libata et al is incorrect.

Current code only reads the error register when
in LBA48 mode, and then stores it in tf->hob_feature.
Attached patch always reads it and stores it
in tf->feature.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=error_patch

diff -ur pre/drivers/scsi/libata-core.c post/drivers/scsi/libata-core.c
--- pre/drivers/scsi/libata-core.c	2004-09-29 17:28:02.128241280 -0500
+++ post/drivers/scsi/libata-core.c	2004-09-29 17:30:39.849416316 -0500
@@ -321,10 +321,10 @@
 	tf->lbam = inb(ioaddr->lbam_addr);
 	tf->lbah = inb(ioaddr->lbah_addr);
 	tf->device = inb(ioaddr->device_addr);
+	tf->feature = inb(ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
 		outb(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
-		tf->hob_feature = inb(ioaddr->error_addr);
 		tf->hob_nsect = inb(ioaddr->nsect_addr);
 		tf->hob_lbal = inb(ioaddr->lbal_addr);
 		tf->hob_lbam = inb(ioaddr->lbam_addr);
@@ -353,10 +353,10 @@
 	tf->lbam = readb((void __iomem *)ioaddr->lbam_addr);
 	tf->lbah = readb((void __iomem *)ioaddr->lbah_addr);
 	tf->device = readb((void __iomem *)ioaddr->device_addr);
+	tf->feature = readb((void __iomem *)ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
 		writeb(tf->ctl | ATA_HOB, (void __iomem *) ap->ioaddr.ctl_addr);
-		tf->hob_feature = readb((void __iomem *)ioaddr->error_addr);
 		tf->hob_nsect = readb((void __iomem *)ioaddr->nsect_addr);
 		tf->hob_lbal = readb((void __iomem *)ioaddr->lbal_addr);
 		tf->hob_lbam = readb((void __iomem *)ioaddr->lbam_addr);
diff -ur pre/drivers/scsi/sata_svw.c post/drivers/scsi/sata_svw.c
--- pre/drivers/scsi/sata_svw.c	2004-09-29 17:32:42.396805890 -0500
+++ post/drivers/scsi/sata_svw.c	2004-09-29 17:34:39.625030054 -0500
@@ -138,9 +138,9 @@
 	lbam = tf->lbam = readw(ioaddr->lbam_addr);
 	lbah = tf->lbah = readw(ioaddr->lbah_addr);
 	tf->device = readw(ioaddr->device_addr);
+	tf->feature = readw(ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readw(ioaddr->error_addr) >> 8;
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
diff -ur pre/drivers/scsi/sata_vsc.c post/drivers/scsi/sata_vsc.c
--- pre/drivers/scsi/sata_vsc.c	2004-09-29 17:32:30.539605204 -0500
+++ post/drivers/scsi/sata_vsc.c	2004-09-29 17:36:36.286359905 -0500
@@ -139,9 +139,9 @@
 	lbam = tf->lbam = readw(ioaddr->lbam_addr);
 	lbah = tf->lbah = readw(ioaddr->lbah_addr);
 	tf->device = readw(ioaddr->device_addr);
+	tf->feature = readb(ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readb(ioaddr->error_addr);
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;

--r5Pyd7+fXNt84Ff3--
