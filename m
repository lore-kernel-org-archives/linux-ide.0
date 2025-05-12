Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CC299A8B;
	Mon, 12 May 2025 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087081; cv=none; b=RxKax7cqOE7w6U9zK7h1pUE1sKEWihHqyKw4lrHi0aJpP/OvSdMv84uKjtm491H+y/ALW/Y7kFQZeqLrt4svBuqcJv/s4OZcnOt5muEg3GgjqmRHGT9Jf5Y2VD2uQs7Z8J/AyGS5Aim1ZPZ6HCBTcPWZT8xswDqndzhAPWNld0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087081; c=relaxed/simple;
	bh=CtWkXewTUGFLfTtKdEgy6eY4PV7fvG7VEA8GNqqqq58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P60GFCubXzgKW7CoAkJBPYBag44xTiGflsbXtogYCv47atcBiKcKERAz6CMqN69ZFz999fvjWUjPrkIdnib6LDEVPAUQBgD1GxqKL0WX4elEva9B28DKP4a43FbyJSQojtJmPvkBMrMWX6P1XQzszSlqbYegtdhuZwvLtwHk6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TorKSvHM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TorKSvHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FB5C4CEE7;
	Mon, 12 May 2025 21:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747087080;
	bh=CtWkXewTUGFLfTtKdEgy6eY4PV7fvG7VEA8GNqqqq58=;
	h=From:To:Cc:Subject:Date:From;
	b=TorKSvHMtSY8JZ3Cxs1G/ulcZ/l56OdbmdAN9k1v8usrd9axbNraxUtWKdb/CcRN6
	 l8sBprsr4exmnE2evYIYvqwhoGDzd4fu1gkEs/7+uOOKfnNeJi7CALzMRHEEKMt0PZ
	 zzVxUUWcKWYlJeLbfcYfBu2t6ukWil+/YdvS4/ipk1pqYWWXsIICDRr0yN/tOPMeOK
	 1k05RYMK1Z8VUUfRyFWm+ZSNOb99Jah6olHDUqM4CzlL1LQgbIfaDU0ObuVRPQcs6d
	 46ij1LF06+7Ox2+hLDGjLUxhcevJ80DCLt2A5uaNMcJule4pPLiKiVro9qdM/P18LA
	 spNuud6YiiQ9w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: Convert arasan,cf-spear1340 to DT schema
Date: Mon, 12 May 2025 16:57:56 -0500
Message-ID: <20250512215757.4179283-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Arasan/SPEAr Compact Flash Controller to DT schema format.

The "clock-frequency" property isn't actually used. Add a single
"clocks" entry as the Linux driver supports a single clock though the
platform still doesn't have clocks in DT.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/ata/arasan,cf-spear1340.yaml     | 70 +++++++++++++++++++
 .../devicetree/bindings/ata/pata-arasan.txt   | 37 ----------
 2 files changed, 70 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/arasan,cf-spear1340.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/pata-arasan.txt

diff --git a/Documentation/devicetree/bindings/ata/arasan,cf-spear1340.yaml b/Documentation/devicetree/bindings/ata/arasan,cf-spear1340.yaml
new file mode 100644
index 000000000000..4d7017452dda
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/arasan,cf-spear1340.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/arasan,cf-spear1340.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arasan PATA Compact Flash Controller
+
+maintainers:
+  - Viresh Kumar <viresh.kumar@linaro.org>
+
+properties:
+  compatible:
+    const: arasan,cf-spear1340
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  arasan,broken-udma:
+    description: UDMA mode is unusable
+    type: boolean
+
+  arasan,broken-mwdma:
+    description: MWDMA mode is unusable
+    type: boolean
+
+  arasan,broken-pio:
+    description: PIO mode is unusable
+    type: boolean
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: data
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+allOf:
+  - if:
+      not:
+        required:
+          - arasan,broken-udma
+          - arasan,broken-mwdma
+    then:
+      required:
+        - dmas
+        - dma-names
+
+examples:
+  - |
+    cf@fc000000 {
+        compatible = "arasan,cf-spear1340";
+        reg = <0xfc000000 0x1000>;
+        interrupts = <12>;
+        dmas = <&dma 23>;
+        dma-names = "data";
+    };
diff --git a/Documentation/devicetree/bindings/ata/pata-arasan.txt b/Documentation/devicetree/bindings/ata/pata-arasan.txt
deleted file mode 100644
index 872edc105680..000000000000
--- a/Documentation/devicetree/bindings/ata/pata-arasan.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* ARASAN PATA COMPACT FLASH CONTROLLER
-
-Required properties:
-- compatible: "arasan,cf-spear1340"
-- reg: Address range of the CF registers
-- interrupt: Should contain the CF interrupt number
-- clock-frequency: Interface clock rate, in Hz, one of
-       25000000
-       33000000
-       40000000
-       50000000
-       66000000
-       75000000
-      100000000
-      125000000
-      150000000
-      166000000
-      200000000
-
-Optional properties:
-- arasan,broken-udma: if present, UDMA mode is unusable
-- arasan,broken-mwdma: if present, MWDMA mode is unusable
-- arasan,broken-pio: if present, PIO mode is unusable
-- dmas: one DMA channel, as described in bindings/dma/dma.txt
-  required unless both UDMA and MWDMA mode are broken
-- dma-names: the corresponding channel name, must be "data"
-
-Example:
-
-	cf@fc000000 {
-		compatible = "arasan,cf-spear1340";
-		reg = <0xfc000000 0x1000>;
-		interrupt-parent = <&vic1>;
-		interrupts = <12>;
-		dmas = <&dma-controller 23>;
-		dma-names = "data";
-	};
-- 
2.47.2

