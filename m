Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DD1F63D9
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264928; cv=none; b=O9rE+mVoL04EJGDF+YQH6lN/Ni9HOIQnTtk11KwbXBrwF9wabC5QVir82gyQEhYTsQkjLLJ28PNi6mVn7bLe5gPfYuAuv+YrQk6x5ukGpnQxEZ0I8UptWSzsxrp8hptIu4LiBVVuq+d2DiPf7qJgZ8AC1vp4rCbwJkYBweQ1plw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264928; c=relaxed/simple;
	bh=LNVsjv8EqX8N9jpByMAIIGIVsPi/a5xIkgp4VbbgJg8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5WWgto09sRBG4xqBE66Gd1bU753nHZHEniJvFz33uOXSRvL5N8vOjpBl6iDPQ8oZB0aa8kS2bo2jGnggc0f8KrDH37kRWiPaLXC0fFob7wpG/FE8YK00n1kGLDCiJDWr1g5qRZ4AMl0lXEE0Bu7B/wRmoCdSow9y8S/RROMbL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQN6IJg8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQN6IJg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D107DC4CEF7;
	Mon, 30 Jun 2025 06:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751264928;
	bh=LNVsjv8EqX8N9jpByMAIIGIVsPi/a5xIkgp4VbbgJg8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QQN6IJg8u+dl8nJ1pSPRsOODUVvWhH6oeUaQwDJU36g1VRWSCIUtC+I8AsaFaKfVE
	 YxObprT7lb8DdbcdpEubQTihr9b1jDpbUaAh6pAAoZwRCpQiVO4qNjvHd6Dx32fahc
	 ehBJ2Sp5ZcVjt6/dAL2ANyGJuZg001bgwwnREtIBKZlXJKXSMPDmBati7/XI2tfdnZ
	 iS903vgPATUpNpWtm8s1IONRBrGQ6duNvJ3S1yclg91tallC0OnqcrAKs5+4Tcpw1B
	 +4D6fKYNcMBvYHX8NgsdZQ1kHitijslPJ23UEGlKSu1RYQ7qmjhOFlRUigu5kiuPSY
	 SQNMZO+DYDMLQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 01/10] ata: libata-core: Introduce ata_dev_config_lpm()
Date: Mon, 30 Jun 2025 15:26:28 +0900
Message-ID: <20250630062637.258329-2-dlemoal@kernel.org>
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

If the port of a device does not support Device Initiated Power
Management (DIPM), that is, the port is flagged with ATA_FLAG_NO_DIPM,
the DIPM feature of a device should be disabled when the device is first
configured.

Introduce the function ata_dev_config_lpm() to disable DIPM on a
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

