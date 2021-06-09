Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6754C48BCF
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 07:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEB261351
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 07:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhFIHjS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhFIHjS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 03:39:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7509CC06175F;
        Wed,  9 Jun 2021 00:37:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x10so12095565plg.3;
        Wed, 09 Jun 2021 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3vxfoigo83sshUyO8P1oaAvHedMM0FfePK8OA+A7B8=;
        b=Xbxjw08a4e0o8pfRsE+oO9MTi1hTCPeHHUyyBC0UdgtSqTkcsK+cYMsdlKtUBa+rzh
         OgWe2auFM6Zq1toXrF6GXMfqeBf+e/7bQQhFQPiDA4Q0eg5aDzVz/BQTnyBzhOgLV99G
         wtR0+zOLyC7IeeiBjqLn7ODKf3+7uPDe3Vo4S3fgtxlEm/ULZ5mTLRALkULgHUDXGn0J
         FcANQcKTqyAH5whGvKSZy3j6HM/kRamDXPle1KrOdicrd9wp5/Sgs+bcoBELIvLzTaTG
         hOxenxH+G8u9EjEUGblc7q2eXcPKEU0bL+g5DvvV/iV1G6WI4mMpEusGDb3TgtVo+J2r
         Z3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3vxfoigo83sshUyO8P1oaAvHedMM0FfePK8OA+A7B8=;
        b=mijbe/WZgkpE4t93pOtE6duar8DqIFg2U8LpwcMwAQqpZQMxZhEx7UKwPZVx3SpktV
         6f6/1S6WOpEBfJFBw2hRw3wOICGMADgORlWx+ZAmU9bLRX59QquqjdJddYgUxRdvac0h
         hjyU4tsMyoTpejV+LZyacWjU9Sd7LwdsnIRs1UtnBSDq3SghTkGebN6hICcZyLr1jDnF
         rQNffSaxZMjYVs1vSoqHDpWvFfLKmwiGXOdXs7M58KxPvZIgZhJjHmSA4lPR+4+YjREa
         ADGo4oOaGNg06oGvohtTFCrIWr11CEX8x7Y4dgVRmmUVaiWpYcYmtQEcy19Hz2WwO5U4
         DHog==
X-Gm-Message-State: AOAM532Yre9n9BSAbMpZTF+sJ8Lkr3ctZr1TOKEXrXJYRKweXIko07Uw
        ZQBtfxzOj+dIOGqhi/a3QT0=
X-Google-Smtp-Source: ABdhPJyUcc5q25sUrRwPcJYtua+o7kzdEZTej5kLUxfcOJr8LIR47QEzA4pqD5owYfYBupKI3CoYSA==
X-Received: by 2002:a17:90b:1908:: with SMTP id mp8mr4774213pjb.106.1623224229048;
        Wed, 09 Jun 2021 00:37:09 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id pi8sm12088784pjb.52.2021.06.09.00.37.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 00:37:08 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 638BD3603D8; Wed,  9 Jun 2021 19:37:05 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v1 2/2] net/8390: apne.c - add 100 Mbit support to apne.c driver
Date:   Wed,  9 Jun 2021 19:36:54 +1200
Message-Id: <1623224214-4836-3-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
References: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
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

--
Changes from RFC:

Geert Uytterhoeven:
- change APNE_100MBIT to depend on APNE
- change '---help---' to 'help' (former no longer supported)
- fix whitespace errors
- fix module_param_named() arg count
- protect all added code by #ifdef CONFIG_APNE_100MBIT
---
 drivers/net/ethernet/8390/Kconfig | 12 ++++++++++++
 drivers/net/ethernet/8390/apne.c  | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/8390/Kconfig b/drivers/net/ethernet/8390/Kconfig
index 9f4b302..8ff8da6 100644
--- a/drivers/net/ethernet/8390/Kconfig
+++ b/drivers/net/ethernet/8390/Kconfig
@@ -143,6 +143,18 @@ config APNE
 	  To compile this driver as a module, choose M here: the module
 	  will be called apne.
 
+config APNE100MBIT
+	bool "PCMCIA NE2000 100MBit support"
+	depends on APNE
+	default n
+	help
+	  This changes the driver to support 10/100Mbit cards (e.g. Netgear
+	  FA411, CNet Singlepoint). 10 MBit cards and 100 MBit cards are
+	  supported by the same driver.
+
+	  To activate 100 Mbit support at runtime, use the apne100 module
+	  parameter.
+
 config PCMCIA_PCNET
 	tristate "NE2000 compatible PCMCIA support"
 	depends on PCMCIA
diff --git a/drivers/net/ethernet/8390/apne.c b/drivers/net/ethernet/8390/apne.c
index fe6c834..cd99cc3 100644
--- a/drivers/net/ethernet/8390/apne.c
+++ b/drivers/net/ethernet/8390/apne.c
@@ -120,6 +120,12 @@ static u32 apne_msg_enable;
 module_param_named(msg_enable, apne_msg_enable, uint, 0444);
 MODULE_PARM_DESC(msg_enable, "Debug message level (see linux/netdevice.h for bitmap)");
 
+#ifdef CONFIG_APNE100MBIT
+static u32 apne_100_mbit;
+module_param_named(apne_100_mbit_msg, apne_100_mbit, uint, 0);
+MODULE_PARM_DESC(apne_100_mbit_msg, "Enable 100 Mbit support");
+#endif
+
 struct net_device * __init apne_probe(int unit)
 {
 	struct net_device *dev;
@@ -139,6 +145,11 @@ struct net_device * __init apne_probe(int unit)
 	if ( !(AMIGAHW_PRESENT(PCMCIA)) )
 		return ERR_PTR(-ENODEV);
 
+#ifdef CONFIG_APNE100MBIT
+	if (apne_100_mbit)
+		isa_type = ISA_TYPE_AG16;
+#endif
+
 	pr_info("Looking for PCMCIA ethernet card : ");
 
 	/* check if a card is inserted */
@@ -590,6 +601,16 @@ static int init_pcmcia(void)
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

