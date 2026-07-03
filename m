Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D357F2D3A60
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051554; cv=none; b=DjLFj9c06wB74bKlpGaplRJz8sevtDs9ROIL0QQxkLrFbF7WeuPyApGp8KwRevHz73SsHpVd0uobZQHOvS1TyfSnq3r8Pga3yBW9X2kGgxTfuNPknf74dSRl+gdUHwkiNeBcCSpGr/r5pxrg1Vsn0THSiw/0VCW0by8gExTz/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051554; c=relaxed/simple;
	bh=RPAmARmySOlgeXMNho48w8ZDLL2D+3hdvCXdPJgJvQk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQuzsNMCVx3gIbBz/UUoY3jFbYL6OPHqkqsUdVOlMN2xel6KFoPMubFE05AzYaLZ6YB2nqvrfFJM0dsdSgPa47QwS3T/nOvczHFMDcQjvRjp31/ix4BFgnGn9b8hQmtqjmse9qiNSJLWyF0zI6cSWGbr8jPu5tMo6eObaIDzU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFAQz7+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFAQz7+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E421F00A3D;
	Fri,  3 Jul 2026 04:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051544;
	bh=uzxN0FhSbjSJAYoJWecsOyaiy81WGVB6naYA3IfvH9s=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=OFAQz7+YIEtj0omn6re36NGpm8PyguPugHcXrqVLru/JzhoculDmjXBIYh4dXxmYo
	 LlWVv6P0w28EulGygRfg/56o2ZG4P+fuSsa0FWK2l+vacgyHGWtGpoDe/ylW7u3iSa
	 0HdPj4ogdWr+V+4t1oj6auninIR+zflJFCBwJgb1uwFRumDtxt1mogUozUX4yDjo/U
	 POpSWHcwkovncpQWrdxmKYYrV/IrgfAcrY247dT50g7KZcQz2zEx8Ym337teYaB8Y/
	 h7zMaadPBOyPfgDln3VrUPbkFXU2KOSgMCBAtMC9OUfxjaonE5N1ty1C+VMj6cM0wu
	 c8vTAYuFwcdPQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 1/5] ata: libata: rename ata_dev_is_zac()
Date: Fri,  3 Jul 2026 13:05:28 +0900
Message-ID: <20260703040532.2152614-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703040532.2152614-1-dlemoal@kernel.org>
References: <20260703040532.2152614-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper function ata_dev_is_zac() checks if a device is a ZAC class
device (host managed zoned disk) or if it is a host aware zoned disk, that
is, a regular ATA disk that supports the zoned capabilities. So the name
of this helper function is confusing as it hints at the first case only.

Rename this helper function to ata_dev_is_zoned() to avoid confusions and
better reflect the two cases tested. Use this helper in
ata_scsiop_inq_std(), ata_scsiop_read_cap() and
ata_scsi_report_supported_opcodes() instead of having the same tests open
coded.

While at it, to stay consistent with this renaming, also rename
ata_dev_config_zac() to ata_dev_config_zoned().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/ata/libata-core.c |  6 +++---
 drivers/ata/libata-scsi.c | 11 +++++------
 drivers/ata/libata.h      |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3b6243f0f91e..6daa99508b72 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2488,7 +2488,7 @@ static void ata_dev_config_sense_reporting(struct ata_device *dev)
 	}
 }
 
-static void ata_dev_config_zac(struct ata_device *dev)
+static void ata_dev_config_zoned(struct ata_device *dev)
 {
 	unsigned int err_mask;
 	u8 *identify_buf = dev->sector_buf;
@@ -2497,7 +2497,7 @@ static void ata_dev_config_zac(struct ata_device *dev)
 	dev->zac_zones_optimal_nonseq = U32_MAX;
 	dev->zac_zones_max_open = U32_MAX;
 
-	if (!ata_dev_is_zac(dev))
+	if (!ata_dev_is_zoned(dev))
 		return;
 
 	if (!ata_identify_page_supported(dev, ATA_LOG_ZONED_INFORMATION)) {
@@ -3093,7 +3093,7 @@ int ata_dev_configure(struct ata_device *dev)
 		ata_dev_config_fua(dev);
 		ata_dev_config_devslp(dev);
 		ata_dev_config_sense_reporting(dev);
-		ata_dev_config_zac(dev);
+		ata_dev_config_zoned(dev);
 		ata_dev_config_trusted(dev);
 		ata_dev_config_cpr(dev);
 		ata_dev_config_cdl(dev);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d54ec1631e9a..a86721b5df7f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2020,7 +2020,7 @@ static unsigned int ata_scsiop_inq_std(struct ata_device *dev,
 	if (rbuf[32] == 0 || rbuf[32] == ' ')
 		memcpy(&rbuf[32], "n/a ", 4);
 
-	if (ata_id_zoned_cap(dev->id) || dev->class == ATA_DEV_ZAC)
+	if (ata_dev_is_zoned(dev))
 		memcpy(rbuf + 58, versions_zbc, sizeof(versions_zbc));
 	else
 		memcpy(rbuf + 58, versions, sizeof(versions));
@@ -2060,7 +2060,7 @@ static unsigned int ata_scsiop_inq_00(struct ata_device *dev,
 	};
 
 	for (i = 0; i < sizeof(pages); i++) {
-		if (pages[i] == 0xb6 && !ata_dev_is_zac(dev))
+		if (pages[i] == 0xb6 && !ata_dev_is_zoned(dev))
 			continue;
 		rbuf[num_pages + 4] = pages[i];
 		num_pages++;
@@ -2317,7 +2317,7 @@ static unsigned int ata_scsiop_inq_b2(struct ata_device *dev,
 static unsigned int ata_scsiop_inq_b6(struct ata_device *dev,
 				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
-	if (!ata_dev_is_zac(dev)) {
+	if (!ata_dev_is_zoned(dev)) {
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 0;
 	}
@@ -2848,7 +2848,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_device *dev,
 	rbuf[10] = sector_size >> (8 * 1);
 	rbuf[11] = sector_size;
 
-	if (ata_id_zoned_cap(dev->id) || dev->class == ATA_DEV_ZAC)
+	if (ata_dev_is_zoned(dev))
 		rbuf[12] = (1 << 4); /* RC_BASIS */
 	rbuf[13] = log2_per_phys;
 	rbuf[14] = (lowest_aligned >> 8) & 0x3f;
@@ -3656,8 +3656,7 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
 		break;
 	case ZBC_IN:
 	case ZBC_OUT:
-		if (ata_id_zoned_cap(dev->id) ||
-		    dev->class == ATA_DEV_ZAC)
+		if (ata_dev_is_zoned(dev))
 			supported = 3;
 		break;
 	case SECURITY_PROTOCOL_IN:
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0dd735c2e5b5..f813b1c32461 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -44,7 +44,7 @@ static inline bool ata_sstatus_online(u32 sstatus)
 	return (sstatus & 0xf) == 0x3;
 }
 
-static inline bool ata_dev_is_zac(struct ata_device *dev)
+static inline bool ata_dev_is_zoned(struct ata_device *dev)
 {
 	/* Host managed device or host aware device */
 	return dev->class == ATA_DEV_ZAC ||
-- 
2.54.0

