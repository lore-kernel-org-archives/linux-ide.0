Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B462264A3
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010857; cv=none; b=XTrAw1oUC98LEbHbruHnZRchywjXMSCaa9G2shYzyUMb5Z/yQEiDt4QlWkBl84arzQkA96ZNxy8Cyt3LHGbkKiApRukTGyWLZqaiLqAoX7pPq7NX1qSxOuMEby8s2H9rSbJ4RYNJ3oGUZKqMEr68kUnWWPH4IbFjSUTdJIYN5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010857; c=relaxed/simple;
	bh=RAijM9NmQPo6nRy/jgW6I1L0fMJS/izcwzAUphDQGFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgocDRVzR5tkvuaSMkbQaVLTrWVqx56Ll7fmdhY5e+57JOpJw5kHteokFno/zA4l0zy1IGCpec6KXQyAI4OsrsFF3BbHRhwyvc894znxHdpVD112Om4yPg9Rt9VhFIQydbx6K0u/wlNxA0DY5HQleJ2qbB+MhrZmt6+lBpAXoPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw2tcQQS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw2tcQQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5250CC4CEED;
	Fri, 27 Jun 2025 07:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751010856;
	bh=RAijM9NmQPo6nRy/jgW6I1L0fMJS/izcwzAUphDQGFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kw2tcQQS+5fq+fDh2TVuHZD5EcVNSlOJjUybkV6iMTx5X8lJuGBvH10IXcmTKGLsi
	 cgeRRaPcvWI547m7AfW5bnZx6uvvkScZYjgWnfqnkvGN7w6bcLcxVfuSQW1bOW2E2B
	 GVGNhje+xyNOlbCMJpQMZS31k/eq1d35qLabY8EwiuAqE3Iem/cIbg9SGIu3Bxw1VE
	 CUWGxQnFdAFMHlX/roPjmJx2WqgQe8Ssy1tOEgRLOO/RH29v4jqEvUNvbWU1cnylve
	 ZyeUvfdvZ+zwSL/5JvfoWkJaBAsrgVzQoqea1fVzUE1TuKAp00F5N8dK96WA0DUwSR
	 D/HdlgFm+9NcQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 1/6] ata: libata: Remove ATA_DFLAG_ZAC device flag
Date: Fri, 27 Jun 2025 16:52:02 +0900
Message-ID: <20250627075207.23969-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627075207.23969-1-dlemoal@kernel.org>
References: <20250627075207.23969-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ATA device flag ATA_DFLAG_ZAC is used to indicate if a devie is a
host managed or host aware zoned device. However, this flag is not used
in the hot path and only used during device scanning/revalidation and
for inquiry and sense SCSI command translation.

Save one bit from struct ata_device flags field by replacing this flag
with the internal helper function ata_dev_is_zac(). This function
returns true if the device class is ATA_DEV_ZAC (host managed ZAC device
case) or if its identify data reports it supports the zoned command set
(host aware ZAC device case).

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 13 +------------
 drivers/ata/libata-scsi.c |  5 ++---
 drivers/ata/libata.h      |  7 +++++++
 include/linux/libata.h    |  1 -
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 79b20da0a256..3918ea624e0b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2421,18 +2421,7 @@ static void ata_dev_config_zac(struct ata_device *dev)
 	dev->zac_zones_optimal_nonseq = U32_MAX;
 	dev->zac_zones_max_open = U32_MAX;
 
-	/*
-	 * Always set the 'ZAC' flag for Host-managed devices.
-	 */
-	if (dev->class == ATA_DEV_ZAC)
-		dev->flags |= ATA_DFLAG_ZAC;
-	else if (ata_id_zoned_cap(dev->id) == 0x01)
-		/*
-		 * Check for host-aware devices.
-		 */
-		dev->flags |= ATA_DFLAG_ZAC;
-
-	if (!(dev->flags & ATA_DFLAG_ZAC))
+	if (!ata_dev_is_zac(dev))
 		return;
 
 	if (!ata_identify_page_supported(dev, ATA_LOG_ZONED_INFORMATION)) {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a21c9895408d..ccd7651710be 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1923,8 +1923,7 @@ static unsigned int ata_scsiop_inq_00(struct ata_device *dev,
 	};
 
 	for (i = 0; i < sizeof(pages); i++) {
-		if (pages[i] == 0xb6 &&
-		    !(dev->flags & ATA_DFLAG_ZAC))
+		if (pages[i] == 0xb6 && !ata_dev_is_zac(dev))
 			continue;
 		rbuf[num_pages + 4] = pages[i];
 		num_pages++;
@@ -2181,7 +2180,7 @@ static unsigned int ata_scsiop_inq_b2(struct ata_device *dev,
 static unsigned int ata_scsiop_inq_b6(struct ata_device *dev,
 				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
-	if (!(dev->flags & ATA_DFLAG_ZAC)) {
+	if (!ata_dev_is_zac(dev)) {
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 0;
 	}
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index ce5c628fa6fd..48ee7acb87af 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -44,6 +44,13 @@ static inline bool ata_sstatus_online(u32 sstatus)
 	return (sstatus & 0xf) == 0x3;
 }
 
+static inline bool ata_dev_is_zac(struct ata_device *dev)
+{
+	/* Host managed device or host aware device */
+	return dev->class == ATA_DEV_ZAC ||
+		ata_id_zoned_cap(dev->id) == 0x01;
+}
+
 #ifdef CONFIG_ATA_FORCE
 extern void ata_force_cbl(struct ata_port *ap);
 #else
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1e5aec839041..721f0805b6c9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -144,7 +144,6 @@ enum {
 	ATA_DFLAG_DEVSLP	= (1 << 27), /* device supports Device Sleep */
 	ATA_DFLAG_ACPI_DISABLED = (1 << 28), /* ACPI for the device is disabled */
 	ATA_DFLAG_D_SENSE	= (1 << 29), /* Descriptor sense requested */
-	ATA_DFLAG_ZAC		= (1 << 30), /* ZAC device */
 
 	ATA_DFLAG_FEATURES_MASK	= (ATA_DFLAG_TRUSTED | ATA_DFLAG_DA |	\
 				   ATA_DFLAG_DEVSLP | ATA_DFLAG_NCQ_SEND_RECV | \
-- 
2.50.0

