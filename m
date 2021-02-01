Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44876C433E6
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C1964E9A
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhBAOnB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhBAOmg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:42:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3E6C0611BE
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:40:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g10so16847706wrx.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyQtn17PTBrcRsPcgHDOZTKxROdnGY6b4VlV5omsb8Y=;
        b=Ypd5PZfSNYNiJAYSx+BZ9Vu97SLXnMdYKLrCGZ9szRSzrZ1Rdtn03RWttjlyxVJTEP
         x1llYip6JKBwInGWquGAjb560vGHl7wDHBy7Oehttp2kBaOkOYYDswDAx1yoI7APC8tp
         vS8kIq4zGoGmeAJlRPyGLWLukENBH8CfRM719g3o8TU7iheZQGGgMynx2+hfWCUj3l9Q
         w1c59YWEum5h1/HYaFd4thKrhS1fSq3Nu6sNMjr/8UncUEY/6+E3k5oV69wEel2dfx5Z
         vBSvfkhUurg85FpU//XAbzQ9txe8BDaJg2VdYSEJrc9UKrAKqGM84PftrPe08C38rapL
         wKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyQtn17PTBrcRsPcgHDOZTKxROdnGY6b4VlV5omsb8Y=;
        b=iWViqgA3pXDocyrVUMwfSv9q8icuTfev+2qZLjGBjzvEJq8WETd00pVlzYlGEmevwr
         0R0BtYkx96gBNBsioEVKeXi5lFIqL9dasILPvqsgBIYaRl1c29Xe5G1mHtFeyy797gal
         ZJUJOk4TyRjcVB5tUCt3eYM4/uqzA1ZOiBVeanTlUHoFspSZSX0kehgn1JOE/VlyQZkY
         XrgHWLRn5Iv1pBY1LDKhzIFqqJFiJQHc5vfi0Yv1yrukzkdM1cpgj6t9lg5Kpg+Psc4C
         37zOCjFkY1OzBDubP/N/lfkf8FMY4hEllO9f4Y4FruJnJ7shLwkCj4Pdy7xr3GTszNe5
         KhuQ==
X-Gm-Message-State: AOAM531LtEf56ll0LVWDh26++7yxrO2/ZpMsT8tDtwQkKfSl1zUlMCvD
        9T+lKel3cb3+PWoCm8LOOkTqIQ==
X-Google-Smtp-Source: ABdhPJz8aTRKHvddtB5nncbPFCCIBsYnVI7a6DdrYz/XZgAQ2mtfhZTen/1AL1goK6IY5AAhRytGag==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr18578011wrt.269.1612190405951;
        Mon, 01 Feb 2021 06:40:05 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:40:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Albert Lee <albertcc@tw.ibm.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Frank Tiernan <frankt@promise.com>, linux-ide@vger.kernel.org
Subject: [PATCH 20/20] ata: pata_pdc2027x: Fix some incorrect function names and parameter docs
Date:   Mon,  1 Feb 2021 14:39:40 +0000
Message-Id: <20210201143940.2070919-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_pdc2027x.c:209: warning: expecting prototype for pdc2027x_pata_cable_detect(). Prototype was for pdc2027x_cable_detect() instead
 drivers/ata/pata_pdc2027x.c:262: warning: expecting prototype for pdc2720x_mode_filter(). Prototype was for pdc2027x_mode_filter() instead
 drivers/ata/pata_pdc2027x.c:513: warning: Function parameter or member 'board_idx' not described in 'pdc_adjust_pll'
 drivers/ata/pata_pdc2027x.c:513: warning: expecting prototype for adjust_pll(). Prototype was for pdc_adjust_pll() instead
 drivers/ata/pata_pdc2027x.c:599: warning: expecting prototype for detect_pll_input_clock(). Prototype was for pdc_detect_pll_input_clock() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Albert Lee <albertcc@tw.ibm.com>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Frank Tiernan <frankt@promise.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_pdc2027x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index de834fbb6dfe6..effc1a09444de 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -196,7 +196,7 @@ static inline void __iomem *dev_mmio(struct ata_port *ap, struct ata_device *ade
 }
 
 /**
- *	pdc2027x_pata_cable_detect - Probe host controller cable detect info
+ *	pdc2027x_cable_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
  *
  *	Read 80c cable indicator from Promise extended register.
@@ -251,7 +251,7 @@ static int pdc2027x_prereset(struct ata_link *link, unsigned long deadline)
 }
 
 /**
- *	pdc2720x_mode_filter	-	mode selection filter
+ *	pdc2027x_mode_filter	-	mode selection filter
  *	@adev: ATA device
  *	@mask: list of modes proposed
  *
@@ -503,11 +503,11 @@ static long pdc_read_counter(struct ata_host *host)
 }
 
 /**
- * adjust_pll - Adjust the PLL input clock in Hz.
+ * pdc_adjust_pll - Adjust the PLL input clock in Hz.
  *
- * @pdc_controller: controller specific information
  * @host: target ATA host
  * @pll_clock: The input of PLL in HZ
+ * @board_idx: board identifier
  */
 static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int board_idx)
 {
@@ -590,7 +590,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 }
 
 /**
- * detect_pll_input_clock - Detect the PLL input clock in Hz.
+ * pdc_detect_pll_input_clock - Detect the PLL input clock in Hz.
  * @host: target ATA host
  * Ex. 16949000 on 33MHz PCI bus for pdc20275.
  *     Half of the PCI clock.
-- 
2.25.1

