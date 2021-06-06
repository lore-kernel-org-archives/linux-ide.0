Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC84C4743E
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 05:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F21A6141E
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 05:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhFFF4w (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Jun 2021 01:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFFF4v (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jun 2021 01:56:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D78C061766;
        Sat,  5 Jun 2021 22:54:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u9so6784946plr.1;
        Sat, 05 Jun 2021 22:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hld5kw7o2R7vVcZgh6KN7uiMlmdrN/hjOIuaLJxHHSU=;
        b=Y+w8jNwaLJ49HL+Qx8/wr0UQhUfyUstcZEUXocQeALujPAAo/JndlvituE3Z2R9dwJ
         KeatSyGnckAJY/OTvyM9rIO+D2AuG+F42DgJZixArWGtddvDoBRb6g2DdVthct0qKGuo
         6OzfzKvcJ7BvWOXAWDij6Rx2CZ4KVF5xljMaVPvFkNc7UraRmUw3JybQOhqbjE5g/I5b
         1Zi6w5qdKJet5FFTBgZaUItEkxG4Nq4/VOeVYlRxXDt+4fLVFd6PhVHqSId/AOKIpEJM
         e6MGFTdQ1MTZo8BlFyWZ61hMSWurpz5U71cCjr2+WEzoW8JzXkNK5L3HYIYpqu7knwqr
         nlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hld5kw7o2R7vVcZgh6KN7uiMlmdrN/hjOIuaLJxHHSU=;
        b=FddCuTmm660Q7oy5mg3eAI1qD8wck55+ePrn+Xb7SU9EAO+uOpVc5jv7mubfobIokk
         54DYSPKcfBbWKmiBT1j0ANYWQee75ffHLD76a4K/cWt6jxSY5KQkzcuKtMrs7vUEcNg4
         fjf56cDY1kji/i6WjNT2+NRmSAwMiYdpuJoXN1HQNAvKWjsFTjIPdpQmu4Zz6L7lnwEt
         yW51iH73HTfrxsth4arCnh+UFf3NpCbZeCBGWsDi6BOMCc0jA25F7htPGwt0zKUIzUtQ
         Z5JLEbE8SVFJwWab9B/Dlv9V1vVueoD6J2kMzssolycRTnmYyJOwM51Hd0C9jcV2B+is
         Hzkg==
X-Gm-Message-State: AOAM531PBqmu3IRjjrkJqKAU4UUmoFCpZhE+PuuMtsvAWPziHI2eQfJZ
        nxkXaYSXLiwxGufQ5q1HYys=
X-Google-Smtp-Source: ABdhPJzLMF/Ewbt0AaWCYcY61nEXVE8E0YEqkmoC52eiJpZ7a17JCb4w2LxEkcPaDlf6ZX2hzkwK+g==
X-Received: by 2002:a17:902:8b81:b029:108:ec1:e024 with SMTP id ay1-20020a1709028b81b02901080ec1e024mr11991781plb.59.1622958891426;
        Sat, 05 Jun 2021 22:54:51 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id u13sm7535044pjr.29.2021.06.05.22.54.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 22:54:51 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id B73873603D8; Sun,  6 Jun 2021 17:54:47 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH RFC 2/2] net/8390: apne.c - add 100 Mbit support to apne.c driver
Date:   Sun,  6 Jun 2021 17:54:37 +1200
Message-Id: <1622958877-2026-3-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
References: <20210605060447.GA18461@allandria.com>
 <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig option, module parameter and PCMCIA reset code
required to support 100 Mbit PCMCIA ethernet cards on Amiga.

10 Mbit and 100 Mbit mode are supported by the same module.
A module parameter switches Amiga ISA IO accessors to word
access by changing isa_type at runtime. Additional code to
reset the PCMCIA hardware is also added to the driver probe.

Patch modified after patch "[PATCH RFC net-next] Amiga PCMCIA
100 MBit card support" submitted to netdev 2018/09/16 by Alex
Kazik <alex@kazik.de>.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 drivers/net/ethernet/8390/Kconfig | 13 +++++++++++++
 drivers/net/ethernet/8390/apne.c  | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/8390/Kconfig b/drivers/net/ethernet/8390/Kconfig
index 9f4b302..10103fb 100644
--- a/drivers/net/ethernet/8390/Kconfig
+++ b/drivers/net/ethernet/8390/Kconfig
@@ -143,6 +143,19 @@ config APNE
 	  To compile this driver as a module, choose M here: the module
 	  will be called apne.
 
+if APNE
+config APNE100MBIT
+	bool "PCMCIA NE2000 100MBit support"
+	default n
+	---help---
+	  This changes the driver to support 10/100Mbit cards (e.g. Netgear
+	  FA411, CNet Singlepoint). 10 MBit cards and 100 MBit cards are
+	  supported by the same driver.
+
+	  To activate 100 Mbit support at runtime, use the apne100 module
+	  parameter. 
+endif
+
 config PCMCIA_PCNET
 	tristate "NE2000 compatible PCMCIA support"
 	depends on PCMCIA
diff --git a/drivers/net/ethernet/8390/apne.c b/drivers/net/ethernet/8390/apne.c
index fe6c834..9648e45 100644
--- a/drivers/net/ethernet/8390/apne.c
+++ b/drivers/net/ethernet/8390/apne.c
@@ -120,6 +120,10 @@ static u32 apne_msg_enable;
 module_param_named(msg_enable, apne_msg_enable, uint, 0444);
 MODULE_PARM_DESC(msg_enable, "Debug message level (see linux/netdevice.h for bitmap)");
 
+static u32 apne_100_mbit;
+module_param_named(apne_100_mbit, uint, 0);
+MODULE_PARM_DESC(apne_100_mbit, "Enable 100 Mbit support");
+
 struct net_device * __init apne_probe(int unit)
 {
 	struct net_device *dev;
@@ -139,6 +143,9 @@ struct net_device * __init apne_probe(int unit)
 	if ( !(AMIGAHW_PRESENT(PCMCIA)) )
 		return ERR_PTR(-ENODEV);
 
+        if (apne_100_mbit)
+                isa_type = ISA_TYPE_AG100;
+
 	pr_info("Looking for PCMCIA ethernet card : ");
 
 	/* check if a card is inserted */
@@ -590,6 +597,16 @@ static int init_pcmcia(void)
 #endif
 	u_long offset;
 
+#ifdef CONFIG_APNE100MBIT
+	/* reset card (idea taken from CardReset by Artur Pogoda) */
+	{
+		u_char  tmp = gayle.intreq;
+
+		gayle.intreq = 0xff;    mdelay(1);
+		gayle.intreq = tmp;     mdelay(300);
+	}
+#endif
+
 	pcmcia_reset();
 	pcmcia_program_voltage(PCMCIA_0V);
 	pcmcia_access_speed(PCMCIA_SPEED_250NS);
-- 
2.7.4

