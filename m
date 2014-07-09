From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] phy: qcom: Update APQ8064 PHY device tree bindings
Date: Wed,  9 Jul 2014 12:04:37 +0100
Message-ID: <1404903877-26119-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1404903807-26032-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1404903807-26032-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-ide@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-ide@vger.kernel.org

Update binding spec for Qualcomm SoC PHYs with APQ8064 compatibles.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom-phy.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-phy.txt b/Documentation/devicetree/bindings/phy/qcom-phy.txt
index 76bfbd0..6bff1e0 100644
--- a/Documentation/devicetree/bindings/phy/qcom-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-phy.txt
@@ -1,4 +1,4 @@
-Qualcomm IPQ806x SATA PHY Controller
+Qualcomm IPQ806x/APQ8064 SATA PHY Controller
 ------------------------------------
 
 SATA PHY nodes are defined to describe on-chip SATA Physical layer controllers.
@@ -6,6 +6,7 @@ Each SATA PHY controller should have its own node.
 
 Required properties:
 - compatible: compatible list, contains "qcom,ipq806x-sata-phy"
+	     or "qcom,apq8064-sata-phy".
 - reg: offset and length of the SATA PHY register set;
 - #phy-cells: must be zero
 - clocks: must be exactly one entry
-- 
1.9.1
