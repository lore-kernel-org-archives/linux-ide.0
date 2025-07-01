Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F825B301
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374533; cv=none; b=uij4J/3GroIBR6a784Id5DEaYcd1VKDZDvH3nRWcvEQxToWQZYlAmpzw4FwCVXA+4VN1HcHrX4ip/4XeUKVDRZYj8+tv3l2Ge/1CjMCmtwBILZOFnIN/WypfMbHmOZ/4ateRpeey6HXWM2Lgz3+twbiv+sGvJYCLe9XQEQf9Duk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374533; c=relaxed/simple;
	bh=6rmzGFT/PrcEZBwuQXJPg/gulvM2i0cKUy8gg26iI9Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6a0IQJ/beAgGq6kX+rcQ1eM/Yf1eXCpUL7ga/qFYOOntQU6vDpMRlWGg+R/mOWnxR1r9oqnwoAFBzeHolpbX121XsXtiEECGIsSoW4KoDN4choVm9NjYgsUcnFnLoQ0DQ4Fp24ocKOSY+HwTFl9z7b0KZ/kMcjzOOjx9FsIDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTi0j3qU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTi0j3qU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82049C4CEED;
	Tue,  1 Jul 2025 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374532;
	bh=6rmzGFT/PrcEZBwuQXJPg/gulvM2i0cKUy8gg26iI9Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MTi0j3qU0pIy8DG/xVSN2IkUgvHj9hGTPf88yp2wfmYRJ39z+ZWOWG1AfbFEqUc04
	 XSK09s6y4gzDhjQO1mK+RKl5sgPwRlFSWTpw1y0Sb/qIpNUxfp6ONqcfIrmxrk3hai
	 AcRGJcERKzzvkNVT8rBOuC4EFdg4mUFJ+q3BWx16WEf2Af8SxX98yz2ypNG9BY2gTH
	 iCqlP4s5TkfIiTMeeMYgGH0oTxBhl9Iijjt0+bx0arUi7hG6zWBs8gWteZ9Kw1Kj+W
	 uUj71PfGOGSczCPZQJQAEZEIV6qhF1COop7n9VJcWMUGQo/5CBFUQ29RPy5yBhja9I
	 3lPx/NoPKduNA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 01/10] ata: libata-core: Introduce ata_dev_config_lpm()
Date: Tue,  1 Jul 2025 21:53:12 +0900
Message-ID: <20250701125321.69496-2-dlemoal@kernel.org>
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

If the port of a device does not support Device Initiated Power
Management (DIPM), that is, the port is flagged with ATA_FLAG_NO_DIPM,
the DIPM feature of a device should not be used. Though DIPM is disabled
by default on a device, the "Software Settings Preservation feature"
may keep DIPM enabled or DIPM may have been enabled by the system
firmware.

Introduce the function ata_dev_config_lpm() to always disable DIPM on a
device that supports this feature if the port of the device is flagged
with ATA_FLAG_NO_DIPM. ata_dev_config_lpm() is called from
ata_dev_configure(), ensuring that a device DIPM feature is disabled
when it cannot be used.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3918ea624e0b..6df5e51ece21 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2790,6 +2790,30 @@ static void ata_dev_config_cpr(struct ata_device *dev)
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
+	 * Device Initiated Power Management (DIPM) is normally disabled by
+	 * default on a device. However, DIPM may have been enabled and that
+	 * setting kept even after COMRESET because of the Software Settings
+	 * Preservation feature. So if the port does not support DIPM and the
+	 * device does, disable DIPM on the device.
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
@@ -2963,6 +2987,7 @@ int ata_dev_configure(struct ata_device *dev)
 			ata_dev_config_chs(dev);
 		}
 
+		ata_dev_config_lpm(dev);
 		ata_dev_config_fua(dev);
 		ata_dev_config_devslp(dev);
 		ata_dev_config_sense_reporting(dev);
-- 
2.50.0

