Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28D299AA5;
	Mon, 12 May 2025 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087048; cv=none; b=uoShOSEgrEJPhHw/kL9nQbSDWVw7iw63zX9lbEyLNUGiYX8FMnEKxbpCH0m2DurA7XQ9TmpxA5TJcj74h/oRQoXb5XroSCXxTPbPEtgSlrO2Qm8zldcd2HGvra2N9nuhTzLkjvL1xtdYE1mfDfoS+cHoUGMtrDDtcnOHNtDdsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087048; c=relaxed/simple;
	bh=gE1OR5tGnrn3izCXTAKDAp7UlhwtWcuVL2/OUg0e+64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTMkxeWJdiuToxAT7PBFVDKnki1sEi6K3gv1so2atwow2bjmO1UkNp8B1jQDXDQVWK1N613TVlRx8slsSmy8gg4i4hC9HCrYh7cfh0o37+U93KeUjIIgOW6y2K7gygbhyH5r71lbxD/7fprBEhk0Tt2ylKBRLy3wbZy3cOgaheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItH3pCZv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItH3pCZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA65BC4CEE7;
	Mon, 12 May 2025 21:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747087047;
	bh=gE1OR5tGnrn3izCXTAKDAp7UlhwtWcuVL2/OUg0e+64=;
	h=From:To:Cc:Subject:Date:From;
	b=ItH3pCZvHqmJBQkDsGXWSWkXOi3B5vIfuuhGG9RQ6FvztaYirVuFCwpXWJqdRL99C
	 rXTlJUkH9hbhfFSzkexDg2JzR/W9zdirbbZye00SO8BrGERf7UF1sREInWDcGVJEtH
	 IU6IWGoeDFV7XkwpDCiqPdBcwsLkdKSN6riUV06RnG1bexYA/bAj0BdiPAPC+zg0B8
	 WOGrUjG89RKU0Dt4qSwBBzAxd7uK6Exgant8YJ8MQ8FS33hNJaMzxwzcGvmZ0ht6EX
	 aojPiC7hasEPnMrtRktPRP7xXLHMcDl9gBt/H5QpNrTGC9+PAqNffyaghe6SU8/sQv
	 q4mnfA0398C5Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: Convert st,ahci to DT schema
Date: Mon, 12 May 2025 16:57:23 -0500
Message-ID: <20250512215724.4178359-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the ST AHCI SATA Controller to DT schema format.

The phy-names changes from "ahci_phy" to "sata-phy" with the inclusion
of ahci-common.yaml. That's an ABI change, but the Linux driver at least
ignores the names. The binding uses "ports-implemented" property, so
including ahci-common.yaml is required.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/ata/ahci-st.txt       | 35 ---------
 .../devicetree/bindings/ata/st,ahci.yaml      | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-st.txt
 create mode 100644 Documentation/devicetree/bindings/ata/st,ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-st.txt b/Documentation/devicetree/bindings/ata/ahci-st.txt
deleted file mode 100644
index 909c9935360d..000000000000
--- a/Documentation/devicetree/bindings/ata/ahci-st.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-STMicroelectronics STi SATA controller
-
-This binding describes a SATA device.
-
-Required properties:
- - compatible	   : Must be "st,ahci"
- - reg		   : Physical base addresses and length of register sets
- - interrupts	   : Interrupt associated with the SATA device
- - interrupt-names :   Associated name must be; "hostc"
- - clocks	   : The phandle for the clock
- - clock-names	   :   Associated name must be; "ahci_clk"
- - phys		   : The phandle for the PHY port
- - phy-names	   :   Associated name must be; "ahci_phy"
-
-Optional properties:
- - resets	   : The power-down, soft-reset and power-reset lines of SATA IP
- - reset-names	   :   Associated names must be; "pwr-dwn", "sw-rst" and "pwr-rst"
-
-Example:
-
-	/* Example for stih407 family silicon */
-	sata0: sata@9b20000 {
-		compatible	= "st,ahci";
-		reg		= <0x9b20000 0x1000>;
-		interrupts	= <GIC_SPI 159 IRQ_TYPE_NONE>;
-		interrupt-names	= "hostc";
-		phys		= <&phy_port0 PHY_TYPE_SATA>;
-		phy-names	= "ahci_phy";
-		resets		= <&powerdown STIH407_SATA0_POWERDOWN>,
-				  <&softreset STIH407_SATA0_SOFTRESET>,
-				  <&softreset STIH407_SATA0_PWR_SOFTRESET>;
-		reset-names	= "pwr-dwn", "sw-rst", "pwr-rst";
-		clocks		= <&clk_s_c0_flexgen CLK_ICN_REG>;
-		clock-names	= "ahci_clk";
-	};
diff --git a/Documentation/devicetree/bindings/ata/st,ahci.yaml b/Documentation/devicetree/bindings/ata/st,ahci.yaml
new file mode 100644
index 000000000000..6e8e4b4f3d6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/st,ahci.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/st,ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi SATA controller
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+allOf:
+  - $ref: ahci-common.yaml#
+
+properties:
+  compatible:
+    const: st,ahci
+
+  interrupt-names:
+    items:
+      - const: hostc
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ahci_clk
+
+  resets:
+    items:
+      - description: Power-down line
+      - description: Soft-reset line
+      - description: Power-reset line
+
+  reset-names:
+    items:
+      - const: pwr-dwn
+      - const: sw-rst
+      - const: pwr-rst
+
+required:
+  - compatible
+  - interrupt-names
+  - phys
+  - phy-names
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/reset/stih407-resets.h>
+    #include <dt-bindings/clock/stih407-clks.h>
+
+    sata@9b20000 {
+        compatible    = "st,ahci";
+        reg           = <0x9b20000 0x1000>;
+        interrupts    = <GIC_SPI 159 IRQ_TYPE_NONE>;
+        interrupt-names = "hostc";
+        phys          = <&phy_port0 PHY_TYPE_SATA>;
+        phy-names     = "sata-phy";
+        resets        = <&powerdown STIH407_SATA0_POWERDOWN>,
+                         <&softreset STIH407_SATA0_SOFTRESET>,
+                         <&softreset STIH407_SATA0_PWR_SOFTRESET>;
+        reset-names   = "pwr-dwn", "sw-rst", "pwr-rst";
+        clocks        = <&clk_s_c0_flexgen CLK_ICN_REG>;
+        clock-names   = "ahci_clk";
+    };
-- 
2.47.2

