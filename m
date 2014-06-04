From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 1/9] of: Add NVIDIA Tegra SATA controller binding
Date: Wed, 4 Jun 2014 14:32:31 +0300
Message-ID: <1401881559-18469-2-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, tj@kernel.org, pdeschrijver@nvidia.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

This patch adds device tree binding documentation for the SATA
controller found on NVIDIA Tegra SoCs.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/ata/tegra-sata.txt         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/tegra-sata.txt

diff --git a/Documentation/devicetree/bindings/ata/tegra-sata.txt b/Documentation/devicetree/bindings/ata/tegra-sata.txt
new file mode 100644
index 0000000..70e3119
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/tegra-sata.txt
@@ -0,0 +1,29 @@
+Tegra124 SoC SATA AHCI controller
+
+Required properties :
+ - compatible : Should be "nvidia,tegra124-ahci".
+ - reg : Defines the following set of registers, in the order listed:
+   - AHCI register set (SATA BAR5)
+   - SATA register set
+ - interrupts : Defines the interrupt used by SATA
+ - clocks : Defines the clocks listed in the clock-names property.
+ - clock-names : The following clock names must be present:
+   - sata
+   - sata-oob
+   - cml1
+   - pll_e
+ - resets : Defines the resets listed in the reset-names property
+ - reset-names : The following reset names must be present:
+   - sata
+   - sata-oob
+   - sata-cold
+ - phys : Defines the phys listed in the phy-names property
+ - phy-names : The following phy names must be present:
+   - sata-phy : XUSB PADCTL SATA PHY
+ - hvdd-supply : Defines the SATA HVDD regulator
+ - vddio-supply : Defines the SATA VDDIO regulator
+ - avdd-supply : Defines the SATA AVDD regulator
+
+Optional properties:
+ - target-supply : Defines a regulator for a power output connector
+                   for SATA devices.
-- 
1.8.1.5
