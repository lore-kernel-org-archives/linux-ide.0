Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0B2F1FE2
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328980; cv=none; b=IJEE8KHt5M2o1zEb+Lwojj0B3dSfx109CaccENrt/mTucWBpnMX8cAAUrh+muNnS+dzA5kFsDo0Kpfwou1kHndcV7ULA1qF/+c9TUOanxNj6YPaHICCQt+fMEJ5gtdgnVxxprCqA9hYNq1DiDyFd/vJtIBbH0W/GituzMLYx0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328980; c=relaxed/simple;
	bh=JDXS8/SYE07qiC12gHzhX5GUzoJBSIOe8d1j7KPyNxs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NldpDEUQs9V+iyvKHr3OKTmOWLt5oizF1hE0COUDVMrHVmTUwvoRe7bxRNTEiaCBWfUwyh3aV7lvXOFfQgE6T+atVWReQh7irrWskeU9rckHOWHwWdBVqp6sN8LBlvcYumplhaN4dEqDxUglHvXYtWu0NFxw1pj9TMkkjQyuHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfRjmYQt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfRjmYQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD538C4CEEF;
	Tue,  1 Jul 2025 00:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328980;
	bh=JDXS8/SYE07qiC12gHzhX5GUzoJBSIOe8d1j7KPyNxs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JfRjmYQtFocbFPP672xho7b6C0BhSLIgMANvVfQyrNHY41DGKxQ9wYRg9dmlp3tas
	 D67lEvvWnOIlclSX1EgbclIQ3PVp4ghbqo7xd2eFyl5qrz9GF4h5704ji1LxOdU7wR
	 Mt4X3QwEYT7l1OAYZBwH2dywXnG+YhzULeuEwNEhXbF4YNAWXKrMcNHp6YZheNXjRz
	 +t620alaDVQj3DNUpYVEp7InR2AMJFIwPtqFCSWRpan/EQRcu4v+eRCtyqbZ3hzANR
	 AqaqT9/aJ7fVpnSR0gXbBxTdFgG3P96Hmjoz91JAzL3qedEJLv++RD+9cLqBrd4MWX
	 ojwjqFPWFGXhA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 03/10] ata: libata-core: Advertize device support for DIPM and HIPM features
Date: Tue,  1 Jul 2025 09:14:01 +0900
Message-ID: <20250701001408.330364-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701001408.330364-1-dlemoal@kernel.org>
References: <20250701001408.330364-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify ata_dev_print_features() to advertize if a device supports the
Device Initiated Power Management (DIPM) and Host Initiated Power
Management (HIPM) features.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fdce96fd3ffa..d1dff9018a3a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2843,11 +2843,13 @@ static void ata_dev_print_features(struct ata_device *dev)
 		return;
 
 	ata_dev_info(dev,
-		     "Features:%s%s%s%s%s%s%s%s\n",
+		     "Features:%s%s%s%s%s%s%s%s%s%s\n",
 		     dev->flags & ATA_DFLAG_FUA ? " FUA" : "",
 		     dev->flags & ATA_DFLAG_TRUSTED ? " Trust" : "",
 		     dev->flags & ATA_DFLAG_DA ? " Dev-Attention" : "",
 		     dev->flags & ATA_DFLAG_DEVSLP ? " Dev-Sleep" : "",
+		     ata_id_has_hipm(dev->id) ? " HIPM" : "",
+		     ata_id_has_dipm(dev->id) ? " DIPM" : "",
 		     dev->flags & ATA_DFLAG_NCQ_SEND_RECV ? " NCQ-sndrcv" : "",
 		     dev->flags & ATA_DFLAG_NCQ_PRIO ? " NCQ-prio" : "",
 		     dev->flags & ATA_DFLAG_CDL ? " CDL" : "",
-- 
2.50.0

