Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081F29A309;
	Mon, 12 May 2025 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087041; cv=none; b=FOisACXOPdsZqBjmYg62M/Jq6LtVV9nxLXEwksitzzY1+ZzfBEycUzhBNiFmX2GoTzZfsMb2cdcOAG/LY0vY5bxhGsPAP/C17lIAA84VNYGvTOc9Y2k/0olJE6a2R/iACqPWqqAQIx3xgoEvLCbSiQ1HcwqB76PmtUja9rNyYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087041; c=relaxed/simple;
	bh=BuQrryaIgC3EvZiXKjjWrWy0UGz783xjPVrTxSZuytA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJ7R33kAEYoX1nJ3JJEXkXdaoThQlgI92UzD7omiws6O9/1k6pEqUBrcSbqblIaiO1dlzRgYMVb7dMmTMnfnYVWtR301ySe/KaTPRgddP3XTCWkVAxSXUOuXz+gJ+NCeyAsBCmb7hR0Jrbe/YZ//ITa+FcALc4hoN0JgV2157ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPDJ9hH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPDJ9hH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255D2C4CEE7;
	Mon, 12 May 2025 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747087040;
	bh=BuQrryaIgC3EvZiXKjjWrWy0UGz783xjPVrTxSZuytA=;
	h=From:To:Cc:Subject:Date:From;
	b=cPDJ9hH9sTvGySkqanQHF3qB34h+U77R9SMDbkuD9R4ZgWjQV/xWuwqaz+SbgpiIj
	 Es0MpNn52QWPpaJz4TaJJ6u8BrgC55YqQL3W/Qj9WCtqqWPARUkNDv8h7wLFYvXA/K
	 iLvje7EWqUEvwD41neruOC/+XNl0AiZ/Si7J8QeOIOYGFpQtGMfTHdZuM8oFkDmEhP
	 SPHZAb5qLkt/t+lM5Z88mk2nayTZ6oWfIqwgwDGOEBbtUbM3d4Y5Pr0bg4UVEVjUT7
	 OYjuX+HeH8lfD3qQ9i6V53PgCZtQ5h2bInNAyFzGDWcPw1onWlUYqfmYlaHldJO+Vy
	 tn6+Psbgt6+NA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: Convert ti,dm816-ahci to DT schema
Date: Mon, 12 May 2025 16:57:05 -0500
Message-ID: <20250512215706.4177925-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the TI DM816 AHCI SATA Controller to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/ata/ahci-dm816.txt    | 21 ---------
 .../bindings/ata/ti,dm816-ahci.yaml           | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-dm816.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ti,dm816-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-dm816.txt b/Documentation/devicetree/bindings/ata/ahci-dm816.txt
deleted file mode 100644
index f8c535f3541f..000000000000
--- a/Documentation/devicetree/bindings/ata/ahci-dm816.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Device tree binding for the TI DM816 AHCI SATA Controller
----------------------------------------------------------
-
-Required properties:
-  - compatible: must be "ti,dm816-ahci"
-  - reg: physical base address and size of the register region used by
-         the controller (as defined by the AHCI 1.1 standard)
-  - interrupts: interrupt specifier (refer to the interrupt binding)
-  - clocks: list of phandle and clock specifier pairs (or only
-            phandles for clock providers with '0' defined for
-            #clock-cells); two clocks must be specified: the functional
-            clock and an external reference clock
-
-Example:
-
-	sata: sata@4a140000 {
-		compatible = "ti,dm816-ahci";
-		reg = <0x4a140000 0x10000>;
-		interrupts = <16>;
-		clocks = <&sysclk5_ck>, <&sata_refclk>;
-	};
diff --git a/Documentation/devicetree/bindings/ata/ti,dm816-ahci.yaml b/Documentation/devicetree/bindings/ata/ti,dm816-ahci.yaml
new file mode 100644
index 000000000000..d0ff9e78afe6
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ti,dm816-ahci.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/ti,dm816-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI DM816 AHCI SATA Controller
+
+maintainers:
+  - Bartosz Golaszewski <brgl@bgdev.pl>
+
+allOf:
+  - $ref: ahci-common.yaml#
+
+properties:
+  compatible:
+    const: ti,dm816-ahci
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: functional clock
+      - description: external reference clock
+
+  ti,hwmods:
+    const: sata
+
+required:
+  - compatible
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sata@4a140000 {
+        compatible = "ti,dm816-ahci";
+        reg = <0x4a140000 0x10000>;
+        interrupts = <16>;
+        clocks = <&sysclk5_ck>, <&sata_refclk>;
+    };
-- 
2.47.2

