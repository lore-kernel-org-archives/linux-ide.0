From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH] libata-core.c: restore configuration boot messages in ata_dev_configure()
Date: Tue, 27 Jun 2006 09:33:35 +0200
Message-ID: <20060627073335.GA6237@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp105.plus.mail.re2.yahoo.com ([206.190.53.30]:54937 "HELO
	smtp105.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932162AbWF0LY7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jun 2006 07:24:59 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux IDE ML <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>

Hi Tejun, Jeff,
   is this one like what you had in mind? I left out the ENTER/EXIT printk's
   since they are debug level. By the way, should I convert the dbg message
   levels to the scheme you both proposed now while not everything is converted
   or wait first. However, i'd rather do it now since it is less work than
   later :)?



This restores the default libata configuration messages printed during booting.

Signed-off-by: <petkov@math.uni-muenster.de>


--- libata-dev/drivers/scsi/libata-core.c.orig2	2006-06-27 09:21:44.000000000 +0200
+++ libata-dev/drivers/scsi/libata-core.c	2006-06-27 09:23:54.000000000 +0200
@@ -1359,11 +1359,10 @@ int ata_dev_configure(struct ata_device 
 			       __FUNCTION__, ap->id, dev->devno);
 
 	/* print device capabilities */
-	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG,
-			       "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
+	if (ata_msg_drv(ap))
+		ata_dev_printk(dev, KERN_INFO,
+			       "cfg 49:%04x 82:%04x 83:%04x 84:%04x "
 			       "85:%04x 86:%04x 87:%04x 88:%04x\n",
-			       __FUNCTION__,
 			       id[49], id[82], id[83], id[84],
 			       id[85], id[86], id[87], id[88]);
 
@@ -1405,7 +1404,7 @@ int ata_dev_configure(struct ata_device 
 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
 
 			/* print device info to dmesg */
-			if (ata_msg_info(ap))
+			if (ata_msg_drv(ap))
 				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: %s %s\n",
 					ata_id_major_version(id),
@@ -1428,7 +1427,7 @@ int ata_dev_configure(struct ata_device 
 			}
 
 			/* print device info to dmesg */
-			if (ata_msg_info(ap))
+			if (ata_msg_drv(ap))
 				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: CHS %u/%u/%u\n",
 					ata_id_major_version(id),
@@ -1440,7 +1439,7 @@ int ata_dev_configure(struct ata_device 
 
 		if (dev->id[59] & 0x100) {
 			dev->multi_count = dev->id[59] & 0xff;
-			if (ata_msg_info(ap))
+			if (ata_msg_drv(ap))
 				ata_dev_printk(dev, KERN_INFO,
 					"ata%u: dev %u multi count %u\n",
 					ap->id, dev->devno, dev->multi_count);
@@ -1469,7 +1468,7 @@ int ata_dev_configure(struct ata_device 
 		}
 
 		/* print device info to dmesg */
-		if (ata_msg_info(ap))
+		if (ata_msg_drv(ap))
 			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s%s\n",
 				       ata_mode_string(xfer_mask),
 				       cdb_intr_string);
@@ -1483,7 +1482,7 @@ int ata_dev_configure(struct ata_device 
 
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(dev)) {
-		if (ata_msg_info(ap))
+		if (ata_msg_drv(ap))
 			ata_dev_printk(dev, KERN_INFO,
 				       "applying bridge limits\n");
 		dev->udma_mask &= ATA_UDMA5;

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

