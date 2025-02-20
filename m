Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5AA1EC017;
	Thu, 20 Feb 2025 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052205; cv=none; b=RUo7uszYn3GqGIxqB2Gq2vb2hhrpsSRwz27OhkcTP7tLfxOxNOEOPyMpgMky9Gv0ylmy2e5i+EOPf4hmOMVv5z493jtdytST71Ep2v/gFm4NqzHNUs2Y1pbPhNj9ceBdP+jm2oXmo0oExtZeusbQilcNSwAv3ZO1PHOkC6LX+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052205; c=relaxed/simple;
	bh=C+0ekwaq00CWtb+HKL1mviruRXnG2ADk2+yUrBT9ETM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z3gKrmxYCnBohRLKYeBl+jLA0lafCMSlFnRTcXOtbGXakRes+Nc8C1BGnqyKdc5R9FG6zDp2CVuSj5Axr8qH+y+vOr8SdmgFYDI32lHx/KHE2cdozEbBh9zAoJcwBBlX0SyxlxWMD52qoDdy2/sjqhtMmfIDTN1OjXk5tQ5ZWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlXnI7ER; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlXnI7ER"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9D8EC4CED6;
	Thu, 20 Feb 2025 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740052204;
	bh=C+0ekwaq00CWtb+HKL1mviruRXnG2ADk2+yUrBT9ETM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OlXnI7ERyNOC+aNFmJFAhon8+4+UhrPZjF94w0yBX2nXCGuref0zyeVUqIJTo35mm
	 FIjOvGpD62lOAVykIOYCm8IYNKZ+n8xCUVsK5NzEUx/JPl1E5/DO+QU8yyAyYJN8tr
	 uWigmmHjYa4IrTC+zolMfpcLQnGbTVWWtHB0YwFn+zWV1/3AWzQRxpFVHxJb+66YHt
	 MFDU5ALWyoUO6r914QXWxnl9JkM7U1+vJQADFAfDn4AcchAJuveGlQi7MmoYTSDl3k
	 DSfATLelMIkMw2GKGRI0OCGO1+PlCa7oNBrtieexQCrhgmdrSxyKF0gEtPRX2ulc7L
	 2/XkXKbcjw1GQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85B1C021B1;
	Thu, 20 Feb 2025 11:50:04 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 20 Feb 2025 12:49:53 +0100
Subject: [PATCH v3] dt-bindings: ata: Convert fsl,pq-sata to YAML
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250220-ppcyaml-ata-v3-1-5e727ab86247@posteo.net>
X-B4-Tracking: v=1; b=H4sIAOAWt2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3YKC5MrE3BzdxJJEXSPTZJOkZFNLSwOLZCWgjoKi1LTMCrBp0bG
 1tQDDk7zIXQAAAA==
X-Change-ID: 20250220-ppcyaml-ata-25c4bc59908c
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740052203; l=4260;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=I+iOxUsz/9CxQwT62hvjviACbjXEM9v+6IkeVNuuCH4=;
 b=GP/8wcKb/lg4TszfarXzTkAsi7e0cEos83MXINc18FVkBq/T3mPTWrNYmpt1OOyGJ0sRX2BfW
 hQPyx21r42WBocZSFiil9jgPiNp/28Nj4jsRc5TJnXrYE4Ei08mguP7
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Convert the Freescale PowerQUICC SATA controller binding from text form
to YAML. The list of compatible strings reflects current usage.

To clarify the description, I changed it to mention "each SATA
controller" instead of each port.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
V3:
- split out as a single patch
- remove interrupt-parent property from example
- add missing end-of-document marker (...)

V2:
- part of series [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
  Link: https://lore.kernel.org/lkml/20250207-ppcyaml-v2-2-8137b0c42526@posteo.net/
- remove unnecessary multiline marker (|)
- clarified controllers vs. ports in the description
- trim subject line (remove "binding")
---
 .../devicetree/bindings/ata/fsl,pq-sata.yaml       | 60 ++++++++++++++++++++++
 Documentation/devicetree/bindings/ata/fsl-sata.txt | 28 ----------
 2 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml b/Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1d19ee832f0ca93735d033e9b95552b6b156c6a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/fsl,pq-sata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale 8xxx/3.0 Gb/s SATA nodes
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+description:
+  SATA nodes are defined to describe on-chip Serial ATA controllers.
+  Each SATA controller should have its own node.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,mpc8377-sata
+              - fsl,mpc8536-sata
+              - fsl,mpc8315-sata
+              - fsl,mpc8379-sata
+          - const: fsl,pq-sata
+      - const: fsl,pq-sata-v2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  cell-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3, 4]
+    description: |
+      1 for controller @ 0x18000
+      2 for controller @ 0x19000
+      3 for controller @ 0x1a000
+      4 for controller @ 0x1b000
+
+required:
+  - compatible
+  - interrupts
+  - cell-index
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    sata@18000 {
+        compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
+        reg = <0x18000 0x1000>;
+        cell-index = <1>;
+        interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/ata/fsl-sata.txt b/Documentation/devicetree/bindings/ata/fsl-sata.txt
deleted file mode 100644
index fd63bb3becc9363c520a8fd06629fdc52c4d4299..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/ata/fsl-sata.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Freescale 8xxx/3.0 Gb/s SATA nodes
-
-SATA nodes are defined to describe on-chip Serial ATA controllers.
-Each SATA port should have its own node.
-
-Required properties:
-- compatible        : compatible list, contains 2 entries, first is
-		 "fsl,CHIP-sata", where CHIP is the processor
-		 (mpc8315, mpc8379, etc.) and the second is
-		 "fsl,pq-sata"
-- interrupts        : <interrupt mapping for SATA IRQ>
-- cell-index        : controller index.
-                          1 for controller @ 0x18000
-                          2 for controller @ 0x19000
-                          3 for controller @ 0x1a000
-                          4 for controller @ 0x1b000
-
-Optional properties:
-- reg               : <registers mapping>
-
-Example:
-	sata@18000 {
-		compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
-		reg = <0x18000 0x1000>;
-		cell-index = <1>;
-		interrupts = <2c 8>;
-		interrupt-parent = < &ipic >;
-	};

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250220-ppcyaml-ata-25c4bc59908c

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


