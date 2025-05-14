Received: from devloop.tasossah.com (devloop.tasossah.com [145.239.141.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9A1C84A6
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.141.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747247416; cv=none; b=bFpKZFliffYUhHn8ha7KqduCtZv0ihp+1ZEs1xQpdwnt/lXylVQbsd437kMyLMCkVd0F8EF2IlEJNXupSWS89/H5bDibH5PpwyA+iSCSFBNFqXSvvkIgbyjVGpa2VSaq65lC5Xetunh5ARNK1/AY2kGg8yww8s2xzn0JHJEnxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747247416; c=relaxed/simple;
	bh=zxLlAhMqo+J6DjxsOmkcpvBskS8NlFzjcxixQt5vaPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hCDth4sviYjoF/oORiY+ZhP7FskDFZmulULRpJlVLHAgCx2nuKhKHpcg6OQybggh6z7MU5Ar/CqYn2Ef8KF/QdmnmLD6GjEOvgBPj1TcyL6Kp9gG6jWAnW7fA9o7qyYrEEsGRfFpf9cPq3DyOBzX5NPyruc6wtw3+jMOQt4v0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com; spf=pass smtp.mailfrom=tasossah.com; dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b=NWehsL7J; arc=none smtp.client-ip=145.239.141.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tasossah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b="NWehsL7J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tasossah.com; s=devloop; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qFUt8LMY0bAXaKbjzLPforqwLM9U8iGIMeRKQA1+YW8=; b=NWehsL7JVTcsFzIgY/ThKnbBUA
	fOQjk+b/998GXa1mh7kxPMvb1g8wr4z4dlF4XOc97noRMCRdEGhza/RS13DI+exmBmVM8jGXIjfx2
	ItP80h4rqn3YOt2T+tr5umy8XeZ2FwxGQTnLJVoNc2qy2bfwSmehgyScisI9hzxcXIAGIM4YPCmdg
	wnKKfjb0/AWajenn+bY+MfRlsa9mbk6DYcVX5Ub7Oziki3lgRsoNpthPI+piSccPUQNC7Uu1HKqAl
	XkOQOJB0xcT+O4niYAgFAJA9AvX9alwYNHnwcEjX/cMAKL0Nix/N42zF6DT54Y1H3coKAhEyZ7DPT
	1feahQaibnAGpN8YErEzzytMPmjqg7KTx4ps5SNhJ9Vlfh9W4sOp/XFTOGJCEp5eIkmNxQsM1bIKS
	tygjcxkpszqHWdKVQ44Ma1Cj0XTWF6KUnEmIYXE/HBuxk3ZjZ4J+NCUbN1o7aIDsSw5W9OG8Kb17P
	bna0n60wpTHNQkH33fKU+ZYr8dvSgDmdGte3g26X9u4FNO9/8S9Yq0cPVC2oH+eeCqI+yKio00PRY
	Hc4ECR205lqrk3/cunX9uAFmu2+YvWoaCgQMHYfpSTPcbP30c78BJQSoR/2AQtys02vWSkuJIDPmi
	Lh/pnKbYY3843ld9YN8i1fgQQUvAblexHtKtKMtSo=;
Received: from [2a02:587:6a09:4a00:e434:6f7a:8bc0:eab1] (helo=localhost.localdomain)
	by devloop.tasossah.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <tasos@tasossah.com>)
	id 1uFGrs-0000000BMdQ-2u0g;
	Wed, 14 May 2025 21:30:12 +0300
From: Tasos Sahanidis <tasos@tasossah.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tasos Sahanidis <tasos@tasossah.com>
Subject: [PATCH] ata: libata-acpi: Do not assume 40 wire cable if no devices are enabled
Date: Wed, 14 May 2025 21:29:38 +0300
Message-ID: <20250514182939.151081-1-tasos@tasossah.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On at least an ASRock 990FX Extreme 4 with a VIA VT6330, the devices
have not yet been enabled by the first time ata_acpi_cbl_80wire() is
called. This means that the ata_for_each_dev loop is never entered,
and a 40 wire cable is assumed.

The VIA controller on this board does not report the cable in the PCI
config space, thus having to fall back to ACPI even though no SATA
bridge is present.

The _GTM values are correctly reported by the firmware through ACPI,
which has already set up faster transfer modes, but due to the above
the controller is forced down to a maximum of UDMA/33.

Resolve this by returning EAGAIN in ata_acpi_cbl_80wire() if no devices
have been detected and modify pata_via to handle this scenario.

First, an unknown cable is assumed which preserves the mode set by the
firmware, and then on subsequent calls when the devices have been
enabled, an 80 wire cable is correctly detected.

Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
---
 drivers/ata/libata-acpi.c | 11 ++++++++---
 drivers/ata/pata_via.c    | 13 ++++++++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index b7f0bf795521..c508a19c2495 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -523,6 +523,7 @@ EXPORT_SYMBOL_GPL(ata_acpi_gtm_xfermask);
 int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
 {
 	struct ata_device *dev;
+	int ret = -EAGAIN;
 
 	ata_for_each_dev(dev, &ap->link, ENABLED) {
 		unsigned int xfer_mask, udma_mask;
@@ -530,11 +531,15 @@ int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
 		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
 		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
 
-		if (udma_mask & ~ATA_UDMA_MASK_40C)
-			return 1;
+		ret = 0;
+
+		if (udma_mask & ~ATA_UDMA_MASK_40C) {
+			ret = 1;
+			break;
+		}
 	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 696b99720dcb..4d03b4a1ea4d 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -182,6 +182,7 @@ static int via_cable_detect(struct ata_port *ap) {
 	const struct via_isa_bridge *config = ap->host->private_data;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 ata66;
+	const struct ata_acpi_gtm *gtm;
 
 	if (via_cable_override(pdev))
 		return ATA_CBL_PATA40_SHORT;
@@ -202,9 +203,15 @@ static int via_cable_detect(struct ata_port *ap) {
 	if (ata66 & (0x10100000 >> (16 * ap->port_no)))
 		return ATA_CBL_PATA80;
 	/* Check with ACPI so we can spot BIOS reported SATA bridges */
-	if (ata_acpi_init_gtm(ap) &&
-	    ata_acpi_cbl_80wire(ap, ata_acpi_init_gtm(ap)))
-		return ATA_CBL_PATA80;
+	gtm = ata_acpi_init_gtm(ap);
+	if (gtm) {
+		int cbl = ata_acpi_cbl_80wire(ap, gtm);
+
+		if (cbl < 0)
+			return ATA_CBL_PATA_UNK;
+		else if (cbl == 1)
+			return ATA_CBL_PATA80;
+	}
 	return ATA_CBL_PATA40;
 }
 
-- 
2.43.0

