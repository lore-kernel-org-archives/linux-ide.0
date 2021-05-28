Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3F0C4708D
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3C96124B
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhE1JGt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 May 2021 05:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbhE1JGr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2021 05:06:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB88C061574
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m18so1726280wmq.0
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHd78hRSkMzuohg5J3tzRz48OXEcvuzZqwhJwyMkBCw=;
        b=wD3jASsKf47ADb/cQ6s+gUIahaxifDyockRP1XMmKAeQ3V9G/Zv0IUyryXAVWpO1fy
         WZ33oMxOFXrMsq/KA5yLUcwHffr1RCh+s4ihw1HTM3D5yKsy0ztllL4DFoXrnaUefWh7
         1gkqr331hL0ZEzQW3vV5LAh5xEjJSvmVdig60CGOxevPIH/2zyZOUk4RI36Q3OTnDslP
         TI9Jd5ZEc9ULvxxJd06SiLGl8bptmpvTJVXgmlV4ra529TBljZjfVrEaPoEQCXa4uNKb
         WX1itQvfrQtfN7+X5fkJyrImAFIoSnVKY9+n2PkIoYH6BLKIP1W0UeVb121kwwKYd1Nm
         8pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHd78hRSkMzuohg5J3tzRz48OXEcvuzZqwhJwyMkBCw=;
        b=jDRCsFppGENVJFmsxbmqPDfrnAcgUWBWjjNLfAZo0BzLlxu1k+kBxk6ojE+vtcokTk
         XWjoDsfkIUpRCS8QyOxcrs1/19NrOULtGZcfJ88UwEra/mh32PMgo/yOUaxgWPoGZDkV
         u3UQFgiP91WhA6AJtmFyq7Jj/jwGL5Y0rOOSf5acFRjJ1K1ggg2L4IF05Jkcz4IFTTwZ
         MUgyyXQanPlX9u/DHMGZvtcBeOyDfHrLYEiWVvJDQ0KTxOByQI7BI0zB1k6C/MrUEeGx
         0eDtEoUpQK7UI3VTd0XqlQ0SwiGGXmuNcOOwnAHaY8RK7eN94W4M4dIdE388u1Bcgr+v
         lr2Q==
X-Gm-Message-State: AOAM5337FIh6EofSIY9vYxoxeZwWqoKWLixR5dL2ekDICVV9UYe3XYws
        p1AyF+4NTQVbUjdAeW0O9FlhUQ==
X-Google-Smtp-Source: ABdhPJz7oPUrqLGppxgr5fJU3aFUM3mla0OIMhHa6HERtpy9ScnCBl0ZZyTaytq7qkALkKkjadk8pw==
X-Received: by 2002:a05:600c:4f95:: with SMTP id n21mr12358979wmq.74.1622192708815;
        Fri, 28 May 2021 02:05:08 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Lord <mlord@pobox.com>,
        ALWAYS copy <linux-ide@vger.kernel.org>
Subject: [PATCH 04/11] ata: sata_mv: Do not over-write initialise fields in 'mv6_sht'
Date:   Fri, 28 May 2021 10:04:55 +0100
Message-Id: <20210528090502.1799866-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090502.1799866-1-lee.jones@linaro.org>
References: <20210528090502.1799866-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/sata_mv.c:670:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_mv.c:670:16: note: (near initialization for ‘mv6_sht.can_queue’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mark Lord <mlord@pobox.com>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/sata_mv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index c8867c12c0b86..9d86203e1e7a1 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -666,10 +666,14 @@ static struct scsi_host_template mv5_sht = {
 };
 #endif
 static struct scsi_host_template mv6_sht = {
-	ATA_NCQ_SHT(DRV_NAME),
+	__ATA_BASE_SHT(DRV_NAME),
 	.can_queue		= MV_MAX_Q_DEPTH - 1,
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
 	.dma_boundary		= MV_DMA_BOUNDARY,
+	.sdev_attrs             = ata_ncq_sdev_attrs,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
+	.slave_configure	= ata_scsi_slave_config
 };
 
 static struct ata_port_operations mv5_ops = {
-- 
2.31.1

