Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471EF2F1FE2
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328979; cv=none; b=XryZiPJ/sbYnLVjcS+6CX6CC9+liJMiQhL5u8uDU9WFrLI1lcZCeWjpfB9eiTLdykGTp4icXZaxB00IZKVth0CwsZJx21vFOpfyn8/0JyvOCrIucMWwIwqqnEzamfezvUq9JVtHtjR4B0LA7ZwiKkQhuhoPAhWm7hkVGsHM546o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328979; c=relaxed/simple;
	bh=7SOYjUbQ4ckLs7zzoU44ZDTK4B3eQXUGYA/YBZdLFKM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kpfy+JYJkF4595K2qbf74pYTQ504NDFAsNQHnd4/JefsrHLt4gZhVqLzBz1uKqAkLCauJNRB5+5s/e2acbo0CzwOgcqz2eu+JP+nk6/onXYqs0q5E3PbGOjMRDxys3uxUljC+IWAJdRIZ8M87xwgFHi23EGoHwqDcwCW8UJMMmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sigasFSQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sigasFSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829E5C4CEEF;
	Tue,  1 Jul 2025 00:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328978;
	bh=7SOYjUbQ4ckLs7zzoU44ZDTK4B3eQXUGYA/YBZdLFKM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sigasFSQR5/7Kd/HtGlUPqNCs2c+GKWI6EaFEr0/T8mJignhQOPiXNCr4kF79pza1
	 1fNG81iSVcz3Iyo1LpKeNKcx6PhwfpuAUtJPHa24eGwhU+TivSXzNbQZxR1ndP2UOP
	 VtvKZfyWTEbpHG7tB88+Dd6PtG7BeSuJ5PEpAYdqGcMF2PDdvFtbPBVNWytZAPRF+g
	 Cztyqws6Rr22daJdZHEG3o1pvpATHcRSystLfURcHheNJB6MNWNhi/YrYHZa55dcIJ
	 ylGqQYsua7roLzNSKY5w898Hv9MBlEOyXsuaPXCDZfbmt3TjXFbzcJh+sTZw3rGcSM
	 OtNJjNk2+ou4g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 01/10] ata: libata-core: Introduce ata_dev_config_lpm()
Date: Tue,  1 Jul 2025 09:13:59 +0900
Message-ID: <20250701001408.330364-2-dlemoal@kernel.org>
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

If the port of a device does not support Device Initiated Power
Management (DIPM), that is, the port is flagged with ATA_FLAG_NO_DIPM,
the DIPM feature of a device should be used. Though DIPM is disabled on
a drive by default thanks to the "Software Settings Preservation
feature", DIPM may have been enabled by the system firmware when using
the LPM policy "Keep FW settings" (ATA_LPM_UNKNOWN).

Introduce the function ata_dev_config_lpm() to always disable DIPM on a
device that supports this feature if the port of the device is flagged
with ATA_FLAG_NO_DIPM. ata_dev_config_lpm() is called from
ata_dev_configure(), ensuring that a device DIPM feature is disabled
when it cannot be used.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3918ea624e0b..0d85474f6640 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2790,6 +2790,27 @@ static void ata_dev_config_cpr(struct ata_device *dev)
 	kfree(buf);
 }
 
+/*
+ * Configure features related to link power management.
+ */
+static void ata_dev_config_lpm(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->link->ap;
+	unsigned int err_mask;
+
+	/*
+	 * If the device port does not support Device Initiated Power Management
+	 * (DIPM), and the device supports this feature, disable it.
+	 */
+	if (ap->flags & ATA_FLAG_NO_DIPM && ata_id_has_dipm(dev->id)) {
+		err_mask = ata_dev_set_feature(dev,
+					SETFEATURES_SATA_DISABLE, SATA_DIPM);
+		if (err_mask && err_mask != AC_ERR_DEV)
+			ata_dev_err(dev, "Disable DIPM failed, Emask 0x%x\n",
+				    err_mask);
+	}
+}
+
 static void ata_dev_print_features(struct ata_device *dev)
 {
 	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK))
@@ -2963,6 +2984,7 @@ int ata_dev_configure(struct ata_device *dev)
 			ata_dev_config_chs(dev);
 		}
 
+		ata_dev_config_lpm(dev);
 		ata_dev_config_fua(dev);
 		ata_dev_config_devslp(dev);
 		ata_dev_config_sense_reporting(dev);
-- 
2.50.0

