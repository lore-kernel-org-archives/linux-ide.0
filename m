Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2DC347D5
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328984; cv=none; b=lvZAtXqMT1e8QcB1D7ApTc05nCF1NlnQpIPwFb5UW0+dcYZCZPaVYhxDuWwNn/KG6O0iztyKwlcRFyO27lrwaKTfvhE1vX5z+9TpX65gTrP4T2pqjdiOeSn+nEoYAMOZOa7h7Ye56fIF50RTEgL0amI7dp+Z90COOXHh9PjLg5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328984; c=relaxed/simple;
	bh=xWH0qLAhFHXSyZPmeiY6TiLfWdXgpTIgc5tthidOB4s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cb3l6OYGPDd15ERRqdqNnx7q2GwWUOjHhJqHiv31ndeEUjWTUEfaqavruRl8RlDuzEIuYEdoeyhvvCslkfn6tuf5c9HKtxHyN2J5OF+4AkbNTpXSktcidWY8HkfY4y+I6KKtEUViKGridyGuD3igjttrgnRv8Ll9oQ8ZkbWmZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W89/n7nS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W89/n7nS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBA4C4CEE3;
	Tue,  1 Jul 2025 00:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328983;
	bh=xWH0qLAhFHXSyZPmeiY6TiLfWdXgpTIgc5tthidOB4s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=W89/n7nSclE82C0RrwxpFGiriBH12G6QyMXdkaXn/u7hq1o0Lz3+nn+0wkmrAMBdO
	 Twi9zsajsq+YHLzNG/p21mnbA7BbwLbldLlimmhP45VWl1Bkg5aomT6Jw+Da6rOZrk
	 hLns2jEBrbjTl3udSZVjqk104jWINBR0Yy7nu2GS3YqUNRvIPvwCJ2zE37PYtRrUFE
	 jLiWqlyydK3AWevYYdXtLVLGfzQ4FYs/+k8xyqPZzFZHVJ2tSz1n41NIZN+ZS+js4l
	 Q6XlUs5H4i04H3irEzVro9ZlrfUNBzyeG1XG8ObJTyRTVdzr8ArFD7MQyGXLmag4tY
	 9HP5NH9vihK3Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 09/10] ata: libata-core: Reduce the number of messages signaling broken LPM
Date: Tue,  1 Jul 2025 09:14:07 +0900
Message-ID: <20250701001408.330364-10-dlemoal@kernel.org>
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

ata_dev_config_lpm() prints the message "LPM support broken, forcing
max_power" for devices that have the ATA_QUIRK_NOLPM quirk flag set.
This messages is repeated for every device revalidation, which is not
necessary, but also erroneously printed for devices without a broken LPM
support when connected to a port that does not support LPM (e.g. because
the port is an external one with hotplug capability).

Since in all cases the device port target_lpm_policy is set to
ATA_LPM_MAX_POWER, avoid the "LPM broken" message repetition and
erroneous output by generating it only if the port target_lpm_policy is
not already set to ATA_LPM_MAX_POWER.

This change will suppress the "LPM broken" message for genuine cases of
a device having broken LPM if the initial LPM policy is set to
ATA_LPM_MAX_POWER through CONFIG_SATA_MOBILE_LPM_POLICY. This is not a
problem as the ATA_LPM_MAX_POWER policy implies that LPM is disabled and
unused, which is safe for devices with broken LPM.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d1dff9018a3a..3e6cf26af4e4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2819,7 +2819,8 @@ static void ata_dev_config_lpm(struct ata_device *dev)
 			dev->quirks |= ATA_QUIRK_NOLPM;
 	}
 
-	if (dev->quirks & ATA_QUIRK_NOLPM) {
+	if (dev->quirks & ATA_QUIRK_NOLPM &&
+	    ap->target_lpm_policy != ATA_LPM_MAX_POWER) {
 		ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
 		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
 	}
-- 
2.50.0

