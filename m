Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F8351C2E
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974066; cv=none; b=Z+RM+2YvAagFgRLJevPwCI917x50mACY58IGmzAjr5JNNl6Nr78vLAyKWXdfoHTzhunF3q25DFt3MPNH2bgIbz9OI+YZQ6ByyloVoKFTM1uCSa8aCFFMw6KX+dv8qcTxYKLBFsCiAsvzDF+Ty2f8F9EHRnNQyl3QFW5jjthFwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974066; c=relaxed/simple;
	bh=OWQLrUW9+8ILvhFQVqwj2WZnfuHw0AjLO5WJVXcuTFw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HulW0eByh15LMwap5H0Xtdas1KQ1GWRqe7mzIhmwgVdvGUuRpAkCFx9KNNrHWHrbnfQwswWFsNyQcYyaXAqmMU6bOgHY8ki3kYdNy9mAfJzG0ACMNto5vuZ5Ip3Ral+Wr5C9TUoUcF2PKFKD52ZfUvSePWL/Jmd3csWfwcpVQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVpkEdET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVpkEdET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D3D1F00A3A;
	Thu,  2 Jul 2026 06:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782974064;
	bh=G21oUr8742MssWsVox2sxw5BmKqzPM1CXNBDXoAt2yU=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=MVpkEdET1EVimfvc8FSg0jqF4iby11hhbYla5adWLjpiUsY8fnnogjhu00MHSpYp5
	 vVTVnULqrskBzIDL0qLxjYtfnR0Cr50YlaB6UUVnNHY39XHcYuUsgmydlIpG873mBB
	 0edPpknJUL1eZ2OPlEN30ZiOpgdEYY18L1Bb4VjWLiZQre94NK3fapbtghXr+nkQ6B
	 d7cUR5YLWOUGtTrf+2NgYF8GktlTgEYyG9dNsyOxD1VWEMs5rMYD4B06g7i5pFZGAL
	 kpSAYes+qmO4q7BN08iWjorAu67o/Q5e6ZqEPoDAP5iXXEwqIH447JxMmh1iqm0v1k
	 F02hy00ovChUw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 1/5] ata: libata: rename ata_dev_is_zac()
Date: Thu,  2 Jul 2026 15:34:08 +0900
Message-ID: <20260702063412.1892584-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702063412.1892584-1-dlemoal@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
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
 drivers/ata/libata-scsi.c | 7 +++----
 drivers/ata/libata.h      | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

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
index d54ec1631e9a..8811bfc37369 100644
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

