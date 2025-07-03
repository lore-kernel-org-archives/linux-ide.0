Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5B2D5412
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539114; cv=none; b=nTz/e1hj0nGEThoH46+l/+dp+QimRoTtl5v6IOivwwej7acG1C3FYpgXw3s4RVY1nASVBoL8R9HnKqvbEsVF3DKS01T0nojSS6GQmAdIgmOOW9wIZDItitTmXSOvO8bVeuercdBxOAvLUI2RKIpPP033/WYfjxrtAJW/uzFpl2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539114; c=relaxed/simple;
	bh=r+//HraZCzhiHOU+fxvZgcs697vTX0T+BtSEnTtvcMI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8Tso7Tzb0Pgif/gREWexSc6lV0ODsn3CdaDML0N03C5vCqTdoy39rhGDSk/30biLm5l5ToTejm3Kqb97Y7rrGFL7PZN7XX6Nh3cKs5a9utPnAIX97gfEsUnq0dfRSyNm86I3UfHTIGa/EQWWS9Eyfqfem7wVSo+IWoYyZC4JE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMiovLxY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMiovLxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85B3C4CEE3;
	Thu,  3 Jul 2025 10:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751539114;
	bh=r+//HraZCzhiHOU+fxvZgcs697vTX0T+BtSEnTtvcMI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kMiovLxYIK8ML3h88YdghuZIEMU8jk6sLzH1egHCFWan8+xn4/NSNxVWXrTE8+OQb
	 wLnQrKwhy8xMi0zE8Yvhtdq+1pDcczx6xkQ6pWhcsSJtDi98iJTnhxNLI0hB2/qgec
	 YLSGqd+YUNCkaZyzkjy1pQwfuYvlvPnHD4bBva5JOS2NyI3Pi9Wt4JKonLx1b6GSrh
	 KqQAV2cn6hohKFMCeFw68Awt0LZoVQrB6abBacC0rZFaTZRcA/rRr1+8cwXzEmL6nE
	 fbphyRfD+wc0Em5KB6wXmcNLVtmmK0SKeCQCPlNtuNaVypLfrGAHsMUH5s/dS0qPoU
	 UFIi8B43BqJow==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/4] ata: libata-core: Make ata_dev_cleanup_cdl_resources() static
Date: Thu,  3 Jul 2025 19:36:20 +0900
Message-ID: <20250703103622.291272-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703103622.291272-1-dlemoal@kernel.org>
References: <20250703103622.291272-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ata_dev_cleanup_cdl_resources() is called only from
ata_dev_init_cdl_resources() and ata_dev_free_resources() which are
both defined in drivers/ata/libata-core.c. So there is no need for
ata_dev_cleanup_cdl_resources() to be visible from outside of this
file. Change this function definition to be a static function.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 drivers/ata/libata.h      | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 30913bc6fe21..72abd2996e9c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2516,7 +2516,7 @@ static void ata_dev_config_trusted(struct ata_device *dev)
 		dev->flags |= ATA_DFLAG_TRUSTED;
 }
 
-void ata_dev_cleanup_cdl_resources(struct ata_device *dev)
+static void ata_dev_cleanup_cdl_resources(struct ata_device *dev)
 {
 	kfree(dev->cdl);
 	dev->cdl = NULL;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 8e68f4556962..767a61f8ff89 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -97,7 +97,6 @@ extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern const char *sata_spd_string(unsigned int spd);
 extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 				      u8 page, void *buf, unsigned int sectors);
-void ata_dev_cleanup_cdl_resources(struct ata_device *dev);
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
-- 
2.50.0

