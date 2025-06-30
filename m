Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5971F4E57
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264935; cv=none; b=HEiRI82tGrJW0ajmZ3+i4H21Hk0mNh7I9518tQVWJJRSWW9c8adySemTrZAzUTlTLGTl9BadTSOfDOCY+p4IKtb3DxBayXTZESISjrnQ/v+A1oa+lvwKFrFDEWQHriXAf4drWdeX3wHf4BGIYtUGTcYHbQmwSC5khT9RjVIWk0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264935; c=relaxed/simple;
	bh=VEnBjjjMQq9DD88xR2CJHamqW9p7jBUmhEi5PERDGPU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlxuioB+me884pxxEQNtfSj6i7cztPS0hkT/+ahGir2Rv8CgNwUKm/YP0z35bXvUmqkRT9uM52Z04h2hHFrvOX2PVTZCJ1B+nFC1l4YOtX9eY9OO7+JZuyVGDdzxWLbBgVdHu+xvb2LTgUTh7dqIWn41cdAx+OpTZt5B9c3POVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3rDOgd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3rDOgd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8139C4CEF0;
	Mon, 30 Jun 2025 06:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751264935;
	bh=VEnBjjjMQq9DD88xR2CJHamqW9p7jBUmhEi5PERDGPU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L3rDOgd0ETQTEAhcXEhtWdZnLmiGxhFsLfHWvqyVodZgQH30q6E/Ve95/lxe2KDwK
	 3bXm5U0lknsFUTG9sJ3NKwumVo9p7j2+EUGqtadNsR/WBjBHeCPqwi1txq01aOA6oE
	 v10TFt2zC1ZsRC8NMPwq1747LLrSn5N52WhcgSlo7hKodYYRzwF6QsZm4tOwk0JGF2
	 /GbyfZ41F+8GsiJWy7WezfCpv5+DHffJYbciyIwXYXxSVR06i3hPQ2ITFlj3qW5u74
	 6r1/v5R3iNPPBgVqokOrZ0dmHsznYTTf3stTkXcwcn8Fugvj8BmzM0MVfP6Bn10Mlw
	 J7Lj1sK+eg6gQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 09/10] ata: libata-core: Reduce the number of messages signaling broken LPM
Date: Mon, 30 Jun 2025 15:26:36 +0900
Message-ID: <20250630062637.258329-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630062637.258329-1-dlemoal@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
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

