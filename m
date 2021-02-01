Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CD8C433DB
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D61664E56
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhBAOl2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhBAOlU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:41:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB754C0617A9
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:39:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u14so12840036wml.4
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psxck1KMWyXDOgBCEv3jYVYq9cj2r/nvdYNmqCZ8a8o=;
        b=naPZ9ARqYCwvn9JncVu9nING3uu/kiOgXUcGuQTkTs7taI4zz63FAnlO5iWAGDACmP
         iNXjbxhfFKnGqviFm5BLJpk/Wu4a/5bfixHBp9hT6evXG6ay6VrzNclsUPnPqWPYmkD/
         +w7SdPm01xRq9T6iWux+jV3mGiLopxx0qBwFqKjz/4hrdP/SFrID+68Z7Qk/DJAR79Eh
         vHDJNIff4gd6ZinI4ir9DLGQgSubMZQZcEV4PIb3oNELlQsB7ldgGt9YCfDhmAf2G/LJ
         rST08acpa2/lv7Z/NoEnoBnODJBs/6tuJql74+yjwK5N5xolpDFN3w3VpKgo3hFV/L2z
         o3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psxck1KMWyXDOgBCEv3jYVYq9cj2r/nvdYNmqCZ8a8o=;
        b=JkhZ/LVnzrwkl0t0id8oQvUj3KJPQiBrnyqyN5wwZOPHqCa74m1i0TtuoIrNzQfDOX
         iiLKlI/haYk/I66Q0yVDJXfPpGvDuHKYhfVuB5NZygEWisUyLr4UN8k8QTlVfaco/Rnq
         OXzVQUz/Sp3WoaZpXfLRspgAlLJZcqYy972nwg9ZKps5AVs22XsYDfRMTHhETGJOYCZ4
         JaOUg0mnv1cAtLYHScMKiHkwDT2otRgjxu3Qf7+LBpjKadiEfk+0oEGElReiGvGY537A
         H6gsCPlNJqKH26ve3iIBsCutN+gZzf13SDvk4FRQBmCiT9BXDit9qFiaDN8d6PxTXPdq
         zRwQ==
X-Gm-Message-State: AOAM530tGWwBgumVv2I5eZCWSf4MOzErXMiNV61UYHHKcjIadi0fI9nC
        j0VVLBKiwYLN+Zs2mz2NFwy11A==
X-Google-Smtp-Source: ABdhPJx79fAmVLm4zlWTVY4xGoZWThx6TZd/7y+7bG+tOG2ZTCyfUiiFTet7/Ct3roidAjr1wfd10Q==
X-Received: by 2002:a1c:5f89:: with SMTP id t131mr7153496wmb.148.1612190390339;
        Mon, 01 Feb 2021 06:39:50 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 06/20] ata: pata_amd: Remove superfluous, add missing and fix broken params
Date:   Mon,  1 Feb 2021 14:39:26 +0000
Message-Id: <20210201143940.2070919-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
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

