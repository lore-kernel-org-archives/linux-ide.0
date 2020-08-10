Return-Path: <SRS0=g8lw=BU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C76C433DF
	for <linux-ide@archiver.kernel.org>; Mon, 10 Aug 2020 00:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1019A206D8
	for <linux-ide@archiver.kernel.org>; Mon, 10 Aug 2020 00:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcDioUBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgHJA7v (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 9 Aug 2020 20:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgHJA7v (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2020 20:59:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2AC061756;
        Sun,  9 Aug 2020 17:59:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f9so4085449pju.4;
        Sun, 09 Aug 2020 17:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0qJO4EPZit/EH6A7WT7wLcgl0yNkUMzQdIUs1Xd0rs=;
        b=WcDioUBhF3OBNLdRFGPm4xL/wg35NsnX1T7B+N5mLgLGfMHPO6e+ws8jSymjP+fehv
         Ymmj/A6435/LrpYObcEkppCnaGGFKHSFsc5Ok7yFInm1fFiQ1pRb5OADygG4gD/UQiyU
         jRioeUsmQzBmnvSOQVGnA7APtjxLRx2pCwkaAoh0rKBI+KwCOGP94+uGAeBY4BZPHm8K
         61uXgWQlXJ1btsyM3z4HvgYLxoXS0TwCFcZ1JQVvvSH/tfXVaDabCX6i5Iq26FN+Fl7f
         q+swu2/13lE3Skkfm/pY2Jf9hphdNgNueVLvi4ZCbH+cGiPdJ9qxMi00TiTCAh4bi/ZG
         hZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0qJO4EPZit/EH6A7WT7wLcgl0yNkUMzQdIUs1Xd0rs=;
        b=LCZEr76RLHWB4JtMuoZrlTadoxuEVl13t0EVvp9pAtBOv93dT7GqiEtHzIN7MBcKxw
         1y5chC1JNSIIewfbyZfmmu4yaRu9tK+UNSCNcaCKpW2Pc3uDJ+eIfq1gO/dxIrI0Esxf
         MKLG9tx5eovoQzTEVzwAPbsPfFO9hiLsGRy+2rdQRPIw9hCRbnwN4LCzn0qKmAP0v78M
         1cCQrU/TMcAYi8NlCyFhWTrbY0xkP26CLdOLlsKicAhWXjwGKOgVjY0+y7HoWRuLF1H+
         DL4TLiC0svddgnsiqYcjGg+5SmwvvX1hTrZ3K8YJvtmDkcJwmEolAGWh6mAzvdvTZEtv
         4z2A==
X-Gm-Message-State: AOAM532tJHFLrFFJqmyp1GPCDFK2KHa5xJJRQauwyW0ZU7swN2iY0Das
        BJ+tmKy/+JQ6BqvIzkNPqeQzZVVIU8vkhA==
X-Google-Smtp-Source: ABdhPJwN4CR2mZ8LTgbsjjdYYXjpnUy33fewmZnUndv91/R9tDZ9Wg5yIe7kVXKqjfra6UNUTrSO0Q==
X-Received: by 2002:a17:90b:252:: with SMTP id fz18mr24344482pjb.48.1597021190564;
        Sun, 09 Aug 2020 17:59:50 -0700 (PDT)
Received: from localhost.localdomain (c-24-16-167-223.hsd1.wa.comcast.net. [24.16.167.223])
        by smtp.gmail.com with ESMTPSA id j5sm21504055pfg.80.2020.08.09.17.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 17:59:50 -0700 (PDT)
From:   YourName <argoz1701@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mturquette@baylibre.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-clk@vger.kernel.org, argoz1701@gmail.com
Subject: [PATCH 3/3] drivers/clk/clk-asm9260.c
Date:   Sun,  9 Aug 2020 17:59:41 -0700
Message-Id: <20200810005941.20581-1-argoz1701@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Daniel <argoz1701@gmail.com>

---
 drivers/ata/acard-ahci.c  |  6 +++---
 drivers/bluetooth/bfusb.c |  5 ++---
 drivers/clk/clk-asm9260.c | 12 ++++++------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 2a04e8abd397..3ffb21f3e88b 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -79,10 +79,10 @@ static struct ata_port_operations acard_ops = {
 
 #define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)
 
-static const struct ata_port_info acard_ahci_port_info[] = {
+static const struct ata_port_info acard_ahci_port_info[] ={
 	[board_acard_ahci] =
-	{
-		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ),
+	
+        {       AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 5a321b4076aa..dc6a62cb1941 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -355,15 +355,14 @@ static void bfusb_rx_complete(struct urb *urb)
 	while (count) {
 		hdr = buf[0] | (buf[1] << 8);
 
-		if (hdr & 0x4000) {
+		if (hdr & 0x4000) 
 			len = 0;
 			count -= 2;
 			buf   += 2;
-		} else {
+		 else {
 			len = (buf[2] == 0) ? 256 : buf[2];
 			count -= 3;
 			buf   += 3;
-		}
 
 		if (count < len) {
 			bt_dev_err(data->hdev, "block extends over URB buffer ranges");
diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
index bacebd457e6f..4e608807a00a 100644
--- a/drivers/clk/clk-asm9260.c
+++ b/drivers/clk/clk-asm9260.c
@@ -92,8 +92,8 @@ static const struct asm9260_div_clk asm9260_div_clks[] __initconst = {
 	{ CLKID_SYS_CPU,	"cpu_div", "main_gate", HW_CPUCLKDIV },
 	{ CLKID_SYS_AHB,	"ahb_div", "cpu_div", HW_SYSAHBCLKDIV },
 
-	/* i2s has two deviders: one for only external mclk and internal
-	 * devider for all clks. */
+	//i2s has two deviders: one for only external mclk and internal
+	//devider for all clks.
 	{ CLKID_SYS_I2S0M,	"i2s0m_div", "i2s0_mclk",  HW_I2S0MCLKDIV },
 	{ CLKID_SYS_I2S1M,	"i2s1m_div", "i2s1_mclk",  HW_I2S1MCLKDIV },
 	{ CLKID_SYS_I2S0S,	"i2s0s_div", "i2s0_gate",  HW_I2S0SCLKDIV },
@@ -232,10 +232,10 @@ static const struct asm9260_gate_data asm9260_ahb_gates[] __initconst = {
 		HW_AHBCLKCTRL1,	16 },
 };
 
-static const char __initdata *main_mux_p[] =   { NULL, NULL };
-static const char __initdata *i2s0_mux_p[] =   { NULL, NULL, "i2s0m_div"};
-static const char __initdata *i2s1_mux_p[] =   { NULL, NULL, "i2s1m_div"};
-static const char __initdata *clkout_mux_p[] = { NULL, NULL, "rtc"};
+static const char __initconst *main_mux_p[] =   { NULL, NULL };
+static const char __initconst *i2s0_mux_p[] =   { NULL, NULL, "i2s0m_div"};
+static const char __initconst *i2s1_mux_p[] =   { NULL, NULL, "i2s1m_div"};
+static const char __initconst *clkout_mux_p[] = { NULL, NULL, "rtc"};
 static u32 three_mux_table[] = {0, 1, 3};
 
 static struct asm9260_mux_clock asm9260_mux_clks[] __initdata = {
-- 
2.25.1

