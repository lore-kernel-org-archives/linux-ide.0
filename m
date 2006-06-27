From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH] libata-core.c: restore configuration boot messages in ata_dev_configure(), v2
Date: Tue, 27 Jun 2006 14:51:25 +0200
Message-ID: <20060627125125.GA14997@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp108.plus.mail.re2.yahoo.com ([206.190.53.33]:11939 "HELO
	smtp108.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932518AbWF0Mvb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jun 2006 08:51:31 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux IDE ML <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>

This one looks better, IMHO.

This restores the default libata configuration messages printed during booting.

Signed-off-by: <petkov@math.uni-muenster.de>


--- libata-dev/drivers/scsi/libata-core.c.orig2	2006-06-27 09:21:44.000000000 +0200
+++ libata-dev/drivers/scsi/libata-core.c	2006-06-27 14:47:58.000000000 +0200
@@ -1405,7 +1405,7 @@ int ata_dev_configure(struct ata_device 
 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
 
 			/* print device info to dmesg */
-			if (ata_msg_info(ap))
+			if (ata_msg_drv(ap) && print_info)
 				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: %s %s\n",
 					ata_id_major_version(id),
@@ -1428,7 +1428,7 @@ int ata_dev_configure(struct ata_device 
 			}
 
 			/* print device info to dmesg */
-			if (ata_msg_info(ap))
+			if (ata_msg_drv(ap) && print_info)
 				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: CHS %u/%u/%u\n",
 					ata_id_major_version(id),
@@ -1440,7 +1440,7 @@ int ata_dev_configure(struct ata_device 
 
 		if (dev->id[59] & 0x100) {
 			dev->multi_count = dev->id[59] & 0xff;
-			if (ata_msg_info(ap))
+			if (ata_msg_drv(ap) && print_info)
 				ata_dev_printk(dev, KERN_INFO,
 					"ata%u: dev %u multi count %u\n",
 					ap->id, dev->devno, dev->multi_count);
@@ -1469,7 +1469,7 @@ int ata_dev_configure(struct ata_device 
 		}
 
 		/* print device info to dmesg */
-		if (ata_msg_info(ap))
+		if (ata_msg_drv(ap) && print_info)
 			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s%s\n",
 				       ata_mode_string(xfer_mask),
 				       cdb_intr_string);
@@ -1483,7 +1483,7 @@ int ata_dev_configure(struct ata_device 
 
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(dev)) {
-		if (ata_msg_info(ap))
+		if (ata_msg_drv(ap) && print_info)
 			ata_dev_printk(dev, KERN_INFO,
 				       "applying bridge limits\n");
 		dev->udma_mask &= ATA_UDMA5;

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

