From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC] add DMA setup FIS auto-activate feature
Date: Thu, 23 Jul 2009 11:45:34 +0800
Message-ID: <1248320734.9035.22.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30117 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbZGWDpg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Jul 2009 23:45:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org

hi,
The SATA spec defines DMA setup FIS auto-activate optimization for FPDMA
transfers. I had an attempt to add it, though my test doesn't show obvious
performance improvement (not worse too), I wonder why not add this feature?

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2c6aeda..53cc355 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2303,6 +2303,7 @@ static void ata_dev_config_ncq(struct ata_device *dev,
 {
 	struct ata_port *ap = dev->link->ap;
 	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
+	const u16 *id = dev->id;
 
 	if (!ata_id_has_ncq(dev->id)) {
 		desc[0] = '\0';
@@ -2317,6 +2318,9 @@ static void ata_dev_config_ncq(struct ata_device *dev,
 		dev->flags |= ATA_DFLAG_NCQ;
 	}
 
+	if (ata_id_has_daa(id))
+		ata_dev_set_feature(dev, SETFEATURES_SATA_ENABLE, SATA_DAA);
+
 	if (hdepth >= ddepth)
 		snprintf(desc, desc_sz, "NCQ (depth %d)", ddepth);
 	else
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 9c75921..bb5b6ba 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -306,6 +306,7 @@ enum {
 	/* SETFEATURE Sector counts for SATA features */
 	SATA_AN			= 0x05,  /* Asynchronous Notification */
 	SATA_DIPM		= 0x03,  /* Device Initiated Power Management */
+	SATA_DAA		= 0x02,  /* DMA Setup FIS Auto-Activate */
 
 	/* feature values for SET_MAX */
 	ATA_SET_MAX_ADDR	= 0x00,
@@ -525,6 +526,9 @@ static inline int ata_is_data(u8 prot)
 #define ata_id_has_atapi_AN(id)	\
 	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
 	  ((id)[78] & (1 << 5)) )
+#define ata_id_has_daa(id)	\
+	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
+	  ((id)[78] & (1 << 2)) )
 #define ata_id_iordy_disable(id) ((id)[ATA_ID_CAPABILITY] & (1 << 10))
 #define ata_id_has_iordy(id) ((id)[ATA_ID_CAPABILITY] & (1 << 11))
 #define ata_id_u32(id,n)	\


