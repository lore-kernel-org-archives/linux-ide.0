Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2F2C4332D
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5D664E2E
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhCRIwP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCRIv5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:51:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F38FC06174A
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:51:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so2849761wmj.1
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxZxF4hq2WUxPEWONl0C36ILOQnwGtK5Kgu+3CdOvGE=;
        b=jgT7ilJ84tK2lz/jYCrcTsFWXdIQqjFrcSZO+wuwNCAxhhzUVWginn5lDvgg4pwc77
         Rv44k5Pr08EeK23LgoIfQplCHraMOTZq4MGNYwJwEDTpECcqWBMrIXyRj+f6gqjCyyzC
         TeY59hmaF6eLpObK8nZyr6KDNHHTELki6neenOBxx6cJgBqLnQ1Bl1nFsAVx6gQFLp57
         W0kyqEL1cvI7M0lpJoOkLrpkRCClWTmBvCu8wYJTo/wY9hlGkh2MA8kj/CmDn9kP8YX3
         rCPNVUEZTA76WCIoyPgXBnxdushlS2CsOGQtZwLohO4WTDZJ/zrt5HYaDAn3pQ+U0LCt
         AMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxZxF4hq2WUxPEWONl0C36ILOQnwGtK5Kgu+3CdOvGE=;
        b=AyJD8jIzBfvmk6gjy4qnVFcubT/siAEx9J2R/StnI+hQq37QSfGa7tjzUVvE+1csNe
         y04JDGo1AkL3HoaeAM6JTQ86uxtQz9RXeHktQL5ZcnC6Qzid48AmMb3hMAXvwB3YYDx7
         cJoq2BMLjGKRIDSNfn8t6VtS4XCig27o++3YEkv+Bq7oeGcCHpPbswsL71bQK8Aw0ggm
         C0XCwvmAqMd7hMWEP6m18UQAG6BKmwicDAtRyOdp4Hz0CjWTWw7luy24R319wEDlLoaf
         YniilwtUhZC4URJXgN3nur8GvlQgIe20Vtw7Ur587179bcD5y2MxpuPK64yH4mI3XwSR
         o5Ag==
X-Gm-Message-State: AOAM532JEuPuEzxANjC/g/qKR9VdFQ0MTpgJVfJWNNzHSku3ZHL1opx+
        23WZtI9e0TLSvf1NRuukLFX13w==
X-Google-Smtp-Source: ABdhPJwgIahBU2bvMS81hRPmVLgu9kQbD/3kXrFawRNphy1r7IwfrJ1vt+mGHm7VMPVbrmjhqKuc9g==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr2554933wmi.27.1616057515445;
        Thu, 18 Mar 2021 01:51:55 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>,
        Lionel Bouton <Lionel.Bouton@inet6.fr>,
        Vojtech Pavlik <vojtech@suse.cz>,
        "L.C. Chang" <lcchang@sis.com.tw>, linux-ide@vger.kernel.org
Subject: [PATCH 03/15] ata: pata_sis: Remove superfluous param description and supply another
Date:   Thu, 18 Mar 2021 08:51:38 +0000
Message-Id: <20210318085150.3131936-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_sis.c:124: warning: Excess function parameter 'deadline' description in 'sis_133_cable_detect'
 drivers/ata/pata_sis.c:529: warning: Function parameter or member 'mask' not described in 'sis_133_mode_filter'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Cc: "L.C. Chang" <lcchang@sis.com.tw>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_sis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index d7cd39a9888a9..b5b764e18adfc 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -114,7 +114,6 @@ static int sis_port_base(struct ata_device *adev)
 /**
  *	sis_133_cable_detect - check for 40/80 pin
  *	@ap: Port
- *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection for the later UDMA133 capable
  *	SiS chipset.
@@ -521,6 +520,7 @@ static void sis_133_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 /**
  *	sis_133_mode_filter - mode selection filter
  *	@adev: ATA device
+ *	@mask: received mask to manipulate and pass back
  *
  *	Block UDMA6 on devices that do not support it.
  */
-- 
2.27.0

