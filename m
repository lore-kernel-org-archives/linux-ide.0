From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/16] libata: fold ata_dev_config() into ata_dev_configure()
Date: Fri, 27 Jan 2006 00:39:11 +0900
Message-ID: <11382899513982-git-send-email-htejun@gmail.com>
References: <1138289951261-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:61520 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964778AbWAZPja (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:39:30 -0500
Received: by zproxy.gmail.com with SMTP id 34so372373nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:39:30 -0800 (PST)
In-Reply-To: <1138289951261-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_config() needs to be done everytime a device is configured.
Fold it into ata_dev_configure().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   49 +++++++++++++++-----------------------------
 include/linux/libata.h     |    1 -
 2 files changed, 17 insertions(+), 33 deletions(-)

74f80371779e436674c85f66df5ee339dfe44657
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8289fc5..7bc3a59 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1429,6 +1429,12 @@ static int ata_dev_read_id(struct ata_po
 	return rc;
 }
 
+static inline u8 ata_dev_knobble(const struct ata_port *ap,
+				 struct ata_device *dev)
+{
+	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
+}
+
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@ap: Port on which target device resides
@@ -1543,6 +1549,17 @@ static int ata_dev_configure(struct ata_
 					      ap->host->max_cmd_len,
 					      ap->device[i].cdb_len);
 
+	/* limit bridge transfers to udma5, 200 sectors */
+	if (ata_dev_knobble(ap, dev)) {
+		printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
+		       ap->id, dev->devno);
+		ap->udma_mask &= ATA_UDMA5;
+		dev->max_sectors = ATA_MAX_SECTORS;
+	}
+
+	if (ap->ops->dev_config)
+		ap->ops->dev_config(ap, dev);
+
 	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
 	return 0;
 
@@ -1553,36 +1570,6 @@ err_out_nosup:
 	return rc;
 }
 
-
-static inline u8 ata_dev_knobble(const struct ata_port *ap,
-				 struct ata_device *dev)
-{
-	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
-}
-
-/**
- * 	ata_dev_config - Run device specific handlers and check for
- * 			 SATA->PATA bridges
- * 	@ap: Bus
- * 	@i:  Device
- *
- * 	LOCKING:
- */
-
-void ata_dev_config(struct ata_port *ap, unsigned int i)
-{
-	/* limit bridge transfers to udma5, 200 sectors */
-	if (ata_dev_knobble(ap, &ap->device[i])) {
-		printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
-		       ap->id, i);
-		ap->udma_mask &= ATA_UDMA5;
-		ap->device[i].max_sectors = ATA_MAX_SECTORS;
-	}
-
-	if (ap->ops->dev_config)
-		ap->ops->dev_config(ap, &ap->device[i]);
-}
-
 /**
  *	ata_bus_probe - Reset and probe ATA bus
  *	@ap: Bus to probe
@@ -1639,7 +1626,6 @@ static int ata_bus_probe(struct ata_port
 			continue;
 		}
 
-		ata_dev_config(ap, i);
 		found = 1;
 	}
 
@@ -5564,7 +5550,6 @@ EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
 EXPORT_SYMBOL_GPL(ata_dev_id_c_string);
-EXPORT_SYMBOL_GPL(ata_dev_config);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1fceafd..2221013 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -547,7 +547,6 @@ extern void ata_dev_id_string(const u16 
 			      unsigned int ofs, unsigned int len);
 extern void ata_dev_id_c_string(const u16 *id, unsigned char *s,
 				unsigned int ofs, unsigned int len);
-extern void ata_dev_config(struct ata_port *ap, unsigned int i);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
-- 
1.1.3


