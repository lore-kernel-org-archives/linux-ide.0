Return-Path: <SRS0=Q01X=U6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6980EC5B578
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jul 2019 22:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E36206E0
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jul 2019 22:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGQlQswf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfGAWCn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Jul 2019 18:02:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43202 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGAWCn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2019 18:02:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so7194788pfg.10;
        Mon, 01 Jul 2019 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m/RGaWxbD3ervCUN5FYVhOmz0L/VzhJqQQ8iqyX/oHA=;
        b=ZGQlQswf1RukQBL/Pjan9SIAPzVFm29rh3S4XfVsUMUqe3oqy4OFhs0TVqUf+g2dZj
         nAC6NEr71OjKdjY3+8pKN2Vwm8hb4sSDooJAxpemOJNPT+aB2xyeAvmCd96bw3r1wvZe
         FViui3uQnEtfQeWWU1t7Rh0T/3vaEUgJAtZfcSJ5eiiASHYSgRbSFvcLa6SgMYdqaz1X
         pMuWxgklvSHvzSpJl8Y1Q/R8rhBxQrLvGFIbcynrzUr+uz0buOYUihIl9O87dKFO8Uhj
         g0CuGM/gwh8Tz2ymBBB1SYrUfEYI2J70tMDcKcby3htXNbYpZC7sfKGTuwiNTMn8oRnK
         4LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m/RGaWxbD3ervCUN5FYVhOmz0L/VzhJqQQ8iqyX/oHA=;
        b=jVq2ssLiJIpDti4T1rs3LJeSa/Cf+UxqiYj4Wb2/dgnyXQUGVXyN7aJFxSmR/tWtZT
         Xnmexr5HtH1iMjBVV6AhToBt2D1eZRFr9XAtkThqrV/tr/2F4LWZwoHPz+ktQojj/vty
         7j6sUe9G7BB2x6b2Li4gGXviBxTW1qgVFScS7nQp7eh4mcIU6Aq/b7bxWeWebTt5jLq1
         iv9dNSXnlbvIYuIxxn0bVJ9rMijlVWkLyprWN7b6m5N8CEni6WtcpZB0kvLkmiB0fS/G
         kF2UfKebnqofg8x0nlKbcYG4UUIUvatM3Xhdob7V58xg7XfqHa2hvYWgP+D4nIVviECy
         QrOA==
X-Gm-Message-State: APjAAAVDYYVJzk8PJgtyWgblkPp8JwHrSSsLxlLXalQJ3A61lvL4nsFQ
        HlM4cZ6q/JzPvKXyqbvY4Ps=
X-Google-Smtp-Source: APXvYqyn/gwYB5FZo/4K9YLOpqBR8NGU4uk9OrVuvx/Lf+SrQxVYJBfrN0HiC0OMCVX7CMRoU4x7yw==
X-Received: by 2002:a63:d410:: with SMTP id a16mr25946762pgh.122.1562018562603;
        Mon, 01 Jul 2019 15:02:42 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id q5sm11415998pgj.49.2019.07.01.15.02.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 15:02:41 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id AB92A360082; Tue,  2 Jul 2019 10:02:38 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH 1/2] m68k/atari: add platform device for Falcon IDE port
Date:   Tue,  2 Jul 2019 10:02:35 +1200
Message-Id: <1562018556-15090-2-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1562018556-15090-1-git-send-email-schmitzmic@gmail.com>
References: <1562018556-15090-1-git-send-email-schmitzmic@gmail.com>
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
---
 arch/m68k/atari/config.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index ca8469e..c10533c 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -896,6 +896,25 @@ static void isp1160_delay(struct device *dev, int delay)
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
 	int rv = 0;
@@ -939,6 +958,10 @@ int __init atari_platform_init(void)
 			atari_scsi_tt_rsrc, ARRAY_SIZE(atari_scsi_tt_rsrc));
 #endif
 
+	if (ATARIHW_PRESENT(IDE))
+		platform_device_register_simple("pata_falcon", -1,
+			atari_falconide_rsrc, ARRAY_SIZE(atari_falconide_rsrc));
+
 	return rv;
 }
 
-- 
1.7.0.4

