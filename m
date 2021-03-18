Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41187C433DB
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B21D64F2A
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCRIwM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhCRIvz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:51:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9139C061762
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v4so4593042wrp.13
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ystH3myeToYGZd9BOxHc1y/jrK48gikwMGVDRc5Ve78=;
        b=WvZ4yc83cLyyR8aCuTFUcfCIK/bNibqruWRisk+DMhXqt/psnvrO5+YG+tRKf+5Aot
         GsZxB3nikqN3W1lknbIYCXEW9JHbPu5KMAida6CNgoG0tCR2of0UuMlgHNPCJnmEjysz
         jOpTvluwFF3ERzUJCtNtbyqtxjEYFUPSNvH5Te+ykWyNgi8k4Rid7nX+qj9CsNZwnYEZ
         fsQocuR+ElhekSUXRkwdEJZ/7C857jYelmfjGrbgD+l35eOesr7+06mgJjZesbY/qGoY
         1uph666BM+419FSsvemt7gyjVOON5MToMYyyluQrV6yqrAzy91RVDzNKRZMngMmDTQUg
         MduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ystH3myeToYGZd9BOxHc1y/jrK48gikwMGVDRc5Ve78=;
        b=LiEEFDGBKTNddD7GcgNoIQk1Gcys0N0lxjwGNPkRHTyd47Jx4bS2LtQronR9puh919
         oKC/v0tUJIWSNbFaSh4pkOdyHWPVdLGLjxtfidx7Fuw3CKnP5KGhucakqCkVuMXbHcW6
         pSEiEUxV1gNiKR10rhzoekTBIzN6p3IbcR3+wIj578PT6IIC3C0rbIwMtQl8j2c9UCzL
         ClgJoFgrp8TZhQUJe8XacWiAYYTRl6Zf6Jw089MNQof/+1zLkm7zLdOn72SszayR+Mfh
         bIDbIl/H8CGfvvWlBeJq6j5COjIePWSpNvLW3p81pz6k57n5mLSrYYNXlh2O+uPqnwRw
         MtHw==
X-Gm-Message-State: AOAM531AwtvIKOdgT6nKjHduvi59KMGlCCbiD60Oxlk/D2gkssj9Chau
        Cx1a5ncbSIiBlLmhRCLVG91Bpw==
X-Google-Smtp-Source: ABdhPJxo8bV03/lAPsmphEXIb5LOtTF/A8T+YRXITJthCNS8OTQ2s0J5hMPfg+088GXYb3TJUXSkKA==
X-Received: by 2002:a5d:560e:: with SMTP id l14mr8436423wrv.10.1616057513665;
        Thu, 18 Mar 2021 01:51:53 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
Subject: [PATCH 01/15] ata: pata_pdc202xx_old: Fix some incorrectly named functions
Date:   Thu, 18 Mar 2021 08:51:36 +0000
Message-Id: <20210318085150.3131936-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_pdc202xx_old.c:127: warning: expecting prototype for pdc202xx_configure_dmamode(). Prototype was for pdc202xx_set_dmamode() instead
 drivers/ata/pata_pdc202xx_old.c:228: warning: expecting prototype for pdc2026x_bmdma_end(). Prototype was for pdc2026x_bmdma_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_pdc202xx_old.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 378ed9ea97e90..0c5cbcd28d0db 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -115,7 +115,7 @@ static void pdc202xx_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	pdc202xx_configure_dmamode	-	set DMA mode in chip
+ *	pdc202xx_set_dmamode	-	set DMA mode in chip
  *	@ap: ATA interface
  *	@adev: ATA device
  *
@@ -214,7 +214,7 @@ static void pdc2026x_bmdma_start(struct ata_queued_cmd *qc)
 }
 
 /**
- *	pdc2026x_bmdma_end		-	DMA engine stop
+ *	pdc2026x_bmdma_stop		-	DMA engine stop
  *	@qc: ATA command
  *
  *	After a DMA completes we need to put the clock back to 33MHz for
-- 
2.27.0

