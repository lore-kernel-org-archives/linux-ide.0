From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 10/15] dmaengine: dw: pass platform data via struct dw_dma_chip
Date: Sun, 24 Jan 2016 19:21:57 +0000
Message-ID: <1453663322-14474-11-git-send-email-mans@mansr.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453663322-14474-1-git-send-email-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-ide@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-ide@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

We pass struct dw_dma_chip to the dw_dma_probe() anyway, thus we may use it to
pass platform data as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c          |  2 +-
 drivers/dma/dw/core.c                 |  3 ++-
 drivers/dma/dw/pci.c                  |  3 ++-
 drivers/dma/dw/platform.c             |  3 ++-
 include/linux/dma/dw.h                | 14 ++++++++------
 sound/soc/intel/common/sst-firmware.c |  2 +-
 6 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 80bdcabc293f..2cb6f7e04b5c 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1248,7 +1248,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	hsdev->dma->dev = &ofdev->dev;
 
 	/* Initialize AHB DMAC */
-	err = dw_dma_probe(hsdev->dma, NULL);
+	err = dw_dma_probe(hsdev->dma);
 	if (err)
 		goto error_dma_iomap;
 
diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 1644d79a071a..91a6d8b304aa 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1468,8 +1468,9 @@ EXPORT_SYMBOL(dw_dma_cyclic_free);
 
 /*----------------------------------------------------------------------*/
 
-int dw_dma_probe(struct dw_dma_chip *chip, struct dw_dma_platform_data *pdata)
+int dw_dma_probe(struct dw_dma_chip *chip)
 {
+	struct dw_dma_platform_data	*pdata = chip->pdata;
 	struct dw_dma		*dw;
 	bool			autocfg = false;
 	unsigned int		dw_params;
diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index 4c30fdd092b3..fc3b954b27da 100644
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -49,8 +49,9 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 	chip->dev = &pdev->dev;
 	chip->regs = pcim_iomap_table(pdev)[0];
 	chip->irq = pdev->irq;
+	chip->pdata = pdata;
 
-	ret = dw_dma_probe(chip, pdata);
+	ret = dw_dma_probe(chip);
 	if (ret)
 		return ret;
 
diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index fcbe57006e59..808bafdd7d48 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -181,6 +181,7 @@ static int dw_probe(struct platform_device *pdev)
 		pdata = dw_dma_parse_dt(pdev);
 
 	chip->dev = dev;
+	chip->pdata = pdata;
 
 	chip->clk = devm_clk_get(chip->dev, "hclk");
 	if (IS_ERR(chip->clk))
@@ -191,7 +192,7 @@ static int dw_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	err = dw_dma_probe(chip, pdata);
+	err = dw_dma_probe(chip);
 	if (err)
 		goto err_dw_dma_probe;
 
diff --git a/include/linux/dma/dw.h b/include/linux/dma/dw.h
index 71456442ebe3..c9a3914e8a08 100644
--- a/include/linux/dma/dw.h
+++ b/include/linux/dma/dw.h
@@ -27,17 +27,19 @@ struct dw_dma;
  * @regs:		memory mapped I/O space
  * @clk:		hclk clock
  * @dw:			struct dw_dma that is filed by dw_dma_probe()
+ * @pdata:		pointer to platform data
  */
 struct dw_dma_chip {
-	struct device	*dev;
-	int		irq;
-	void __iomem	*regs;
-	struct clk	*clk;
-	struct dw_dma	*dw;
+	struct device			*dev;
+	int				irq;
+	void __iomem			*regs;
+	struct clk			*clk;
+	struct dw_dma			*dw;
+	struct dw_dma_platform_data	*pdata;
 };
 
 /* Export to the platform drivers */
-int dw_dma_probe(struct dw_dma_chip *chip, struct dw_dma_platform_data *pdata);
+int dw_dma_probe(struct dw_dma_chip *chip);
 int dw_dma_remove(struct dw_dma_chip *chip);
 
 /* DMA API extensions */
diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index ef4881e7753a..25993527370b 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -203,7 +203,7 @@ static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
 
 	chip->dev = dev;
 
-	err = dw_dma_probe(chip, NULL);
+	err = dw_dma_probe(chip);
 	if (err)
 		return ERR_PTR(err);
 
-- 
2.7.0
