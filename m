From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 1/n] libata-core.c conversion to new debugging scheme, part 1 (25% done)
Date: Wed, 31 May 2006 07:46:33 +0200
Message-ID: <20060531054633.GA4875@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp101.plus.mail.re2.yahoo.com ([206.190.53.26]:55197 "HELO
	smtp101.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932488AbWEaFrm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 01:47:42 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

This patch converts the first 25% of libata-core.c to the new debugging scheme.

Signed-off-by: <petkov@uni-muenster.de>


--- libata-dev/drivers/scsi/libata-core.c.orig	2006-05-30 22:02:51.000000000 +0200
+++ libata-dev/drivers/scsi/libata-core.c	2006-05-31 07:37:44.000000000 +0200
@@ -411,7 +411,7 @@ static const char *sata_spd_string(unsig
 
 void ata_dev_disable(struct ata_device *dev)
 {
-	if (ata_dev_enabled(dev)) {
+	if (ata_dev_enabled(dev) && ata_msg_drv(dev->ap)) {
 		ata_dev_printk(dev, KERN_WARNING, "disabled\n");
 		dev->class++;
 	}
@@ -770,8 +770,12 @@ void ata_std_dev_select (struct ata_port
 void ata_dev_select(struct ata_port *ap, unsigned int device,
 			   unsigned int wait, unsigned int can_sleep)
 {
-	VPRINTK("ENTER, ata%u: device %u, wait %u\n",
-		ap->id, device, wait);
+	if (ata_msg_probe(ap)) {
+		struct ata_device *dev = container_of(&ap, struct ata_device, ap);
+		ata_dev_printk(dev, KERN_INFO, "ata_dev_select: ENTER, ata%u: "
+				"device %u, wait %u\n",
+				ap->id, device, wait);
+	}
 
 	if (wait)
 		ata_wait_idle(ap);
@@ -1297,18 +1301,21 @@ static int ata_dev_configure(struct ata_
 	unsigned int xfer_mask;
 	int i, rc;
 
-	if (!ata_dev_enabled(dev)) {
-		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
-			ap->id, dev->devno);
+	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
+		ata_dev_printk(dev, KERN_INFO, "%s: ENTER/EXIT (host %u, dev %u) -- nodev\n",
+			__FUNCTION__, ap->id, dev->devno);
 		return 0;
 	}
 
-	DPRINTK("ENTER, host %u, dev %u\n", ap->id, dev->devno);
+	if (ata_msg_probe(ap))
+		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n", 
+			__FUNCTION__, ap->id, dev->devno);
 
 	/* print device capabilities */
-	if (print_info)
-		ata_dev_printk(dev, KERN_DEBUG, "cfg 49:%04x 82:%04x 83:%04x "
+	if (ata_msg_probe(ap))
+		ata_dev_printk(dev, KERN_DEBUG, "%s: cfg 49:%04x 82:%04x 83:%04x "
 			       "84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
+			       __FUNCTION__,
 			       id[49], id[82], id[83], id[84],
 			       id[85], id[86], id[87], id[88]);
 
@@ -1328,7 +1335,8 @@ static int ata_dev_configure(struct ata_
 	/* find max transfer mode; for printk only */
 	xfer_mask = ata_id_xfermask(id);
 
-	ata_dump_id(id);
+	if (ata_msg_probe(ap))
+		ata_dump_id(id);
 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
@@ -1349,7 +1357,7 @@ static int ata_dev_configure(struct ata_
 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
 
 			/* print device info to dmesg */
-			if (print_info)
+			if (ata_msg_info(ap))
 				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: %s %s\n",
 					ata_id_major_version(id),
@@ -1372,7 +1380,7 @@ static int ata_dev_configure(struct ata_
 			}
 
 			/* print device info to dmesg */
-			if (print_info)
+			if (ata_msg_info(ap))
 				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
 					"max %s, %Lu sectors: CHS %u/%u/%u\n",
 					ata_id_major_version(id),
@@ -1383,7 +1391,8 @@ static int ata_dev_configure(struct ata_
 
 		if (dev->id[59] & 0x100) {
 			dev->multi_count = dev->id[59] & 0xff;
-			DPRINTK("ata%u: dev %u multi count %u\n",
+			if (ata_msg_info(ap))
+				ata_dev_printk(dev, KERN_INFO, "ata%u: dev %u multi count %u\n",
 				ap->id, dev->devno, dev->multi_count);
 		}
 
@@ -1396,8 +1405,9 @@ static int ata_dev_configure(struct ata_
 
 		rc = atapi_cdb_len(id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
-			ata_dev_printk(dev, KERN_WARNING,
-				       "unsupported CDB len\n");
+			if (ata_msg_warn(ap))
+				ata_dev_printk(dev, KERN_WARNING, 
+					"unsupported CDB len\n");
 			rc = -EINVAL;
 			goto err_out_nosup;
 		}
@@ -1409,7 +1419,7 @@ static int ata_dev_configure(struct ata_
 		}
 
 		/* print device info to dmesg */
-		if (print_info)
+		if (ata_msg_info(ap))
 			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s%s\n",
 				       ata_mode_string(xfer_mask),
 				       cdb_intr_string);
@@ -1423,7 +1433,7 @@ static int ata_dev_configure(struct ata_
 
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(dev)) {
-		if (print_info)
+		if (ata_msg_info(ap))
 			ata_dev_printk(dev, KERN_INFO,
 				       "applying bridge limits\n");
 		dev->udma_mask &= ATA_UDMA5;
@@ -1433,11 +1443,15 @@ static int ata_dev_configure(struct ata_
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(ap, dev);
 
-	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
+	if (ata_msg_probe(ap))
+		ata_dev_printk(dev, KERN_DEBUG, "%s: EXIT, drv_stat = 0x%x\n",
+			__FUNCTION__, ata_chk_status(ap));
 	return 0;
 
 err_out_nosup:
-	DPRINTK("EXIT, err\n");
+	if (ata_msg_probe(ap))
+		ata_dev_printk(dev, KERN_DEBUG, 
+				"%s: EXIT, err\n", __FUNCTION__);
 	return rc;
 }
 
@@ -1478,8 +1492,9 @@ static int ata_bus_probe(struct ata_port
 	if (ap->ops->probe_reset) {
 		rc = ap->ops->probe_reset(ap, classes);
 		if (rc) {
-			ata_port_printk(ap, KERN_ERR,
-					"reset failed (errno=%d)\n", rc);
+			if (ata_msg_err(ap))
+				ata_port_printk(ap, KERN_ERR, 
+						"reset failed (errno=%d)\n", rc);
 			return rc;
 		}
 	} else {

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

