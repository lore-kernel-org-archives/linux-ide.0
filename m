Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A929175A98
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957420; cv=none; b=R7DH8S1eTrrZ4S99VRCED+f+GMpV5mUJZzMEYZqj1jO19iH82lRvK+laK6UabP9AELiMJz08/YyqkZ/3UHNG4M/TFPjqHFu4ZRunx7o5UCBGA1cmOd2yGypcMnXFMvHAmU9qCYUvT2WTOvvHe7aQ5NfWM4p9nlh9Dh+rufdVJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957420; c=relaxed/simple;
	bh=xotUFHWjnQvdafv8AsaDEvU3WYWVLIpHG0wEI+10q3w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bbe2SyhapZOGQTn794gyy5R+tnT7oCU9fI/xzJjDOsXsHaEFQCXy3oLSRkX3q3JSeouMaUV9VCFmyQ6lKtrPoiDJPldqvZfzKL9IBdG1gSmKdRklbt0VQawPUk4KmQzxTXW33Nl6ehBr5OAGuJeBHo7EzQlaSTf+1S1cGdE0rkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJzs5+j1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJzs5+j1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA92A1F00A3A;
	Thu,  2 Jul 2026 01:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957419;
	bh=lFRdMt99Lkky8/VEew96qBqs8MFeslQJOd63XuDKNC8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=OJzs5+j1bGJP5ngGbEvQCbXMYZCED2EsdZYsBZ2kyvdirJpUamsnKCy9iH6wQMY5+
	 FqWuoWkTfRd8nE26Oc7q5cuw5mj1R5gK9IssDwtLqVzigH7vjRk+EYNn8v/zmNpBku
	 EkNSa1Pt/+D6Cel0ynam6xr0mTd8rxMsbNOgsz9h6Wy7M1wR6+0CLtPTaqN3cIBhxU
	 JVrH3goPBDJY6rY9E6KwP2PVHcTdqyLNHHePEM58lDz53k/oc0hNjxcgjFSxubufP9
	 tVbhqpTD7MNkWINHSO2Dz/gJ5UAxqwcayyBC52Q6llFAoa6+RSHJtujbud5tSjCUcj
	 T198/YSWGIOvQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 1/6] ata: libata: rename ata_dev_is_zac()
Date: Thu,  2 Jul 2026 10:56:41 +0900
Message-ID: <20260702015646.1702539-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702015646.1702539-1-dlemoal@kernel.org>
References: <20260702015646.1702539-1-dlemoal@kernel.org>
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
better reflect the two cases tested.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 6 +++---
 drivers/ata/libata-scsi.c | 4 ++--
 drivers/ata/libata.h      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

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
index d54ec1631e9a..b8aabd08f786 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
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

