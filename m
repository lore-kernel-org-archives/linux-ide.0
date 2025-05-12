Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC64299A81;
	Mon, 12 May 2025 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087054; cv=none; b=fLH97gzrQd37vriJ9pklezmAYl1/DcVRMtMp81e2Wy7mLFayXsBrFvWIrbLO8RU5hOu8M6jWiKCTOK0cDFeuG36KuSS2nJQSdyh5QVWDM0/Hnb0YQzcEUNR2upxks8xh3wGvJrZjtqtTVYWvy/tzuV4xURphPRVXDy/W7GcYh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087054; c=relaxed/simple;
	bh=WsrvOR/i83dt0Bws9AyaGjMaMbCRy19tBSje8RUHgQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXytsCml8atFbpSDS9NexZrpRgUBo76A1vmQPLkdDpiObcPeWJ3oVSYBag+R2KAADOipeVtXHlFVdL3bcfpZ5LglDrphR8aZtMyjJ7qpp6lIVTmZUqenyhaXxQdinthUeQ4tWH6IC8yGXvKfmxdfllWBsrAR4iHgRJ3JWFS8bOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmulNC+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmulNC+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB03C4CEE7;
	Mon, 12 May 2025 21:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747087054;
	bh=WsrvOR/i83dt0Bws9AyaGjMaMbCRy19tBSje8RUHgQY=;
	h=From:To:Cc:Subject:Date:From;
	b=gmulNC+KqXMqyZIV12SUglBxCbPDmlCdwsOrVpKyU3ONIHBEBwsRG/ket7+3rvUep
	 WaNTZeB3K+5HiW9ibOsOQPDnjNOPkDgP8dGBCw3c1hMtaKp8rW+lCmtpkK1C0SeiCO
	 2U+m7+Pa8Y/UDWiL/eeIlROhUl4trAasZ1E8pT5qQWZ+l2BqUKxzeHW2coy6VS6GQ9
	 gZFxFLGBNhz0LTTvqRgARZlOKIgQRn6pl7I9mGhn3mmPj7s8PizYl60RtaUyw1ofZE
	 xWL5j4/emgpqqFtn46nK92iZts/wX5et+FIXXj8KcGXxOSDhE/gPDdi7Vu2Qk/U9SL
	 Wa4fGD5iZx/0w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: Convert apm,xgene-ahci to DT schema
Date: Mon, 12 May 2025 16:57:29 -0500
Message-ID: <20250512215731.4178567-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the APM X-Gene AHCI SATA Controller to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/ata/apm,xgene-ahci.yaml          | 58 ++++++++++++++
 .../devicetree/bindings/ata/apm-xgene.txt     | 77 -------------------
 2 files changed, 58 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/apm,xgene-ahci.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/apm-xgene.txt

diff --git a/Documentation/devicetree/bindings/ata/apm,xgene-ahci.yaml b/Documentation/devicetree/bindings/ata/apm,xgene-ahci.yaml
new file mode 100644
index 000000000000..7dc942808656
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/apm,xgene-ahci.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/apm,xgene-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: APM X-Gene 6.0 Gb/s SATA host controller
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+allOf:
+  - $ref: ahci-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - apm,xgene-ahci
+      - apm,xgene-ahci-pcie
+
+  reg:
+    minItems: 4
+    items:
+      - description: AHCI memory resource
+      - description: Host controller core
+      - description: Host controller diagnostic
+      - description: Host controller AXI
+      - description: Host controller MUX
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - phys
+  - phy-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sata@1a400000 {
+        compatible = "apm,xgene-ahci";
+        reg = <0x1a400000 0x1000>,
+              <0x1f220000 0x1000>,
+              <0x1f22d000 0x1000>,
+              <0x1f22e000 0x1000>,
+              <0x1f227000 0x1000>;
+        clocks = <&sataclk 0>;
+        dma-coherent;
+        interrupts = <0x0 0x87 0x4>;
+        phys = <&phy2 0>;
+        phy-names = "sata-phy";
+    };
diff --git a/Documentation/devicetree/bindings/ata/apm-xgene.txt b/Documentation/devicetree/bindings/ata/apm-xgene.txt
deleted file mode 100644
index 02e690a675db..000000000000
--- a/Documentation/devicetree/bindings/ata/apm-xgene.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-* APM X-Gene 6.0 Gb/s SATA host controller nodes
-
-SATA host controller nodes are defined to describe on-chip Serial ATA
-controllers. Each SATA controller (pair of ports) have its own node.
-
-Required properties:
-- compatible		: Shall contain:
-  * "apm,xgene-ahci"
-- reg			: First memory resource shall be the AHCI memory
-			  resource.
-			  Second memory resource shall be the host controller
-			  core memory resource.
-			  Third memory resource shall be the host controller
-			  diagnostic memory resource.
-			  4th memory resource shall be the host controller
-			  AXI memory resource.
-			  5th optional memory resource shall be the host
-			  controller MUX memory resource if required.
-- interrupts		: Interrupt-specifier for SATA host controller IRQ.
-- clocks		: Reference to the clock entry.
-- phys			: A list of phandles + phy-specifiers, one for each
-			  entry in phy-names.
-- phy-names		: Should contain:
-  * "sata-phy" for the SATA 6.0Gbps PHY
-
-Optional properties:
-- dma-coherent		: Present if dma operations are coherent
-- status		: Shall be "ok" if enabled or "disabled" if disabled.
-			  Default is "ok".
-
-Example:
-		sataclk: sataclk {
-			compatible = "fixed-clock";
-			#clock-cells = <1>;
-			clock-frequency = <100000000>;
-			clock-output-names = "sataclk";
-		};
-
-		phy2: phy@1f22a000 {
-			compatible = "apm,xgene-phy";
-			reg = <0x0 0x1f22a000 0x0 0x100>;
-			#phy-cells = <1>;
-		};
-
-		phy3: phy@1f23a000 {
-			compatible = "apm,xgene-phy";
-			reg = <0x0 0x1f23a000 0x0 0x100>;
-			#phy-cells = <1>;
-		};
-
-		sata2: sata@1a400000 {
-			compatible = "apm,xgene-ahci";
-			reg = <0x0 0x1a400000 0x0 0x1000>,
-			      <0x0 0x1f220000 0x0 0x1000>,
-			      <0x0 0x1f22d000 0x0 0x1000>,
-			      <0x0 0x1f22e000 0x0 0x1000>,
-			      <0x0 0x1f227000 0x0 0x1000>;
-			interrupts = <0x0 0x87 0x4>;
-			dma-coherent;
-			clocks = <&sataclk 0>;
-			phys = <&phy2 0>;
-			phy-names = "sata-phy";
-		};
-
-		sata3: sata@1a800000 {
-			compatible = "apm,xgene-ahci-pcie";
-			reg = <0x0 0x1a800000 0x0 0x1000>,
-			      <0x0 0x1f230000 0x0 0x1000>,
-			      <0x0 0x1f23d000 0x0 0x1000>,
-			      <0x0 0x1f23e000 0x0 0x1000>,
-			      <0x0 0x1f237000 0x0 0x1000>;
-			interrupts = <0x0 0x88 0x4>;
-			dma-coherent;
-			clocks = <&sataclk 0>;
-			phys = <&phy3 0>;
-			phy-names = "sata-phy";
-		};
-- 
2.47.2

