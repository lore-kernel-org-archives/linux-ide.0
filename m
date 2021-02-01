Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C33C433E0
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDB964DF5
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhBAOsW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhBAOlm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:41:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811AFC061225
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:40:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 6so16824863wri.3
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c13mHJ9q4khjz3HwzXj0RVixkGCKPHZCZNKDXnyAPKA=;
        b=WH4TudRdMpbtfWTgz3kZxyfD4xxbcAxrnxExnwv52RKJdsQciElU5atM3mvLIWKCo4
         akyCXc3l1pwmQHiKrQ1TdBh5FirhGwBrhP/08yHl5/WYFOd3wQrynGBQ4WeiFchqLKEY
         6SjClh99xFLDo7kGMUePuwCZx7K5wTVc/gs6LkO3Vays5jjTblnbgTSlsOiV0UNQHtWE
         z8mpj0GpZ/3CkH2EA9oQNpMxR/SSTV6h9aDEAN4sqXNaIOBfdaCNeZbHR9UKsidX+Mkz
         /lMM3WCQG2VuEqh9R61Ikh4k0eLqx0vatbWNy8P/xz4XQjGmQiCk57gTguUZQMGYskzJ
         K0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c13mHJ9q4khjz3HwzXj0RVixkGCKPHZCZNKDXnyAPKA=;
        b=GabM2VDWb/8JLAFgzggqkRpsW4ZVauCzdn12UniW5/7WGhWQEHcI+ps+e4PhmdsLYN
         2U0uzn5VuWok/ceIbBT8F38YMCtldTn6vmhxPusejKPgu0LdjucT8Qsa/uSbMg05ftid
         X6FEBcrB4Wfs43Jr2D3pRgXXhE01f9rDrtXaJ2k5hwPUqgV5vjwNu3+gt8GkLa3RaDBD
         RfUKRfwxYl/jCSt+ONjXGNXIRnIRN+nTWImwDSaWIruk2u4ccBZZe1BDaAd3p0/6Nxf0
         4dvWoQ0inTxGAc0SZD+qE8vvBwqKdasFlSdIHNLNV/zEf4F60sl/naojrY+5TYw+hc+Z
         TXpA==
X-Gm-Message-State: AOAM531161pjV3ndfzbUBtwLqL7JXgB/lr5zwDSIigqHDQqB9bRuVrPh
        9RMG5xjd1Nl2uLIEZTN4/k8pD8fB46yASDwG
X-Google-Smtp-Source: ABdhPJxmGE3JK7wr0XyMbiF60DgeRRAUKAjBPS36IT8pEnVa6IVYU7eGywYdD12qP9vrfvp1AAtmqw==
X-Received: by 2002:a05:6000:234:: with SMTP id l20mr18427477wrz.212.1612190401316;
        Mon, 01 Feb 2021 06:40:01 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:40:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 16/20] ata: pata_hpt3x2n: Fix possible doc-rotted function name
Date:   Mon,  1 Feb 2021 14:39:36 +0000
Message-Id: <20210201143940.2070919-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_hpt3x2n.c:247: warning: expecting prototype for hpt3x2n_bmdma_end(). Prototype was for hpt3x2n_bmdma_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_hpt3x2n.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 9cb2d50db8768..48eef338e0507 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -237,7 +237,7 @@ static void hpt3x2n_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	hpt3x2n_bmdma_end		-	DMA engine stop
+ *	hpt3x2n_bmdma_stop		-	DMA engine stop
  *	@qc: ATA command
  *
  *	Clean up after the HPT3x2n and later DMA engine
-- 
2.25.1

