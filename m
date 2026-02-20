Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FF1343D91;
	Fri, 20 Feb 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594580; cv=none; b=ktqwlY+KISQiwpFTex1cFxC+omx9CyBLFg1v0JT9IxfKdj9+Bq8eJ80JEHWlPJmPbXvqEYdsG2PjqiH+7SRHKkpnePEF4B8hRLU//90wwa5ChSHVVV/j8YLbZe1zjUR5uBWEwVH/QBOM9ulLuCcLjpeU3u7IArp9VAzfQMNNJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594580; c=relaxed/simple;
	bh=mdmgfTaAzOAg1qHQ2chCWDOSiu05V3ropYOq8/9q9tA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ua/J+a4xDtodl4Vn/isNzTc08LIuQmSsR7yB/SNm9bFfSYuQRnotD2LIDjD6egbW9cccD3o/UPwxua9sDXt8aJImpwB7pmg/duihWh3h8uTRSlZGqQdx2P/+D+kXtcOQWN4avJFw2/SLlXeNJp11erRrDDhN4tD1IK1K2jz8/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkwBQQF+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkwBQQF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771594579; x=1803130579;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mdmgfTaAzOAg1qHQ2chCWDOSiu05V3ropYOq8/9q9tA=;
  b=XkwBQQF+iYwR8ahskVEdMj9TS3ZsOaTAowtm1flumB8KAdVu3GzbEVUe
   Qus4CPT6DeNtQq4WuGOpt31+yxb737olhaTMFxzm3lXHw63G+oY+ydi0m
   wTM064+1O2rdfJa3FRWK8iXn8YDwdD5jGaSlHN/Ku+7z/lWZyycwq3L6r
   4YU0v6Hm07RhO7zH7qqjc2vmhPjtFhf54740hkqk2hENqGJAAKfkeTMYW
   SerQkgm62lvYbqu5oWOGawhZWh16sWkiWil0FzG7DW5DPWYY7vwl6pJ2h
   rej7RDYKLSCHhbX9VFjRuaPcukftRv/7wDnJikglNlRq+YnftArCIrtEZ
   w==;
X-CSE-ConnectionGUID: NW7Vn9//T5WGIlCJj9wpBw==
X-CSE-MsgGUID: tdj2PSQKSD2A578GhTgnyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72387601"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72387601"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:36:19 -0800
X-CSE-ConnectionGUID: qdnhmFbJRS+3ycLu6wy4JQ==
X-CSE-MsgGUID: OPf/udNsT6y3qvzBlzrd+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="219352862"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 20 Feb 2026 05:36:16 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1792695; Fri, 20 Feb 2026 14:36:15 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 1/1] ata: ahci-dwc: Remove not-going-to-be-supported code for Baikal SoC
Date: Fri, 20 Feb 2026 14:35:46 +0100
Message-ID: <20260220133613.2392906-1-andriy.shevchenko@linux.intel.com>
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

v2: dropped YAML and regmap.h (Niklas)

 .../bindings/ata/baikal,bt1-ahci.yaml         | 115 ------------------
 drivers/ata/Kconfig                           |   1 -
 drivers/ata/ahci_dwc.c                        |  55 ---------
 3 files changed, 171 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
deleted file mode 100644
index 9b7ca4759bd7..000000000000
--- a/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
+++ /dev/null
@@ -1,115 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/ata/baikal,bt1-ahci.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Baikal-T1 SoC AHCI SATA controller
-
-maintainers:
-  - Serge Semin <fancer.lancer@gmail.com>
-
-description:
-  AHCI SATA controller embedded into the Baikal-T1 SoC is based on the
-  DWC AHCI SATA v4.10a IP-core.
-
-allOf:
-  - $ref: snps,dwc-ahci-common.yaml#
-
-properties:
-  compatible:
-    const: baikal,bt1-ahci
-
-  clocks:
-    items:
-      - description: Peripheral APB bus clock
-      - description: Application AXI BIU clock
-      - description: SATA Ports reference clock
-
-  clock-names:
-    items:
-      - const: pclk
-      - const: aclk
-      - const: ref
-
-  resets:
-    items:
-      - description: Application AXI BIU domain reset
-      - description: SATA Ports clock domain reset
-
-  reset-names:
-    items:
-      - const: arst
-      - const: ref
-
-  ports-implemented:
-    maximum: 0x3
-
-patternProperties:
-  "^sata-port@[0-1]$":
-    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
-
-    properties:
-      reg:
-        minimum: 0
-        maximum: 1
-
-      snps,tx-ts-max:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description:
-          Due to having AXI3 bus interface utilized the maximum Tx DMA
-          transaction size can't exceed 16 beats (AxLEN[3:0]).
-        enum: [ 1, 2, 4, 8, 16 ]
-
-      snps,rx-ts-max:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description:
-          Due to having AXI3 bus interface utilized the maximum Rx DMA
-          transaction size can't exceed 16 beats (AxLEN[3:0]).
-        enum: [ 1, 2, 4, 8, 16 ]
-
-    unevaluatedProperties: false
-
-required:
-  - compatible
-  - reg
-  - interrupts
-  - clocks
-  - clock-names
-  - resets
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    sata@1f050000 {
-      compatible = "baikal,bt1-ahci";
-      reg = <0x1f050000 0x2000>;
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      interrupts = <0 64 4>;
-
-      clocks = <&ccu_sys 1>, <&ccu_axi 2>, <&sata_ref_clk>;
-      clock-names = "pclk", "aclk", "ref";
-
-      resets = <&ccu_axi 2>, <&ccu_sys 0>;
-      reset-names = "arst", "ref";
-
-      ports-implemented = <0x3>;
-
-      sata-port@0 {
-        reg = <0>;
-
-        snps,tx-ts-max = <4>;
-        snps,rx-ts-max = <4>;
-      };
-
-      sata-port@1 {
-        reg = <1>;
-
-        snps,tx-ts-max = <4>;
-        snps,rx-ts-max = <4>;
-      };
-    };
-...
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
index 64abf865bb67..feb8a8539b8e 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -13,12 +13,10 @@
 #include <linux/kernel.h>
 #include <linux/libata.h>
 #include <linux/log2.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
-#include <linux/regmap.h>
 
 #include "ahci.h"
 
@@ -92,20 +90,6 @@
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
@@ -122,39 +106,6 @@ struct ahci_dwc_host_priv {
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
@@ -457,15 +408,9 @@ static struct ahci_dwc_plat_data ahci_dwc_plat = {
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

