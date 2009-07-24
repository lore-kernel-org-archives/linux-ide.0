From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Fri, 24 Jul 2009 17:12:15 +0800
Message-ID: <20090724091215.GA27802@sli10-desk.sh.intel.com>
References: <4A67E00F.40808@pobox.com> <20090723054007.GA7473@sli10-desk.sh.intel.com> <4A67F8ED.2070204@kernel.org> <4A67FE1A.1050408@pobox.com> <4A67FF56.5040708@kernel.org> <4A6807A8.30403@pobox.com> <20090723072518.GA3545@sli10-desk.sh.intel.com> <4A68A6D1.4090508@gmail.com> <4A68A7C1.2030302@pobox.com> <4A68CD90.5000404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15726 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbZGXJMR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Jul 2009 05:12:17 -0400
Content-Disposition: inline
In-Reply-To: <4A68CD90.5000404@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robert Hancock <hancockrwd@gmail.com>, linux-ide <linux-ide@vger.kernel.org>

On Fri, Jul 24, 2009 at 04:52:32AM +0800, Tejun Heo wrote:
> Jeff Garzik wrote:
> > Robert Hancock wrote:
> >> Seems reasonable to me, though we may want to print something out
> >> during device identification to indicate that we're using AA (like we
> >> do for ATAPI AN).
> > 
> > Agreed -- the user needs some indication, somewhere, that this feature
> > is enabled.
> 
> Also, the return value from ata_dev_set_feature() needs to be checked.
> AC_ERR_DEV can be ignored.  Other errors should probably set
> inhinit-AA bit and fail the current recovery trial.
Ok, updated patch.

Add SATA DMA setup FIS auto-activate feature in AHCI.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 336eb1e..d5d67b8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2802,7 +2802,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* prepare host */
 	if (hpriv->cap & HOST_CAP_NCQ)
-		pi.flags |= ATA_FLAG_NCQ;
+		pi.flags |= ATA_FLAG_NCQ | ATA_FLAG_FPDMA_AA;
 
 	if (hpriv->cap & HOST_CAP_PMP)
 		pi.flags |= ATA_FLAG_PMP;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2c6aeda..68f60f3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2298,29 +2298,48 @@ static inline u8 ata_dev_knobble(struct ata_device *dev)
 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
 
-static void ata_dev_config_ncq(struct ata_device *dev,
+static int ata_dev_config_ncq(struct ata_device *dev,
 			       char *desc, size_t desc_sz)
 {
 	struct ata_port *ap = dev->link->ap;
 	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
+	unsigned int err_mask;
+	char *aa_desc = "";
 
 	if (!ata_id_has_ncq(dev->id)) {
 		desc[0] = '\0';
-		return;
+		return 0;
 	}
 	if (dev->horkage & ATA_HORKAGE_NONCQ) {
 		snprintf(desc, desc_sz, "NCQ (not used)");
-		return;
+		return 0;
 	}
 	if (ap->flags & ATA_FLAG_NCQ) {
 		hdepth = min(ap->scsi_host->can_queue, ATA_MAX_QUEUE - 1);
 		dev->flags |= ATA_DFLAG_NCQ;
 	}
 
+	if (!(dev->horkage & ATA_HORKAGE_FPDMA_AA) &&
+		(ap->flags & ATA_FLAG_FPDMA_AA) &&
+		ata_id_has_fpdma_aa(dev->id)) {
+		err_mask = ata_dev_set_feature(dev, SETFEATURES_SATA_ENABLE,
+			SATA_FPDMA_AA);
+		if (err_mask) {
+			ata_dev_printk(dev, KERN_ERR, "failed to enable AA"
+				"(error_mask=0x%x)\n", err_mask);
+			if (err_mask != AC_ERR_DEV)
+				dev->horkage |= ATA_HORKAGE_FPDMA_AA;
+			return -EIO;
+		} else
+			aa_desc = ", AA";
+	}
+
 	if (hdepth >= ddepth)
-		snprintf(desc, desc_sz, "NCQ (depth %d)", ddepth);
+		snprintf(desc, desc_sz, "NCQ (depth %d)%s", ddepth, aa_desc);
 	else
-		snprintf(desc, desc_sz, "NCQ (depth %d/%d)", hdepth, ddepth);
+		snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
+			ddepth, aa_desc);
+	return 0;
 }
 
 /**
@@ -2460,7 +2479,7 @@ int ata_dev_configure(struct ata_device *dev)
 
 		if (ata_id_has_lba(id)) {
 			const char *lba_desc;
-			char ncq_desc[20];
+			char ncq_desc[24];
 
 			lba_desc = "LBA";
 			dev->flags |= ATA_DFLAG_LBA;
@@ -2474,7 +2493,9 @@ int ata_dev_configure(struct ata_device *dev)
 			}
 
 			/* config NCQ */
-			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
+			rc = ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
+			if (rc)
+				return rc;
 
 			/* print device info to dmesg */
 			if (ata_msg_drv(ap) && print_info) {
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 9c75921..f549405 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -306,6 +306,7 @@ enum {
 	/* SETFEATURE Sector counts for SATA features */
 	SATA_AN			= 0x05,  /* Asynchronous Notification */
 	SATA_DIPM		= 0x03,  /* Device Initiated Power Management */
+	SATA_FPDMA_AA		= 0x02,  /* DMA Setup FIS Auto-Activate */
 
 	/* feature values for SET_MAX */
 	ATA_SET_MAX_ADDR	= 0x00,
@@ -525,6 +526,9 @@ static inline int ata_is_data(u8 prot)
 #define ata_id_has_atapi_AN(id)	\
 	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
 	  ((id)[78] & (1 << 5)) )
+#define ata_id_has_fpdma_aa(id)	\
+	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
+	  ((id)[78] & (1 << 2)) )
 #define ata_id_iordy_disable(id) ((id)[ATA_ID_CAPABILITY] & (1 << 10))
 #define ata_id_has_iordy(id) ((id)[ATA_ID_CAPABILITY] & (1 << 11))
 #define ata_id_u32(id,n)	\
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 79b6d7f..a8232b9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -190,6 +190,7 @@ enum {
 	ATA_FLAG_NO_POWEROFF_SPINDOWN = (1 << 11), /* don't spindown before poweroff */
 	ATA_FLAG_NO_HIBERNATE_SPINDOWN = (1 << 12), /* don't spindown before hibernation */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
+	ATA_FLAG_FPDMA_AA		= (1 << 14), /* driver supports Auto-Activate */
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
 	ATA_FLAG_ACPI_SATA	= (1 << 17), /* need native SATA ACPI layout */
@@ -386,6 +387,7 @@ enum {
 	ATA_HORKAGE_FIRMWARE_WARN = (1 << 12),	/* firmware update warning */
 	ATA_HORKAGE_1_5_GBPS	= (1 << 13),	/* force 1.5 Gbps */
 	ATA_HORKAGE_NOSETXFER	= (1 << 14),	/* skip SETXFER, SATA only */
+	ATA_HORKAGE_FPDMA_AA	= (1 << 15),	/* skip AA */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
