From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V3 Resend 06/12] ata/pata_arasan: Remove conditional
 compilation of clk code
Date: Tue, 8 May 2012 09:22:33 +0530
Message-ID: <0a3ff891741dfe39d69dd6d90c123ec276a10d4d.1336448639.git.viresh.kumar@st.com>
References: <cover.1336448639.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1336448639.git.viresh.kumar@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: akpm@linux-foundation.org
Cc: andrew@lunn.ch, mturquette@linaro.org, sshtylyov@mvista.com, spear-devel@list.st.com, linux-kernel@vger.kernel.org, w.sang@pengutronix.de, linux-ide@vger.kernel.org, viresh.linux@gmail.com, linux@arm.linux.org.uk, jgarzik@redhat.com, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de
List-Id: linux-ide@vger.kernel.org

With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
macros.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/pata_arasan_cf.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 3239517..b943be0 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -184,10 +184,8 @@
 struct arasan_cf_dev {
 	/* pointer to ata_host structure */
 	struct ata_host *host;
-	/* clk structure, only if HAVE_CLK is defined */
-#ifdef CONFIG_HAVE_CLK
+	/* clk structure */
 	struct clk *clk;
-#endif
 
 	/* physical base address of controller */
 	dma_addr_t pbase;
@@ -312,13 +310,11 @@ static int cf_init(struct arasan_cf_dev *acdev)
 	unsigned long flags;
 	int ret = 0;
 
-#ifdef CONFIG_HAVE_CLK
 	ret = clk_enable(acdev->clk);
 	if (ret) {
 		dev_dbg(acdev->host->dev, "clock enable failed");
 		return ret;
 	}
-#endif
 
 	spin_lock_irqsave(&acdev->host->lock, flags);
 	/* configure CF interface clock */
@@ -344,9 +340,7 @@ static void cf_exit(struct arasan_cf_dev *acdev)
 	writel(readl(acdev->vbase + OP_MODE) & ~CFHOST_ENB,
 			acdev->vbase + OP_MODE);
 	spin_unlock_irqrestore(&acdev->host->lock, flags);
-#ifdef CONFIG_HAVE_CLK
 	clk_disable(acdev->clk);
-#endif
 }
 
 static void dma_callback(void *dev)
@@ -828,13 +822,11 @@ static int __devinit arasan_cf_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-#ifdef CONFIG_HAVE_CLK
 	acdev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(acdev->clk)) {
 		dev_warn(&pdev->dev, "Clock not found\n");
 		return PTR_ERR(acdev->clk);
 	}
-#endif
 
 	/* allocate host */
 	host = ata_host_alloc(&pdev->dev, 1);
@@ -899,9 +891,7 @@ static int __devinit arasan_cf_probe(struct platform_device *pdev)
 			&arasan_cf_sht);
 
 free_clk:
-#ifdef CONFIG_HAVE_CLK
 	clk_put(acdev->clk);
-#endif
 	return ret;
 }
 
@@ -912,9 +902,7 @@ static int __devexit arasan_cf_remove(struct platform_device *pdev)
 
 	ata_host_detach(host);
 	cf_exit(acdev);
-#ifdef CONFIG_HAVE_CLK
 	clk_put(acdev->clk);
-#endif
 
 	return 0;
 }
-- 
1.7.9
