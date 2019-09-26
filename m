Return-Path: <SRS0=z20e=XV=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4280C432C2
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 03:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7CC207FF
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 03:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L88RPw4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbfIZDyn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Sep 2019 23:54:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41033 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfIZDyn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Sep 2019 23:54:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so938816pfh.8;
        Wed, 25 Sep 2019 20:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D+5ppbg8COrcSTyDinlhZqZ5EdqQHJG8tG2i99hzSEU=;
        b=L88RPw4zApuOp1yIeawri2yRM36d7dPJBFYYyW9zKH7DHAXvlrv69Tgp0pG4Z+uCg6
         ZeNYaQx4BE7nCTZ9yVSwkfSUD3SmlZylM1e7N6W+WvBohOn/s0idsVOTQ/5GFMTwbNoW
         FcpjafDK7QtmSQmfA6+fiAR9bS+SDOJqSTf488OA/5iXeQnwWEg6CZrIisMO6b0qG1l4
         8oyaTdoIEq0s4bNP816r9S6EvE1Khe7LxXDtc5OiJ/y7514kCxU3MWmUE5Prrzv4N6qd
         UMHW0e6Yk6deFF3FuNKsxJvcHhTJCyfPIFxcjtDohRfWKY9Kpb22rtVy/GcPvruHQSOC
         hCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D+5ppbg8COrcSTyDinlhZqZ5EdqQHJG8tG2i99hzSEU=;
        b=kxIelJY0KOgF9yQiy6+eT2205IrnUEnA7lvvbLTEcgJRDu6uwmjZBy2e8HEdAjQofs
         SL1bf+GapbQzLEIWsFkp3qgasPPPyLAiekVledBcP8U2skT2+aSLL22lgscx1BA0FRWa
         C380D6hvCfaooZO9fIDElSXVDSSq/zWLJhBXhzFik0xsIh54rKdYRUoM01bMUVITfwML
         nPXaovL361t6qFNKZZfm1LS7xQf9r2aqFyIye3z6UeC2qP1z2lLz34YelUGol4p3gIMp
         ih/RO/ZYtregNpK/rKdw8lbhloVrRJarU1/CJJPRGKtiOWsVXf/JJfmw0z0lmLTCTPi6
         ZNSA==
X-Gm-Message-State: APjAAAWSIHsZXOx193ZOy6tUD6cuR5WiHsUzZswuH6qk3WZfPxFiPwE4
        TUbqP20d3013/Peljqv4dIs=
X-Google-Smtp-Source: APXvYqyuV4oGs2xRTRGEHC/JkxYwN9DXtmZagGPAFwmSNC1pttUwRivNSMN0MZcTthEX8j0VjiB/LA==
X-Received: by 2002:a65:5bc3:: with SMTP id o3mr1369858pgr.30.1569470082432;
        Wed, 25 Sep 2019 20:54:42 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id z13sm528694pfg.172.2019.09.25.20.54.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 20:54:42 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 04748360079; Thu, 26 Sep 2019 15:54:38 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH RESEND v2 2/2] drivers/ata: convert pata_falcon to arch platform device
Date:   Thu, 26 Sep 2019 15:54:24 +1200
Message-Id: <1569470064-3977-3-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The Atari platform device setup now provides a platform device
for the Falcon IDE interface. Use this in place of the simple platform
device set up in the old pata_falcon probe code.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

--

Changes from v1

- drop obsolete ATA_HD_BASE define
- use dev_err() to report error obtaining platform resource
---
 drivers/ata/pata_falcon.c |   42 ++++++++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 41e0d6a..0e6c6b6 100644
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
+	dev_info(&pdev->dev, ": Atari Falcon PATA controller\n");
 
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
-- 
1.7.0.4

