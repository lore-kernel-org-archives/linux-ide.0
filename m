From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 2/2] phy: qcom: Add APQ8064 SATA PHY device tree bindings
Date: Mon, 14 Jul 2014 12:18:08 +0100
Message-ID: <1405336688-32221-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1405336651-32135-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1405336651-32135-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-ide@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-ide@vger.kernel.org

This patch adds binding spec for Qualcomm AP8064 SATA PHY.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/phy/qcom-apq8064-sata-phy.txt         | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-apq8064-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom-apq8064-sata-phy.txt b/Documentation/devicetree/bindings/phy/qcom-apq8064-sata-phy.txt
new file mode 100644
index 0000000..952f6c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom-apq8064-sata-phy.txt
@@ -0,0 +1,24 @@
+Qualcomm APQ8064 SATA PHY Controller
+------------------------------------
+
+SATA PHY nodes are defined to describe on-chip SATA Physical layer controllers.
+Each SATA PHY controller should have its own node.
+
+Required properties:
+- compatible: compatible list, contains "qcom,apq8064-sata-phy".
+- reg: offset and length of the SATA PHY register set;
+- #phy-cells: must be zero
+- clocks: a list of phandles and clock-specifier pairs, one for each entry in
+  clock-names.
+- clock-names: must be "cfg" for phy config clock.
+
+Example:
+	sata_phy: sata-phy@1b400000 {
+		compatible = "qcom,apq8064-sata-phy";
+		reg = <0x1b400000 0x200>;
+
+		clocks = <&gcc SATA_PHY_CFG_CLK>;
+		clock-names = "cfg";
+
+		#phy-cells = <0>;
+	};
-- 
1.9.1
