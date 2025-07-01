Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285225B301
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374539; cv=none; b=Sz8rsgmaLbyWne86HKPv31eXPqzzncnm8aaZcMHkDHPKZqpwUOTVkSsjL1drPkIBfGmvWfOPEw30oEOt/b+scC522tHwgfeeg7c/Xc71HseV9/MuSbCPQxVeqyXEECd5MUl8+5SvOkU80Sif6RyMi3FfL2KdFKk0O0FC4UFXoO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374539; c=relaxed/simple;
	bh=8zaIL6Zb/FcWUhRht6tKfm9XXHB79CipYOsPnUexbXk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DX39Ywu6u19zof2igUKW5W3mr73U1s13n9Nkk/U009up3PQMRrXVN6fPgGuPUL9QNU5VslJSOXcYu3ipmjNopRUWuHDbdifMl/RCiqtuVnaS5/axD5pu9+YuHrFc7kUkajHsF6VvFpp4sRoxMhE7pMkD0fy88XupbB1ZDYc8K+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZkKzsDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZkKzsDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE03FC4CEED;
	Tue,  1 Jul 2025 12:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374539;
	bh=8zaIL6Zb/FcWUhRht6tKfm9XXHB79CipYOsPnUexbXk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fZkKzsDCvHiHME3PHRgqhVahZ6tqGMclxV5OwulHDZ3g7mUnjvF9Y6zN1gnf/ma7J
	 XOthmbNswiSKYEBD1YzTpqwjvzw5Ats9wSjlDBpuETKLg+SPR2iuLvwrpfHOkKSEeh
	 wsBODTY0CuQa5tEOfRnLNO04Rdbwji9sG/1C5BtpSRt58b3gUZDJCXApAZBKr/7CxY
	 fc0HW/0FHfOWMG31ItG5XS69B2vYIDvcy2IrA9RfFata+eDqSXU0g6eqJDa86TUOPC
	 g6K/YNlHy8hTWbSaEBIU8K/r6A4nmHs/sqhBeJcndd43ymIGpfZEPYlrgbFES+ilmf
	 DUpDt1ukwB2bg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 09/10] ata: libata-core: Reduce the number of messages signaling broken LPM
Date: Tue,  1 Jul 2025 21:53:20 +0900
Message-ID: <20250701125321.69496-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701125321.69496-1-dlemoal@kernel.org>
References: <20250701125321.69496-1-dlemoal@kernel.org>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4619e66ae100..7f6cebe61b33 100644
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

