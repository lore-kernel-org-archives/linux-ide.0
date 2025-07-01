Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12DC2F1FE2
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328980; cv=none; b=ltTAmGj2Hn8iKqtamzBcmyzsubbN96JI30vw0Agi/XIGyZq1tyl4IhGIDim6KtBPT0Sh1G5qUe3bTCRDMRpZchSy+2E4DMLswxNqx6KghO8GEL5JG/OG4rXgKPfSksVdOjFOp6MWC2+XZ7V7L17bg1q2kNPc08MnOglSuRqSTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328980; c=relaxed/simple;
	bh=HyDlJvtwFqtGyyr0aCUrn1L6x1j7cBAGL6wqANvTI9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqvUG1uhsKgXTNRre0bYqUtM08LCrekd8iP4U33VR9V7JL2FcSQzvtJbRMi2HiTiuHTM6JsPHEDz/1OJV9qn1TluPNmJPZvCFJpp8Vwr8Ji4xOa7v6keAhDLxWelm1vtSZrABpT0XPwsGpNoh2YzTp1zezvJTt6jf7rkb6vcxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKhD6KIH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKhD6KIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B8DC4CEF3;
	Tue,  1 Jul 2025 00:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328979;
	bh=HyDlJvtwFqtGyyr0aCUrn1L6x1j7cBAGL6wqANvTI9I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eKhD6KIHyq/t9Ch8K8oGjNmy5T3ZAEaFKiWYPm9tyXwY31mUx5N9ddRA6igxgUtnV
	 2zRSgz2sMg8OBLNoYAtYjReMaSRdn5HYuWuZ3rGOqInFV7T47WX1cELmatQ9WGlHVJ
	 OBXNmabDGgOzGcqR+N5VAGE9jdN+LFY+9+lTmTu8fho//kfjq0Z0RWUCJhW4aDzAjG
	 Ut+PTjc6AAVI3DspDA/1RYi6ZSQrotYnUAwR0W+OZkZjpcygOzfo4t79YRHK3mA9KT
	 dFgxW+UfBD8A6CP6R6xaxGwFqmrzhDPSBtC9JDJi6DesMFUK+ulDW4GZ0xgaW3G8ZS
	 Kf0fuBOW/CegA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 02/10] ata: libata-core: Move device LPM quirk settings to ata_dev_config_lpm()
Date: Tue,  1 Jul 2025 09:14:00 +0900
Message-ID: <20250701001408.330364-3-dlemoal@kernel.org>
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

Move the various cases of setting the ATA_QUIRK_NOLPM quirk flag for a
device in ata_dev_configure() to the function ata_dev_config_lpm().
This allows having all LPM related settings in one place to facilitate
maintenance.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
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

