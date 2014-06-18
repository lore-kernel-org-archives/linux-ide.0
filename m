From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 4/7] clk: tegra: Enable hardware control of SATA PLL
Date: Wed, 18 Jun 2014 17:23:23 +0300
Message-ID: <1403101406-15439-5-git-send-email-mperttunen@nvidia.com>
References: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com>
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
Cc: linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-ide@vger.kernel.org

This makes the SATA PLL be controlled by hardware instead of software.
This is required for working SATA support.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/clk/tegra/clk-pll.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 637b62c..f070c36 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -110,6 +110,9 @@
 #define XUSBIO_PLL_CFG0_SEQ_ENABLE		BIT(24)
 #define XUSBIO_PLL_CFG0_SEQ_START_STATE		BIT(25)
 
+#define SATA_PLL_CFG0		0x490
+#define SATA_PLL_CFG0_PADPLL_RESET_SWCTL	BIT(0)
+
 #define PLLE_MISC_PLLE_PTS	BIT(8)
 #define PLLE_MISC_IDDQ_SW_VALUE	BIT(13)
 #define PLLE_MISC_IDDQ_SW_CTRL	BIT(14)
@@ -1361,6 +1364,11 @@ static int clk_plle_tegra114_enable(struct clk_hw *hw)
 	val |= XUSBIO_PLL_CFG0_SEQ_ENABLE;
 	pll_writel(val, XUSBIO_PLL_CFG0, pll);
 
+	/* Enable hw control of SATA pll */
+	val = pll_readl(SATA_PLL_CFG0, pll);
+	val &= ~SATA_PLL_CFG0_PADPLL_RESET_SWCTL;
+	pll_writel(val, SATA_PLL_CFG0, pll);
+
 out:
 	if (pll->lock)
 		spin_unlock_irqrestore(pll->lock, flags);
-- 
1.8.1.5
