Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C00299AAA;
	Mon, 12 May 2025 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087074; cv=none; b=mEb6fpXsCtjYS5tZaOG7DP6nxPwe/Uw8wD/GqlyE/xe7BcliviVKVakqoQBUUPWq1vG5AZjE3VmoS4hMrjpDGwmiviAFKS5+qIAkK0CnU5BvX8Rv/9c/WphvQ6YJG6SYMWvdW3qcn0PlHGtCPKNYoNKDovPmK4uSY/7Qo1ZSa6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087074; c=relaxed/simple;
	bh=D7VFquU0lJm3wQ5q23AcvZBJHJj2ysIMNElXOUUcTFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrHEOAsxxCYDjNGvRjSvCJMllMdCMwI5kvr0BEHHKWvMS+gFZV3F4Q1xuCNUyuyBapmzUymULzHX4o+xrC7uHg7pAoigc3B9avsJmM4yymYxEoeiAje8ImQ8CkNb0KIMgX12g7f3HeqR5gtQfeYDRLZOwU3+qG+owP4VvKTQvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar09xvJo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar09xvJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB580C4CEE7;
	Mon, 12 May 2025 21:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747087074;
	bh=D7VFquU0lJm3wQ5q23AcvZBJHJj2ysIMNElXOUUcTFE=;
	h=From:To:Cc:Subject:Date:From;
	b=Ar09xvJo+KyQUcfgZGAURPgPV5+5ud4PwNdpUOPrRoWrikjclisFZnh5T7o1hWtD9
	 7FlwJ1zaaudseU1+fsIaGsunjetKtLcOAHKaLZAIsbZsbY3CD89wFZhV2N+SakdJ+u
	 AtazEpdjmsEnzCDqJ8wypKrWXZbLRwXuNIijvNEvIES3pfhfbcp8TRmhjPtkangDrv
	 Sm0mizd+UDTNKOOWhvmzzUa4wGoCFlvD+OZ9hmBvYWQ5oJxQJWR5rLZpzgud2Vkod/
	 VXvhea0wyidu0F7x9k70sKBNz1Wewdwgz+3RDIqA3F3JgMQdZx/zV41sQ78EbszJbA
	 c6yGCpj1L1iHg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: Convert marvell,orion-sata to DT schema
Date: Mon, 12 May 2025 16:57:48 -0500
Message-ID: <20250512215750.4179075-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Marvell Orion SATA Controller to DT schema format.

The clocks and clock-names properties were missing. The names for
phy-names were incorrect. The maximum "nr-ports" was determined from the
Linux driver.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/ata/marvell,orion-sata.yaml      | 83 +++++++++++++++++++
 .../devicetree/bindings/ata/marvell.txt       | 22 -----
 2 files changed, 83 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/marvell,orion-sata.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/marvell.txt

diff --git a/Documentation/devicetree/bindings/ata/marvell,orion-sata.yaml b/Documentation/devicetree/bindings/ata/marvell,orion-sata.yaml
new file mode 100644
index 000000000000..f656ea9223d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/marvell,orion-sata.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/marvell,orion-sata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Orion SATA
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Gregory Clement <gregory.clement@bootlin.com>
+
+allOf:
+  - $ref: sata-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - marvell,orion-sata
+      - marvell,armada-370-sata
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 8
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: '0'
+      - const: '1'
+      - const: '2'
+      - const: '3'
+      - const: '4'
+      - const: '5'
+      - const: '6'
+      - const: '7'
+
+  interrupts:
+    maxItems: 1
+
+  nr-ports:
+    description:
+      Number of SATA ports in use.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 8
+
+  phys:
+    minItems: 1
+    maxItems: 8
+
+  phy-names:
+    minItems: 1
+    items:
+      - const: port0
+      - const: port1
+      - const: port2
+      - const: port3
+      - const: port4
+      - const: port5
+      - const: port6
+      - const: port7
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - nr-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sata@80000 {
+        compatible = "marvell,orion-sata";
+        reg = <0x80000 0x5000>;
+        interrupts = <21>;
+        phys = <&sata_phy0>, <&sata_phy1>;
+        phy-names = "port0", "port1";
+        nr-ports = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/ata/marvell.txt b/Documentation/devicetree/bindings/ata/marvell.txt
deleted file mode 100644
index b460edd12766..000000000000
--- a/Documentation/devicetree/bindings/ata/marvell.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Marvell Orion SATA
-
-Required Properties:
-- compatibility : "marvell,orion-sata" or "marvell,armada-370-sata"
-- reg           : Address range of controller
-- interrupts    : Interrupt controller is using
-- nr-ports      : Number of SATA ports in use.
-
-Optional Properties:
-- phys		: List of phandles to sata phys
-- phy-names	: Should be "0", "1", etc, one number per phandle
-
-Example:
-
-	sata@80000 {
-		compatible = "marvell,orion-sata";
-		reg = <0x80000 0x5000>;
-		interrupts = <21>;
-		phys = <&sata_phy0>, <&sata_phy1>;
-		phy-names = "0", "1";
-		nr-ports = <2>;
-	}
-- 
2.47.2

