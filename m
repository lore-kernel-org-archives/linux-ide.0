From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 26/35] ata: use dev_get_platdata()
Date: Tue, 30 Jul 2013 17:16:05 +0900
Message-ID: <005501ce8cfd$09c47e90$1d4d7bb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47079 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758050Ab3G3IQI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jul 2013 04:16:08 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQQ00DDJPMUAKV0@mailout2.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 30 Jul 2013 17:16:06 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ata/pata_at32.c       |    2 +-
 drivers/ata/pata_at91.c       |    2 +-
 drivers/ata/pata_ixp4xx_cf.c  |    4 ++--
 drivers/ata/pata_octeon_cf.c  |    2 +-
 drivers/ata/pata_platform.c   |    2 +-
 drivers/ata/pata_pxa.c        |    2 +-
 drivers/ata/pata_samsung_cf.c |    4 ++--
 drivers/ata/sata_mv.c         |    2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
index 8d493b4..d59d523 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -271,7 +271,7 @@ static int __init pata_at32_probe(struct platform_device *pdev)
 
 	struct device		 *dev = &pdev->dev;
 	struct at32_ide_info	 *info;
-	struct ide_platform_data *board = pdev->dev.platform_data;
+	struct ide_platform_data *board = dev_get_platdata(&pdev->dev);
 	struct resource		 *res;
 
 	int irq;
diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 5364f97..d63ee8f 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -315,7 +315,7 @@ static struct ata_port_operations pata_at91_port_ops = {
 
 static int pata_at91_probe(struct platform_device *pdev)
 {
-	struct at91_cf_data *board = pdev->dev.platform_data;
+	struct at91_cf_data *board = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct at91_ide_info *info;
 	struct resource *mem_res;
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index dcc6b24..1ec53f8 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -48,7 +48,7 @@ static unsigned int ixp4xx_mmio_data_xfer(struct ata_device *dev,
 	u16 *buf16 = (u16 *) buf;
 	struct ata_port *ap = dev->link->ap;
 	void __iomem *mmio = ap->ioaddr.data_addr;
-	struct ixp4xx_pata_data *data = ap->host->dev->platform_data;
+	struct ixp4xx_pata_data *data = dev_get_platdata(ap->host->dev);
 
 	/* set the expansion bus in 16bit mode and restore
 	 * 8 bit mode after the transaction.
@@ -143,7 +143,7 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	struct resource *cs0, *cs1;
 	struct ata_host *host;
 	struct ata_port *ap;
-	struct ixp4xx_pata_data *data = pdev->dev.platform_data;
+	struct ixp4xx_pata_data *data = dev_get_platdata(&pdev->dev);
 
 	cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index e73bef3..c51bbb9 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -1037,7 +1037,7 @@ static void octeon_cf_shutdown(struct device *dev)
 	union cvmx_mio_boot_dma_cfgx dma_cfg;
 	union cvmx_mio_boot_dma_intx dma_int;
 
-	struct octeon_cf_port *cf_port = dev->platform_data;
+	struct octeon_cf_port *cf_port = dev_get_platdata(dev);
 
 	if (cf_port->dma_base) {
 		/* Stop and clear the dma engine.  */
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 71e0937..0279488 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -180,7 +180,7 @@ static int pata_platform_probe(struct platform_device *pdev)
 	struct resource *io_res;
 	struct resource *ctl_res;
 	struct resource *irq_res;
-	struct pata_platform_info *pp_info = pdev->dev.platform_data;
+	struct pata_platform_info *pp_info = dev_get_platdata(&pdev->dev);
 
 	/*
 	 * Simple resource validation ..
diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 942ef94..a6f05ac 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -238,7 +238,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	struct resource *ctl_res;
 	struct resource *dma_res;
 	struct resource *irq_res;
-	struct pata_pxa_pdata *pdata = pdev->dev.platform_data;
+	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
 	int ret = 0;
 
 	/*
diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 6ef27e9..951aa95 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -475,7 +475,7 @@ static void pata_s3c_hwinit(struct s3c_ide_info *info,
 
 static int __init pata_s3c_probe(struct platform_device *pdev)
 {
-	struct s3c_ide_platdata *pdata = pdev->dev.platform_data;
+	struct s3c_ide_platdata *pdata = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct s3c_ide_info *info;
 	struct resource *res;
@@ -617,7 +617,7 @@ static int pata_s3c_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct ata_host *host = platform_get_drvdata(pdev);
-	struct s3c_ide_platdata *pdata = pdev->dev.platform_data;
+	struct s3c_ide_platdata *pdata = dev_get_platdata(&pdev->dev);
 	struct s3c_ide_info *info = host->private_data;
 
 	pata_s3c_hwinit(info, pdata);
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 10ea99a..88e0851 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4058,7 +4058,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 		of_property_read_u32(pdev->dev.of_node, "nr-ports", &n_ports);
 		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
 	} else {
-		mv_platform_data = pdev->dev.platform_data;
+		mv_platform_data = dev_get_platdata(&pdev->dev);
 		n_ports = mv_platform_data->n_ports;
 		irq = platform_get_irq(pdev, 0);
 	}
-- 
1.7.10.4


