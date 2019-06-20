Return-Path: <SRS0=CgUK=UT=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417AFC43613
	for <linux-ide@archiver.kernel.org>; Thu, 20 Jun 2019 20:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1648B2082C
	for <linux-ide@archiver.kernel.org>; Thu, 20 Jun 2019 20:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vP2PXZX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfFTUrp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:47:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36992 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFTUrp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Jun 2019 16:47:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so2330395pfa.4;
        Thu, 20 Jun 2019 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=20zUOmhbr4c1dI/gFurcJdwsyxZCOaPC9d8sh21LLXA=;
        b=vP2PXZX45dN84RiP9iPMes6nkv5TaRjDdmW2QPmEnsf0GbjsgIt4IrCcEcyGZUbQEY
         JsL4n1zvrjSRFDTbAsShIdy8kSciGdrmmJgUnBUJIOrh/dn9Q1zkuLewi+OmVvIUXT1N
         d2eeKjEY6lXv2EXBXUqrp+PMSwHKpy1Edamiy72lYtlsCh9lAwnDpf5z2mh1zjt8TG94
         NsY3m45zMFiI/4E3fDy7Tn3oOQIcsC9c+05WJbeNTFbhVthMyzvd7M9hjmbuppTTEbu/
         RXFKVLCxIwAXrvPLz6EdN56DEfDl1clA659IvR6Nxgz9MzuW7596qjMjtHhB0EU7oC6N
         XP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=20zUOmhbr4c1dI/gFurcJdwsyxZCOaPC9d8sh21LLXA=;
        b=giZw0jjS0YQx8vKlcZCiRjQ8aLZ8MsQWRLzI+rhtuC9LAr4VhifeHRgXbS3xQrY5AX
         7i+NSIVVXeCM2mMyPkzcsxFieuOtiC65Z1q/e1oJgh5H6o940uZkwGY9ZmYwvbXn76dA
         8DXoE02mIZLbCFWovTQN5nzuYx1BzOI4W5gkwacxagGzvGYo/NZ4ZjWAbwv5ZgLPHxX6
         AV+wRE0gKvIXwdds+apSNaoW1dLOd0e+VfG+JDXTSI18OWB3CLV1qR6+Wes7rvoHZ3H3
         5oPwXTdjNGMWMkPDRRN5Gqdp9RXl+99U0ZlpPHgXCxokn+LPYyTUeSeaADCPlw2wv6Be
         94gg==
X-Gm-Message-State: APjAAAVXOABuUjMpJdvm2uoAea1Q05FmwmEzmC3REKCQ0zZPZUvc0MXm
        3asPTcxfeNgs8DsQMMtdBdO4bQVn
X-Google-Smtp-Source: APXvYqw/vxuLOiXu5ZQM932CWmdlhQp4d8XvhyXqJ9zMIuFVYysSUQV4kbp3tTA2Hr/F9S298fdEeA==
X-Received: by 2002:a63:dc09:: with SMTP id s9mr14768861pgg.425.1561063665008;
        Thu, 20 Jun 2019 13:47:45 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id j13sm370101pfh.13.2019.06.20.13.47.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 13:47:44 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 809D3360079; Fri, 21 Jun 2019 08:47:41 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH RFC 2/2] drivers/ata: convert pata_falcon to arch platform device
Date:   Fri, 21 Jun 2019 08:47:22 +1200
Message-Id: <1561063642-13900-3-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <CAMuHMdUcUqWWGNngNV3EpEq5wSsf5qTVeZvTB9gX1e26Jrq1xA@mail.gmail.com>
References: <CAMuHMdUcUqWWGNngNV3EpEq5wSsf5qTVeZvTB9gX1e26Jrq1xA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The Atari platform device setup now provides a platform device
for the Falcon IDE interface. Use this in place of the simple platform
device set up in the old pata_falcon probe code.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 drivers/ata/pata_falcon.c |   39 +++++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 41e0d6a..1ff6fcb 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -120,23 +120,21 @@ static int pata_falcon_set_mode(struct ata_link *link,
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
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     resource_size(res), DRV_NAME)) {
 		pr_err(DRV_NAME ": resources busy\n");
 		return -EBUSY;
 	}
@@ -152,7 +150,7 @@ static int pata_falcon_init_one(void)
 	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
 	ap->flags |= ATA_FLAG_PIO_POLLING;
 
-	base = (void __iomem *)ATA_HD_BASE;
+	base = (void __iomem *)res->start;
 	ap->ioaddr.data_addr		= base;
 	ap->ioaddr.error_addr		= base + 1 + 1 * 4;
 	ap->ioaddr.feature_addr		= base + 1 + 1 * 4;
@@ -174,9 +172,26 @@ static int pata_falcon_init_one(void)
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

