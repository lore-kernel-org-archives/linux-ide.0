Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3527E341AC5;
	Tue, 19 Aug 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611684; cv=none; b=NhQ5S5Oh7lGl/bN0Iub0lZ76r/bOWODZproFaqp/d/0szk9sdxQInUowd6InVkpE+ZUgZt6mwWLf5nzNh+upjqfdPsEan5MQkHiwRVK3L+eYBjJU1qRlBjbAoVE/21GWvGq4xUwF99tkmlKp0MU5AaHv+gN3AUf+J6e3cF3m5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611684; c=relaxed/simple;
	bh=ZS+6bYad0dFJEXAGryJcWbqcidW1jBJw291RsJ3Nf6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNeiK1TwBrQUg5xaTvmCxErc/PCkeJ66A8LKqd7nWm5qvRfvM/PfDX06Z0RyJJ9I8E/mwbjzMugsHPQ9qalwBJNlYSlU214AhmgQzwtkaPMY/lDyjZqpoYGm9EVOUlPiN8ZZNU/uqncmfcjFuCarQhQmDeD+Cpzv+1oBF5y9Taw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006800LT.eswin.cn (unknown [10.12.96.77])
	by app2 (Coremail) with SMTP id TQJkCgCHJpUIgqRozqjAAA--.31802S2;
	Tue, 19 Aug 2025 21:54:18 +0800 (CST)
From: Yulin Lu <luyulin@eswincomputing.com>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	linux-phy@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	zhengyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com,
	lianghujun@eswincomputing.com,
	luyulin <luyulin@eswincomputing.com>
Subject: [PATCH v2 1/3] dt-bindings: ata: eswin: Document for EIC7700 SoC ahci
Date: Tue, 19 Aug 2025 21:54:13 +0800
Message-Id: <20250819135413.386-1-luyulin@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20250819134722.220-1-luyulin@eswincomputing.com>
References: <20250819134722.220-1-luyulin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgCHJpUIgqRozqjAAA--.31802S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4UCF1rZF1fCw4DJF4kCrg_yoW5Jr45pF
	s7CrsrJF4SgryxXay8GF10kF1ftaykCF1Yyr97t3WUKrZ8WasYqrsIk3W5Ja47Jw1xXa43
	XF9Ig347Aa12vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRKZX5UUUUU==
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/

From: luyulin <luyulin@eswincomputing.com>

Add document for the SATA AHCI controller on the EIC7700 SoC platform,
including descriptions of its hardware configurations.

Signed-off-by: luyulin <luyulin@eswincomputing.com>
---
 .../bindings/ata/eswin,eic7700-ahci.yaml      | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml b/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
new file mode 100644
index 000000000000..9ef58c9c2f28
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/eswin,eic7700-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Eswin EIC7700 SoC SATA Controller
+
+maintainers:
+  - Yulin Lu <luyulin@eswincomputing.com>
+  - Huan He <hehuan1@eswincomputing.com>
+
+description:
+  This document defines device tree bindings for the Synopsys DWC
+  implementation of the AHCI SATA controller found in Eswin's
+  Eic7700 SoC platform.
+
+select:
+  properties:
+    compatible:
+      const: eswin,eic7700-ahci
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dwc-ahci-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: eswin,eic7700-ahci
+      - const: snps,dwc-ahci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ports-implemented:
+    const: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: aclk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: arst
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: sata-phy
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - phys
+  - phy-names
+  - ports-implemented
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sata@50420000 {
+        compatible = "eswin,eic7700-ahci", "snps,dwc-ahci";
+        reg = <0x50420000 0x10000>;
+        interrupt-parent = <&plic>;
+        interrupts = <58>;
+        ports-implemented = <0x1>;
+        clocks = <&gate_clk_hsp_cfgclk>, <&gate_clk_hsp_aclk>;
+        clock-names = "pclk", "aclk";
+        resets = <&reset 96>;
+        reset-names = "arst";
+        phys = <&sata_phy>;
+        phy-names = "sata-phy";
+    };
-- 
2.25.1

