From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] add DMA blacklist to libata
Date: Thu, 06 Jan 2005 20:36:31 -0500
Message-ID: <41DDE79F.8090601@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060107050703070301000705"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63878 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261272AbVAGBgr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jan 2005 20:36:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------060107050703070301000705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

For review.  I checked this into libata-dev just now.

Design decisions:
* no whitelist.  Worst case is a few more devices will use PIO.
* no firmware rev checking.  Worst case is a few more models (2) will 
use PIO.


--------------060107050703070301000705
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/libata-core.c 1.112 vs edited =====
--- 1.112/drivers/scsi/libata-core.c	2004-12-27 15:41:22 -05:00
+++ edited/drivers/scsi/libata-core.c	2005-01-06 20:34:28 -05:00
@@ -1700,6 +1700,70 @@
 	DPRINTK("EXIT\n");
 }
 
+static void ata_pr_blacklisted(struct ata_port *ap, struct ata_device *dev)
+{
+	printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, disabling DMA\n",
+		ap->id, dev->devno);
+}
+
+static const char * ata_dma_blacklist [] = {
+	"WDC AC11000H",
+	"WDC AC22100H",
+	"WDC AC32500H",
+	"WDC AC33100H",
+	"WDC AC31600H",
+	"WDC AC32100H",
+	"WDC AC23200L",
+	"Compaq CRD-8241B",
+	"CRD-8400B",
+	"CRD-8480B",
+	"CRD-8480C",
+	"CRD-8482B",
+ 	"CRD-84",
+	"SanDisk SDP3B",
+	"SanDisk SDP3B-64",
+	"SANYO CD-ROM CRD",
+	"HITACHI CDR-8",
+	"HITACHI CDR-8335",
+	"HITACHI CDR-8435",
+	"Toshiba CD-ROM XM-6202B",
+	"CD-532E-A",
+	"E-IDE CD-ROM CR-840",
+	"CD-ROM Drive/F5A",
+	"WPI CDD-820",
+	"SAMSUNG CD-ROM SC-148C",
+	"SAMSUNG CD-ROM SC",
+	"SanDisk SDP3B-64",
+	"SAMSUNG CD-ROM SN-124",
+	"ATAPI CD-ROM DRIVE 40X MAXIMUM",
+	"_NEC DV5800A",
+};
+
+static int ata_dma_blacklisted(struct ata_port *ap, struct ata_device *dev)
+{
+	unsigned char model_num[40];
+	char *s;
+	unsigned int len;
+	int i;
+
+	ata_dev_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
+			  sizeof(model_num));
+	s = &model_num[0];
+	len = strnlen(s, sizeof(model_num));
+
+	/* ATAPI specifies that empty space is blank-filled; remove blanks */
+	while ((len > 0) && (s[len - 1] == ' ')) {
+		len--;
+		s[len] = 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ata_dma_blacklist); i++)
+		if (!strncmp(ata_dma_blacklist[i], s, len))
+			return 1;
+
+	return 0;
+}
+
 static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift)
 {
 	struct ata_device *master, *slave;
@@ -1712,17 +1776,37 @@
 
 	if (shift == ATA_SHIFT_UDMA) {
 		mask = ap->udma_mask;
-		if (ata_dev_present(master))
+		if (ata_dev_present(master)) {
 			mask &= (master->id[ATA_ID_UDMA_MODES] & 0xff);
-		if (ata_dev_present(slave))
+			if (ata_dma_blacklisted(ap, master)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, master);
+			}
+		}
+		if (ata_dev_present(slave)) {
 			mask &= (slave->id[ATA_ID_UDMA_MODES] & 0xff);
+			if (ata_dma_blacklisted(ap, slave)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, slave);
+			}
+		}
 	}
 	else if (shift == ATA_SHIFT_MWDMA) {
 		mask = ap->mwdma_mask;
-		if (ata_dev_present(master))
+		if (ata_dev_present(master)) {
 			mask &= (master->id[ATA_ID_MWDMA_MODES] & 0x07);
-		if (ata_dev_present(slave))
+			if (ata_dma_blacklisted(ap, master)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, master);
+			}
+		}
+		if (ata_dev_present(slave)) {
 			mask &= (slave->id[ATA_ID_MWDMA_MODES] & 0x07);
+			if (ata_dma_blacklisted(ap, slave)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, slave);
+			}
+		}
 	}
 	else if (shift == ATA_SHIFT_PIO) {
 		mask = ap->pio_mask;

--------------060107050703070301000705--
