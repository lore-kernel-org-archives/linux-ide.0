Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D037BE7E
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068726; cv=none; b=YajwR/Eq7VpNliTBkwl7TbGu8egS12cGm6paK7p3hM2U4zyVanZD3PSbTpZTHkhZk6nk9hWZNR2I4Ss0tWX7hlNdXns0i00nPP5EtdaPtJrQHfdHuEDtsEl7AZb6RS5l9hKsp21cWWc68cVukp0Ygy/81IaJ0wYUcS4BN27Ixdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068726; c=relaxed/simple;
	bh=gMOeMH+MWsFa3gjO8oG5XyHZstW8dG5jMlwmGVrlsLQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jw8d+L44U9Ht7ISV0GJQYLABSM50TNrrg0MOsQKHXtE3hM45T7yKu58b3DzFj6yHy1aer4EOop6NQNh83FQjkFgJqe0PWT9bQbpxaaqpyzpAH8UCkM0Q0anb68kfOhdKj5DxqjbJl50uhBNOLeG71zKlp9UOCsIJiE0ZyAD58uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv1IFek7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv1IFek7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F3C1F00A3D;
	Fri,  3 Jul 2026 08:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783068724;
	bh=l0UGelUL9hG6I+xd0+F7eBAulpUbIgq8RbcReT0lnlE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Wv1IFek7kuVHwyhDVo1YrAvserSqVJaFQsYpb2yW/e0lcRa8hIYCNZCSV/5Hf1pJP
	 j9NcATXIkr4yycuSUL+m4JH2XWOfVGSSKJHtufHpJYAWRbYaogYv7Ie6u92YlX0kWJ
	 6krem1OumOI7B1A84v3nxGsZY6q/tSWBLeJ0JmiaqkXBuESa4Qcpev9+BfWKsIiQst
	 qkR0CTPD0wYod7Hxz7FTv9avMxVjvFgcYrMx+ob/yg3Qaj8lvE3gS0H67YgdUWBPjF
	 AglQl5oZvextaAxOrNq18p2E0ivHZeXNvlZhcRQrTVGDcDO0Z1xYTS6LgY+xDqjBv5
	 tpVFHTDiQoBHg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 1/5] ata: libata: rename ata_dev_is_zac()
Date: Fri,  3 Jul 2026 17:51:48 +0900
Message-ID: <20260703085152.2350034-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703085152.2350034-1-dlemoal@kernel.org>
References: <20260703085152.2350034-1-dlemoal@kernel.org>
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
index bdc88cf74709..5121faf9738e 100644
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
@@ -3111,7 +3111,7 @@ int ata_dev_configure(struct ata_device *dev)
 		ata_dev_config_fua(dev);
 		ata_dev_config_devslp(dev);
 		ata_dev_config_sense_reporting(dev);
-		ata_dev_config_zac(dev);
+		ata_dev_config_zoned(dev);
 		ata_dev_config_trusted(dev);
 		ata_dev_config_cpr(dev);
 		ata_dev_config_cdl(dev);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5868526301a2..be7143df6a01 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2023,7 +2023,7 @@ static unsigned int ata_scsiop_inq_std(struct ata_device *dev,
 	if (rbuf[32] == 0 || rbuf[32] == ' ')
 		memcpy(&rbuf[32], "n/a ", 4);
 
-	if (ata_id_zoned_cap(dev->id) || dev->class == ATA_DEV_ZAC)
+	if (ata_dev_is_zoned(dev))
 		memcpy(rbuf + 58, versions_zbc, sizeof(versions_zbc));
 	else
 		memcpy(rbuf + 58, versions, sizeof(versions));
@@ -2063,7 +2063,7 @@ static unsigned int ata_scsiop_inq_00(struct ata_device *dev,
 	};
 
 	for (i = 0; i < sizeof(pages); i++) {
-		if (pages[i] == 0xb6 && !ata_dev_is_zac(dev))
+		if (pages[i] == 0xb6 && !ata_dev_is_zoned(dev))
 			continue;
 		rbuf[num_pages + 4] = pages[i];
 		num_pages++;
@@ -2320,7 +2320,7 @@ static unsigned int ata_scsiop_inq_b2(struct ata_device *dev,
 static unsigned int ata_scsiop_inq_b6(struct ata_device *dev,
 				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
-	if (!ata_dev_is_zac(dev)) {
+	if (!ata_dev_is_zoned(dev)) {
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 0;
 	}
@@ -2851,7 +2851,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_device *dev,
 	rbuf[10] = sector_size >> (8 * 1);
 	rbuf[11] = sector_size;
 
-	if (ata_id_zoned_cap(dev->id) || dev->class == ATA_DEV_ZAC)
+	if (ata_dev_is_zoned(dev))
 		rbuf[12] = (1 << 4); /* RC_BASIS */
 	rbuf[13] = log2_per_phys;
 	rbuf[14] = (lowest_aligned >> 8) & 0x3f;
@@ -3659,8 +3659,7 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
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
index 700627596ce1..39494ab206a2 100644
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

