Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCD8C43381
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFB864E1E
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhA1SHm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhA1SEw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:04:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191BBC06178A
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:58 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u14so5031984wml.4
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psxck1KMWyXDOgBCEv3jYVYq9cj2r/nvdYNmqCZ8a8o=;
        b=lBHSuYaf+ThEC3XoD0nFSMFQjdNXO6266Ggd88khh8AtoBXvl5UBglSmIvSRwJwD/P
         IU+b4wERYdnenTF6z5UMj7tvpnI2dsyL4IgBsQpv5O0O8Fodim0dN50K9Is4SYp+x238
         EHO/MnRTxnmFfSeI9jdmrzpL+a5AQzn2G2BuvDfXa7Ctui6GlQkZpxkp13i4VaKrl/en
         wMa/Mm1CvgoWI9IFvVRU1EorTkSXe4SkFGacVGi+RiAWSYltYNF2/zEr5+ZrI1Vru+OU
         xkDX6pGasijORHWcwHiMpzLFKoCevZIiJ4RPRx7IYiiUpkulawfPN0j1SZfCt188cWup
         S8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psxck1KMWyXDOgBCEv3jYVYq9cj2r/nvdYNmqCZ8a8o=;
        b=UfcHEEARiXyhiN10Fn1QsBShncWcOpIm/mwK8xS4sHBVG8T+syjHaIHNLq71fkfRYX
         USrMcczPNFDstDNQGk+57/WRyX4TjDfdHKVSV+2fjvUemVFGdGzvnnGuV4jW1VHlK58h
         nCU+GJOrtXFAo8cAqLXOqI94KaKWWGkNWSdpEwNYE7HWjn2UaZ4o2cljQ2xHyiyhgDcS
         nHOw614HdFnh9YYNG/xpGEGJA0AuHg4fSaMjTKwC9pqSpU88S4nvkRuLNQfpBqpsiAx0
         IH0uTNEMNgiqlhIMs8CykrcaFB6ypdfv/ypc/okZRFMytJtac8cANR9IRlphM9P69xp8
         XP5Q==
X-Gm-Message-State: AOAM530bcl2jidsJS1D+dwrusCQEaCGcWVCX4SCIyPO02PuF3jGV6ark
        pccCLJknWh5DpruMOSUQg78WgA==
X-Google-Smtp-Source: ABdhPJylmz84beCkITbxAGADN4SRcalxnpuBzHeS1s4xaAKVu0RnbM6Gdx3NAZPS52cxhsCp1GI+tA==
X-Received: by 2002:a1c:b682:: with SMTP id g124mr473279wmf.10.1611856976813;
        Thu, 28 Jan 2021 10:02:56 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 11/20] ata: pata_amd: Remove superfluous, add missing and fix broken params
Date:   Thu, 28 Jan 2021 18:02:30 +0000
Message-Id: <20210128180239.548512-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_amd.c:179: warning: Excess function parameter 'adev' description in 'amd_fifo_setup'
 drivers/ata/pata_amd.c:331: warning: Function parameter or member 'link' not described in 'nv_pre_reset'
 drivers/ata/pata_amd.c:331: warning: Function parameter or member 'deadline' not described in 'nv_pre_reset'
 drivers/ata/pata_amd.c:331: warning: expecting prototype for nv_probe_init(). Prototype was for nv_pre_reset() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 987967f976cb2..75b830eb3c542 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -167,7 +167,6 @@ static int amd_cable_detect(struct ata_port *ap)
 /**
  *	amd_fifo_setup		-	set the PIO FIFO for ATA/ATAPI
  *	@ap: ATA interface
- *	@adev: ATA device
  *
  *	Set the PCI fifo for this device according to the devices present
  *	on the bus at this point in time. We need to turn the post write buffer
@@ -321,7 +320,8 @@ static unsigned long nv_mode_filter(struct ata_device *dev,
 
 /**
  *	nv_probe_init	-	cable detection
- *	@lin: ATA link
+ *	@link: ATA link
+ *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection. The BIOS stores this in PCI config
  *	space for us.
-- 
2.25.1

