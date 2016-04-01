From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 3/3] ARM: dts: apq8064: add ahci ports-implemented mask
Date: Fri,  1 Apr 2016 08:52:58 +0100
Message-ID: <1459497178-31090-4-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-ide@vger.kernel.org

This patch adds new ports-implemented mask, which is required to get
achi working on the mainline. Without this patch value read from
PORTS_IMPL register which is zero would not enable any ports for
software to use.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 252b310..36e058c 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -696,7 +696,7 @@
 		};
 
 		sata0: sata@29000000 {
-			compatible		= "generic-ahci";
+			compatible		= "qcom,apq8064-ahci", "generic-ahci";
 			status			= "disabled";
 			reg			= <0x29000000 0x180>;
 			interrupts		= <GIC_SPI 209 IRQ_TYPE_NONE>;
@@ -718,6 +718,7 @@
 
 			phys			= <&sata_phy0>;
 			phy-names		= "sata-phy";
+			ports-implemented	= <0x1>;
 		};
 
 		/* Temporary fixed regulator */
-- 
2.5.0
