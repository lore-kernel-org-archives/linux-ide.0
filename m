From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] ata: ftide010: Add a quirk for SQ201
Date: Sun, 15 Jul 2018 22:09:29 +0200
Message-ID: <20180715200929.10116-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Janos Laube <janos.dev@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

The DMA is broken on this specific device for some unknown
reason (probably badly designed or plain broken interface
electronics) and will only work with PIO. Other users of
the same hardware does not have this problem.

Add a specific quirk so that this Gemini device gets
DMA turned off. Also fix up some code around passing the
port information around in probe while we're at it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/pata_ftide010.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 5d4b72e21161..569a4a662dcd 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -256,14 +256,12 @@ static struct ata_port_operations pata_ftide010_port_ops = {
 	.qc_issue	= ftide010_qc_issue,
 };
 
-static struct ata_port_info ftide010_port_info[] = {
-	{
-		.flags		= ATA_FLAG_SLAVE_POSS,
-		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask	= ATA_UDMA6,
-		.pio_mask	= ATA_PIO4,
-		.port_ops	= &pata_ftide010_port_ops,
-	},
+static struct ata_port_info ftide010_port_info = {
+	.flags		= ATA_FLAG_SLAVE_POSS,
+	.mwdma_mask	= ATA_MWDMA2,
+	.udma_mask	= ATA_UDMA6,
+	.pio_mask	= ATA_PIO4,
+	.port_ops	= &pata_ftide010_port_ops,
 };
 
 #if IS_ENABLED(CONFIG_SATA_GEMINI)
@@ -349,6 +347,7 @@ static int pata_ftide010_gemini_cable_detect(struct ata_port *ap)
 }
 
 static int pata_ftide010_gemini_init(struct ftide010 *ftide,
+				     struct ata_port_info *pi,
 				     bool is_ata1)
 {
 	struct device *dev = ftide->dev;
@@ -373,7 +372,13 @@ static int pata_ftide010_gemini_init(struct ftide010 *ftide,
 
 	/* Flag port as SATA-capable */
 	if (gemini_sata_bridge_enabled(sg, is_ata1))
-		ftide010_port_info[0].flags |= ATA_FLAG_SATA;
+		pi->flags |= ATA_FLAG_SATA;
+
+	/* This device has broken DMA, only PIO works */
+	if (of_machine_is_compatible("itian,sq201")) {
+		pi->mwdma_mask = 0;
+		pi->udma_mask = 0;
+	}
 
 	/*
 	 * We assume that a simple 40-wire cable is used in the PATA mode.
@@ -435,6 +440,7 @@ static int pata_ftide010_gemini_init(struct ftide010 *ftide,
 }
 #else
 static int pata_ftide010_gemini_init(struct ftide010 *ftide,
+				     struct ata_port_info *pi,
 				     bool is_ata1)
 {
 	return -ENOTSUPP;
@@ -446,7 +452,7 @@ static int pata_ftide010_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	const struct ata_port_info pi = ftide010_port_info[0];
+	struct ata_port_info pi = ftide010_port_info;
 	const struct ata_port_info *ppi[] = { &pi, NULL };
 	struct ftide010 *ftide;
 	struct resource *res;
@@ -490,6 +496,7 @@ static int pata_ftide010_probe(struct platform_device *pdev)
 		 * are ATA0. This will also set up the cable types.
 		 */
 		ret = pata_ftide010_gemini_init(ftide,
+				&pi,
 				(res->start == 0x63400000));
 		if (ret)
 			goto err_dis_clk;
-- 
2.17.1
