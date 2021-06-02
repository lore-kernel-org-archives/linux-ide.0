Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C784C47083
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45673613B8
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFBKTd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhFBKTV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CECC061760
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h8so1698240wrz.8
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYcpB4gr4G9b2N/HTEwmEP3ZKhvHq1OB6C2fuW7h01g=;
        b=SRPujFKDl9FG5cjbsJZqcYMVAtYY7G8LN7erKFPkE6GmvyX4My3D2twyDhgc9eIxqE
         7FeRVBOGkN9zRhpg2Z8zxe/GWg5+z5CIXaTjxExBU24lmunFMz7C/u468F2bu+hPTIUS
         ts7muC4hg1Dov0Mw3GirBXa6Q1RzqQpVYNu6/LXdXreFrODTbnR2bkTZI/Bq5t+93Uia
         gmeZx02H1ItteO8NfGBXztBcjtVaphcHYQ2K1hupnTZt6OwAbIduK0CzwIYQqkeGaMGM
         7co1rWuwrt2910az35uAjSnN9xF4TriNf81GLNPRheX3VD6iby6IOxMuDqdRCtQs3AKK
         IcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYcpB4gr4G9b2N/HTEwmEP3ZKhvHq1OB6C2fuW7h01g=;
        b=OAuiSy/aHSunuBoQC9qCfRqDcJVFV9+cFrZsS4tm12hC3WfcTnGyZ0VUDQpXc1gn6+
         5zQckmHQZYC1Hj4appLLHwPTPstwpqtR7EDERuYXn8nNiP3OGHHaHbObaJmNoKHJQ5Kq
         4fvrVVHaKWhwVE1wF+aBcYGv/a8Xe1sIv6S/CNYUbNCd6FfYV4bb+dFdGiVKHCiFpPaq
         +quCK4cQ1wz4VEaDjBdPPYzahHGQ69cwPjA2TL0SVm3msYZI1/x9daR4P3D+aFwzmFYd
         3Cwyium7R7tAn/FoR9wuFtHpVa/rEUofpU1cvUJesNKO8irUtCEL/CkOCvObzFI/LMt9
         CY6w==
X-Gm-Message-State: AOAM530/NgvRYWaiNb1jC33EXjIcyH1SCBWfDGcLJpLgWEox2LUptDBa
        zS4c2VpVSZrtQNy4hqALjg89nFJE4J73Fw==
X-Google-Smtp-Source: ABdhPJz8e++rnMpw2N98w8tVzPOnJlN85qJszJwSFdMRp5oMLbXduiYRmh5S6pRNG2utPxKqiYMKGg==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr644878wrq.330.1622629057037;
        Wed, 02 Jun 2021 03:17:37 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 03/21] ide: ide-dma-sff: Provide some missing 'param' descriptions
Date:   Wed,  2 Jun 2021 11:17:04 +0100
Message-Id: <20210602101722.2276638-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-dma-sff.c:84: warning: Function parameter or member 'on' not described in 'ide_dma_host_set'
 drivers/ide/ide-dma-sff.c:116: warning: Function parameter or member 'drive' not described in 'ide_build_dmatable'
 drivers/ide/ide-dma-sff.c:116: warning: Function parameter or member 'cmd' not described in 'ide_build_dmatable'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-dma-sff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ide/ide-dma-sff.c b/drivers/ide/ide-dma-sff.c
index b7c2c0bd18b53..8603df4d92fd8 100644
--- a/drivers/ide/ide-dma-sff.c
+++ b/drivers/ide/ide-dma-sff.c
@@ -75,6 +75,7 @@ static void ide_dma_sff_write_status(ide_hwif_t *hwif, u8 val)
 /**
  *	ide_dma_host_set	-	Enable/disable DMA on a host
  *	@drive: drive to control
+ *	@on: whether to enable/disable the IDE controller's DMA
  *
  *	Enable/disable DMA on an IDE controller following generic
  *	bus-mastering IDE controller behaviour.
@@ -98,6 +99,9 @@ EXPORT_SYMBOL_GPL(ide_dma_host_set);
 /**
  *	ide_build_dmatable	-	build IDE DMA table
  *
+ *	@drive: The drive to unmap
+ *	@cmd: The IDEcommand
+ *
  *	ide_build_dmatable() prepares a dma request. We map the command
  *	to get the pci bus addresses of the buffers and then build up
  *	the PRD table that the IDE layer wants to be fed.
-- 
2.31.1

