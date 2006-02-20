From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/6] libata: separate out ata_dev_configure()
Date: Tue, 21 Feb 2006 02:12:11 +0900
Message-ID: <11404555312745-git-send-email-htejun@gmail.com>
References: <11404555312141-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:32657 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161055AbWBTRMP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 12:12:15 -0500
Received: by pproxy.gmail.com with SMTP id o67so1152385pye
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 09:12:14 -0800 (PST)
In-Reply-To: <11404555312141-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out ata_dev_configure() from ata_dev_identify() such that
ata_dev_configure() only configures @dev according to passed in @id.
The function now does not disable device on failure, it just returns
appropirate error code.

As this change leaves ata_dev_identify() with only reading ID, calling
configure and disabling devices according to the results, this patch
also kills ata_dev_identify() and inlines the logic into
ata_bus_probe().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   78 ++++++++++++++++++++++----------------------
 1 files changed, 39 insertions(+), 39 deletions(-)

2b73230af60643e37a49d1d96dda2fce882c2d7f
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1d7c2f5..5e98b0b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1050,45 +1050,31 @@ static int ata_dev_read_id(struct ata_po
 }
 
 /**
- *	ata_dev_identify - obtain IDENTIFY x DEVICE page
- *	@ap: port on which device we wish to probe resides
- *	@device: device bus address, starting at zero
+ *	ata_dev_configure - Configure the specified ATA/ATAPI device
+ *	@ap: Port on which target device resides
+ *	@dev: Target device to configure
  *
- *	Following bus reset, we issue the IDENTIFY [PACKET] DEVICE
- *	command, and read back the 512-byte device information page.
- *	The device information page is fed to us via the standard
- *	PIO-IN protocol, but we hand-code it here. (TODO: investigate
- *	using standard PIO-IN paths)
- *
- *	After reading the device information page, we use several
- *	bits of information from it to initialize data structures
- *	that will be used during the lifetime of the ata_device.
- *	Other data from the info page is used to disqualify certain
- *	older ATA devices we do not wish to support.
+ *	Configure @dev according to @dev->id.  Generic and low-level
+ *	driver specific fixups are also applied.
  *
  *	LOCKING:
- *	Inherited from caller.  Some functions called by this function
- *	obtain the host_set lock.
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise
  */
-
-static void ata_dev_identify(struct ata_port *ap, unsigned int device)
+static int ata_dev_configure(struct ata_port *ap, struct ata_device *dev)
 {
-	struct ata_device *dev = &ap->device[device];
 	unsigned long xfer_modes;
 	int i, rc;
 
 	if (!ata_dev_present(dev)) {
 		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
-			ap->id, device);
-		return;
+			ap->id, dev->devno);
+		return 0;
 	}
 
-	DPRINTK("ENTER, host %u, dev %u\n", ap->id, device);
-
-	WARN_ON(dev->id != NULL);
-	rc = ata_dev_read_id(ap, dev, &dev->class, 1, &dev->id);
-	if (rc)
-		goto err_out;
+	DPRINTK("ENTER, host %u, dev %u\n", ap->id, dev->devno);
 
 	/*
 	 * common ATA, ATAPI feature tests
@@ -1097,6 +1083,7 @@ static void ata_dev_identify(struct ata_
 	/* we require DMA support (bits 8 of word 49) */
 	if (!ata_id_has_dma(dev->id)) {
 		printk(KERN_DEBUG "ata%u: no dma\n", ap->id);
+		rc = -EINVAL;
 		goto err_out_nosup;
 	}
 
@@ -1121,12 +1108,12 @@ static void ata_dev_identify(struct ata_
 
 			/* print device info to dmesg */
 			printk(KERN_INFO "ata%u: dev %u ATA-%d, max %s, %Lu sectors:%s\n",
-			       ap->id, device,
+			       ap->id, dev->devno,
 			       ata_id_major_version(dev->id),
 			       ata_mode_string(xfer_modes),
 			       (unsigned long long)dev->n_sectors,
 			       dev->flags & ATA_DFLAG_LBA48 ? " LBA48" : " LBA");
-		} else { 
+		} else {
 			/* CHS */
 
 			/* Default translation */
@@ -1143,7 +1130,7 @@ static void ata_dev_identify(struct ata_
 
 			/* print device info to dmesg */
 			printk(KERN_INFO "ata%u: dev %u ATA-%d, max %s, %Lu sectors: CHS %d/%d/%d\n",
-			       ap->id, device,
+			       ap->id, dev->devno,
 			       ata_id_major_version(dev->id),
 			       ata_mode_string(xfer_modes),
 			       (unsigned long long)dev->n_sectors,
@@ -1159,13 +1146,14 @@ static void ata_dev_identify(struct ata_
 		rc = atapi_cdb_len(dev->id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
 			printk(KERN_WARNING "ata%u: unsupported CDB len\n", ap->id);
+			rc = -EINVAL;
 			goto err_out_nosup;
 		}
 		dev->cdb_len = (unsigned int) rc;
 
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
-		       ap->id, device,
+		       ap->id, dev->devno,
 		       ata_mode_string(xfer_modes));
 	}
 
@@ -1176,14 +1164,13 @@ static void ata_dev_identify(struct ata_
 					      ap->device[i].cdb_len);
 
 	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
-	return;
+	return 0;
 
 err_out_nosup:
 	printk(KERN_WARNING "ata%u: dev %u not supported, ignoring\n",
-	       ap->id, device);
-err_out:
-	dev->class++;	/* converts ATA_DEV_xxx into ATA_DEV_xxx_UNSUP */
+	       ap->id, dev->devno);
 	DPRINTK("EXIT, err\n");
+	return rc;
 }
 
 
@@ -1259,11 +1246,24 @@ static int ata_bus_probe(struct ata_port
 		goto err_out;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		ata_dev_identify(ap, i);
-		if (ata_dev_present(&ap->device[i])) {
-			found = 1;
-			ata_dev_config(ap,i);
+		struct ata_device *dev = &ap->device[i];
+
+		if (!ata_dev_present(dev))
+			continue;
+
+		WARN_ON(dev->id != NULL);
+		if (ata_dev_read_id(ap, dev, &dev->class, 1, &dev->id)) {
+			dev->class = ATA_DEV_NONE;
+			continue;
 		}
+
+		if (ata_dev_configure(ap, dev)) {
+			dev->class++;	/* disable device */
+			continue;
+		}
+
+		ata_dev_config(ap, i);
+		found = 1;
 	}
 
 	if ((!found) || (ap->flags & ATA_FLAG_PORT_DISABLED))
-- 
1.1.5


