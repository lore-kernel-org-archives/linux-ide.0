Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1D4C433E0
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8076F64DAD
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBAOtZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhBAOle (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:41:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F1FC061221
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:40:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i9so13408896wmq.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9JDBMmgrFoXz6Tq0/RYZRCcswI9jrwMOoIxfQ3LDYhE=;
        b=nBNTL8NllFuSIqpu9W87YK9Jyo6ZKRW4b3Efot8Fbhi8ZYVkCfVHFFNUuk+wle657W
         VFaXvFYoaSgc4skwFELv1JFyX/Nf9mKDuV79+hTvtUqGbVQdl+ZPQJoFIxCIOe4axf1W
         JhLt4ECV+Gkth0ae5s6owEii/hMXqeTBeSzddcE3xqXL/lB2O2WMKCI1Ypt0t0JXi0+X
         AIli0lASNRDooifXIYIKbM+oh+KTi/abrUZ+TWb1zIkNe+a1SK7JB+KsWn6fU2SY47rc
         PqWP7DCpwPuIMieFkjDlFIASLzRa3fr6U1qaO0pdIcxP0uTC760nmaDel/fB0z15I5Jp
         rc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JDBMmgrFoXz6Tq0/RYZRCcswI9jrwMOoIxfQ3LDYhE=;
        b=h4PXM0PFamQj6DDM1d5mjdEL3V2MPNpeJy02EIPB+/qh67mcmTa7YVw4Tz8dk97uUN
         BV4/RcG5wMoF+SQUCtfJOnUf0o0Nv/iKmQ2fIBVsrIGBtY2Pcrtiq98ZzEbBJzxgWyeS
         F1USsLKNSvB/9VnTiw5UsM2XIvyqzXra60P/ar+zYBw8Wj7jUhuXVtYWDqyZSqYIoNhM
         wy0EEna8st5feOvecJS5I4qzfh10avz5iYNAhBh3kIc/TT0oyatB3W7JFs6YF0os1Ftu
         Upl8l1alHkq6bWxDwIfOuny98fUh4De/0OB6DTl5KK+o8eaAXWp3WOhP/PxwFZWLzp5K
         G2Mw==
X-Gm-Message-State: AOAM532QDuKVwWo1evlsn1YUuiPH8Fe/Oe29McSoFR/gDPEOo9hQtqL0
        b7gB4dYaNvhgH9Cja5TF9MhODkiPrPxrpxxO
X-Google-Smtp-Source: ABdhPJzETHP18h8WFbldkDtgdSCitWNoRnpxhK0ewYLbgWMleHO3cRkXllWdeuLFsAfYkmzie4btGA==
X-Received: by 2002:a05:600c:3504:: with SMTP id h4mr2789387wmq.168.1612190398918;
        Mon, 01 Feb 2021 06:39:58 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        ATI Inc <hyu@ati.com>, linux-ide@vger.kernel.org
Subject: [PATCH 14/20] ata: pata_atiixp: Fix a function name and supply description for 'pio'
Date:   Mon,  1 Feb 2021 14:39:34 +0000
Message-Id: <20210201143940.2070919-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_atiixp.c:103: warning: Function parameter or member 'pio' not described in 'atiixp_set_pio_timing'
 drivers/ata/pata_atiixp.c:241: warning: expecting prototype for atiixp_dma_stop(). Prototype was for atiixp_bmdma_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: ATI Inc <hyu@ati.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_atiixp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index c68aa3f585f22..d671d33ef2874 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -93,6 +93,7 @@ static int atiixp_prereset(struct ata_link *link, unsigned long deadline)
  *	atiixp_set_pio_timing	-	set initial PIO mode data
  *	@ap: ATA interface
  *	@adev: ATA device
+ *	@pio: Requested PIO
  *
  *	Called by both the pio and dma setup functions to set the controller
  *	timings for PIO transfers. We must load both the mode number and
@@ -227,7 +228,7 @@ static void atiixp_bmdma_start(struct ata_queued_cmd *qc)
 }
 
 /**
- *	atiixp_dma_stop	-	DMA stop callback
+ *	atiixp_bmdma_stop	-	DMA stop callback
  *	@qc: Command in progress
  *
  *	DMA has completed. Clear the UDMA flag as the next operations will
-- 
2.25.1

