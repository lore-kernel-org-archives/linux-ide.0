Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7302F1FE2
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328981; cv=none; b=BeSP/atONwLLa3yIW0Eu/w+vXYuOH3CC1rNvsSKYMGPWwKM5lbc19owGxM+jxPyf2YENV5gXCCDc+xnACjX2MilqfRtZkbn05IW5V3C7Wo245woPUA5lNoIuG6/j0XY/kUrwVY44pzpgzBg01SY/coC2MVSCgshrvQW3tulokPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328981; c=relaxed/simple;
	bh=yib31MXLzOGQnOJzci964+a5FAZ8uiJFxMZsY6ypURY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wgfv78OijBjiFiNO3hLDvgtqITeGgJJ/WA9w/bZlfEza1x13gChdQuqC3amOBVzdLjE2bhPZpiywNtfgIHQGIx+5ejoebRCPv/zdGwYCoBkJ/FiEsmqde1JCqDw+GJ9lEKb4fjxKiBeGz5QRXvRxKFU1gdUV9y5BAiv8xJRSHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvT4LlJo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvT4LlJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735A7C4CEF1;
	Tue,  1 Jul 2025 00:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328980;
	bh=yib31MXLzOGQnOJzci964+a5FAZ8uiJFxMZsY6ypURY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WvT4LlJoR3UAI+x3tVM8wQVmIKaM1OZoB+8j5zhm4aeV1vYreOfTBtsyBp6GZVQGR
	 YrTnEq7/BLV4QJ3nbn2fADLp+c5Idwg7KBgWKEwXCtyodCfdVUBNV45DqV78Qgsw9G
	 Iup03RK66SIzK1TtQSoFX/VoACf8RLjx96puGPl6eJAQfu1AK9BZBt9bPqSCfTNO51
	 aPpjFwe9zVr5S0AqGpUJ61T3hdWP8+6S4aTUJm8e/bx8jZIS63qJYFPgMY5etLDDpc
	 A7JkPZvQvPR8m//AF3A3cJXT9eWx/ZXHXDPxRT8Cajq0c0xj1kU5lhqcmK2pA24kx9
	 0+Gqdh2Hbal6Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 04/10] ata: libata-eh: Avoid unnecessary resets when revalidating devices
Date: Tue,  1 Jul 2025 09:14:02 +0900
Message-ID: <20250701001408.330364-5-dlemoal@kernel.org>
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

In ata_eh_revalidate_and_attach(), a link LPM policy is always
set to ATA_LPM_MAX_POWER before calling ata_dev_revalidate() to ensure
that the call to ata_phys_link_offline() does not return true, thus
causing an unnecessary device reset. This change was introduced
with commit 71d7b6e51ad3 ("ata: libata-eh: avoid needless hard reset
when revalidating link").

However, setting the link LPM policy to ATA_LPM_MAX_POWER may be
visible only after some time, depending on the power state the link was
in. E.g. transitioning out of the Partial state should take no longer
than a few microseconds, but transitioning out of the Slumber or
DevSleep state may take several milliseconds. So despite the changes
introduced with commit 71d7b6e51ad3 ("ata: libata-eh: avoid needless
hard reset when revalidating link"), we can still endup with
ata_phys_link_offline() seeing a link SCR_STATUS register signaling that
the device is present (DET is equal to 1h) but that the link PHY is
still in a low power mode (e.g. IPM is 2h, signaling "Interface in
Partial power management state"). In such cases, ata_phys_link_offline()
returns true, causing an EIO return for ata_eh_revalidate_and_attach()
and a device reset.

Avoid such unnecessary device resets by introducing a relaxed version
of the link offline test implemented by ata_phys_link_offline() with
the new helper function ata_eh_link_established(). This functions
returns true if for the link SCR_STATUS register we see that:
 - A device is still present, that is, the DET field is 1h (Device
   presence detected but Phy communication not established) or 3h
   (Device presence detected and Phy communication established).
 - Communication is established, that is, the IPM field is not 0h,
   indicating that the PHY is online or in a low power state.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f98d5123e1e4..7f5d13f9ca73 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2071,6 +2071,33 @@ static void ata_eh_get_success_sense(struct ata_link *link)
 	ata_eh_done(link, dev, ATA_EH_GET_SUCCESS_SENSE);
 }
 
+/*
+ * Check if a link is established. This is a relaxed version of
+ * ata_phys_link_online() which accounts for the fact that this is potentially
+ * called after changing the link power management policy, which may not be
+ * reflected immediately in the SSTAUS register (e.g., we may still be seeing
+ * the PHY in partial, slumber or devsleep Partial power management state.
+ * So check that:
+ * - A device is still present, that is, DET is 1h (Device presence detected
+ *   but Phy communication not established) or 3h (Device presence detected and
+ *   Phy communication established)
+ * - Communication is established, that is, IPM is not 0h, indicating that PHY
+ *   is online or in a low power state.
+ */
+static bool ata_eh_link_established(struct ata_link *link)
+{
+	u32 sstatus;
+	u8 det, ipm;
+
+	if (sata_scr_read(link, SCR_STATUS, &sstatus))
+		return false;
+
+	det = sstatus & 0x0f;
+	ipm = (sstatus >> 8) & 0x0f;
+
+	return (det & 0x01) && ipm;
+}
+
 /**
  *	ata_eh_link_set_lpm - configure SATA interface power management
  *	@link: link to configure
@@ -3275,7 +3302,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 					goto err;
 			}
 
-			if (ata_phys_link_offline(ata_dev_phys_link(dev))) {
+			if (!ata_eh_link_established(ata_dev_phys_link(dev))) {
 				rc = -EIO;
 				goto err;
 			}
-- 
2.50.0

