Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BF33C536;
	Fri, 20 Feb 2026 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584134; cv=none; b=UnfLrABrE9iA2D6nueV5X8S7ZHBsceH6TvWFzYP3CYGfMbX+nhk7WFwzdIXYn2oih6eq1bTGybjvkjj12pH4IMKvnbKOzeJvfqNJO2f+aJ+F+QWFJnlcQebhcZZRFhmR+dkCLyrp2oNHE1GpgwrMk3R7MeC/sOOFC7Ao+3K7VEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584134; c=relaxed/simple;
	bh=2+Qhmk5xCEXac0YyiYUablYyJ/h0nzG5rbWVo1xd11w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmnQ3iQS/Dkw/CW99sKWZSE8IwoNwDdCQJoAvmm0N26UcF5PslyZW1sQx/mC1NFxvtD27b/BhQt3PzxpZzuMexYIm9RaMwD6MwMHLyMTZWzykiiTxjsSS5U99tn3SPBVFoIj5l0AscU7Sa0LKyOM+TK719rujQgR4fbLaT4XfOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KjQkjQAg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KjQkjQAg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771584133; x=1803120133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2+Qhmk5xCEXac0YyiYUablYyJ/h0nzG5rbWVo1xd11w=;
  b=KjQkjQAggGrD7Fr7YS5ChAbio1rg9SusnU5kdBcFayxH9/n9bAKnASrq
   a/+W+gMEWmc+4LA47f1HkbT57YihXl35asIKHduR0ddNc2mD0w2F+RhSt
   LtidH6AZtfzoHlmiTvftGee83Zjy1Djl46c3DgHbjBGx07A0/dLmSV7aR
   NSLKrEONfh18va7sOQfcqYldyVhMnZsfGfijmGsOLPrxX64ljt51Gq06a
   Ca0D+ByCKepfqAb/ypkREPvM7X6m4RBGDUMIjYZR5lMCRlzOhmaGg6LXa
   WPF6aP1NbsVS6MGk23BW5L0itMWR6YPfiD9grSVTsz9DCxqf0iu+AaeH9
   w==;
X-CSE-ConnectionGUID: at24dP0aRkqn8vzdoU+4pQ==
X-CSE-MsgGUID: VritDko9TCiiZqW4Mnn7ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75284682"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="75284682"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:42:12 -0800
X-CSE-ConnectionGUID: Y1LBIIFhTWCW5ewKEiw00g==
X-CSE-MsgGUID: WIB8aOhERvGrodIQunb+5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="219322606"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 20 Feb 2026 02:42:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4F7CE95; Fri, 20 Feb 2026 11:42:09 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 1/1] ata: ahci-dwc: Remove not-going-to-be-supported code for Baikal SoC
Date: Fri, 20 Feb 2026 11:42:08 +0100
Message-ID: <20260220104208.2326568-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As noticed in the discussion [1] the Baikal SoC and platforms
are not going to be finalized, hence remove stale code.

Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/Kconfig    |  1 -
 drivers/ata/ahci_dwc.c | 54 ------------------------------------------
 2 files changed, 55 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 2349bca136e0..fff305ec1e78 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -194,7 +194,6 @@ config AHCI_DM816
 config AHCI_DWC
 	tristate "Synopsys DWC AHCI SATA support"
 	select SATA_HOST
-	select MFD_SYSCON if (MIPS_BAIKAL_T1 || COMPILE_TEST)
 	help
 	  This option enables support for the Synopsys DWC AHCI SATA
 	  controller implementation.
diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index 64abf865bb67..436041c57f73 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/libata.h>
 #include <linux/log2.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -92,20 +91,6 @@
 #define AHCI_DWC_PORT_PHYCR		0x74
 #define AHCI_DWC_PORT_PHYSR		0x78
 
-/* Baikal-T1 AHCI SATA specific registers */
-#define AHCI_BT1_HOST_PHYCR		AHCI_DWC_HOST_GPCR
-#define AHCI_BT1_HOST_MPLM_MASK		GENMASK(29, 23)
-#define AHCI_BT1_HOST_LOSDT_MASK	GENMASK(22, 20)
-#define AHCI_BT1_HOST_CRR		BIT(19)
-#define AHCI_BT1_HOST_CRW		BIT(18)
-#define AHCI_BT1_HOST_CRCD		BIT(17)
-#define AHCI_BT1_HOST_CRCA		BIT(16)
-#define AHCI_BT1_HOST_CRDI_MASK		GENMASK(15, 0)
-
-#define AHCI_BT1_HOST_PHYSR		AHCI_DWC_HOST_GPSR
-#define AHCI_BT1_HOST_CRA		BIT(16)
-#define AHCI_BT1_HOST_CRDO_MASK		GENMASK(15, 0)
-
 struct ahci_dwc_plat_data {
 	unsigned int pflags;
 	unsigned int hflags;
@@ -122,39 +107,6 @@ struct ahci_dwc_host_priv {
 	u32 dmacr[AHCI_MAX_PORTS];
 };
 
-static int ahci_bt1_init(struct ahci_host_priv *hpriv)
-{
-	struct ahci_dwc_host_priv *dpriv = hpriv->plat_data;
-	int ret;
-
-	/* APB, application and reference clocks are required */
-	if (!ahci_platform_find_clk(hpriv, "pclk") ||
-	    !ahci_platform_find_clk(hpriv, "aclk") ||
-	    !ahci_platform_find_clk(hpriv, "ref")) {
-		dev_err(&dpriv->pdev->dev, "No system clocks specified\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Fully reset the SATA AXI and ref clocks domain to ensure the state
-	 * machine is working from scratch especially if the reference clocks
-	 * source has been changed.
-	 */
-	ret = ahci_platform_assert_rsts(hpriv);
-	if (ret) {
-		dev_err(&dpriv->pdev->dev, "Couldn't assert the resets\n");
-		return ret;
-	}
-
-	ret = ahci_platform_deassert_rsts(hpriv);
-	if (ret) {
-		dev_err(&dpriv->pdev->dev, "Couldn't de-assert the resets\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static struct ahci_host_priv *ahci_dwc_get_resources(struct platform_device *pdev)
 {
 	struct ahci_dwc_host_priv *dpriv;
@@ -457,15 +409,9 @@ static struct ahci_dwc_plat_data ahci_dwc_plat = {
 	.pflags = AHCI_PLATFORM_GET_RESETS,
 };
 
-static struct ahci_dwc_plat_data ahci_bt1_plat = {
-	.pflags = AHCI_PLATFORM_GET_RESETS | AHCI_PLATFORM_RST_TRIGGER,
-	.init = ahci_bt1_init,
-};
-
 static const struct of_device_id ahci_dwc_of_match[] = {
 	{ .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
 	{ .compatible = "snps,spear-ahci", &ahci_dwc_plat },
-	{ .compatible = "baikal,bt1-ahci", &ahci_bt1_plat },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_dwc_of_match);
-- 
2.50.1

