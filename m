Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F6FC4320A
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2AF60FD8
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhG1JFB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Jul 2021 05:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhG1JE7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jul 2021 05:04:59 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B650C061757
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b21so2169274ljo.13
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rncp0sA06hDt53nyXA1xJzQAyXuEpMC/gHR30e4Wr4g=;
        b=NaPCWvEkzC0v0OABod97xAG/UxSnE5/SunggPyFMNq2g9AW7Y9smmHAfxPD0gPEY0W
         IQA/lHTMUSJ/4p6QzOOg+2543Alxrcmr3nSsa5qIv16yTcx54sF93KOglAG9nZRN3kaB
         tL5XnsL8ZU4Ntd2MPq98WUVP56vKuiXLg8KLjmq45oXBpgZXnfvksZ+RtkADQCs6Z+ie
         IiR76k4JH4FuWBVoc71FWlUxc1m2tTlEWTVdOzlO39EjarR3v/LfrE8BruUsoFCSVLh6
         bNC0mhkeFls13pqtYyOKkgzfs/hCwP9RJeBA3jJn/raGQ9f3rv+zw4LX2Tn/be446c9h
         rlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rncp0sA06hDt53nyXA1xJzQAyXuEpMC/gHR30e4Wr4g=;
        b=ttUXiFgyfP6/QummJ2GxA1nG6I5WIrw4O105EzQNRNhH2Pyj7phN2yLiLtzDIdhpC7
         7rxMLqX/bZ/6JmA86MhFafUtlGNOeJgvAIjWQnYjf5KGVRKWE13fFG31Q/a9g/p8eTa5
         JyKlYZTxUNmky+W81yHezqx8ACy2b8NyLCaJwmyNhgwzhVjJ3jcX4KEWb6dpnbHTEoLJ
         Hbkqt7jkf9ompm4pL5t6hIxwRUGDBtMZ/+XG4hNRCAsguN+hXH+pJ2XqmP+Kgn4iTckg
         0ffFFg2Im+duwXUoMK5Rop0ZOPuSMOfns9SRD4vOc11eX9Az2UZdQC9i2XPTv4PX2yJK
         6ioA==
X-Gm-Message-State: AOAM530T8a1KMgDskw96CrqbYjN0/mtnXFticbFp85U25YRq7KG3DY6q
        lg/bKk8HI0Jo6ziWQmQIKkan90Ix23b9aQ==
X-Google-Smtp-Source: ABdhPJy1BFn4fwW8xG5dL7QnnFe7wJQNISiMnjBvxEpOH7uts3U1PDNW/Q8HF2YE/sDZYyaA4kYp8A==
X-Received: by 2002:a2e:9b0f:: with SMTP id u15mr18711483lji.97.1627463095760;
        Wed, 28 Jul 2021 02:04:55 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d9sm505495ljq.54.2021.07.28.02.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:04:55 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5] pata: ixp4xx: Rewrite to use device tree
Date:   Wed, 28 Jul 2021 11:02:42 +0200
Message-Id: <20210728090242.2758812-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728090242.2758812-1-linus.walleij@linaro.org>
References: <20210728090242.2758812-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This rewrites the IXP4xx CF (IDE) libata driver to use the
device tree exclusively to look up its resources:

- Probe exclusively from the device tree and look up all
  resources from there.
- Allocate a local state container with devres and pass
  this around in .private_data.
- Initialize with struct ata_port_info.
- Use the .set_piomode() callback instead of the much
  wider .set_mode(), we only support PIO after all.
- Bump driver version number from 0.2 to 1.0 to reflect this
  wider change.
- Get a handle on the expansion bus syscon regmap to alter
  the timings on the chip select.
- Put in the more elaborate timing adjustment code for PIO0
  to PIO4 in 8 and 16bit mode from the downstream OpenWrt
  patch.

The board file initialization path and platform data include
is dropped because the board files will be deleted at the same
time as this patch is merged.

The platform data file is not deleted right now so as not to
conflict with the removal of board files.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/pata_ixp4xx_cf.c | 201 +++++++++++++++++++++++++++--------
 1 file changed, 154 insertions(+), 47 deletions(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 72d6d6f2ef99..99c63087c8ae 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -13,45 +13,134 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/libata.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/pata_ixp4xx_cf.h>
+#include <linux/regmap.h>
 #include <scsi/scsi_host.h>
 
 #define DRV_NAME	"pata_ixp4xx_cf"
-#define DRV_VERSION	"0.2"
+#define DRV_VERSION	"1.0"
 
-static int ixp4xx_set_mode(struct ata_link *link, struct ata_device **error)
+struct ixp4xx_pata {
+	struct ata_host *host;
+	struct regmap *rmap;
+	u32 cmd_csreg;
+	void __iomem *cmd;
+	void __iomem *ctl;
+};
+
+#define IXP4XX_EXP_TIMING_STRIDE	0x04
+/* The timings for the chipselect is in bits 29..16 */
+#define IXP4XX_EXP_T1_T5_MASK	GENMASK(29, 16)
+#define IXP4XX_EXP_PIO_0_8	0x0a470000
+#define IXP4XX_EXP_PIO_1_8	0x06430000
+#define IXP4XX_EXP_PIO_2_8	0x02410000
+#define IXP4XX_EXP_PIO_3_8	0x00820000
+#define IXP4XX_EXP_PIO_4_8	0x00400000
+#define IXP4XX_EXP_PIO_0_16	0x29640000
+#define IXP4XX_EXP_PIO_1_16	0x05030000
+#define IXP4XX_EXP_PIO_2_16	0x00b20000
+#define IXP4XX_EXP_PIO_3_16	0x00820000
+#define IXP4XX_EXP_PIO_4_16	0x00400000
+#define IXP4XX_EXP_BW_MASK	(BIT(6)|BIT(0))
+#define IXP4XX_EXP_BYTE_RD16	BIT(6) /* Byte reads on half-word devices */
+#define IXP4XX_EXP_BYTE_EN	BIT(0) /* Use 8bit data bus if set */
+
+static void ixp4xx_set_8bit_timing(struct ixp4xx_pata *ixpp, u8 pio_mode)
+{
+	switch (pio_mode) {
+	case XFER_PIO_0:
+		regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+				   IXP4XX_EXP_T1_T5_MASK, IXP4XX_EXP_PIO_0_8);
+		break;
+	case XFER_PIO_1:
+		regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+				   IXP4XX_EXP_T1_T5_MASK, IXP4XX_EXP_PIO_1_8);
+		break;
+	case XFER_PIO_2:
+		regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+				   IXP4XX_EXP_T1_T5_MASK, IXP4XX_EXP_PIO_2_8);
+		break;
+	case XFER_PIO_3:
+		regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+				   IXP4XX_EXP_T1_T5_MASK, IXP4XX_EXP_PIO_3_8);
+		break;
+	case XFER_PIO_4:
+		regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+				   IXP4XX_EXP_T1_T5_MASK, IXP4XX_EXP_PIO_4_8);
+		break;
+	default:
+		break;
+	}
+	regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+			   IXP4XX_EXP_BW_MASK, IXP4XX_EXP_BYTE_RD16|IXP4XX_EXP_BYTE_EN);
+}
+
+static void ixp4xx_set_16bit_timing(struct ixp4xx_pata *ixpp, u8 pio_mode)
 {
-	struct ata_device *dev;
-
-	ata_for_each_dev(dev, link, ENABLED) {
-		ata_dev_info(dev, "configured for PIO0\n");
-		dev->pio_mode = XFER_PIO_0;
-		dev->xfer_mode = XFER_PIO_0;
-		dev->xfer_shift = ATA_SHIFT_PIO;
-		dev->flags |= ATA_DFLAG_PIO;
+	switch (pio_mode){
+	case XFER_PIO_0:
+		regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+				   IXP4XX_EXP_T1_T5_MASK, IXP4XX_EXP_PIO_0_16);
+		break;
+	case XFER_PIO_1:
+		regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+				   IXP4XX_EXP_T1_T5_MASK, IXP4XX_EXP_PIO_1_16);
+		break;
+	case XFER_PIO_2:
+		regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+				   IXP4XX_EXP_T1_T5_MASK, IXP4XX_EXP_PIO_2_16);
+		break;
+	case XFER_PIO_3:
+		regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+				   IXP4XX_EXP_T1_T5_MASK, IXP4XX_EXP_PIO_3_16);
+		break;
+	case XFER_PIO_4:
+		regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+				   IXP4XX_EXP_T1_T5_MASK, IXP4XX_EXP_PIO_4_16);
+		break;
+	default:
+		break;
 	}
-	return 0;
+	regmap_update_bits(ixpp->rmap, ixpp->cmd_csreg,
+			   IXP4XX_EXP_BW_MASK, IXP4XX_EXP_BYTE_RD16);
 }
 
+/* This sets up the timing on the chipselect CMD accordingly */
+static void ixp4xx_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct ixp4xx_pata *ixpp = ap->host->private_data;
+
+	ata_dev_printk(adev, KERN_INFO, "configured for PIO%d 8bit\n",
+		       adev->pio_mode - XFER_PIO_0);
+	ixp4xx_set_8bit_timing(ixpp, adev->pio_mode);
+}
+
+
 static unsigned int ixp4xx_mmio_data_xfer(struct ata_queued_cmd *qc,
-				unsigned char *buf, unsigned int buflen, int rw)
+					  unsigned char *buf, unsigned int buflen, int rw)
 {
 	unsigned int i;
 	unsigned int words = buflen >> 1;
 	u16 *buf16 = (u16 *) buf;
+	struct ata_device *adev = qc->dev;
 	struct ata_port *ap = qc->dev->link->ap;
 	void __iomem *mmio = ap->ioaddr.data_addr;
-	struct ixp4xx_pata_data *data = dev_get_platdata(ap->host->dev);
+	struct ixp4xx_pata *ixpp = ap->host->private_data;
+	unsigned long flags;
+
+	ata_dev_printk(adev, KERN_DEBUG, "%s %d bytes\n", (rw == READ) ? "READ" : "WRITE",
+		       buflen);
+	spin_lock_irqsave(ap->lock, flags);
 
 	/* set the expansion bus in 16bit mode and restore
 	 * 8 bit mode after the transaction.
 	 */
-	*data->cs0_cfg &= ~(0x01);
-	udelay(100);
+	ixp4xx_set_16bit_timing(ixpp, adev->pio_mode);
+	udelay(5);
 
 	/* Transfer multiple of 2 bytes */
 	if (rw == READ)
@@ -76,8 +165,10 @@ static unsigned int ixp4xx_mmio_data_xfer(struct ata_queued_cmd *qc,
 		words++;
 	}
 
-	udelay(100);
-	*data->cs0_cfg |= 0x01;
+	ixp4xx_set_8bit_timing(ixpp, adev->pio_mode);
+	udelay(5);
+
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	return words << 1;
 }
@@ -90,19 +181,25 @@ static struct ata_port_operations ixp4xx_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 	.sff_data_xfer		= ixp4xx_mmio_data_xfer,
 	.cable_detect		= ata_cable_40wire,
-	.set_mode		= ixp4xx_set_mode,
+	.set_piomode		= ixp4xx_set_piomode,
+};
+
+static struct ata_port_info ixp4xx_port_info = {
+	.flags		= ATA_FLAG_NO_ATAPI,
+	.pio_mask	= ATA_PIO4,
+	.port_ops	= &ixp4xx_port_ops,
 };
 
 static void ixp4xx_setup_port(struct ata_port *ap,
-			      struct ixp4xx_pata_data *data,
+			      struct ixp4xx_pata *ixpp,
 			      unsigned long raw_cmd, unsigned long raw_ctl)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
 	raw_ctl += 0x06;
-	ioaddr->cmd_addr	= data->cmd;
-	ioaddr->altstatus_addr	= data->ctl + 0x06;
-	ioaddr->ctl_addr	= data->ctl + 0x06;
+	ioaddr->cmd_addr	= ixpp->cmd;
+	ioaddr->altstatus_addr	= ixpp->ctl + 0x06;
+	ioaddr->ctl_addr	= ixpp->ctl + 0x06;
 
 	ata_sff_std_ports(ioaddr);
 
@@ -135,10 +232,12 @@ static void ixp4xx_setup_port(struct ata_port *ap,
 static int ixp4xx_pata_probe(struct platform_device *pdev)
 {
 	struct resource *cmd, *ctl;
-	struct ata_host *host;
-	struct ata_port *ap;
+	struct ata_port_info pi = ixp4xx_port_info;
+	const struct ata_port_info *ppi[] = { &pi, NULL };
 	struct device *dev = &pdev->dev;
-	struct ixp4xx_pata_data *data = dev_get_platdata(&pdev->dev);
+	struct device_node *np = dev->of_node;
+	struct ixp4xx_pata *ixpp;
+	u32 csindex;
 	int ret;
 	int irq;
 
@@ -148,20 +247,32 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	if (!cmd || !ctl)
 		return -EINVAL;
 
-	/* allocate host */
-	host = ata_host_alloc(dev, 1);
-	if (!host)
+	ixpp = devm_kzalloc(dev, sizeof(*ixpp), GFP_KERNEL);
+	if (!ixpp)
+		return -ENOMEM;
+
+	ixpp->rmap = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(ixpp->rmap))
+		return dev_err_probe(dev, PTR_ERR(ixpp->rmap), "no regmap\n");
+	/* Inspect our address to figure out what chipselect the CMD is on */
+	ret = of_property_read_u32_index(np, "reg", 0, &csindex);
+	if (ret)
+		return dev_err_probe(dev, ret, "can't inspect CMD address\n");
+	dev_info(dev, "using CS%d for PIO timing configuration\n", csindex);
+	ixpp->cmd_csreg = csindex * IXP4XX_EXP_TIMING_STRIDE;
+
+	ixpp->host = ata_host_alloc_pinfo(dev, ppi, 1);
+	if (!ixpp->host)
 		return -ENOMEM;
+	ixpp->host->private_data = ixpp;
 
-	/* acquire resources and fill host */
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
-	data->cmd = devm_ioremap(dev, cmd->start, 0x1000);
-	data->ctl = devm_ioremap(dev, ctl->start, 0x1000);
-
-	if (!data->cmd || !data->ctl)
+	ixpp->cmd = devm_ioremap_resource(dev, cmd);
+	ixpp->ctl = devm_ioremap_resource(dev, ctl);
+	if (IS_ERR(ixpp->cmd) || IS_ERR(ixpp->ctl))
 		return -ENOMEM;
 
 	irq = platform_get_irq(pdev, 0);
@@ -172,27 +283,23 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	else
 		return -EINVAL;
 
-	/* Setup expansion bus chip selects */
-	*data->cs0_cfg = data->cs0_bits;
-	*data->cs1_cfg = data->cs1_bits;
-
-	ap = host->ports[0];
-
-	ap->ops	= &ixp4xx_port_ops;
-	ap->pio_mask = ATA_PIO4;
-	ap->flags |= ATA_FLAG_NO_ATAPI;
-
-	ixp4xx_setup_port(ap, data, cmd->start, ctl->start);
+	/* Just one port to set up */
+	ixp4xx_setup_port(ixpp->host->ports[0], ixpp, cmd->start, ctl->start);
 
 	ata_print_version_once(dev, DRV_VERSION);
 
-	/* activate host */
-	return ata_host_activate(host, irq, ata_sff_interrupt, 0, &ixp4xx_sht);
+	return ata_host_activate(ixpp->host, irq, ata_sff_interrupt, 0, &ixp4xx_sht);
 }
 
+static const struct of_device_id ixp4xx_pata_of_match[] = {
+	{ .compatible = "intel,ixp4xx-compact-flash", },
+	{ },
+};
+
 static struct platform_driver ixp4xx_pata_platform_driver = {
 	.driver	 = {
 		.name   = DRV_NAME,
+		.of_match_table = ixp4xx_pata_of_match,
 	},
 	.probe		= ixp4xx_pata_probe,
 	.remove		= ata_platform_remove_one,
-- 
2.31.1

