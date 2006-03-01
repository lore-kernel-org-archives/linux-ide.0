From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: fold ata_dev_config() into ata_dev_configure()
Date: Wed, 1 Mar 2006 16:09:36 +0900
Message-ID: <1141196976110-git-send-email-htejun@gmail.com>
References: <11411969752304-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:13447 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750769AbWCAHL5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 02:11:57 -0500
Received: by zproxy.gmail.com with SMTP id 18so70347nzp
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 23:11:57 -0800 (PST)
In-Reply-To: <11411969752304-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_config() needs to be done everytime a device is configured.
Fold it into ata_dev_configure().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   48 ++++++++++++++++----------------------------
 include/linux/libata.h     |    1 -
 2 files changed, 17 insertions(+), 32 deletions(-)

8686b79624ba861834b6648a043c1ca95ea806dd
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index dcc6b06..f9ab563 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1049,6 +1049,12 @@ static int ata_dev_read_id(struct ata_po
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
@@ -1163,6 +1169,17 @@ static int ata_dev_configure(struct ata_
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
 
@@ -1173,35 +1190,6 @@ err_out_nosup:
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
- * ata_dev_config - Run device specific handlers & check for SATA->PATA bridges
- * @ap: Bus
- * @i:  Device
- *
- * LOCKING:
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
@@ -1262,7 +1250,6 @@ static int ata_bus_probe(struct ata_port
 			continue;
 		}
 
-		ata_dev_config(ap, i);
 		found = 1;
 	}
 
@@ -4963,7 +4950,6 @@ EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
-EXPORT_SYMBOL_GPL(ata_dev_config);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 68666b9..1aab218 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -542,7 +542,6 @@ extern void ata_id_string(const u16 *id,
 			  unsigned int ofs, unsigned int len);
 extern void ata_id_c_string(const u16 *id, unsigned char *s,
 			    unsigned int ofs, unsigned int len);
-extern void ata_dev_config(struct ata_port *ap, unsigned int i);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
-- 
1.2.1


