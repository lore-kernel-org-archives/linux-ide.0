Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA91299AAA;
	Mon, 12 May 2025 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087068; cv=none; b=tu4M489MZryQUV+rgccebcY+maCMxjwgUdz3KY/RITJJK4o5nHFyWYpVW+dmb7N5DTSL91c0fEuf1fG2+hKcTuHcTAjkGjYwvJsNmNKmNgABFUEWj8S7to+bHusDyV/U/XVQB/iLW9cB7c4IymbHPNwNez6a0v4B9mGqKlouOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087068; c=relaxed/simple;
	bh=F2GYr0+7M4/qy66+bLnqegGGLwk4RFGTm4veUraYBFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TmFtHrmpc8B8WSij/i+7UU64ucQH2Z/MEidW4qfJll7NCp9nOzmViC6W/n89E6KAQmnq2icaITVZiLv47QBRtmOueSamkhBnDgQ009iYYKX7FrX4bcsH+MwocWcxC0H27vEiroFNo/9HyPDVST7YjbVkYMTAYteCOqb7vpYvzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKmecZoK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKmecZoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A421C4CEE7;
	Mon, 12 May 2025 21:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747087066;
	bh=F2GYr0+7M4/qy66+bLnqegGGLwk4RFGTm4veUraYBFE=;
	h=From:To:Cc:Subject:Date:From;
	b=KKmecZoKeWy/iekckjS75sYCGA0bdrVq7MGU+WSLVkr0xH4Lx/KINZe7cMIm+FlgR
	 42ZywmgtGv0BzcXSxEKmcGXC5ca4oIPwPO0c6zImXnxfWZmXEc2JExyOQ8pGvcgyPT
	 HHH3CMlK8C4SFago9Q8kJ3wgYmxLK4LFlW0aPWEHGC+RkKyqEdBdPABpyTGvBQ7L/n
	 n09B0keSRt1u3Z1n9FKmnyReHGljgFHYsa8XWnPA4ye+cmSEzCpPg63CbWiYnQBcMd
	 4l7bQCEx2qnfCeqhhNmD/ybzhkS259NkmEAXk095Jp536wQvlICAK9oPh7UE4+6KJh
	 zMNRiLiZJUsBQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: Convert cavium,ebt3000-compact-flash to DT schema
Date: Mon, 12 May 2025 16:57:41 -0500
Message-ID: <20250512215742.4178861-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Cavium Compact Flash Controller to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../ata/cavium,ebt3000-compact-flash.yaml     | 59 +++++++++++++++++++
 .../bindings/ata/cavium-compact-flash.txt     | 30 ----------
 2 files changed, 59 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/cavium,ebt3000-compact-flash.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/cavium-compact-flash.txt

diff --git a/Documentation/devicetree/bindings/ata/cavium,ebt3000-compact-flash.yaml b/Documentation/devicetree/bindings/ata/cavium,ebt3000-compact-flash.yaml
new file mode 100644
index 000000000000..349f289b81e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/cavium,ebt3000-compact-flash.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/cavium,ebt3000-compact-flash.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cavium Compact Flash
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description:
+  The Cavium Compact Flash device is connected to the Octeon Boot Bus, and is
+  thus a child of the Boot Bus device.  It can read and write industry standard
+  compact flash devices.
+
+properties:
+  compatible:
+    const: cavium,ebt3000-compact-flash
+
+  reg:
+    description: The base address of the CF chip select banks.
+    items:
+      - description: CF chip select bank 0
+      - description: CF chip select bank 1
+
+  cavium,bus-width:
+    description: The width of the connection to the CF devices.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [8, 16]
+
+  cavium,true-ide:
+    description: True IDE mode when present.
+    type: boolean
+
+  cavium,dma-engine-handle:
+    description: A phandle for the DMA Engine connected to this device.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        compact-flash@5,0 {
+            compatible = "cavium,ebt3000-compact-flash";
+            reg = <5 0 0x10000>, <6 0 0x10000>;
+            cavium,bus-width = <16>;
+            cavium,true-ide;
+            cavium,dma-engine-handle = <&dma0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/ata/cavium-compact-flash.txt b/Documentation/devicetree/bindings/ata/cavium-compact-flash.txt
deleted file mode 100644
index 3bacc8e0931e..000000000000
--- a/Documentation/devicetree/bindings/ata/cavium-compact-flash.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Compact Flash
-
-The Cavium Compact Flash device is connected to the Octeon Boot Bus,
-and is thus a child of the Boot Bus device.  It can read and write
-industry standard compact flash devices.
-
-Properties:
-- compatible: "cavium,ebt3000-compact-flash";
-
-  Compatibility with many Cavium evaluation boards.
-
-- reg: The base address of the CF chip select banks.  Depending on
-  the device configuration, there may be one or two banks.
-
-- cavium,bus-width: The width of the connection to the CF devices.  Valid
-  values are 8 and 16.
-
-- cavium,true-ide: Optional, if present the CF connection is in True IDE mode.
-
-- cavium,dma-engine-handle: Optional, a phandle for the DMA Engine connected
-  to this device.
-
-Example:
-	compact-flash@5,0 {
-		compatible = "cavium,ebt3000-compact-flash";
-		reg = <5 0 0x10000>, <6 0 0x10000>;
-		cavium,bus-width = <16>;
-		cavium,true-ide;
-		cavium,dma-engine-handle = <&dma0>;
-	};
-- 
2.47.2

