Return-Path: <SRS0=Q01X=U6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF93C06510
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jul 2019 22:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74A0206E0
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jul 2019 22:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey5qcJAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfGAWCo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Jul 2019 18:02:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33514 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGAWCo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2019 18:02:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so8025457plo.0;
        Mon, 01 Jul 2019 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=20zUOmhbr4c1dI/gFurcJdwsyxZCOaPC9d8sh21LLXA=;
        b=ey5qcJAhZmTvBHxhSRIO195RuQZUE3igZXjyitLTsJwi+BhoUsYy6hJ6Hwnvq2iF6C
         y958XwsuoTT44tp4bbAE3woOBnF5U0NXzO6xEE1iw0tA3oAnJqGuDvCoIMebS3NfwcBg
         QMRy/kd2yOuH0LGjDmK4X2GW7f47enCI58hq30qnjb3a069VltQLPm9hR07Avjx+EeG8
         VRpCJ86Ipwznh5Oa7iOK/rbJftIy/VzvvzdbIwcWZGv6RsT+aMAJwiQ8+Pf5u6685AEQ
         sJuKqK2mvEUyk10g0O99AtUUbyWNeUYMHuxu7PWwv169q+cJJAb4ilDFRxwAmJ39sNXk
         syPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=20zUOmhbr4c1dI/gFurcJdwsyxZCOaPC9d8sh21LLXA=;
        b=cOsQN0CGBjid82qoH6mli64XZZsL+7aFmlZmv/Prsicrq5uEc1BYWpJVYns1+vKhQY
         CrzwAOT6VVilWuM3cjVoQEjA5p372BNro37pfcrHtnPdTczWHkzywHjZNFexYFzJO6Yr
         fxMlK08Lb7EW6ciCIioa+trNIOxnvuVQY/xsqLGy7SaRSeSBlbvz2JzwmDEaAWcouwPQ
         DI2e3QxrfkUHdeklJH/4Z8aGpUw6v0QGkMR96siBte1cSgyAPSgh/dgW9T8AUsKBOYSe
         MY6TsN20C3OMlGHZ8ghJ/WlKuvfVzsYfR86POwwbgaNnBW6k9Vhl4Epb4CjlCoaIN9zM
         Qqng==
X-Gm-Message-State: APjAAAWTOz10OrseVnRq+FuGAxZYHWL/v7IW/GQigtWq7+mr5wKABS1S
        VLcgrUDbsfqB5LzqG8YaIzw/emR1
X-Google-Smtp-Source: APXvYqwB04ywn4OzrohjiwcCtd14t68a1NogIAvHm5MecZ5mlAKv7xBhc86l9OS8xEd02oHYJncutQ==
X-Received: by 2002:a17:902:6ac6:: with SMTP id i6mr31384810plt.233.1562018563738;
        Mon, 01 Jul 2019 15:02:43 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id o15sm12100759pgj.18.2019.07.01.15.02.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 15:02:43 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 70EE5360084; Tue,  2 Jul 2019 10:02:39 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH 2/2] drivers/ata: convert pata_falcon to arch platform device
Date:   Tue,  2 Jul 2019 10:02:36 +1200
Message-Id: <1562018556-15090-3-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1562018556-15090-1-git-send-email-schmitzmic@gmail.com>
References: <1562018556-15090-1-git-send-email-schmitzmic@gmail.com>
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

