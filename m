Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519E1F8EFF
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264929; cv=none; b=iBzd1g+SDVS1q7jQn3NhmQQfPjEAjWiSUJl9JFuPAyJ68EAWpue4CXlXiZybLYcpbe/6trkBMBaPNlvVW7yk3yx98be/0QepXgpGlxkrKDsvwr/igvZwG+JqzNeLBEI2W9HfDgUc0RU8JekvQn4BjfUNsAVseaeWNzyatX2W5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264929; c=relaxed/simple;
	bh=XDhJWouayl+OeX1GvSexxiPrTOQHhrIVt49zNidoLwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5nEk+UMxkGhGxwh5xAY8cXJ95PRf17KjQxyPNfAb4omH8D4Hm2edInKZxsrTR80/NiICxhi0yGIzFKtl/YJDJliM8YeEcKliszXKwJWZPpCzDBHsJVV+fOZbAsbhnMX/skjFzTWBaIZQYwV8zJxkozUz6rUylptM2kNjKaRHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drT0FbbM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drT0FbbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FBDC4CEE3;
	Mon, 30 Jun 2025 06:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751264929;
	bh=XDhJWouayl+OeX1GvSexxiPrTOQHhrIVt49zNidoLwc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=drT0FbbME3LY5C6JJ/QnLtC9mFGnAcTbMXfWxdVpvg3eJaKxazdSrs3tfWnJAfiuP
	 L3+iHDvxjTveY7rxS2nKQOH/kVueLMQ9KNuudreC+ev4C1Tz52tGnkTmLBDsiTosKg
	 /+NfG+tssaea+cJ9sOl+ru3gPPoIY7IWJhlQ8ZMoniAWZtdrcSlSXCu7Z5EoBktSlR
	 mWLNC6pIhK3Gbz6poOeM/z3tooyqEfPstTIr+0Fn+RXbxXW8YhtN6sQHcWnYoer+hW
	 WABB57mvDlCZPoTDWO9X1SGRs/Cf9AaXFlwmzsTSCHXN0kep8Pri2F1gQof8wPhBqo
	 NItCB7R63+HRw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 02/10] ata: libata-core: Move device LPM quirk settings to ata_dev_config_lpm()
Date: Mon, 30 Jun 2025 15:26:29 +0900
Message-ID: <20250630062637.258329-3-dlemoal@kernel.org>
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

Move the various cases of setting the ATA_QUIRK_NOLPM quirk flag for a
device in ata_dev_configure() to the function ata_dev_config_lpm().
This allows having all LPM related settings in one place to facilitate
maintenance.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 43 +++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0d85474f6640..fdce96fd3ffa 100644
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
 	 * If the device port does not support Device Initiated Power Management
 	 * (DIPM), and the device supports this feature, disable it.
@@ -2881,23 +2907,6 @@ int ata_dev_configure(struct ata_device *dev)
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

