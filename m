Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C735F297B80;
	Thu, 15 May 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299468; cv=none; b=SwE7ePcjrfrXhUfbcdMQuS/yIrDe53ODiwMg5z0iGOyUmgheXMKqY6GGezEM8MLhWu6M75xsr3cgDof9ILdXPGm0kciFK9zhGtOyUpL+2vx2AIyRvVa9wM4xoqYVO3soHnya0fWrrhvdtVY8DK3oiMS2Lo3cTI7Qdb4RZOLm7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299468; c=relaxed/simple;
	bh=Uacy/T85NjrYqwsVAcBXza0n7x8SpTrfY2clvu2Ph4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQIFdpIJJRPOPeLse3h7RU3XQGYWx0LRbQQXMgQH+ygJiyHZS/RXd0pPT7biBAh+gi12Bt6bDoCV98Iy8MEke64hiDpQcm96B1ccfwMBn/+aMUEoUnJ8t6gq/Xwvai94RB/3rJ9aGgo8YWjsNqDPHlGZWjsOAsgZnzo3sHi0cL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005154LT.eswin.cn (unknown [10.12.96.103])
	by app1 (Coremail) with SMTP id TAJkCgAXOxF3rCVoMDV8AA--.55791S2;
	Thu, 15 May 2025 16:57:29 +0800 (CST)
From: hehuan1@eswincomputing.com
To: dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	luyulin@eswincomputing.com,
	Huan He <hehuan1@eswincomputing.com>
Subject: [PATCH v1 1/2] dt-bindings: sata: eswin: Document for EIC7700 SoC
Date: Thu, 15 May 2025 16:57:23 +0800
Message-ID: <20250515085723.1706-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250515085114.1692-1-hehuan1@eswincomputing.com>
References: <20250515085114.1692-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgAXOxF3rCVoMDV8AA--.55791S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4UuF1DWF1UCw4fXF4rGrg_yoW5Xw13pF
	4kGryDJF4fXr17Wa17XF10kF13Xan7uF1Ykrn2qF15twn0ga4Yqw4akF15Ca4UCr1xXa43
	WF4Fg343Aw47AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXJ5wUUUUU=
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

Add eic7700 AHCI SATA controller device with single port support.
For the eic7700 SATA registers, it supports AHCI standard interface,
interrupt modes (INTx/MSI/PME), APB reset control,
and HSP_SP_CSR register configuration.

Co-developed-by: Yulin Lu <luyulin@eswincomputing.com>
Signed-off-by: Yulin Lu <luyulin@eswincomputing.com>
Signed-off-by: Huan He <hehuan1@eswincomputing.com>
---
 .../bindings/ata/eswin,eic7700-sata.yaml      | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/eswin,eic7700-sata.yaml

diff --git a/Documentation/devicetree/bindings/ata/eswin,eic7700-sata.yaml b/Documentation/devicetree/bindings/ata/eswin,eic7700-sata.yaml
new file mode 100644
index 000000000000..71e1b865ed2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/eswin,eic7700-sata.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/eswin,eic7700-sata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Eswin EIC7700 SoC SATA Controller
+
+maintainers:
+  - Yulin Lu <luyulin@eswincomputing.com>
+  - Huan He <hehuan1@eswincomputing.com>
+
+description: |
+  This binding describes the SATA controller integrated in the Eswin EIC7700 SoC.
+  The controller is compatible with the AHCI (Advanced Host Controller Interface)
+  specification and supports up to 1 port.
+
+properties:
+  compatible:
+    const: eswin,eic7700-ahci
+
+  reg:
+    maxItems: 1
+    description: Address range of the SATA registers
+
+  interrupt-names:
+    items:
+      - const: intrq
+      - const: msi
+      - const: pme
+
+  interrupts:
+    maxItems: 3
+    description: The SATA interrupt numbers
+
+  ports-implemented:
+    maximum: 0x1
+
+  resets:
+    maxItems: 1
+    description: resets to be used by the controller.
+
+  reset-names:
+    const: apb
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  eswin,hsp_sp_csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: hsp_sp_csr regs to be used by the controller.
+
+required:
+  - compatible
+  - reg
+  - interrupt-names
+  - interrupts
+  - resets
+  - reset-names
+  - eswin,hsp_sp_csr
+
+additionalProperties: false
+
+examples:
+  - |
+    sata: sata@50420000 {
+      compatible = "eswin,eic7700-ahci";
+      reg = <0x50420000 0x10000>;
+      interrupt-parent = <&plic>;
+      interrupt-names = "intrq", "msi", "pme";
+      interrupts = <58>, <59>, <60>;
+      ports-implemented = <0x1>;
+      resets = <&reset 7 (1 << 27)>;
+      reset-names = "apb";
+      #size-cells = <2>;
+      eswin,hsp_sp_csr = <&hsp_sp_csr 0x1050>;
+    };
-- 
2.25.1

