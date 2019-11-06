Return-Path: <SRS0=8Rmv=Y6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DAEC5DF62
	for <linux-ide@archiver.kernel.org>; Wed,  6 Nov 2019 02:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212EB222C2
	for <linux-ide@archiver.kernel.org>; Wed,  6 Nov 2019 02:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSoUqtHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfKFCr6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 21:47:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45615 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbfKFCr6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 21:47:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id w11so5744330pga.12;
        Tue, 05 Nov 2019 18:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8cS+jQX9Cav7EbDmmORcWnfFHvSXk3ZmIbNSFNxZZW8=;
        b=lSoUqtHZ+BhD6aAD1N/qRxZdkI5gsP3PhETig8GW9S1jcHuRifyflWogDUXbvNAyzA
         y6Y/qcSf/d7swkRAoFUKf6cjVn4DCvZ8YH94t+EVSowXxMY7q+FBxvFWrQ/Wld8/hTmv
         3s2xMO5fGvH+3qQtBcBJ7/bylMwZCjFLYIsMZubxFPcwhfEHtlxCFrgJ/PN1nlGxirm6
         /q8uR37s+qXNuJUh5T2mxtEPe6QtWMDolqbkVeaaK3/6KsyphbJX0P15482Ikt0LbNf4
         FB5CIubm3d1zHEVipYV2JpLjkyPq+u13y0lv4Dq10iAlXq+0esezU04oxhVvjVihyc6o
         DV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8cS+jQX9Cav7EbDmmORcWnfFHvSXk3ZmIbNSFNxZZW8=;
        b=XITFFoc+MCPkWyS9NIhL5h0mGbffdwRTUPExuZrK7B0SnVCw5Yya/85K94Q2hdSxrV
         mypuOUhrPyjvAd/r35X5c/QG1ly1w+LoRrQQ9T3eZKKTZDNObdiJbgfMSlykj3nA8DDV
         dqqGt7D+vQkq+jHWTJ4UkHecgSgikRFPGLIv5nnko/2YNwZbDDCJux0FzOWMHIAHIH1r
         QtsNkjDCuvEA1l8Am2ryccLioXHIJ19BRH3KNPo/Q4KTdzxvwOgxz2/OxOd7YAZKzi1/
         IiW7QqvHyGJcHwO2DVg5tFXOcznIVaoCVuLTHywf40gAxJssVlZgEd297wEJmXyqC94W
         NNiQ==
X-Gm-Message-State: APjAAAUIQOmjmqZyz4g5EQ4zPQrdENSMpa+aFd23tjRp5GGoSm3t/xub
        UHrNUXoHGCKgmIcBeZxHBCw=
X-Google-Smtp-Source: APXvYqxCgqrVh3/Z9vlpIT+dsFZBL68qQM0Peuk4EQS7mAZ2L8o5+h7ePjVMA8xY/R1mzA0H6cl6rg==
X-Received: by 2002:a17:90a:cf08:: with SMTP id h8mr493349pju.77.1573008475745;
        Tue, 05 Nov 2019 18:47:55 -0800 (PST)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id j14sm797054pje.17.2019.11.05.18.47.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 05 Nov 2019 18:47:55 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 35F32360079; Wed,  6 Nov 2019 15:47:51 +1300 (NZDT)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, axboe@kernel.dk,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3] m68k/atari: convert legacy Falcon IDE driver to platform driver
Date:   Wed,  6 Nov 2019 15:47:29 +1300
Message-Id: <1573008449-8226-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Autoloading of Falcon IDE driver modules requires converting these
drivers to platform drivers.

Add platform device for Falcon IDE interface in Atari platform setup
code. Use this in the pata_falcon driver in place of the simple
platform device set up on the fly.

Convert falconide driver to use the same platform device that is used
by pata_falcon also. (With the introduction of a platform device for
the Atari Falcon IDE interface, the old Falcon IDE driver no longer
loads (resource already claimed by the platform device)).

Tested (as built-in driver) on my Atari Falcon.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changes from RFC

- fix region size (spotted by Szymon Bieganski <S.Bieganski@chello.nl>)
- define IDE interface address in atari/config.c, create platform device
  always (suggested by Geert Uytterhoeven <geert@linux-m68k.org>)

Changes from v1

- drop obsolete ATA_HD_BASE define
- add error checking for Falcon IDE platform device register
- use dev_err() to report error obtaining platform resource im
  pata_falcon driver

Changes from v2

- rewrite legacy falconide driver to use new platform device to avoid
  problem with IDE resource already marked busy (reported by Geert
  Uytterhoeven <geert@linux-m68k.org>)
---
 arch/m68k/atari/config.c  |   27 ++++++++++++++++++++
 drivers/ata/pata_falcon.c |   42 +++++++++++++++++++++----------
 drivers/ide/falconide.c   |   60 ++++++++++++++++++++++++++++++---------------
 3 files changed, 95 insertions(+), 34 deletions(-)

diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index 73bf5ea..b932da1 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -869,8 +869,28 @@ static void isp1160_delay(struct device *dev, int delay)
 };
 #endif
 
+/*
+ * Falcon IDE interface
+ */
+
+#define FALCON_IDE_BASE	0xfff00000
+
+static const struct resource atari_falconide_rsrc[] __initconst = {
+	{
+		.flags = IORESOURCE_MEM,
+		.start = FALCON_IDE_BASE,
+		.end   = FALCON_IDE_BASE+0x39,
+	},
+	{
+		.flags = IORESOURCE_IRQ,
+		.start = IRQ_MFP_FSCSI,
+		.end   = IRQ_MFP_FSCSI,
+	},
+};
+
 int __init atari_platform_init(void)
 {
+	struct platform_device *pdev;
 	int rv = 0;
 
 	if (!MACH_IS_ATARI)
@@ -912,6 +932,13 @@ int __init atari_platform_init(void)
 			atari_scsi_tt_rsrc, ARRAY_SIZE(atari_scsi_tt_rsrc));
 #endif
 
+	if (ATARIHW_PRESENT(IDE)) {
+		pdev = platform_device_register_simple("atari-falcon-ide", -1,
+			atari_falconide_rsrc, ARRAY_SIZE(atari_falconide_rsrc));
+		if (IS_ERR(pdev))
+			rv = PTR_ERR(pdev);
+	}
+
 	return rv;
 }
 
diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 41e0d6a..27b0952 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -33,7 +33,6 @@
 #define DRV_NAME "pata_falcon"
 #define DRV_VERSION "0.1.0"
 
-#define ATA_HD_BASE	0xfff00000
 #define ATA_HD_CONTROL	0x39
 
 static struct scsi_host_template pata_falcon_sht = {
@@ -120,24 +119,22 @@ static int pata_falcon_set_mode(struct ata_link *link,
 	.set_mode	= pata_falcon_set_mode,
 };
 
-static int pata_falcon_init_one(void)
+static int __init pata_falcon_init_one(struct platform_device *pdev)
 {
+	struct resource *res;
 	struct ata_host *host;
 	struct ata_port *ap;
-	struct platform_device *pdev;
 	void __iomem *base;
 
-	if (!MACH_IS_ATARI || !ATARIHW_PRESENT(IDE))
-		return -ENODEV;
-
-	pr_info(DRV_NAME ": Atari Falcon PATA controller\n");
+	dev_info(&pdev->dev, "Atari Falcon PATA controller\n");
 
-	pdev = platform_device_register_simple(DRV_NAME, 0, NULL, 0);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
 
-	if (!devm_request_mem_region(&pdev->dev, ATA_HD_BASE, 0x40, DRV_NAME)) {
-		pr_err(DRV_NAME ": resources busy\n");
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     resource_size(res), DRV_NAME)) {
+		dev_err(&pdev->dev, "resources busy\n");
 		return -EBUSY;
 	}
 
@@ -152,7 +149,7 @@ static int pata_falcon_init_one(void)
 	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
 	ap->flags |= ATA_FLAG_PIO_POLLING;
 
-	base = (void __iomem *)ATA_HD_BASE;
+	base = (void __iomem *)res->start;
 	ap->ioaddr.data_addr		= base;
 	ap->ioaddr.error_addr		= base + 1 + 1 * 4;
 	ap->ioaddr.feature_addr		= base + 1 + 1 * 4;
@@ -174,9 +171,26 @@ static int pata_falcon_init_one(void)
 	return ata_host_activate(host, 0, NULL, 0, &pata_falcon_sht);
 }
 
-module_init(pata_falcon_init_one);
+static int __exit pata_falcon_remove_one(struct platform_device *pdev)
+{
+	struct ata_host *host = platform_get_drvdata(pdev);
+
+	ata_host_detach(host);
+
+	return 0;
+}
+
+static struct platform_driver pata_falcon_driver = {
+	.remove = __exit_p(pata_falcon_remove_one),
+	.driver   = {
+		.name	= "atari-falcon-ide",
+	},
+};
+
+module_platform_driver_probe(pata_falcon_driver, pata_falcon_init_one);
 
 MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
 MODULE_DESCRIPTION("low-level driver for Atari Falcon PATA");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:atari-falcon-ide");
 MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/ide/falconide.c b/drivers/ide/falconide.c
index a5a07cc..dbeb260 100644
--- a/drivers/ide/falconide.c
+++ b/drivers/ide/falconide.c
@@ -15,6 +15,7 @@
 #include <linux/blkdev.h>
 #include <linux/ide.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 
 #include <asm/setup.h>
 #include <asm/atarihw.h>
@@ -25,13 +26,7 @@
 #define DRV_NAME "falconide"
 
     /*
-     *  Base of the IDE interface
-     */
-
-#define ATA_HD_BASE	0xfff00000
-
-    /*
-     *  Offsets from the above base
+     *  Offsets from base address
      */
 
 #define ATA_HD_CONTROL	0x39
@@ -114,18 +109,18 @@ static void falconide_output_data(ide_drive_t *drive, struct ide_cmd *cmd,
 	.chipset		= ide_generic,
 };
 
-static void __init falconide_setup_ports(struct ide_hw *hw)
+static void __init falconide_setup_ports(struct ide_hw *hw, unsigned long base)
 {
 	int i;
 
 	memset(hw, 0, sizeof(*hw));
 
-	hw->io_ports.data_addr = ATA_HD_BASE;
+	hw->io_ports.data_addr = base;
 
 	for (i = 1; i < 8; i++)
-		hw->io_ports_array[i] = ATA_HD_BASE + 1 + i * 4;
+		hw->io_ports_array[i] = base + 1 + i * 4;
 
-	hw->io_ports.ctl_addr = ATA_HD_BASE + ATA_HD_CONTROL;
+	hw->io_ports.ctl_addr = base + ATA_HD_CONTROL;
 
 	hw->irq = IRQ_MFP_IDE;
 }
@@ -134,23 +129,29 @@ static void __init falconide_setup_ports(struct ide_hw *hw)
      *  Probe for a Falcon IDE interface
      */
 
-static int __init falconide_init(void)
+static int __init falconide_init(struct platform_device *pdev)
 {
+	struct resource *res;
 	struct ide_host *host;
 	struct ide_hw hw, *hws[] = { &hw };
+	unsigned long base;
 	int rc;
 
-	if (!MACH_IS_ATARI || !ATARIHW_PRESENT(IDE))
-		return -ENODEV;
+	dev_info(&pdev->dev, "Atari Falcon IDE controller\n");
 
-	printk(KERN_INFO "ide: Falcon IDE controller\n");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
 
-	if (!request_mem_region(ATA_HD_BASE, 0x40, DRV_NAME)) {
-		printk(KERN_ERR "%s: resources busy\n", DRV_NAME);
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     resource_size(res), DRV_NAME)) {
+		dev_err(&pdev->dev, "resources busy\n");
 		return -EBUSY;
 	}
 
-	falconide_setup_ports(&hw);
+	base = (unsigned long)res->start;
+
+	falconide_setup_ports(&hw, base);
 
 	host = ide_host_alloc(&falconide_port_info, hws, 1);
 	if (host == NULL) {
@@ -169,10 +170,29 @@ static int __init falconide_init(void)
 err_free:
 	ide_host_free(host);
 err:
-	release_mem_region(ATA_HD_BASE, 0x40);
+	release_mem_region(res->start, resource_size(res));
 	return rc;
 }
 
-module_init(falconide_init);
+static int falconide_remove(struct platform_device *pdev)
+{
+	struct ide_host *host = dev_get_drvdata(&pdev->dev);
+
+	ide_host_remove(host);
+
+	return 0;
+}
+
+static struct platform_driver ide_falcon_driver = {
+	.remove = falconide_remove,
+	.driver   = {
+		.name	= "atari-falcon-ide",
+	},
+};
+
+module_platform_driver_probe(ide_falcon_driver, falconide_init);
 
+MODULE_AUTHOR("Geert Uytterhoeven");
+MODULE_DESCRIPTION("low-level driver for Atari Falcon IDE");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:atari-falcon-ide");
-- 
1.7.0.4

