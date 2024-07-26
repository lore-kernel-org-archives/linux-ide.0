Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA220B35
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721963998; cv=none; b=p8xq5LsUdTSy/TBI2QFQkNRSFCxNlBYgB8idwA2w+b6ihNditNMr8T3VRFZPvi5bo2oEJd2PfwZ7TiWyzmfZgmQsUOR1k3BEgjL45w69LEH23i6jmEpU58lCU5Qbn2zLwkcJF1ll41K9+E8Cj0RSgC1c8bVUJ/RbY4EVkxJQN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721963998; c=relaxed/simple;
	bh=Pb5ZmnBSK+0m8MLsHtcXGndzMKYfWmtdqu714LrGO2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sn3twS1eb0EtD9DMfGRR1nGVgc+LV+GGtr7+mwhessjSWRl/Kc69IHz8deZK6yFUW8Bz/izAcPwpH6awrMmPTdpcxP5YkkfX+IfI0zz18SXkm/MyVdJ01FIZgK0qxqjUrLk9TTlFcuRxCFgTFGxEnun64SO1mY3Zh6P2LbB9BEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u784bpJK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u784bpJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36F5C32782;
	Fri, 26 Jul 2024 03:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721963998;
	bh=Pb5ZmnBSK+0m8MLsHtcXGndzMKYfWmtdqu714LrGO2c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u784bpJKKYZ7x/mjmUZWDk3UyDABhM3A/U2c2wgwLcuZPH14nbsEHcpePdb0S+y1N
	 nluDi/1g/vbJgXOvgoX5LPUtbjc5kgOLClHs3aCjX3eZxRGtrePxAvdXOgOSrFqYJ0
	 JhP3ovTh87klAR7meZxlsn/e0sZJfeogv598g4fUSidYqp/jx7Otc28TMUo9cgRjGb
	 mX+V7dQYxvHKhwEmqFpWiEpW8/zI5aupFbhZ8nWbP85kYZWAlSLxIPVyhvxRrZ9s+L
	 W7OGJPYGewFRZWi4TUatW5ZFNfjoDRRcPK9RWL6QbNVOB000ODUXnbDJoqDFDCIsWe
	 a6L+dkRI5f3Ag==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 03/11] ata: libata: Use QUIRK instead of HORKAGE
Date: Fri, 26 Jul 2024 12:19:46 +0900
Message-ID: <20240726031954.566882-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726031954.566882-1-dlemoal@kernel.org>
References: <20240726031954.566882-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Wiktionary, the verb "hork" is computing slang defined as
"To foul up; to be occupied with difficulty, tangle, or unpleasantness;
to be broken" (https://en.wiktionary.org/wiki/hork#Verb). libata uses
this with the term "horkage" to refer to broken device features. Given
that this term is not widely used and its meaning unknown to many,
rename it to the more commonly used term "quirk", similar to many other
places in the kernel.

The renaming done is:
1) Rename all ATA_HORKAGE_XXX flags to ATA_QUIRK_XXX
2) Rename struct ata_device horkage field to quirks
3) Rename struct ata_blacklist_entry to struct ata_dev_quirks_entry. The
   array of these structures defining quirks for known devices is
   renamed __ata_dev_quirks.
4) The functions ata_dev_blacklisted() and ata_force_horkage() are
   renamed to ata_dev_quirks() and ata_force_quirks() respectively.
5) All the force_horkage_xxx() macros are renamed to force_quirk_xxx()

And while at it, make sure that the type "unsigned int" is used
consistantly for quirk flags variables and data structure fields.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c      | 490 ++++++++++++++++-----------------
 drivers/ata/libata-sata.c      |   2 +-
 drivers/ata/libata-scsi.c      |   9 +-
 drivers/ata/libata-sff.c       |  10 +-
 drivers/ata/libata-transport.c |   6 +-
 drivers/ata/pata_it821x.c      |   4 +-
 drivers/ata/sata_sil.c         |   2 +-
 include/linux/libata.h         |  71 ++---
 8 files changed, 297 insertions(+), 297 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f1e5055e33fe..19b041bd7588 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -84,7 +84,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
-static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
+static unsigned int ata_dev_quirks(const struct ata_device *dev);
 
 static DEFINE_IDA(ata_ida);
 
@@ -94,8 +94,8 @@ struct ata_force_param {
 	u8		cbl;
 	u8		spd_limit;
 	unsigned int	xfer_mask;
-	unsigned int	horkage_on;
-	unsigned int	horkage_off;
+	unsigned int	quirk_on;
+	unsigned int	quirk_off;
 	u16		lflags_on;
 	u16		lflags_off;
 };
@@ -457,17 +457,17 @@ static void ata_force_xfermask(struct ata_device *dev)
 }
 
 /**
- *	ata_force_horkage - force horkage according to libata.force
+ *	ata_force_quirks - force quirks according to libata.force
  *	@dev: ATA device of interest
  *
- *	Force horkage according to libata.force and whine about it.
+ *	Force quirks according to libata.force and whine about it.
  *	For consistency with link selection, device number 15 selects
  *	the first device connected to the host link.
  *
  *	LOCKING:
  *	EH context.
  */
-static void ata_force_horkage(struct ata_device *dev)
+static void ata_force_quirks(struct ata_device *dev)
 {
 	int devno = dev->link->pmp + dev->devno;
 	int alt_devno = devno;
@@ -487,21 +487,21 @@ static void ata_force_horkage(struct ata_device *dev)
 		    fe->device != alt_devno)
 			continue;
 
-		if (!(~dev->horkage & fe->param.horkage_on) &&
-		    !(dev->horkage & fe->param.horkage_off))
+		if (!(~dev->quirks & fe->param.quirk_on) &&
+		    !(dev->quirks & fe->param.quirk_off))
 			continue;
 
-		dev->horkage |= fe->param.horkage_on;
-		dev->horkage &= ~fe->param.horkage_off;
+		dev->quirks |= fe->param.quirk_on;
+		dev->quirks &= ~fe->param.quirk_off;
 
-		ata_dev_notice(dev, "FORCE: horkage modified (%s)\n",
+		ata_dev_notice(dev, "FORCE: modified (%s)\n",
 			       fe->param.name);
 	}
 }
 #else
 static inline void ata_force_link_limits(struct ata_link *link) { }
 static inline void ata_force_xfermask(struct ata_device *dev) { }
-static inline void ata_force_horkage(struct ata_device *dev) { }
+static inline void ata_force_quirks(struct ata_device *dev) { }
 #endif
 
 /**
@@ -1221,7 +1221,7 @@ static int ata_read_native_max_address(struct ata_device *dev, u64 *max_sectors)
 		*max_sectors = ata_tf_to_lba48(&tf) + 1;
 	else
 		*max_sectors = ata_tf_to_lba(&tf) + 1;
-	if (dev->horkage & ATA_HORKAGE_HPA_SIZE)
+	if (dev->quirks & ATA_QUIRK_HPA_SIZE)
 		(*max_sectors)--;
 	return 0;
 }
@@ -1306,7 +1306,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 	/* do we need to do it? */
 	if ((dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ZAC) ||
 	    !ata_id_has_lba(dev->id) || !ata_id_hpa_enabled(dev->id) ||
-	    (dev->horkage & ATA_HORKAGE_BROKEN_HPA))
+	    (dev->quirks & ATA_QUIRK_BROKEN_HPA))
 		return 0;
 
 	/* read native max address */
@@ -1318,7 +1318,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 		if (rc == -EACCES || !unlock_hpa) {
 			ata_dev_warn(dev,
 				     "HPA support seems broken, skipping HPA handling\n");
-			dev->horkage |= ATA_HORKAGE_BROKEN_HPA;
+			dev->quirks |= ATA_QUIRK_BROKEN_HPA;
 
 			/* we can continue if device aborted the command */
 			if (rc == -EACCES)
@@ -1355,7 +1355,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 			     "device aborted resize (%llu -> %llu), skipping HPA handling\n",
 			     (unsigned long long)sectors,
 			     (unsigned long long)native_sectors);
-		dev->horkage |= ATA_HORKAGE_BROKEN_HPA;
+		dev->quirks |= ATA_QUIRK_BROKEN_HPA;
 		return 0;
 	} else if (rc)
 		return rc;
@@ -1835,7 +1835,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 		goto err_out;
 	}
 
-	if (dev->horkage & ATA_HORKAGE_DUMP_ID) {
+	if (dev->quirks & ATA_QUIRK_DUMP_ID) {
 		ata_dev_info(dev, "dumping IDENTIFY data, "
 			    "class=%d may_fallback=%d tried_spinup=%d\n",
 			    class, may_fallback, tried_spinup);
@@ -2104,7 +2104,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 retry:
 	ata_tf_init(dev, &tf);
 	if (ata_dma_enabled(dev) && ata_id_has_read_log_dma_ext(dev->id) &&
-	    !(dev->horkage & ATA_HORKAGE_NO_DMA_LOG)) {
+	    !(dev->quirks & ATA_QUIRK_NO_DMA_LOG)) {
 		tf.command = ATA_CMD_READ_LOG_DMA_EXT;
 		tf.protocol = ATA_PROT_DMA;
 		dma = true;
@@ -2124,7 +2124,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 	if (err_mask) {
 		if (dma) {
-			dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
+			dev->quirks |= ATA_QUIRK_NO_DMA_LOG;
 			if (!ata_port_is_frozen(dev->link->ap))
 				goto retry;
 		}
@@ -2140,7 +2140,7 @@ static int ata_log_supported(struct ata_device *dev, u8 log)
 {
 	struct ata_port *ap = dev->link->ap;
 
-	if (dev->horkage & ATA_HORKAGE_NO_LOG_DIR)
+	if (dev->quirks & ATA_QUIRK_NO_LOG_DIR)
 		return 0;
 
 	if (ata_read_log_page(dev, ATA_LOG_DIRECTORY, 0, ap->sector_buf, 1))
@@ -2153,7 +2153,7 @@ static bool ata_identify_page_supported(struct ata_device *dev, u8 page)
 	struct ata_port *ap = dev->link->ap;
 	unsigned int err, i;
 
-	if (dev->horkage & ATA_HORKAGE_NO_ID_DEV_LOG)
+	if (dev->quirks & ATA_QUIRK_NO_ID_DEV_LOG)
 		return false;
 
 	if (!ata_log_supported(dev, ATA_LOG_IDENTIFY_DEVICE)) {
@@ -2165,7 +2165,7 @@ static bool ata_identify_page_supported(struct ata_device *dev, u8 page)
 		if (ata_id_major_version(dev->id) >= 10)
 			ata_dev_warn(dev,
 				"ATA Identify Device Log not supported\n");
-		dev->horkage |= ATA_HORKAGE_NO_ID_DEV_LOG;
+		dev->quirks |= ATA_QUIRK_NO_ID_DEV_LOG;
 		return false;
 	}
 
@@ -2186,7 +2186,7 @@ static bool ata_identify_page_supported(struct ata_device *dev, u8 page)
 	return false;
 }
 
-static int ata_do_link_spd_horkage(struct ata_device *dev)
+static int ata_do_link_spd_quirk(struct ata_device *dev)
 {
 	struct ata_link *plink = ata_dev_phys_link(dev);
 	u32 target, target_limit;
@@ -2194,7 +2194,7 @@ static int ata_do_link_spd_horkage(struct ata_device *dev)
 	if (!sata_scr_valid(plink))
 		return 0;
 
-	if (dev->horkage & ATA_HORKAGE_1_5_GBPS)
+	if (dev->quirks & ATA_QUIRK_1_5_GBPS)
 		target = 1;
 	else
 		return 0;
@@ -2212,7 +2212,7 @@ static int ata_do_link_spd_horkage(struct ata_device *dev)
 	 * guaranteed by setting sata_spd_limit to target_limit above.
 	 */
 	if (plink->sata_spd > target) {
-		ata_dev_info(dev, "applying link speed limit horkage to %s\n",
+		ata_dev_info(dev, "applying link speed limit quirk to %s\n",
 			     sata_spd_string(target));
 		return -EAGAIN;
 	}
@@ -2223,7 +2223,7 @@ static inline bool ata_dev_knobble(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
 
-	if (ata_dev_blacklisted(dev) & ATA_HORKAGE_BRIDGE_OK)
+	if (ata_dev_quirks(dev) & ATA_QUIRK_BRIDGE_OK)
 		return false;
 
 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
@@ -2246,7 +2246,7 @@ static void ata_dev_config_ncq_send_recv(struct ata_device *dev)
 		dev->flags |= ATA_DFLAG_NCQ_SEND_RECV;
 		memcpy(cmds, ap->sector_buf, ATA_LOG_NCQ_SEND_RECV_SIZE);
 
-		if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM) {
+		if (dev->quirks & ATA_QUIRK_NO_NCQ_TRIM) {
 			ata_dev_dbg(dev, "disabling queued TRIM support\n");
 			cmds[ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET] &=
 				~ATA_LOG_NCQ_SEND_RECV_DSM_TRIM;
@@ -2334,12 +2334,12 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 	}
 	if (!IS_ENABLED(CONFIG_SATA_HOST))
 		return 0;
-	if (dev->horkage & ATA_HORKAGE_NONCQ) {
+	if (dev->quirks & ATA_QUIRK_NONCQ) {
 		snprintf(desc, desc_sz, "NCQ (not used)");
 		return 0;
 	}
 
-	if (dev->horkage & ATA_HORKAGE_NO_NCQ_ON_ATI &&
+	if (dev->quirks & ATA_QUIRK_NO_NCQ_ON_ATI &&
 	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI)) {
 		snprintf(desc, desc_sz, "NCQ (not used)");
 		return 0;
@@ -2350,7 +2350,7 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 		dev->flags |= ATA_DFLAG_NCQ;
 	}
 
-	if (!(dev->horkage & ATA_HORKAGE_BROKEN_FPDMA_AA) &&
+	if (!(dev->quirks & ATA_QUIRK_BROKEN_FPDMA_AA) &&
 		(ap->flags & ATA_FLAG_FPDMA_AA) &&
 		ata_id_has_fpdma_aa(dev->id)) {
 		err_mask = ata_dev_set_feature(dev, SETFEATURES_SATA_ENABLE,
@@ -2360,7 +2360,7 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 				    "failed to enable AA (error_mask=0x%x)\n",
 				    err_mask);
 			if (err_mask != AC_ERR_DEV) {
-				dev->horkage |= ATA_HORKAGE_BROKEN_FPDMA_AA;
+				dev->quirks |= ATA_QUIRK_BROKEN_FPDMA_AA;
 				return -EIO;
 			}
 		} else
@@ -2689,7 +2689,7 @@ static void ata_dev_config_fua(struct ata_device *dev)
 		goto nofua;
 
 	/* Ignore known bad devices and devices that lack NCQ support */
-	if (!ata_ncq_supported(dev) || (dev->horkage & ATA_HORKAGE_NO_FUA))
+	if (!ata_ncq_supported(dev) || (dev->quirks & ATA_QUIRK_NO_FUA))
 		goto nofua;
 
 	dev->flags |= ATA_DFLAG_FUA;
@@ -2829,11 +2829,11 @@ int ata_dev_configure(struct ata_device *dev)
 		return 0;
 	}
 
-	/* set horkage */
-	dev->horkage |= ata_dev_blacklisted(dev);
-	ata_force_horkage(dev);
+	/* Set quirks */
+	dev->quirks |= ata_dev_quirks(dev);
+	ata_force_quirks(dev);
 
-	if (dev->horkage & ATA_HORKAGE_DISABLE) {
+	if (dev->quirks & ATA_QUIRK_DISABLE) {
 		ata_dev_info(dev, "unsupported device, disabling\n");
 		ata_dev_disable(dev);
 		return 0;
@@ -2848,19 +2848,19 @@ int ata_dev_configure(struct ata_device *dev)
 		return 0;
 	}
 
-	rc = ata_do_link_spd_horkage(dev);
+	rc = ata_do_link_spd_quirk(dev);
 	if (rc)
 		return rc;
 
 	/* some WD SATA-1 drives have issues with LPM, turn on NOLPM for them */
-	if ((dev->horkage & ATA_HORKAGE_WD_BROKEN_LPM) &&
+	if ((dev->quirks & ATA_QUIRK_WD_BROKEN_LPM) &&
 	    (id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
-		dev->horkage |= ATA_HORKAGE_NOLPM;
+		dev->quirks |= ATA_QUIRK_NOLPM;
 
 	if (ap->flags & ATA_FLAG_NO_LPM)
-		dev->horkage |= ATA_HORKAGE_NOLPM;
+		dev->quirks |= ATA_QUIRK_NOLPM;
 
-	if (dev->horkage & ATA_HORKAGE_NOLPM) {
+	if (dev->quirks & ATA_QUIRK_NOLPM) {
 		ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
 		dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
 	}
@@ -3006,7 +3006,8 @@ int ata_dev_configure(struct ata_device *dev)
 			cdb_intr_string = ", CDB intr";
 		}
 
-		if (atapi_dmadir || (dev->horkage & ATA_HORKAGE_ATAPI_DMADIR) || atapi_id_dmadir(dev->id)) {
+		if (atapi_dmadir || (dev->quirks & ATA_QUIRK_ATAPI_DMADIR) ||
+		    atapi_id_dmadir(dev->id)) {
 			dev->flags |= ATA_DFLAG_DMADIR;
 			dma_dir_string = ", DMADIR";
 		}
@@ -3043,24 +3044,24 @@ int ata_dev_configure(struct ata_device *dev)
 	if ((dev->class == ATA_DEV_ATAPI) &&
 	    (atapi_command_packet_set(id) == TYPE_TAPE)) {
 		dev->max_sectors = ATA_MAX_SECTORS_TAPE;
-		dev->horkage |= ATA_HORKAGE_STUCK_ERR;
+		dev->quirks |= ATA_QUIRK_STUCK_ERR;
 	}
 
-	if (dev->horkage & ATA_HORKAGE_MAX_SEC_128)
+	if (dev->quirks & ATA_QUIRK_MAX_SEC_128)
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_128,
 					 dev->max_sectors);
 
-	if (dev->horkage & ATA_HORKAGE_MAX_SEC_1024)
+	if (dev->quirks & ATA_QUIRK_MAX_SEC_1024)
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_1024,
 					 dev->max_sectors);
 
-	if (dev->horkage & ATA_HORKAGE_MAX_SEC_LBA48)
+	if (dev->quirks & ATA_QUIRK_MAX_SEC_LBA48)
 		dev->max_sectors = ATA_MAX_SECTORS_LBA48;
 
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(dev);
 
-	if (dev->horkage & ATA_HORKAGE_DIAGNOSTIC) {
+	if (dev->quirks & ATA_QUIRK_DIAGNOSTIC) {
 		/* Let the user know. We don't want to disallow opens for
 		   rescue purposes, or in case the vendor is just a blithering
 		   idiot. Do this after the dev_config call as some controllers
@@ -3075,7 +3076,7 @@ int ata_dev_configure(struct ata_device *dev)
 		}
 	}
 
-	if ((dev->horkage & ATA_HORKAGE_FIRMWARE_WARN) && print_info) {
+	if ((dev->quirks & ATA_QUIRK_FIRMWARE_WARN) && print_info) {
 		ata_dev_warn(dev, "WARNING: device requires firmware update to be fully functional\n");
 		ata_dev_warn(dev, "         contact the vendor or visit http://ata.wiki.kernel.org\n");
 	}
@@ -3425,7 +3426,7 @@ static int ata_dev_set_mode(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
 	struct ata_eh_context *ehc = &dev->link->eh_context;
-	const bool nosetxfer = dev->horkage & ATA_HORKAGE_NOSETXFER;
+	const bool nosetxfer = dev->quirks & ATA_QUIRK_NOSETXFER;
 	const char *dev_err_whine = "";
 	int ign_dev_err = 0;
 	unsigned int err_mask = 0;
@@ -3969,7 +3970,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 	 */
 	if (dev->n_native_sectors == n_native_sectors &&
 	    dev->n_sectors < n_sectors && n_sectors == n_native_sectors &&
-	    !(dev->horkage & ATA_HORKAGE_BROKEN_HPA)) {
+	    !(dev->quirks & ATA_QUIRK_BROKEN_HPA)) {
 		ata_dev_warn(dev,
 			     "old n_sectors matches native, probably "
 			     "late HPA lock, will try to unlock HPA\n");
@@ -3987,223 +3988,223 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 	return rc;
 }
 
-struct ata_blacklist_entry {
+struct ata_dev_quirks_entry {
 	const char *model_num;
 	const char *model_rev;
-	unsigned long horkage;
+	unsigned int quirks;
 };
 
-static const struct ata_blacklist_entry ata_device_blacklist [] = {
+static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	/* Devices with DMA related problems under Linux */
-	{ "WDC AC11000H",	NULL,		ATA_HORKAGE_NODMA },
-	{ "WDC AC22100H",	NULL,		ATA_HORKAGE_NODMA },
-	{ "WDC AC32500H",	NULL,		ATA_HORKAGE_NODMA },
-	{ "WDC AC33100H",	NULL,		ATA_HORKAGE_NODMA },
-	{ "WDC AC31600H",	NULL,		ATA_HORKAGE_NODMA },
-	{ "WDC AC32100H",	"24.09P07",	ATA_HORKAGE_NODMA },
-	{ "WDC AC23200L",	"21.10N21",	ATA_HORKAGE_NODMA },
-	{ "Compaq CRD-8241B", 	NULL,		ATA_HORKAGE_NODMA },
-	{ "CRD-8400B",		NULL, 		ATA_HORKAGE_NODMA },
-	{ "CRD-848[02]B",	NULL,		ATA_HORKAGE_NODMA },
-	{ "CRD-84",		NULL,		ATA_HORKAGE_NODMA },
-	{ "SanDisk SDP3B",	NULL,		ATA_HORKAGE_NODMA },
-	{ "SanDisk SDP3B-64",	NULL,		ATA_HORKAGE_NODMA },
-	{ "SANYO CD-ROM CRD",	NULL,		ATA_HORKAGE_NODMA },
-	{ "HITACHI CDR-8",	NULL,		ATA_HORKAGE_NODMA },
-	{ "HITACHI CDR-8[34]35",NULL,		ATA_HORKAGE_NODMA },
-	{ "Toshiba CD-ROM XM-6202B", NULL,	ATA_HORKAGE_NODMA },
-	{ "TOSHIBA CD-ROM XM-1702BC", NULL,	ATA_HORKAGE_NODMA },
-	{ "CD-532E-A", 		NULL,		ATA_HORKAGE_NODMA },
-	{ "E-IDE CD-ROM CR-840",NULL,		ATA_HORKAGE_NODMA },
-	{ "CD-ROM Drive/F5A",	NULL,		ATA_HORKAGE_NODMA },
-	{ "WPI CDD-820", 	NULL,		ATA_HORKAGE_NODMA },
-	{ "SAMSUNG CD-ROM SC-148C", NULL,	ATA_HORKAGE_NODMA },
-	{ "SAMSUNG CD-ROM SC",	NULL,		ATA_HORKAGE_NODMA },
-	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",NULL,ATA_HORKAGE_NODMA },
-	{ "_NEC DV5800A", 	NULL,		ATA_HORKAGE_NODMA },
-	{ "SAMSUNG CD-ROM SN-124", "N001",	ATA_HORKAGE_NODMA },
-	{ "Seagate STT20000A", NULL,		ATA_HORKAGE_NODMA },
-	{ " 2GB ATA Flash Disk", "ADMA428M",	ATA_HORKAGE_NODMA },
-	{ "VRFDFC22048UCHC-TE*", NULL,		ATA_HORKAGE_NODMA },
+	{ "WDC AC11000H",	NULL,		ATA_QUIRK_NODMA },
+	{ "WDC AC22100H",	NULL,		ATA_QUIRK_NODMA },
+	{ "WDC AC32500H",	NULL,		ATA_QUIRK_NODMA },
+	{ "WDC AC33100H",	NULL,		ATA_QUIRK_NODMA },
+	{ "WDC AC31600H",	NULL,		ATA_QUIRK_NODMA },
+	{ "WDC AC32100H",	"24.09P07",	ATA_QUIRK_NODMA },
+	{ "WDC AC23200L",	"21.10N21",	ATA_QUIRK_NODMA },
+	{ "Compaq CRD-8241B",	NULL,		ATA_QUIRK_NODMA },
+	{ "CRD-8400B",		NULL,		ATA_QUIRK_NODMA },
+	{ "CRD-848[02]B",	NULL,		ATA_QUIRK_NODMA },
+	{ "CRD-84",		NULL,		ATA_QUIRK_NODMA },
+	{ "SanDisk SDP3B",	NULL,		ATA_QUIRK_NODMA },
+	{ "SanDisk SDP3B-64",	NULL,		ATA_QUIRK_NODMA },
+	{ "SANYO CD-ROM CRD",	NULL,		ATA_QUIRK_NODMA },
+	{ "HITACHI CDR-8",	NULL,		ATA_QUIRK_NODMA },
+	{ "HITACHI CDR-8[34]35", NULL,		ATA_QUIRK_NODMA },
+	{ "Toshiba CD-ROM XM-6202B", NULL,	ATA_QUIRK_NODMA },
+	{ "TOSHIBA CD-ROM XM-1702BC", NULL,	ATA_QUIRK_NODMA },
+	{ "CD-532E-A",		NULL,		ATA_QUIRK_NODMA },
+	{ "E-IDE CD-ROM CR-840", NULL,		ATA_QUIRK_NODMA },
+	{ "CD-ROM Drive/F5A",	NULL,		ATA_QUIRK_NODMA },
+	{ "WPI CDD-820",	NULL,		ATA_QUIRK_NODMA },
+	{ "SAMSUNG CD-ROM SC-148C", NULL,	ATA_QUIRK_NODMA },
+	{ "SAMSUNG CD-ROM SC",	NULL,		ATA_QUIRK_NODMA },
+	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM", NULL, ATA_QUIRK_NODMA },
+	{ "_NEC DV5800A",	NULL,		ATA_QUIRK_NODMA },
+	{ "SAMSUNG CD-ROM SN-124", "N001",	ATA_QUIRK_NODMA },
+	{ "Seagate STT20000A", NULL,		ATA_QUIRK_NODMA },
+	{ " 2GB ATA Flash Disk", "ADMA428M",	ATA_QUIRK_NODMA },
+	{ "VRFDFC22048UCHC-TE*", NULL,		ATA_QUIRK_NODMA },
 	/* Odd clown on sil3726/4726 PMPs */
-	{ "Config  Disk",	NULL,		ATA_HORKAGE_DISABLE },
+	{ "Config  Disk",	NULL,		ATA_QUIRK_DISABLE },
 	/* Similar story with ASMedia 1092 */
-	{ "ASMT109x- Config",	NULL,		ATA_HORKAGE_DISABLE },
+	{ "ASMT109x- Config",	NULL,		ATA_QUIRK_DISABLE },
 
 	/* Weird ATAPI devices */
-	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 },
-	{ "QUANTUM DAT    DAT72-000", NULL,	ATA_HORKAGE_ATAPI_MOD16_DMA },
-	{ "Slimtype DVD A  DS8A8SH", NULL,	ATA_HORKAGE_MAX_SEC_LBA48 },
-	{ "Slimtype DVD A  DS8A9SH", NULL,	ATA_HORKAGE_MAX_SEC_LBA48 },
+	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_QUIRK_MAX_SEC_128 },
+	{ "QUANTUM DAT    DAT72-000", NULL,	ATA_QUIRK_ATAPI_MOD16_DMA },
+	{ "Slimtype DVD A  DS8A8SH", NULL,	ATA_QUIRK_MAX_SEC_LBA48 },
+	{ "Slimtype DVD A  DS8A9SH", NULL,	ATA_QUIRK_MAX_SEC_LBA48 },
 
 	/*
 	 * Causes silent data corruption with higher max sects.
 	 * http://lkml.kernel.org/g/x49wpy40ysk.fsf@segfault.boston.devel.redhat.com
 	 */
-	{ "ST380013AS",		"3.20",		ATA_HORKAGE_MAX_SEC_1024 },
+	{ "ST380013AS",		"3.20",		ATA_QUIRK_MAX_SEC_1024 },
 
 	/*
 	 * These devices time out with higher max sects.
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=121671
 	 */
-	{ "LITEON CX1-JB*-HP",	NULL,		ATA_HORKAGE_MAX_SEC_1024 },
-	{ "LITEON EP1-*",	NULL,		ATA_HORKAGE_MAX_SEC_1024 },
+	{ "LITEON CX1-JB*-HP",	NULL,		ATA_QUIRK_MAX_SEC_1024 },
+	{ "LITEON EP1-*",	NULL,		ATA_QUIRK_MAX_SEC_1024 },
 
 	/* Devices we expect to fail diagnostics */
 
 	/* Devices where NCQ should be avoided */
 	/* NCQ is slow */
-	{ "WDC WD740ADFD-00",	NULL,		ATA_HORKAGE_NONCQ },
-	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ },
+	{ "WDC WD740ADFD-00",	NULL,		ATA_QUIRK_NONCQ },
+	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_QUIRK_NONCQ },
 	/* http://thread.gmane.org/gmane.linux.ide/14907 */
-	{ "FUJITSU MHT2060BH",	NULL,		ATA_HORKAGE_NONCQ },
+	{ "FUJITSU MHT2060BH",	NULL,		ATA_QUIRK_NONCQ },
 	/* NCQ is broken */
-	{ "Maxtor *",		"BANC*",	ATA_HORKAGE_NONCQ },
-	{ "Maxtor 7V300F0",	"VA111630",	ATA_HORKAGE_NONCQ },
-	{ "ST380817AS",		"3.42",		ATA_HORKAGE_NONCQ },
-	{ "ST3160023AS",	"3.42",		ATA_HORKAGE_NONCQ },
-	{ "OCZ CORE_SSD",	"02.10104",	ATA_HORKAGE_NONCQ },
+	{ "Maxtor *",		"BANC*",	ATA_QUIRK_NONCQ },
+	{ "Maxtor 7V300F0",	"VA111630",	ATA_QUIRK_NONCQ },
+	{ "ST380817AS",		"3.42",		ATA_QUIRK_NONCQ },
+	{ "ST3160023AS",	"3.42",		ATA_QUIRK_NONCQ },
+	{ "OCZ CORE_SSD",	"02.10104",	ATA_QUIRK_NONCQ },
 
 	/* Seagate NCQ + FLUSH CACHE firmware bug */
-	{ "ST31500341AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST31500341AS",	"SD1[5-9]",	ATA_QUIRK_NONCQ |
+						ATA_QUIRK_FIRMWARE_WARN },
 
-	{ "ST31000333AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST31000333AS",	"SD1[5-9]",	ATA_QUIRK_NONCQ |
+						ATA_QUIRK_FIRMWARE_WARN },
 
-	{ "ST3640[36]23AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3640[36]23AS",	"SD1[5-9]",	ATA_QUIRK_NONCQ |
+						ATA_QUIRK_FIRMWARE_WARN },
 
-	{ "ST3320[68]13AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3320[68]13AS",	"SD1[5-9]",	ATA_QUIRK_NONCQ |
+						ATA_QUIRK_FIRMWARE_WARN },
 
 	/* drives which fail FPDMA_AA activation (some may freeze afterwards)
 	   the ST disks also have LPM issues */
-	{ "ST1000LM024 HN-M101MBB", NULL,	ATA_HORKAGE_BROKEN_FPDMA_AA |
-						ATA_HORKAGE_NOLPM },
-	{ "VB0250EAVER",	"HPG7",		ATA_HORKAGE_BROKEN_FPDMA_AA },
+	{ "ST1000LM024 HN-M101MBB", NULL,	ATA_QUIRK_BROKEN_FPDMA_AA |
+						ATA_QUIRK_NOLPM },
+	{ "VB0250EAVER",	"HPG7",		ATA_QUIRK_BROKEN_FPDMA_AA },
 
 	/* Blacklist entries taken from Silicon Image 3124/3132
 	   Windows driver .inf file - also several Linux problem reports */
-	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ },
-	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ },
-	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ },
+	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_QUIRK_NONCQ },
+	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_QUIRK_NONCQ },
+	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_QUIRK_NONCQ },
 
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=15573 */
-	{ "C300-CTFDDAC128MAG",	"0001",		ATA_HORKAGE_NONCQ },
+	{ "C300-CTFDDAC128MAG",	"0001",		ATA_QUIRK_NONCQ },
 
 	/* Sandisk SD7/8/9s lock up hard on large trims */
-	{ "SanDisk SD[789]*",	NULL,		ATA_HORKAGE_MAX_TRIM_128M },
+	{ "SanDisk SD[789]*",	NULL,		ATA_QUIRK_MAX_TRIM_128M },
 
 	/* devices which puke on READ_NATIVE_MAX */
-	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA },
-	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
-	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_HORKAGE_BROKEN_HPA },
-	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_HORKAGE_BROKEN_HPA },
+	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_QUIRK_BROKEN_HPA },
+	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_QUIRK_BROKEN_HPA },
+	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_QUIRK_BROKEN_HPA },
+	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_QUIRK_BROKEN_HPA },
 
 	/* this one allows HPA unlocking but fails IOs on the area */
-	{ "OCZ-VERTEX",		    "1.30",	ATA_HORKAGE_BROKEN_HPA },
+	{ "OCZ-VERTEX",		    "1.30",	ATA_QUIRK_BROKEN_HPA },
 
 	/* Devices which report 1 sector over size HPA */
-	{ "ST340823A",		NULL,		ATA_HORKAGE_HPA_SIZE },
-	{ "ST320413A",		NULL,		ATA_HORKAGE_HPA_SIZE },
-	{ "ST310211A",		NULL,		ATA_HORKAGE_HPA_SIZE },
+	{ "ST340823A",		NULL,		ATA_QUIRK_HPA_SIZE },
+	{ "ST320413A",		NULL,		ATA_QUIRK_HPA_SIZE },
+	{ "ST310211A",		NULL,		ATA_QUIRK_HPA_SIZE },
 
 	/* Devices which get the IVB wrong */
-	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_HORKAGE_IVB },
-	/* Maybe we should just blacklist TSSTcorp... */
-	{ "TSSTcorp CDDVDW SH-S202[HJN]", "SB0[01]",  ATA_HORKAGE_IVB },
+	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_QUIRK_IVB },
+	/* Maybe we should just add all TSSTcorp devices... */
+	{ "TSSTcorp CDDVDW SH-S202[HJN]", "SB0[01]",  ATA_QUIRK_IVB },
 
 	/* Devices that do not need bridging limits applied */
-	{ "MTRON MSP-SATA*",		NULL,	ATA_HORKAGE_BRIDGE_OK },
-	{ "BUFFALO HD-QSU2/R5",		NULL,	ATA_HORKAGE_BRIDGE_OK },
+	{ "MTRON MSP-SATA*",		NULL,	ATA_QUIRK_BRIDGE_OK },
+	{ "BUFFALO HD-QSU2/R5",		NULL,	ATA_QUIRK_BRIDGE_OK },
 
 	/* Devices which aren't very happy with higher link speeds */
-	{ "WD My Book",			NULL,	ATA_HORKAGE_1_5_GBPS },
-	{ "Seagate FreeAgent GoFlex",	NULL,	ATA_HORKAGE_1_5_GBPS },
+	{ "WD My Book",			NULL,	ATA_QUIRK_1_5_GBPS },
+	{ "Seagate FreeAgent GoFlex",	NULL,	ATA_QUIRK_1_5_GBPS },
 
 	/*
 	 * Devices which choke on SETXFER.  Applies only if both the
 	 * device and controller are SATA.
 	 */
-	{ "PIONEER DVD-RW  DVRTD08",	NULL,	ATA_HORKAGE_NOSETXFER },
-	{ "PIONEER DVD-RW  DVRTD08A",	NULL,	ATA_HORKAGE_NOSETXFER },
-	{ "PIONEER DVD-RW  DVR-215",	NULL,	ATA_HORKAGE_NOSETXFER },
-	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
-	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVRTD08",	NULL,	ATA_QUIRK_NOSETXFER },
+	{ "PIONEER DVD-RW  DVRTD08A",	NULL,	ATA_QUIRK_NOSETXFER },
+	{ "PIONEER DVD-RW  DVR-215",	NULL,	ATA_QUIRK_NOSETXFER },
+	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_QUIRK_NOSETXFER },
+	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_QUIRK_NOSETXFER },
 
 	/* These specific Pioneer models have LPM issues */
-	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },
-	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_HORKAGE_NOLPM },
+	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_QUIRK_NOLPM },
+	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_QUIRK_NOLPM },
 
 	/* Crucial devices with broken LPM support */
-	{ "CT*0BX*00SSD1",		NULL,	ATA_HORKAGE_NOLPM },
+	{ "CT*0BX*00SSD1",		NULL,	ATA_QUIRK_NOLPM },
 
 	/* 512GB MX100 with MU01 firmware has both queued TRIM and LPM issues */
-	{ "Crucial_CT512MX100*",	"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NOLPM },
+	{ "Crucial_CT512MX100*",	"MU01",	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_NOLPM },
 	/* 512GB MX100 with newer firmware has only LPM issues */
-	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NOLPM },
+	{ "Crucial_CT512MX100*",	NULL,	ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_NOLPM },
 
 	/* 480GB+ M500 SSDs have both queued TRIM and LPM issues */
-	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NOLPM },
-	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NOLPM },
+	{ "Crucial_CT480M500*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_NOLPM },
+	{ "Crucial_CT960M500*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_NOLPM },
 
 	/* AMD Radeon devices with broken LPM support */
-	{ "R3SL240G",			NULL,	ATA_HORKAGE_NOLPM },
+	{ "R3SL240G",			NULL,	ATA_QUIRK_NOLPM },
 
 	/* Apacer models with LPM issues */
-	{ "Apacer AS340*",		NULL,	ATA_HORKAGE_NOLPM },
+	{ "Apacer AS340*",		NULL,	ATA_QUIRK_NOLPM },
 
 	/* These specific Samsung models/firmware-revs do not handle LPM well */
-	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM },
-	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM },
-	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM },
-	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_HORKAGE_NOLPM },
+	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_QUIRK_NOLPM },
+	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_QUIRK_NOLPM },
+	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_QUIRK_NOLPM },
+	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_QUIRK_NOLPM },
 
 	/* devices that don't properly handle queued TRIM commands */
-	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "Micron_M5[15]0_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "Micron_1100_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "Crucial_CT*M550*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "Samsung SSD 840 EVO*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_NO_DMA_LOG |
-						ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "Samsung SSD 860*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NO_NCQ_ON_ATI },
-	{ "Samsung SSD 870*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NO_NCQ_ON_ATI },
-	{ "SAMSUNG*MZ7LH*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NO_NCQ_ON_ATI, },
-	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM },
+	{ "Micron_M500IT_*",		"MU01",	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "Micron_M500_*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "Micron_M5[15]0_*",		"MU01",	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "Micron_1100_*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM, },
+	{ "Crucial_CT*M500*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "Crucial_CT*M550*",		"MU01",	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "Crucial_CT*MX100*",		"MU01",	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "Samsung SSD 840 EVO*",	NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_NO_DMA_LOG |
+						ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "Samsung SSD 840*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "Samsung SSD 850*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "Samsung SSD 860*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_NO_NCQ_ON_ATI },
+	{ "Samsung SSD 870*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_NO_NCQ_ON_ATI },
+	{ "SAMSUNG*MZ7LH*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_NO_NCQ_ON_ATI, },
+	{ "FCCT*M500*",			NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM },
 
 	/* devices that don't properly handle TRIM commands */
-	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM },
-	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM },
+	{ "SuperSSpeed S238*",		NULL,	ATA_QUIRK_NOTRIM },
+	{ "M88V29*",			NULL,	ATA_QUIRK_NOTRIM },
 
 	/*
 	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
@@ -4223,14 +4224,14 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 */
 	{ "INTEL*SSDSC2MH*",		NULL,	0 },
 
-	{ "Micron*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "Crucial*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "INTEL*SSD*", 		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "SSD*INTEL*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "Samsung*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "SAMSUNG*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "SAMSUNG*MZ7KM*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
-	{ "ST[1248][0248]0[FH]*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
+	{ "Micron*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "Crucial*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "INTEL*SSD*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "SSD*INTEL*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "Samsung*SSD*",		NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "SAMSUNG*SSD*",		NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "SAMSUNG*MZ7KM*",		NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "ST[1248][0248]0[FH]*",	NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
 
 	/*
 	 * Some WD SATA-I drives spin up and down erratically when the link
@@ -4241,36 +4242,36 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 *
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=57211
 	 */
-	{ "WDC WD800JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
-	{ "WDC WD1200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
-	{ "WDC WD1600JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
-	{ "WDC WD2000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
-	{ "WDC WD2500JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
-	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
-	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
+	{ "WDC WD800JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
+	{ "WDC WD1200JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
+	{ "WDC WD1600JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
+	{ "WDC WD2000JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
+	{ "WDC WD2500JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
+	{ "WDC WD3000JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
+	{ "WDC WD3200JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
 
 	/*
 	 * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY
 	 * log page is accessed. Ensure we never ask for this log page with
 	 * these devices.
 	 */
-	{ "SATADOM-ML 3ME",		NULL,	ATA_HORKAGE_NO_LOG_DIR },
+	{ "SATADOM-ML 3ME",		NULL,	ATA_QUIRK_NO_LOG_DIR },
 
 	/* Buggy FUA */
-	{ "Maxtor",		"BANC1G10",	ATA_HORKAGE_NO_FUA },
-	{ "WDC*WD2500J*",	NULL,		ATA_HORKAGE_NO_FUA },
-	{ "OCZ-VERTEX*",	NULL,		ATA_HORKAGE_NO_FUA },
-	{ "INTEL*SSDSC2CT*",	NULL,		ATA_HORKAGE_NO_FUA },
+	{ "Maxtor",		"BANC1G10",	ATA_QUIRK_NO_FUA },
+	{ "WDC*WD2500J*",	NULL,		ATA_QUIRK_NO_FUA },
+	{ "OCZ-VERTEX*",	NULL,		ATA_QUIRK_NO_FUA },
+	{ "INTEL*SSDSC2CT*",	NULL,		ATA_QUIRK_NO_FUA },
 
 	/* End Marker */
 	{ }
 };
 
-static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
+static unsigned int ata_dev_quirks(const struct ata_device *dev)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
-	const struct ata_blacklist_entry *ad = ata_device_blacklist;
+	const struct ata_dev_quirks_entry *ad = __ata_dev_quirks;
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
@@ -4278,9 +4279,9 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
 	while (ad->model_num) {
 		if (glob_match(ad->model_num, model_num)) {
 			if (ad->model_rev == NULL)
-				return ad->horkage;
+				return ad->quirks;
 			if (glob_match(ad->model_rev, model_rev))
-				return ad->horkage;
+				return ad->quirks;
 		}
 		ad++;
 	}
@@ -4297,7 +4298,7 @@ static bool ata_dev_nodma(const struct ata_device *dev)
 	if ((dev->link->ap->flags & ATA_FLAG_PIO_POLLING) &&
 	    (dev->flags & ATA_DFLAG_CDB_INTR))
 		return true;
-	return dev->horkage & ATA_HORKAGE_NODMA;
+	return dev->quirks & ATA_QUIRK_NODMA;
 }
 
 /**
@@ -4310,7 +4311,7 @@ static bool ata_dev_nodma(const struct ata_device *dev)
 
 static int ata_is_40wire(struct ata_device *dev)
 {
-	if (dev->horkage & ATA_HORKAGE_IVB)
+	if (dev->quirks & ATA_QUIRK_IVB)
 		return ata_drive_40wire_relaxed(dev->id);
 	return ata_drive_40wire(dev->id);
 }
@@ -4372,8 +4373,7 @@ static int cable_is_40wire(struct ata_port *ap)
  *
  *	Compute supported xfermask of @dev and store it in
  *	dev->*_mask.  This function is responsible for applying all
- *	known limits including host controller limits, device
- *	blacklist, etc...
+ *	known limits including host controller limits, device quirks, etc...
  *
  *	LOCKING:
  *	None.
@@ -4589,7 +4589,7 @@ int atapi_check_dma(struct ata_queued_cmd *qc)
 	/* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
 	 * few ATAPI devices choke on such DMA requests.
 	 */
-	if (!(qc->dev->horkage & ATA_HORKAGE_ATAPI_MOD16_DMA) &&
+	if (!(qc->dev->quirks & ATA_QUIRK_ATAPI_MOD16_DMA) &&
 	    unlikely(qc->nbytes & 15))
 		return 1;
 
@@ -5369,7 +5369,7 @@ void ata_dev_init(struct ata_device *dev)
 	 */
 	spin_lock_irqsave(ap->lock, flags);
 	dev->flags &= ~ATA_DFLAG_INIT_MASK;
-	dev->horkage = 0;
+	dev->quirks = 0;
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	memset((void *)dev + ATA_DEVICE_CLEAR_BEGIN, 0,
@@ -6298,12 +6298,12 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 	{ "no" #name,	.lflags_on	= (flags) },	\
 	{ #name,	.lflags_off	= (flags) }
 
-#define force_horkage_on(name, flag)			\
-	{ #name,	.horkage_on	= (flag) }
+#define force_quirk_on(name, flag)			\
+	{ #name,	.quirk_on	= (flag) }
 
-#define force_horkage_onoff(name, flag)			\
-	{ "no" #name,	.horkage_on	= (flag) },	\
-	{ #name,	.horkage_off	= (flag) }
+#define force_quirk_onoff(name, flag)			\
+	{ "no" #name,	.quirk_on	= (flag) },	\
+	{ #name,	.quirk_off	= (flag) }
 
 static const struct ata_force_param force_tbl[] __initconst = {
 	force_cbl(40c,			ATA_CBL_PATA40),
@@ -6357,32 +6357,32 @@ static const struct ata_force_param force_tbl[] __initconst = {
 	force_lflag_on(rstonce,		ATA_LFLAG_RST_ONCE),
 	force_lflag_onoff(dbdelay,	ATA_LFLAG_NO_DEBOUNCE_DELAY),
 
-	force_horkage_onoff(ncq,	ATA_HORKAGE_NONCQ),
-	force_horkage_onoff(ncqtrim,	ATA_HORKAGE_NO_NCQ_TRIM),
-	force_horkage_onoff(ncqati,	ATA_HORKAGE_NO_NCQ_ON_ATI),
+	force_quirk_onoff(ncq,		ATA_QUIRK_NONCQ),
+	force_quirk_onoff(ncqtrim,	ATA_QUIRK_NO_NCQ_TRIM),
+	force_quirk_onoff(ncqati,	ATA_QUIRK_NO_NCQ_ON_ATI),
 
-	force_horkage_onoff(trim,	ATA_HORKAGE_NOTRIM),
-	force_horkage_on(trim_zero,	ATA_HORKAGE_ZERO_AFTER_TRIM),
-	force_horkage_on(max_trim_128m, ATA_HORKAGE_MAX_TRIM_128M),
+	force_quirk_onoff(trim,		ATA_QUIRK_NOTRIM),
+	force_quirk_on(trim_zero,	ATA_QUIRK_ZERO_AFTER_TRIM),
+	force_quirk_on(max_trim_128m,	ATA_QUIRK_MAX_TRIM_128M),
 
-	force_horkage_onoff(dma,	ATA_HORKAGE_NODMA),
-	force_horkage_on(atapi_dmadir,	ATA_HORKAGE_ATAPI_DMADIR),
-	force_horkage_on(atapi_mod16_dma, ATA_HORKAGE_ATAPI_MOD16_DMA),
+	force_quirk_onoff(dma,		ATA_QUIRK_NODMA),
+	force_quirk_on(atapi_dmadir,	ATA_QUIRK_ATAPI_DMADIR),
+	force_quirk_on(atapi_mod16_dma,	ATA_QUIRK_ATAPI_MOD16_DMA),
 
-	force_horkage_onoff(dmalog,	ATA_HORKAGE_NO_DMA_LOG),
-	force_horkage_onoff(iddevlog,	ATA_HORKAGE_NO_ID_DEV_LOG),
-	force_horkage_onoff(logdir,	ATA_HORKAGE_NO_LOG_DIR),
+	force_quirk_onoff(dmalog,	ATA_QUIRK_NO_DMA_LOG),
+	force_quirk_onoff(iddevlog,	ATA_QUIRK_NO_ID_DEV_LOG),
+	force_quirk_onoff(logdir,	ATA_QUIRK_NO_LOG_DIR),
 
-	force_horkage_on(max_sec_128,	ATA_HORKAGE_MAX_SEC_128),
-	force_horkage_on(max_sec_1024,	ATA_HORKAGE_MAX_SEC_1024),
-	force_horkage_on(max_sec_lba48,	ATA_HORKAGE_MAX_SEC_LBA48),
+	force_quirk_on(max_sec_128,	ATA_QUIRK_MAX_SEC_128),
+	force_quirk_on(max_sec_1024,	ATA_QUIRK_MAX_SEC_1024),
+	force_quirk_on(max_sec_lba48,	ATA_QUIRK_MAX_SEC_LBA48),
 
-	force_horkage_onoff(lpm,	ATA_HORKAGE_NOLPM),
-	force_horkage_onoff(setxfer,	ATA_HORKAGE_NOSETXFER),
-	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
-	force_horkage_onoff(fua,	ATA_HORKAGE_NO_FUA),
+	force_quirk_onoff(lpm,		ATA_QUIRK_NOLPM),
+	force_quirk_onoff(setxfer,	ATA_QUIRK_NOSETXFER),
+	force_quirk_on(dump_id,		ATA_QUIRK_DUMP_ID),
+	force_quirk_onoff(fua,		ATA_QUIRK_NO_FUA),
 
-	force_horkage_on(disable,	ATA_HORKAGE_DISABLE),
+	force_quirk_on(disable,		ATA_QUIRK_DISABLE),
 };
 
 static int __init ata_parse_force_one(char **cur,
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 48660d445602..ecd37649d4d4 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -818,7 +818,7 @@ static ssize_t ata_scsi_lpm_store(struct device *device,
 
 	ata_for_each_link(link, ap, EDGE) {
 		ata_for_each_dev(dev, &ap->link, ENABLED) {
-			if (dev->horkage & ATA_HORKAGE_NOLPM) {
+			if (dev->quirks & ATA_QUIRK_NOLPM) {
 				count = -EOPNOTSUPP;
 				goto out_unlock;
 			}
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d6f5e25e1ed8..3a442f564b0d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2083,7 +2083,7 @@ static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
 	if (ata_id_has_trim(args->id)) {
 		u64 max_blocks = 65535 * ATA_MAX_TRIM_RNUM;
 
-		if (dev->horkage & ATA_HORKAGE_MAX_TRIM_128M)
+		if (dev->quirks & ATA_QUIRK_MAX_TRIM_128M)
 			max_blocks = 128 << (20 - SECTOR_SHIFT);
 
 		put_unaligned_be64(max_blocks, &rbuf[36]);
@@ -2561,11 +2561,11 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 		rbuf[15] = lowest_aligned;
 
 		if (ata_id_has_trim(args->id) &&
-		    !(dev->horkage & ATA_HORKAGE_NOTRIM)) {
+		    !(dev->quirks & ATA_QUIRK_NOTRIM)) {
 			rbuf[14] |= 0x80; /* LBPME */
 
 			if (ata_id_has_zero_after_trim(args->id) &&
-			    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM) {
+			    dev->quirks & ATA_QUIRK_ZERO_AFTER_TRIM) {
 				ata_dev_info(dev, "Enabling discard_zeroes_data\n");
 				rbuf[14] |= 0x40; /* LBPRZ */
 			}
@@ -3229,8 +3229,7 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	}
 	scsi_16_lba_len(cdb, &block, &n_block);
 
-	if (!unmap ||
-	    (dev->horkage & ATA_HORKAGE_NOTRIM) ||
+	if (!unmap || (dev->quirks & ATA_QUIRK_NOTRIM) ||
 	    !ata_id_has_trim(dev->id)) {
 		fp = 1;
 		bp = 3;
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 250f7dae05fd..06868ec5b1fd 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -970,7 +970,7 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 			 * We ignore ERR here to workaround and proceed sending
 			 * the CDB.
 			 */
-			if (!(qc->dev->horkage & ATA_HORKAGE_STUCK_ERR)) {
+			if (!(qc->dev->quirks & ATA_QUIRK_STUCK_ERR)) {
 				ata_ehi_push_desc(ehi, "ST_FIRST: "
 					"DRQ=1 with device error, "
 					"dev_stat 0x%X", status);
@@ -1045,8 +1045,8 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 					 * IDENTIFY, it's likely a phantom
 					 * device.  Mark hint.
 					 */
-					if (qc->dev->horkage &
-					    ATA_HORKAGE_DIAGNOSTIC)
+					if (qc->dev->quirks &
+					    ATA_QUIRK_DIAGNOSTIC)
 						qc->err_mask |=
 							AC_ERR_NODEV_HINT;
 				} else {
@@ -1762,7 +1762,7 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
 	/* see if device passed diags: continue and warn later */
 	if (err == 0)
 		/* diagnostic fail : do nothing _YET_ */
-		dev->horkage |= ATA_HORKAGE_DIAGNOSTIC;
+		dev->quirks |= ATA_QUIRK_DIAGNOSTIC;
 	else if (err == 1)
 		/* do nothing */ ;
 	else if ((dev->devno == 0) && (err == 0x81))
@@ -1781,7 +1781,7 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
 		 * device signature is invalid with diagnostic
 		 * failure.
 		 */
-		if (present && (dev->horkage & ATA_HORKAGE_DIAGNOSTIC))
+		if (present && (dev->quirks & ATA_QUIRK_DIAGNOSTIC))
 			class = ATA_DEV_ATA;
 		else
 			class = ATA_DEV_NONE;
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 9e24c33388f9..48800cd0e75d 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -617,10 +617,10 @@ show_ata_dev_trim(struct device *dev,
 
 	if (!ata_id_has_trim(ata_dev->id))
 		mode = "unsupported";
-	else if (ata_dev->horkage & ATA_HORKAGE_NOTRIM)
+	else if (ata_dev->quirks & ATA_QUIRK_NOTRIM)
 		mode = "forced_unsupported";
-	else if (ata_dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
-			mode = "forced_unqueued";
+	else if (ata_dev->quirks & ATA_QUIRK_NO_NCQ_TRIM)
+		mode = "forced_unqueued";
 	else if (ata_fpdma_dsm_supported(ata_dev))
 		mode = "queued";
 	else
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 2fe3fb6102ce..042f6ad1f7c6 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -519,9 +519,9 @@ static void it821x_dev_config(struct ata_device *adev)
 	}
 	/* This is a controller firmware triggered funny, don't
 	   report the drive faulty! */
-	adev->horkage &= ~ATA_HORKAGE_DIAGNOSTIC;
+	adev->quirks &= ~ATA_QUIRK_DIAGNOSTIC;
 	/* No HPA in 'smart' mode */
-	adev->horkage |= ATA_HORKAGE_BROKEN_HPA;
+	adev->quirks |= ATA_QUIRK_BROKEN_HPA;
 }
 
 /**
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index cc77c0248284..354b68ef91bc 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -616,7 +616,7 @@ static void sil_dev_config(struct ata_device *dev)
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 
 	/* This controller doesn't support trim */
-	dev->horkage |= ATA_HORKAGE_NOTRIM;
+	dev->quirks |= ATA_QUIRK_NOTRIM;
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 17394098bee9..05dd7038ab30 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -362,40 +362,41 @@ enum {
 	 */
 	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 8,
 
-	/* Horkage types. May be set by libata or controller on drives
-	   (some horkage may be drive/controller pair dependent */
-
-	ATA_HORKAGE_DIAGNOSTIC	= (1 << 0),	/* Failed boot diag */
-	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
-	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
-	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
-	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
-	ATA_HORKAGE_DISABLE	= (1 << 5),	/* Disable it */
-	ATA_HORKAGE_HPA_SIZE	= (1 << 6),	/* native size off by one */
-	ATA_HORKAGE_IVB		= (1 << 8),	/* cbl det validity bit bugs */
-	ATA_HORKAGE_STUCK_ERR	= (1 << 9),	/* stuck ERR on next PACKET */
-	ATA_HORKAGE_BRIDGE_OK	= (1 << 10),	/* no bridge limits */
-	ATA_HORKAGE_ATAPI_MOD16_DMA = (1 << 11), /* use ATAPI DMA for commands
-						    not multiple of 16 bytes */
-	ATA_HORKAGE_FIRMWARE_WARN = (1 << 12),	/* firmware update warning */
-	ATA_HORKAGE_1_5_GBPS	= (1 << 13),	/* force 1.5 Gbps */
-	ATA_HORKAGE_NOSETXFER	= (1 << 14),	/* skip SETXFER, SATA only */
-	ATA_HORKAGE_BROKEN_FPDMA_AA	= (1 << 15),	/* skip AA */
-	ATA_HORKAGE_DUMP_ID	= (1 << 16),	/* dump IDENTIFY data */
-	ATA_HORKAGE_MAX_SEC_LBA48 = (1 << 17),	/* Set max sects to 65535 */
-	ATA_HORKAGE_ATAPI_DMADIR = (1 << 18),	/* device requires dmadir */
-	ATA_HORKAGE_NO_NCQ_TRIM	= (1 << 19),	/* don't use queued TRIM */
-	ATA_HORKAGE_NOLPM	= (1 << 20),	/* don't use LPM */
-	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
-	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
-	ATA_HORKAGE_NO_DMA_LOG	= (1 << 23),	/* don't use DMA for log read */
-	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
-	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
-	ATA_HORKAGE_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
-	ATA_HORKAGE_NO_NCQ_ON_ATI = (1 << 27),	/* Disable NCQ on ATI chipset */
-	ATA_HORKAGE_NO_ID_DEV_LOG = (1 << 28),	/* Identify device log missing */
-	ATA_HORKAGE_NO_LOG_DIR	= (1 << 29),	/* Do not read log directory */
-	ATA_HORKAGE_NO_FUA	= (1 << 30),	/* Do not use FUA */
+	/*
+	 * Quirk flags: may be set by libata or controller drivers on drives.
+	 * Some quirks may be drive/controller pair dependent.
+	 */
+	ATA_QUIRK_DIAGNOSTIC	= (1 << 0),	/* Failed boot diag */
+	ATA_QUIRK_NODMA		= (1 << 1),	/* DMA problems */
+	ATA_QUIRK_NONCQ		= (1 << 2),	/* Do not use NCQ */
+	ATA_QUIRK_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
+	ATA_QUIRK_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
+	ATA_QUIRK_DISABLE	= (1 << 5),	/* Disable it */
+	ATA_QUIRK_HPA_SIZE	= (1 << 6),	/* Native size off by one */
+	ATA_QUIRK_IVB		= (1 << 8),	/* CBL det validity bit bugs */
+	ATA_QUIRK_STUCK_ERR	= (1 << 9),	/* Stuck ERR on next PACKET */
+	ATA_QUIRK_BRIDGE_OK	= (1 << 10),	/* No bridge limits */
+	ATA_QUIRK_ATAPI_MOD16_DMA = (1 << 11),	/* Use ATAPI DMA for commands */
+						/* not multiple of 16 bytes */
+	ATA_QUIRK_FIRMWARE_WARN = (1 << 12),	/* Firmware update warning */
+	ATA_QUIRK_1_5_GBPS	= (1 << 13),	/* Force 1.5 Gbps */
+	ATA_QUIRK_NOSETXFER	= (1 << 14),	/* Skip SETXFER, SATA only */
+	ATA_QUIRK_BROKEN_FPDMA_AA = (1 << 15),	/* Skip AA */
+	ATA_QUIRK_DUMP_ID	= (1 << 16),	/* Dump IDENTIFY data */
+	ATA_QUIRK_MAX_SEC_LBA48 = (1 << 17),	/* Set max sects to 65535 */
+	ATA_QUIRK_ATAPI_DMADIR	= (1 << 18),	/* Device requires dmadir */
+	ATA_QUIRK_NO_NCQ_TRIM	= (1 << 19),	/* Do not use queued TRIM */
+	ATA_QUIRK_NOLPM		= (1 << 20),	/* Do not use LPM */
+	ATA_QUIRK_WD_BROKEN_LPM = (1 << 21),	/* Some WDs have broken LPM */
+	ATA_QUIRK_ZERO_AFTER_TRIM = (1 << 22),	/* Guarantees zero after trim */
+	ATA_QUIRK_NO_DMA_LOG	= (1 << 23),	/* Do not use DMA for log read */
+	ATA_QUIRK_NOTRIM	= (1 << 24),	/* Do not use TRIM */
+	ATA_QUIRK_MAX_SEC_1024	= (1 << 25),	/* Limit max sects to 1024 */
+	ATA_QUIRK_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
+	ATA_QUIRK_NO_NCQ_ON_ATI = (1 << 27),	/* Disable NCQ on ATI chipset */
+	ATA_QUIRK_NO_ID_DEV_LOG = (1 << 28),	/* Identify device log missing */
+	ATA_QUIRK_NO_LOG_DIR	= (1 << 29),	/* Do not read log directory */
+	ATA_QUIRK_NO_FUA	= (1 << 30),	/* Do not use FUA */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
@@ -663,7 +664,7 @@ struct ata_cpr_log {
 struct ata_device {
 	struct ata_link		*link;
 	unsigned int		devno;		/* 0 or 1 */
-	unsigned int		horkage;	/* List of broken features */
+	unsigned int		quirks;		/* List of broken features */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	struct scsi_device	*sdev;		/* attached SCSI device */
 	void			*private_data;
-- 
2.45.2

