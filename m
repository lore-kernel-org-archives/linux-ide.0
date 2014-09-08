From: Kumar Gala <galak@codeaurora.org>
Subject: [PATCH v4 3/3] ata: qcom: Add device tree bindings information
Date: Mon,  8 Sep 2014 11:39:50 -0500
Message-ID: <1410194390-29007-3-git-send-email-galak@codeaurora.org>
References: <1410194390-29007-1-git-send-email-galak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1410194390-29007-1-git-send-email-galak@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Add device tree binding for Qualcomm AHCI SATA controller and specifically
the sata controller on the IPQ806x family of SoCs.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 .../devicetree/bindings/ata/qcom-sata.txt          | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/qcom-sata.txt

diff --git a/Documentation/devicetree/bindings/ata/qcom-sata.txt b/Documentation/devicetree/bindings/ata/qcom-sata.txt
new file mode 100644
index 0000000..5e74e41
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/qcom-sata.txt
@@ -0,0 +1,40 @@
+* Qualcomm AHCI SATA Controller
+
+SATA nodes are defined to describe on-chip Serial ATA controllers.
+Each SATA controller should have its own node.
+
+Required properties:
+- compatible		: compatible list, contains "qcom,msm-ahci"
+- interrupts		: <interrupt mapping for SATA IRQ>
+- reg			: <registers mapping>
+- phys			: Must contain exactly one entry as specified
+			  in phy-bindings.txt
+- phy-names		: Must be "sata-phy"
+
+Required properties for "qcom,ipq806x-ahci" compatible:
+- clocks		: Must contain an entry for each entry in clock-names.
+- clock-names		: Shall be:
+				"slave_iface" - Fabric port AHB clock for SATA
+				"iface" - AHB clock
+				"core" - core clock
+				"rxoob" - RX out-of-band clock
+				"pmalive" - Power Module Alive clock
+
+Example:
+	sata@29000000 {
+		compatible = "qcom,ipq806x-ahci", "qcom,msm-ahci";
+		reg = <0x29000000 0x180>;
+
+		interrupts = <0 209 0x0>;
+
+		clocks = <&gcc SFAB_SATA_S_H_CLK>,
+			 <&gcc SATA_H_CLK>,
+			 <&gcc SATA_A_CLK>,
+			 <&gcc SATA_RXOOB_CLK>,
+			 <&gcc SATA_PMALIVE_CLK>;
+		clock-names = "slave_iface", "iface", "core",
+				"rxoob", "pmalive";
+
+		phys = <&sata_phy>;
+		phy-names = "sata-phy";
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
