Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048A136671
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657472; cv=none; b=BWqD7A0IR2tT6yMY88d+695WNfgM4qKiEcP6iwouSAr7mTwq89PU9Zb3glB/hx8jhXZYd60yxwJ6iKIoI+/gqiOQPtz/bKpOxrV/6C7rg0p7hXmO326qaIGmzirs7vmy/erZ3EX1D2Whan/MywVOvhWE/gZo022er7QMPJRPtzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657472; c=relaxed/simple;
	bh=VQeLVRCwCccMNRuqGa7+mLUZJRGvSpjRkR8FZPdc83k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORESTPeb1mw3w2sbr0ZalzPKN05FQPLlm6NOakgGjHiZqsy7YKt33HLY7Z3VGwKZef9wBSC8Ta8rZGgXqrwoZE+9Di+Hhx2ykYIfASKNH60iJiK2IqfsNaD4HWGGCBPBd5lpB3NkW6pPrHJB2P5jPC+UJetPq8TGFoOSBkbeiSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8B3tf+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8B3tf+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DD3C8CDC1;
	Mon, 26 Aug 2024 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724657472;
	bh=VQeLVRCwCccMNRuqGa7+mLUZJRGvSpjRkR8FZPdc83k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U8B3tf+XjtqjjkK6rRLS4DvznZ9qMFIDzIlYe16/GKSvGDrngpjN9Vx0r0CTu0dej
	 QBIXUDnqklGo6lLeHm9wAgJclI3XZF833ZajXw59U8P8IPRwrbp9Yruk9PQT0Qwomi
	 LA55bJ7IQC+HqYdi/cqUdfH/gmXeQKG675B2vv6xgPfK6gP7WchB2UIlLCP1LM4cxu
	 WxxST5DguFrUFz4zDqeSt0X6Hp52r0nSiGu7Ic2CZkrUCAvm2z7Z76am1X0YG6huyv
	 FUdTLJWa9v70pMfjVj/Nq1uue8qcacj1glKpmxcwiE8Bhlh8oupbG+X6d2DdGCEPyg
	 HMWqdvParu/Dg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 7/7] ata: libata: Improve CDL resource management
Date: Mon, 26 Aug 2024 16:31:06 +0900
Message-ID: <20240826073106.56918-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826073106.56918-1-dlemoal@kernel.org>
References: <20240826073106.56918-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command duration limits (CDL) log buffer of struct ata_device is
needed only if a device actually supports CDL. The same applies to the
ncq_sense_log buffer.

Group these 2 buffers into a new structure ata_cdl defining both buffers
as embedded buffers (no allocation needed) and allocate this structure
from ata_dev_config_cdl() only for devices that support CDL.

The functions ata_dev_init_cdl_resources() and
ata_dev_cleanup_cdl_resources() are defined to manage this new structure
allocation, initialization and cleanup when a device is removed.
ata_dev_cleanup_cdl_resources() is called from ata_tdev_free().

Note that the cdl log buffer name is changed to desc_log_buf to make it
clearer what it is.

This change reduces the size of struct ata_device and reduces memory
usage for ATA devices that do not support CDL.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c      | 56 +++++++++++++++++++++-------------
 drivers/ata/libata-sata.c      |  2 +-
 drivers/ata/libata-scsi.c      |  2 +-
 drivers/ata/libata-transport.c |  4 +--
 drivers/ata/libata.h           |  1 +
 include/linux/libata.h         | 18 +++++++++--
 6 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6a1d300dd1f5..bcee96e29b34 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2475,12 +2475,41 @@ static void ata_dev_config_trusted(struct ata_device *dev)
 		dev->flags |= ATA_DFLAG_TRUSTED;
 }
 
+static int ata_dev_init_cdl_resources(struct ata_device *dev)
+{
+	struct ata_cdl *cdl = dev->cdl;
+	unsigned int err_mask;
+
+	if (!cdl) {
+		cdl = kzalloc(sizeof(struct ata_cdl), GFP_KERNEL);
+		if (!cdl)
+			return -ENOMEM;
+		dev->cdl = cdl;
+	}
+
+	err_mask = ata_read_log_page(dev, ATA_LOG_CDL, 0, cdl->desc_log_buf,
+				     ATA_LOG_CDL_SIZE / ATA_SECT_SIZE);
+	if (err_mask) {
+		ata_dev_warn(dev, "Read Command Duration Limits log failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void ata_dev_cleanup_cdl_resources(struct ata_device *dev)
+{
+	kfree(dev->cdl);
+	dev->cdl = NULL;
+}
+
 static void ata_dev_config_cdl(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
 	unsigned int err_mask;
 	bool cdl_enabled;
 	u64 val;
+	int ret;
 
 	if (ata_id_major_version(dev->id) < 11)
 		goto not_supported;
@@ -2575,37 +2604,20 @@ static void ata_dev_config_cdl(struct ata_device *dev)
 		}
 	}
 
-	/*
-	 * Allocate a buffer to handle reading the sense data for successful
-	 * NCQ Commands log page for commands using a CDL with one of the limit
-	 * policy set to 0xD (successful completion with sense data available
-	 * bit set).
-	 */
-	if (!dev->ncq_sense_buf) {
-		dev->ncq_sense_buf = kmalloc(ATA_LOG_SENSE_NCQ_SIZE, GFP_KERNEL);
-		if (!dev->ncq_sense_buf)
-			goto not_supported;
-	}
-
-	/*
-	 * Command duration limits is supported: cache the CDL log page 18h
-	 * (command duration descriptors).
-	 */
-	err_mask = ata_read_log_page(dev, ATA_LOG_CDL, 0, ap->sector_buf, 1);
-	if (err_mask) {
-		ata_dev_warn(dev, "Read Command Duration Limits log failed\n");
+	/* CDL is supported: allocate and initialize needed resources. */
+	ret = ata_dev_init_cdl_resources(dev);
+	if (ret) {
+		ata_dev_warn(dev, "Initialize CDL resources failed\n");
 		goto not_supported;
 	}
 
-	memcpy(dev->cdl, ap->sector_buf, ATA_LOG_CDL_SIZE);
 	dev->flags |= ATA_DFLAG_CDL;
 
 	return;
 
 not_supported:
 	dev->flags &= ~(ATA_DFLAG_CDL | ATA_DFLAG_CDL_ENABLED);
-	kfree(dev->ncq_sense_buf);
-	dev->ncq_sense_buf = NULL;
+	ata_dev_cleanup_cdl_resources(dev);
 }
 
 static int ata_dev_config_lba(struct ata_device *dev)
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 50ea254a213d..e05fb09af061 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1505,7 +1505,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 {
 	struct ata_device *dev = link->device;
 	struct ata_port *ap = dev->link->ap;
-	u8 *buf = dev->ncq_sense_buf;
+	u8 *buf = dev->cdl->ncq_sense_log_buf;
 	struct ata_queued_cmd *qc;
 	unsigned int err_mask, tag;
 	u8 *sense, sk = 0, asc = 0, ascq = 0;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a3ffce4b218d..7fed924d6561 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2259,7 +2259,7 @@ static inline u16 ata_xlat_cdl_limit(u8 *buf)
 static unsigned int ata_msense_control_spgt2(struct ata_device *dev, u8 *buf,
 					     u8 spg)
 {
-	u8 *b, *cdl = dev->cdl, *desc;
+	u8 *b, *cdl = dev->cdl->desc_log_buf, *desc;
 	u32 policy;
 	int i;
 
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 14f50c91ceb9..add230c0d51e 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -671,9 +671,7 @@ static int ata_tdev_match(struct attribute_container *cont,
  */
 static void ata_tdev_free(struct ata_device *dev)
 {
-	kfree(dev->ncq_sense_buf);
-	dev->ncq_sense_buf = NULL;
-
+	ata_dev_cleanup_cdl_resources(dev);
 	transport_destroy_device(&dev->tdev);
 	put_device(&dev->tdev);
 }
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 5ca17784a350..df11f923e1a2 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -89,6 +89,7 @@ extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern const char *sata_spd_string(unsigned int spd);
 extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 				      u8 page, void *buf, unsigned int sectors);
+void ata_dev_cleanup_cdl_resources(struct ata_device *dev);
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3fb6980c8aa1..37a5509adc77 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -700,6 +700,21 @@ struct ata_cpr_log {
 	struct ata_cpr		cpr[] __counted_by(nr_cpr);
 };
 
+struct ata_cdl {
+	/*
+	 * Buffer to cache the CDL log page 18h (command duration descriptors)
+	 * for SCSI-ATA translation.
+	 */
+	u8			desc_log_buf[ATA_LOG_CDL_SIZE];
+
+	/*
+	 * Buffer to handle reading the sense data for successful NCQ Commands
+	 * log page for commands using a CDL with one of the limits policy set
+	 * to 0xD (successful completion with sense data available bit set).
+	 */
+	u8			ncq_sense_log_buf[ATA_LOG_SENSE_NCQ_SIZE];
+};
+
 struct ata_device {
 	struct ata_link		*link;
 	unsigned int		devno;		/* 0 or 1 */
@@ -763,8 +778,7 @@ struct ata_device {
 	struct ata_cpr_log	*cpr_log;
 
 	/* Command Duration Limits support */
-	u8			*ncq_sense_buf;
-	u8			cdl[ATA_LOG_CDL_SIZE];
+	struct ata_cdl		*cdl;
 
 	/* error history */
 	int			spdn_cnt;
-- 
2.46.0

