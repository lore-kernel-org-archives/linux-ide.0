Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5ECC4361B
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0C764F33
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCRIwS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhCRIwE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:52:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C736C061762
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so6516858wma.0
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaackZ/z/LereQfTWx6EZY6YyaXRiP4t4NnTncEoRCA=;
        b=hOaFBnS1qL4EZR4viHQwVJgMva2mOeGRvIL4fuUMRhTF5KlXTL27cypHXcqyLPU9ym
         ptdWABTJunZmopbdxFY3/uyiRuUeA3/Q3UEN80dQm1oAGG49y9/rHmtT7WO3d+psKtIW
         4Wo9VIBg0fX6g9AnuIt18/iI+tv+gBWlBhyXS+hlNi+aLHsijUkLw3BrOUaLxh9SxQuV
         60+NQBDb9bQUXgG60CAZM6YSRq7WwpTT8gOFnLvS7dDyaQ/K4PwYAiaFZaQHjncg+ZjY
         I9puisGMIqbK3GatIdPjfeiOHp4t9xQN748FETqDNEtbHMcYlfVs2JhY0w2VtLpEZsHT
         kEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaackZ/z/LereQfTWx6EZY6YyaXRiP4t4NnTncEoRCA=;
        b=aajLE93o+TgmJWgCD6DW9n/8c1T0hENnTFBpe/LF6oBFLFPDLd0rH+N1YvNETug4jA
         CNpDz5H5LNT267RH2Ip+xmM0RseL7K6nUn3T7NTwLeGs1Lr7XMbUs2WR2w7ttKm2fo0p
         xsJbwxG8hZzl9Pf9ZcX+/aESddfpzxj5SfK3zr8Upf0J20HYr4NPiKg/o4gnW3bpZ6nI
         Ul1B4YQEYie++LJps7SPGsTmISrpnXO1rge3/F5Ez8kuH3rlrbdlY4yFbzxPY/zWi4Ya
         8Lw+h6M04reUtAXHZ559iBdfaGUSq17hMPi9BP/rs8A/kQOs8HFmOchsYzQRS+XaM4UG
         zH5Q==
X-Gm-Message-State: AOAM533FyMGdb1+o6foJ0RCZ4CvOxqGl6SUa4B+u0OgNHHGvJb+HG5eM
        tix3nYoHnmNWjdbtnpTNxC2iYQ==
X-Google-Smtp-Source: ABdhPJxyXMICdkigPOOwmxZ9OVNAiEXw7pw+/JSuD26xTSpiSRESPA5e655cnDxb8hRfkdI6Or5ojg==
X-Received: by 2002:a05:600c:b57:: with SMTP id k23mr2456756wmr.145.1616057522356;
        Thu, 18 Mar 2021 01:52:02 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:52:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Colten Edwards <pje120@cs.usask.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH 11/15] ata: pata_legacy: Repair a couple kernel-doc problems
Date:   Thu, 18 Mar 2021 08:51:46 +0000
Message-Id: <20210318085150.3131936-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_legacy.c:606: warning: expecting prototype for opt82c465mv_qc_issue(). Prototype was for opti82c46x_qc_issue() instead
 drivers/ata/pata_legacy.c:933: warning: Function parameter or member 'probe' not described in 'legacy_init_one'
 drivers/ata/pata_legacy.c:933: warning: Excess function parameter 'pl' description in 'legacy_init_one'
 drivers/ata/pata_legacy.c:1024: warning: Function parameter or member 'primary' not described in 'legacy_check_special_cases'
 drivers/ata/pata_legacy.c:1024: warning: Function parameter or member 'secondary' not described in 'legacy_check_special_cases'
 drivers/ata/pata_legacy.c:1024: warning: Excess function parameter 'master' description in 'legacy_check_special_cases'
 drivers/ata/pata_legacy.c:1024: warning: Excess function parameter 'master' description in 'legacy_check_special_cases'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Colten Edwards <pje120@cs.usask.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_legacy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 4fd12b20df239..a7235bde6ae87 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -588,7 +588,7 @@ static void opti82c46x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	opt82c465mv_qc_issue		-	command issue
+ *	opti82c46x_qc_issue		-	command issue
  *	@qc: command pending
  *
  *	Called when the libata layer is about to issue a command. We wrap
@@ -923,7 +923,7 @@ static __init int probe_chip_type(struct legacy_probe *probe)
 
 /**
  *	legacy_init_one		-	attach a legacy interface
- *	@pl: probe record
+ *	@probe: probe record
  *
  *	Register an ISA bus IDE interface. Such interfaces are PIO and we
  *	assume do not support IRQ sharing.
@@ -1009,8 +1009,8 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 /**
  *	legacy_check_special_cases	-	ATA special cases
  *	@p: PCI device to check
- *	@master: set this if we find an ATA master
- *	@master: set this if we find an ATA secondary
+ *	@primary: set this if we find an ATA master
+ *	@secondary: set this if we find an ATA secondary
  *
  *	A small number of vendors implemented early PCI ATA interfaces
  *	on bridge logic without the ATA interface being PCI visible.
-- 
2.27.0

