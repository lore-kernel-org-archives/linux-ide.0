Return-Path: <SRS0=6af8=XU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71124C432C2
	for <linux-ide@archiver.kernel.org>; Wed, 25 Sep 2019 07:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D6D2082F
	for <linux-ide@archiver.kernel.org>; Wed, 25 Sep 2019 07:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxJfOZ9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437286AbfIYHRQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:17:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33179 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437028AbfIYHRP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Sep 2019 03:17:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id i30so2714128pgl.0
        for <linux-ide@vger.kernel.org>; Wed, 25 Sep 2019 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D+5ppbg8COrcSTyDinlhZqZ5EdqQHJG8tG2i99hzSEU=;
        b=rxJfOZ9XyN0U2ZUSgWWuTS6FtkVXrm3WNBkKyD5RGsSSQi6f4oZFpSQuvVlxtbZRdK
         8V5CzNKnSm3udxG83TIURfQwIvm4ABGWjIgjWgQOG2QIRfKXsQSa/tyyM8tBja5rtXUO
         IWInbwQfr5Y5IMB1DQZXvkdOgTO9lMGjNN1piS8GOMYAwGXr77XsbfP9hy6nbUrJzBfw
         YOwdqxNW9Ss0Mw2gVCcZ572UdaqnkGTaEa4V8Gq3qr/g4AWylOXDfW6c+TnTj5ymEvhE
         Im2eO5KUJLiY0Cj424gRoaCeXD4oRWsE467WcNA3/WxOifPOGpSlkwr3pABFessPfpCA
         FWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D+5ppbg8COrcSTyDinlhZqZ5EdqQHJG8tG2i99hzSEU=;
        b=YuwJPFUzz+G9hxo8VDkx3mxZ/R+lLsqvV7/o5KUGORjdIzgHVPYlyr56w0gk/DQ2a+
         CZf/XpHQ/iONP93hUiUj85R+A7kMhH5ylxOU0SQ141cvHmbscgYdpL/Wfq3B2ihp2lZ2
         O++fCpOHNKZkr0JXpp4iIAq6MhHMkUmBYhYXJjlbI/sfgw32/2t2gOBA2EmF1vn4iz3e
         3urSWk79oc480s9rVrM7zPxCTZV1zctYCBYbCTzBPZtDgAxQJkE45FUWs9OXlxc3sItV
         /0nub0VyAjDgShWhLOFI5xoX8usDZXiTMJfQtObxCW4Wl0Bo41fbt3bgdmI4kjrNGKhU
         oIGw==
X-Gm-Message-State: APjAAAVvNGvT2nDL1xrsA+/h8lwe2O6zpsoQvuldYcpBbWE8C9ubzY+3
        mfr14le8dVlVQa6UmPjt1AM=
X-Google-Smtp-Source: APXvYqylGGVR6F44c86RRp8m6brl16guApLwucnmD6lGOLMDOmITGmG2OHwx9WRP+elDp8SbVBTCew==
X-Received: by 2002:a63:d908:: with SMTP id r8mr7458244pgg.263.1569395833554;
        Wed, 25 Sep 2019 00:17:13 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id 22sm4521650pfo.131.2019.09.25.00.17.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 00:17:12 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 1808E360084; Wed, 25 Sep 2019 19:17:09 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v2--to=linux-m68k@vger.kernel.org 2/2] drivers/ata: convert pata_falcon to arch platform device
Date:   Wed, 25 Sep 2019 19:17:05 +1200
Message-Id: <1569395825-29426-3-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1569395825-29426-1-git-send-email-schmitzmic@gmail.com>
References: <1569395825-29426-1-git-send-email-schmitzmic@gmail.com>
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

