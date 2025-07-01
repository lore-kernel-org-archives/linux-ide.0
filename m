Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84BC25B301
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374533; cv=none; b=LJeVwT5EiEDw526KKtTsCa1+WQ4ISt2eFmfrPdCb1zW74X+73C2B91T8otSP0r+FL6eKjjFYVLQsUH96gC3JgK9A3VPlqUDCLi5A34dRyh1pTlrwV1FU2nA7YCjE34EoXC55d6ImiQL4Tzi8Q/5TlMnwkdhuDnwo5OH4sJOgFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374533; c=relaxed/simple;
	bh=2QLnYTr94wC3mLJm7DyKMinN2tyuIS1jVy3F2wm4xzE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvKyu3tkbN8QXOOv66I//AhOHbZBO/CfKPRCnobJjt6lVF4b2awuPfawO0FXCNOOyKnDR0DfjdnhwRoMYao6nCCSIGMkaCu75DhDOItnPOjVUoax0vfWUvXq1qfSV+oOrn+Y4PZf3de5bjhbuuZr9czscuc/zL3U9jzbNWkqLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCLNyx8J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCLNyx8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F720C4CEEB;
	Tue,  1 Jul 2025 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374533;
	bh=2QLnYTr94wC3mLJm7DyKMinN2tyuIS1jVy3F2wm4xzE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZCLNyx8J3wUkEJj8LsjhFmlD34TA2jnSCPw65HrMy+TXiNuBlDg9UK/i4WJh621OC
	 cEdc9IZMAfu6narlmAslBdKdalrGc/e+Gmed0ujVm6r7ceyPw1wblNgXM0oXFTp4qg
	 ZuQmdJBpBs3L105sTRovq/tTrpScvsn0NZQewNrJyrufWoJ0SvonRWM+XV48p80Bgx
	 +A9V0crvTUkcypEG7oc9laW5Yy8MFTUk/qlY9JMeLi49vklKIgJnKxEUS0dQdwtoiy
	 u95jOBNPm9SeR44xq8v+WrA/EEZSpyyj1pGzmzERwc8q2P8LF6DD0dyi54LqNc9GSx
	 WgN0w5v3oB6sw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 02/10] ata: libata-core: Move device LPM quirk settings to ata_dev_config_lpm()
Date: Tue,  1 Jul 2025 21:53:13 +0900
Message-ID: <20250701125321.69496-3-dlemoal@kernel.org>
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

Move the various cases of setting the ATA_QUIRK_NOLPM quirk flag for a
device in ata_dev_configure() to the function ata_dev_config_lpm().
This allows having all LPM related settings in one place to facilitate
maintenance.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 43 +++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6df5e51ece21..33b2ffd05af7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2798,6 +2798,32 @@ static void ata_dev_config_lpm(struct ata_device *dev)
 	struct ata_port *ap = dev->link->ap;
 	unsigned int err_mask;
 
+	if (ap->flags & ATA_FLAG_NO_LPM) {
+		/*
+		 * When the port does not support LPM, we cannot support it on
+		 * the device either.
+		 */
+		dev->quirks |= ATA_QUIRK_NOLPM;
+	} else {
+		/*
+		 * Some WD SATA-1 drives have issues with LPM, turn on NOLPM for
+		 * them.
+		 */
+		if ((dev->quirks & ATA_QUIRK_WD_BROKEN_LPM) &&
+		    (dev->id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
+			dev->quirks |= ATA_QUIRK_NOLPM;
+
+		/* ATI specific quirk */
+		if ((dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI) &&
+		    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
+			dev->quirks |= ATA_QUIRK_NOLPM;
+	}
+
+	if (dev->quirks & ATA_QUIRK_NOLPM) {
+		ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
+		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
+	}
+
 	/*
 	 * Device Initiated Power Management (DIPM) is normally disabled by
 	 * default on a device. However, DIPM may have been enabled and that
@@ -2884,23 +2910,6 @@ int ata_dev_configure(struct ata_device *dev)
 	if (rc)
 		return rc;
 
-	/* some WD SATA-1 drives have issues with LPM, turn on NOLPM for them */
-	if ((dev->quirks & ATA_QUIRK_WD_BROKEN_LPM) &&
-	    (id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
-		dev->quirks |= ATA_QUIRK_NOLPM;
-
-	if (dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI &&
-	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
-		dev->quirks |= ATA_QUIRK_NOLPM;
-
-	if (ap->flags & ATA_FLAG_NO_LPM)
-		dev->quirks |= ATA_QUIRK_NOLPM;
-
-	if (dev->quirks & ATA_QUIRK_NOLPM) {
-		ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
-		dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
-	}
-
 	/* let ACPI work its magic */
 	rc = ata_acpi_on_devcfg(dev);
 	if (rc)
-- 
2.50.0

