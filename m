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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AF4C48BCF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 02:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A627C613EF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 02:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFJCMQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 22:12:16 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:36823 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhFJCMP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 22:12:15 -0400
Received: by mail-pg1-f177.google.com with SMTP id 27so21313234pgy.3;
        Wed, 09 Jun 2021 19:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3vxfoigo83sshUyO8P1oaAvHedMM0FfePK8OA+A7B8=;
        b=X/ktL3nCyrN1tXx7R1VVaAqdxZsKhBl5yx98xe4GMC/AJwOQ+xYMkMVFGddbHAX5AU
         gQHDumBrd1MUQFh3UJtg+xXt2Hgpo8YsnsyaysbUH9Q+4D3xRbQcbHhfgRdkOwcvVqcu
         N1YwZFwP0YqX4K2IXsgS2MLEE0wx0BlHMKO0U4XZeWbgeTVLOfbQOdZ9prso0ylik0hs
         RqITagGsMyQUuQNObhBr+Aft/8zMRy1Gc9BOIzoQ+i0EiYi2PuQaHVvr5QIr7WrOPhoT
         RjDojxmuWq4hyzAr1N4ghkiEgyAYRfVdgaG4KT03zyY9IotqqPrMRXUKZSawJJgckl/j
         03kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3vxfoigo83sshUyO8P1oaAvHedMM0FfePK8OA+A7B8=;
        b=dqqj0FgNPYk8NENmzqAocWJprO67Mk72JpSPlpSHgUFffG5PfZqJe8QF+iJTMgAxoI
         8f7mO20bOgPHTI3WqeAz5WPN9R/VBUmcPBjMpinPignl63j3eCoO9EjxU9jocWJ/GjWX
         UCUliDVORT2QjBBqKDSidZG+bz6k+msQkpT0a+zBchsnievPec6EYShPh6/gpL3GJl+h
         JluaQLRdsr36UNU+TI/5r7cbAtekKCSpg/z3B0cHlOGVlNs+E6VKhIXF+r0UoCxnnG09
         Ag5pJJLarzo2lwfFwD4y2aT0H5W9Z5PfbGDpFS4C2dXSrucuDDqJBDSNP0MoPZ+V7wje
         uauQ==
X-Gm-Message-State: AOAM532ZkV8RAgiJKCsQhN0MRoco6vnCK8WcDoZUKYeHAbigtlCWhfRA
        eYVvIqWqemfr26l7jlnLh88=
X-Google-Smtp-Source: ABdhPJxuY1pFEfQzlV7e93GvPmzbBQJiT7iKAeW6YFRvFGbKAaQj3KSMbDqwjavAJvbRTCBir7aKnQ==
X-Received: by 2002:a62:cdc6:0:b029:2ec:8ee0:57bd with SMTP id o189-20020a62cdc60000b02902ec8ee057bdmr676332pfg.78.1623290960375;
        Wed, 09 Jun 2021 19:09:20 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id 15sm722309pfy.15.2021.06.09.19.09.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 19:09:19 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 9A8BA3603E0; Thu, 10 Jun 2021 14:09:16 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v2 2/2] net/8390: apne.c - add 100 Mbit support to apne.c driver
Date:   Thu, 10 Jun 2021 14:09:13 +1200
Message-Id: <1623290953-18000-3-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623290953-18000-1-git-send-email-schmitzmic@gmail.com>
References: <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
 <1623290953-18000-1-git-send-email-schmitzmic@gmail.com>
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

