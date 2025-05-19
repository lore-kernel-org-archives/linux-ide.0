Received: from devloop.tasossah.com (devloop.tasossah.com [145.239.141.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B070126AA9E
	for <linux-ide@vger.kernel.org>; Mon, 19 May 2025 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.141.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645198; cv=none; b=Uz/erYtPmsl9fdCf9na9UTfAyyXLPHWPjSMXfTveHwbPl/gTS0ZACSYUKle889IwfzET5Dr6fjEgcc8HAGDkDiCciyEz8jqLReymXP4tCvzV56MB9L3A+6nbpnC8gYiSJg7DRlhoJu1JsHfsqi7KowHPS0UNMsvdpBdGXYHFvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645198; c=relaxed/simple;
	bh=zYZm12BSC+rchbIdU8Fdoaqfi/XaRvING6WyyHmdV4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxVjQe6Kg2Q1UW2N3V+55jUNlSDYQar6bxlrdMa+675YnuQp2g9ijRGo753ISDaRd1wxXT7V+Hmkvhx+f6fLTtf8AMYoDs2TaJ3Owaf6WqXGhne5wuyEqpcAAHZ/SuTlTid9G0wJNcYnhe37iKkg1FBTWJUjs/xtcBEmd2BUdvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com; spf=pass smtp.mailfrom=tasossah.com; dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b=lpQG0HzR; arc=none smtp.client-ip=145.239.141.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tasossah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b="lpQG0HzR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tasossah.com; s=devloop; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GKAGVAmuM+4D27LZt2EKj1PMWe1tH67tMZ0Eg9rcQPo=; b=lpQG0HzRZ8V0jXCEPlaswudUAO
	WVXA4ORlIoVcV8N3EL6jVRXmD849ZlgqEOtW1yOwogaHXgoCZi05PXLU+vY0ZFYdK9xfssVahyCmF
	/IO3r5+kxXF39RJgBWqDkCeibMJ9CoZfu+PPmHvxVHL2xN2cz3d7n9ypxehkbFy8qT91nxkzK5K2Y
	I4WG8nYrXndX4zsic3qw+H9YNp6wrRzHA94gR0nZQoAeS9d1SijRYRUQHFfUYit+KdTaUhT3NRVNl
	Hn3viWz2qS1PZ5WSCU9H2YTdR0S2ERjS/cvgFRL1YlacVCogL/UJKqzGdNSEn9RsRucZhgwj0BNFf
	cB+G+Dg+B1nOJQyNsqzpgnHlxPnOFPKJ1aUVZ1TRdXUMyAsxdceROz5ocnRFf2+5bd/QnFIi3Z52o
	cEW4Tfz/Cp41GxcOSZiEzlk0g1L+r8hnNYO7uxEqa9JdAJ1XL9NGqm/95lUvKwwPl8KsFJ2SDOq37
	AKtNIKByekSr/KsEEM1azh0zClr9EcoNg2XPb66DMBXzzjUoWSUTrVNGAno74cJaj6SmLOOGokI6c
	nHjm8kH669mQPD5MazNqrDAbxYSUj4iCSWOVlcIu6DdsK1wki4ad6m5BagiFrHnYTihdEvxQEIUr4
	zWvx81dDdqZmJkejbHCJN4ATBNbXL1HfUQ/CEKT3U=;
Received: from [2a02:587:6a09:4a00:71b3:b927:f95e:c3f5] (helo=localhost.localdomain)
	by devloop.tasossah.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <tasos@tasossah.com>)
	id 1uGwLi-0000000CGTx-3VSJ;
	Mon, 19 May 2025 11:59:54 +0300
From: Tasos Sahanidis <tasos@tasossah.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tasos Sahanidis <tasos@tasossah.com>
Subject: [PATCH v2] ata: libata-acpi: Do not assume 40 wire cable if no devices are enabled
Date: Mon, 19 May 2025 11:56:55 +0300
Message-ID: <20250519085945.1399466-1-tasos@tasossah.com>
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

Resolve this by modifying ata_acpi_cbl_80wire() to directly return the
cable type. First, an unknown cable is assumed which preserves the mode
set by the firmware, and then on subsequent calls when the devices have
been enabled, an 80 wire cable is correctly detected.

Since the function now directly returns the cable type, it has been
renamed to ata_acpi_cbl_pata_type().

Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
---
 v1 -> v2: Address review feedback
     * ata_acpi_cbl_80wire -> ata_acpi_cbl_pata_type
     * ata_acpi_init_gtm() called inside ata_acpi_cbl_pata_type

 drivers/ata/libata-acpi.c | 24 ++++++++++++++++--------
 drivers/ata/pata_via.c    |  6 ++----
 include/linux/libata.h    |  7 +++----
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index b7f0bf795521..f2140fc06ba0 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -514,15 +514,19 @@ unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
 EXPORT_SYMBOL_GPL(ata_acpi_gtm_xfermask);
 
 /**
- * ata_acpi_cbl_80wire		-	Check for 80 wire cable
+ * ata_acpi_cbl_pata_type - Return PATA cable type
  * @ap: Port to check
- * @gtm: GTM data to use
  *
- * Return 1 if the @gtm indicates the BIOS selected an 80wire mode.
+ * Return ATA_CBL_PATA* according to the transfer mode selected by BIOS
  */
-int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
+int ata_acpi_cbl_pata_type(struct ata_port *ap)
 {
 	struct ata_device *dev;
+	int ret = ATA_CBL_PATA_UNK;
+	const struct ata_acpi_gtm *gtm = ata_acpi_init_gtm(ap);
+
+	if (!gtm)
+		return ATA_CBL_PATA40;
 
 	ata_for_each_dev(dev, &ap->link, ENABLED) {
 		unsigned int xfer_mask, udma_mask;
@@ -530,13 +534,17 @@ int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
 		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
 		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
 
-		if (udma_mask & ~ATA_UDMA_MASK_40C)
-			return 1;
+		ret = ATA_CBL_PATA40;
+
+		if (udma_mask & ~ATA_UDMA_MASK_40C) {
+			ret = ATA_CBL_PATA80;
+			break;
+		}
 	}
 
-	return 0;
+	return ret;
 }
-EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
+EXPORT_SYMBOL_GPL(ata_acpi_cbl_pata_type);
 
 static void ata_acpi_gtf_to_tf(struct ata_device *dev,
 			       const struct ata_acpi_gtf *gtf,
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 696b99720dcb..c8acf6511071 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -201,11 +201,9 @@ static int via_cable_detect(struct ata_port *ap) {
 	   two drives */
 	if (ata66 & (0x10100000 >> (16 * ap->port_no)))
 		return ATA_CBL_PATA80;
+
 	/* Check with ACPI so we can spot BIOS reported SATA bridges */
-	if (ata_acpi_init_gtm(ap) &&
-	    ata_acpi_cbl_80wire(ap, ata_acpi_init_gtm(ap)))
-		return ATA_CBL_PATA80;
-	return ATA_CBL_PATA40;
+	return ata_acpi_cbl_pata_type(ap);
 }
 
 static int via_pre_reset(struct ata_link *link, unsigned long deadline)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e5695998acb0..ec3b0c9c2a8c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1363,7 +1363,7 @@ int ata_acpi_stm(struct ata_port *ap, const struct ata_acpi_gtm *stm);
 int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *stm);
 unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
 				   const struct ata_acpi_gtm *gtm);
-int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm);
+int ata_acpi_cbl_pata_type(struct ata_port *ap);
 #else
 static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
 {
@@ -1388,10 +1388,9 @@ static inline unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
 	return 0;
 }
 
-static inline int ata_acpi_cbl_80wire(struct ata_port *ap,
-				      const struct ata_acpi_gtm *gtm)
+static inline int ata_acpi_cbl_pata_type(struct ata_port *ap)
 {
-	return 0;
+	return ATA_CBL_PATA40;
 }
 #endif
 
-- 
2.43.0

