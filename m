Return-Path: <SRS0=z20e=XV=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C28C432C2
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 03:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC697207FF
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 03:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vN5Xf3NQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfIZDyl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Sep 2019 23:54:41 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:38690 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfIZDyl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Sep 2019 23:54:41 -0400
Received: by mail-pg1-f172.google.com with SMTP id x10so708587pgi.5;
        Wed, 25 Sep 2019 20:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A+1VuJxwvIv+rPKWHqx3gbb1r4WYU4uyfBOklGEbSsw=;
        b=vN5Xf3NQDdkgSedchn63nbcFS33i1v1pnc/0MigYgppkrqFsveH+uyxQyoSt8v7+PP
         kNm4ECzGCCB2hKqmi4g/9LF8Ti9StUVDHbcVfXLDKYlnDO1npXn4lV22gtJQz+emVd6v
         Ajpo2Nk9CgHAgitqW6hnGaK+v2qyoFi8uIcfReY6VdZ4Gt+Lazs3JZeHKViC8vJqWOZ9
         RzFSmCVXXEkGboHsC2KQx9bEUm+7sKc8Hhsep1WYCD90Hes74B5jgfKY1J8wf6xNZ9Kh
         lAJIf2RcYXm25iynMD98cU3YjhfSboDiqYNQXRbjfjhXf1/uw3WVm4Tup+rivUbAti5v
         S1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A+1VuJxwvIv+rPKWHqx3gbb1r4WYU4uyfBOklGEbSsw=;
        b=kR8QMLhAh5YwtMqtmUFlqm1OnKM3gfSptoylm9qDsi3+RrxPqBhg3Ltg+3mWOCaP/N
         nK/McifrCPvzngXUBCvPQorM1PIysE9fghDgD/rWl5JXbHizT+dvke1wvKGGE1eWb7WX
         5vKa0wM4m4mwVSBLJ5xROiaKBMSwsZGYYTT4nx3rtvvAcxlBExLcfp7GQqHQGswCEBSW
         mVy2KApr8o5i+yBrbwPIql6L9Q1rTBKuXgugT4nWZSq7R/GHS7gnp5JOhpVFReBHTDYt
         lE28OKQsSmOgcRv9N6NEP4AaNlNEwNElasK/CFT6RUiM/Tqh7iOv/n0DQRiiiEE/7KMq
         DxFA==
X-Gm-Message-State: APjAAAXntubsDszuNvKb8/XCjreZ51s5X8UN8IZ9RVAccLSaR1rQxEim
        zHRVNZzzd/5an33ddQfHiGs=
X-Google-Smtp-Source: APXvYqwK0pAPQXdCY/FbumAhxkY0B7oB9Xed4TPkvOFOISPXGtHQbH03BuirsxtyYuwqvxjuvGOVOg==
X-Received: by 2002:a62:1658:: with SMTP id 85mr1293752pfw.195.1569470080566;
        Wed, 25 Sep 2019 20:54:40 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id d5sm589072pfa.180.2019.09.25.20.54.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 20:54:40 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id F2CB0360082; Thu, 26 Sep 2019 15:54:36 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH RESEND v2 1/2] m68k/atari: add platform device for Falcon IDE port
Date:   Thu, 26 Sep 2019 15:54:23 +1200
Message-Id: <1569470064-3977-2-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Autoloading of Falcon IDE driver modules requires converting
these drivers to platform drivers.

Add platform device for Falcon IDE interface in Atari platform
setup code in preparation for this.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

--

Changes from RFC

- fix region size (spotted by Szymon Bieganski <S.Bieganski@chello.nl>)
- define IDE interface address in atari/config.c, create platform device
  always (suggested by Geert Uytterhoeven <geert@linux-m68k.org>)

Changes from v1

- add error checking for Falcon IDE platform device register
---
 arch/m68k/atari/config.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index ca8469e..d6e9363 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -896,8 +896,28 @@ static void isp1160_delay(struct device *dev, int delay)
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
@@ -939,6 +959,13 @@ int __init atari_platform_init(void)
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
 
-- 
1.7.0.4

