From: Kumar Gala <galak@codeaurora.org>
Subject: [PATCH 2/2] phy: qcom: Add device tree bindings information
Date: Thu, 12 Jun 2014 14:18:44 -0500
Message-ID: <1402600724-20651-2-git-send-email-galak@codeaurora.org>
References: <1402600724-20651-1-git-send-email-galak@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402600724-20651-1-git-send-email-galak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>, linux-ide@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Add binding spec for Qualcomm SoC PHYs, starting with the SATA PHY on
the IPQ806x family of SoCs.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 Documentation/devicetree/bindings/phy/qcom-phy.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom-phy.txt b/Documentation/devicetree/bindings/phy/qcom-phy.txt
new file mode 100644
index 0000000..76bfbd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom-phy.txt
@@ -0,0 +1,23 @@
+Qualcomm IPQ806x SATA PHY Controller
+------------------------------------
+
+SATA PHY nodes are defined to describe on-chip SATA Physical layer controllers.
+Each SATA PHY controller should have its own node.
+
+Required properties:
+- compatible: compatible list, contains "qcom,ipq806x-sata-phy"
+- reg: offset and length of the SATA PHY register set;
+- #phy-cells: must be zero
+- clocks: must be exactly one entry
+- clock-names: must be "cfg"
+
+Example:
+	sata_phy: sata-phy@1b400000 {
+		compatible = "qcom,ipq806x-sata-phy";
+		reg = <0x1b400000 0x200>;
+
+		clocks = <&gcc SATA_PHY_CFG_CLK>;
+		clock-names = "cfg";
+
+		#phy-cells = <0>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
