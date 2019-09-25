Return-Path: <SRS0=6af8=XU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647E6C432C1
	for <linux-ide@archiver.kernel.org>; Wed, 25 Sep 2019 07:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398272082F
	for <linux-ide@archiver.kernel.org>; Wed, 25 Sep 2019 07:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVdcKUjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437163AbfIYHRO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:17:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36972 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437028AbfIYHRO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Sep 2019 03:17:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id c17so2699325pgg.4
        for <linux-ide@vger.kernel.org>; Wed, 25 Sep 2019 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A+1VuJxwvIv+rPKWHqx3gbb1r4WYU4uyfBOklGEbSsw=;
        b=UVdcKUjTwL/X2pcx1im5MNMIiqoiu201BYwLdcLJvLe/DNzd+m8rDQaccX2NlMCDoO
         t4SqpBqj2dEJZM/fYeZgSwqISG1Nwfd36nHzSlx4ICz8IMMsGHsHBlT6dfoJrRC6+t2X
         cdEfHDsu/OtnFGl6ZwM1VyLoZbSdENEssyJXALGwXibw6QjlMFyW/4XH3BnmGvgRKtuu
         rTIraVwCljMi9Cq9mZmekgOuw+RND0DU8a8BSfekGlj8eU1MOgqGMdK+gI0k9xn4K2k8
         6nqExZJVw0m/fD4arGNXtGNG+Fj/AjinsXAa/qgAZeZLDyHb7ODG4x7vBCuUA9QpBKR9
         xr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A+1VuJxwvIv+rPKWHqx3gbb1r4WYU4uyfBOklGEbSsw=;
        b=HTJe2b1zsHp6HfvtbOj1qXkiDO7b8D09ud98F5xygJ4Sfm6ADblF74reQVyISiVHQf
         NKn6JZycLap9x/20XMDiPWvpNR3t7R6rNjbQbwKdTHXcmjVmcffo6MoCmsxsfm3eud4b
         YnskOFEt6Z5jPsaFObUmOlItEbinO93olMmgOStHVf842NxXDd7RUBiFw7fU9ZYAycXj
         NdwdwoDM0V8qFSDYn85R+k9erLjWsuFL2q25+jocJgFWlbM7dps0eh26qEyRfggUZvaP
         S58Tj0stWQ/goUP+OSOeh86vwJVMqmjR+m4GZvjmEQ/jRL19X8wKwUK87FtAgEjhbY8D
         jhVw==
X-Gm-Message-State: APjAAAVSS4lVI0GTtR3W93nGYb+uPxSAorv5bbBJxhL2M/WgVpscfcjQ
        tXTu+JfbUqzBqSe03R2E4V+CyAKD
X-Google-Smtp-Source: APXvYqyRXJKYr6LHXwICZudwAXHbTp06WIC0efJZLFfHqo+uaxM7m6BFmLnKsxeDCU5059jqXCIkNA==
X-Received: by 2002:aa7:824b:: with SMTP id e11mr8208332pfn.62.1569395832765;
        Wed, 25 Sep 2019 00:17:12 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id 74sm3402769pfy.78.2019.09.25.00.17.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Sep 2019 00:17:12 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 4AE4C360082; Wed, 25 Sep 2019 19:17:08 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v2--to=linux-m68k@vger.kernel.org 1/2] m68k/atari: add platform device for Falcon IDE port
Date:   Wed, 25 Sep 2019 19:17:04 +1200
Message-Id: <1569395825-29426-2-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1569395825-29426-1-git-send-email-schmitzmic@gmail.com>
References: <1569395825-29426-1-git-send-email-schmitzmic@gmail.com>
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

