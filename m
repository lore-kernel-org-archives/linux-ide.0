From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of clk code
Date: Tue, 24 Apr 2012 16:51:29 +0530
Message-ID: <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
References: <cover.1335266056.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1335266056.git.viresh.kumar@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, sshtylyov@mvista.com, jgarzik@redhat.com, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@st.com>, Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
macros.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/sata_mv.c |   32 ++++++++++----------------------
 1 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 7336d4a..2b37b93 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -551,9 +551,7 @@ struct mv_host_priv {
 	u32			irq_mask_offset;
 	u32			unmask_all_irqs;
 
-#if defined(CONFIG_HAVE_CLK)
 	struct clk		*clk;
-#endif
 	/*
 	 * These consistent DMA memory pools give us guaranteed
 	 * alignment for hardware-accessed data structures,
@@ -4063,13 +4061,13 @@ static int mv_platform_probe(struct platform_device *pdev)
 				   resource_size(res));
 	hpriv->base -= SATAHC0_REG_BASE;
 
-#if defined(CONFIG_HAVE_CLK)
 	hpriv->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(hpriv->clk))
-		dev_notice(&pdev->dev, "cannot get clkdev\n");
-	else
-		clk_enable(hpriv->clk);
-#endif
+	if (IS_ERR(hpriv->clk)) {
+		dev_err(&pdev->dev, "cannot get clkdev\n");
+		return PTR_ERR(hpriv->clk);
+	}
+
+	clk_enable(hpriv->clk);
 
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
@@ -4096,12 +4094,8 @@ static int mv_platform_probe(struct platform_device *pdev)
 		return 0;
 
 err:
-#if defined(CONFIG_HAVE_CLK)
-	if (!IS_ERR(hpriv->clk)) {
-		clk_disable(hpriv->clk);
-		clk_put(hpriv->clk);
-	}
-#endif
+	clk_disable(hpriv->clk);
+	clk_put(hpriv->clk);
 
 	return rc;
 }
@@ -4117,17 +4111,11 @@ err:
 static int __devexit mv_platform_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
-#if defined(CONFIG_HAVE_CLK)
 	struct mv_host_priv *hpriv = host->private_data;
-#endif
 	ata_host_detach(host);
 
-#if defined(CONFIG_HAVE_CLK)
-	if (!IS_ERR(hpriv->clk)) {
-		clk_disable(hpriv->clk);
-		clk_put(hpriv->clk);
-	}
-#endif
+	clk_disable(hpriv->clk);
+	clk_put(hpriv->clk);
 	return 0;
 }
 
-- 
1.7.9
