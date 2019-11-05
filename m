Return-Path: <SRS0=rygF=Y5=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35DDC47E49
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 06:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96F6217F4
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 06:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1rdBuhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfKEGiL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:38:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43943 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEGiL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 01:38:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so13295379pgh.10;
        Mon, 04 Nov 2019 22:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+5ESTlbTl8y28Qw/VLztZLaYWCPKCcvBt/47C0di3+s=;
        b=Z1rdBuhHIhFkz3RLIu2Y9QkMlKgQnCzFw1MUq1nxaFpZcsBMPre8k896Tu75rmrM86
         jzeHZTgE8HvkPdhs4q3s2e6VK+euP9atiWf0vWRcRtXeRbsNIBhYiKVHHcD4hERGdDRz
         RNmI3PNUYMdkG4dfNgBTVHmpiPfPUpG1LJ/l3l8bOlhONl5XPHT5xyqJZBStiBSMa+d9
         bAHzswF+8LtgezU0RP5i2ynFPZzP8MmDTraz+OVp2cvqBO5U09/cff9dXe+HipdbBt7n
         Yqdpu1dOJsOYHMucaAQhCUg9lt291Upp5QwYYiLZAp6b5svxBbHKDG/w8vQ7vDQ4ZYDH
         vNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+5ESTlbTl8y28Qw/VLztZLaYWCPKCcvBt/47C0di3+s=;
        b=jc5vsqgUwBAekbFxG2+nXJj93ljdDnAkm9J3jaLMQIsMIuQd+UmvbLt06zeYLA1K09
         Oyn4yV/+LOvw9iTDEpI2X1LpCrIRiEowx+7e9Z1Q5VbSeiFQpPRDHU4fW4SBEvsJA7aU
         xu2lpiZT+CGK1zCEYRq8slNoUgyfT3gRG2C5WHIrVDm7gogmsdWJCJcnRjV9e/ed0MfJ
         xMWZ/kxaFNntlC0zfKTrFiLndEuFkAsdUE7ugngU/VRDlWo/QuCp2p78fjvTtw8tcBjm
         FNjWiOgj3j528l03WfzN/YAGFh1w03w15DwvDS+wAuCJqhi6BNRQ46X7c4iy/IaOhM9D
         ovJw==
X-Gm-Message-State: APjAAAUGjDW+eV4gJukeYmmnqhyN21x3SlB12rqCt/D7aFhKT/10kUOt
        10B/vX6cfV6Hr8eeCCXjalc=
X-Google-Smtp-Source: APXvYqwCg3vA0vMrUGB1Bxrz9fMZMYQeM03pRLhbf8b9nzmt0Na6SlaE8t69a42dJnLKhb5c3h9K7g==
X-Received: by 2002:a62:7c52:: with SMTP id x79mr35266211pfc.18.1572935888629;
        Mon, 04 Nov 2019 22:38:08 -0800 (PST)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id e5sm19586164pfa.110.2019.11.04.22.38.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 22:38:07 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 3F6A9360079; Tue,  5 Nov 2019 19:38:04 +1300 (NZDT)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org,
        b.zolnierkie@samsung.com
Cc:     schmitz@debian.org, Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ide: falconide: convert to platform driver
Date:   Tue,  5 Nov 2019 19:37:52 +1300
Message-Id: <1572935872-28394-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com>
References: <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

With the introduction of a platform device for the Atari Falcon IDE
interface, the old Falcon IDE driver no longer loads (resource already
claimed by the platform device).

Convert falconide driver to use the same platform device that is used
by pata_falcon also.

Tested (as built-in driver) on my Atari Falcon.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ide/falconide.c |   45 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/ide/falconide.c b/drivers/ide/falconide.c
index a5a07cc..d6dd772 100644
--- a/drivers/ide/falconide.c
+++ b/drivers/ide/falconide.c
@@ -15,6 +15,7 @@
 #include <linux/blkdev.h>
 #include <linux/ide.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 
 #include <asm/setup.h>
 #include <asm/atarihw.h>
@@ -23,6 +24,7 @@
 #include <asm/ide.h>
 
 #define DRV_NAME "falconide"
+#define DRV_VERSION "0.1.0"
 
     /*
      *  Base of the IDE interface
@@ -114,18 +116,18 @@ static void falconide_output_data(ide_drive_t *drive, struct ide_cmd *cmd,
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
@@ -134,23 +136,29 @@ static void __init falconide_setup_ports(struct ide_hw *hw)
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
@@ -169,10 +177,21 @@ static int __init falconide_init(void)
 err_free:
 	ide_host_free(host);
 err:
-	release_mem_region(ATA_HD_BASE, 0x40);
+	release_mem_region(res->start, resource_size(res));
 	return rc;
 }
 
-module_init(falconide_init);
+static struct platform_driver ide_falcon_driver = {
+	.driver   = {
+		.name	= "atari-falcon-ide",
+	},
+};
+
+module_platform_driver_probe(ide_falcon_driver, falconide_init);
+
 
+MODULE_AUTHOR("Geert Uytterhoeven");
+MODULE_DESCRIPTION("low-level driver for Atari Falcon IDE");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:atari-falcon-ide");
+MODULE_VERSION(DRV_VERSION);
-- 
1.7.0.4

