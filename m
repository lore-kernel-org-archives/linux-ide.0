Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870CFC47087
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6133F6124B
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhE1JGo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 May 2021 05:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbhE1JGm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2021 05:06:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42179C061760
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x8so2509813wrq.9
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAwi1fvjZmfmHFU/F6uA+Qzc/x3DLxFoaVN4fZrMnzo=;
        b=Oj0wzej15Xoct5UZ2mjnHXTrGKuTad6tmzynF96sXczOpjSFEMctdQYP6Re9pQfDoG
         pGUXM+s5rEQNIEv4+iikWel7kkPS60OrTcBdFfce9NtVB2Wk+2DGlvMYIp9ZOYnoFIRf
         SDxjOdP3Q0WgwhbbeVj+i/bw9QhG5YiJwWDikUelfaSRcCAVra8qO+Q99eI4fOV9uXoo
         60AC1elrDytFsZ2Y9cuGqldp7BfJ6BP89w/mU2XzqwrNgzrZXxaftnrGbxBd1gWTGQhP
         ghs+Qei4HJMl0JaaehcCZjGPITn4ZM5SWN2Dehc+dAIVKmKcPRvDgHWZzx6ZTAW9Xwnk
         4vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAwi1fvjZmfmHFU/F6uA+Qzc/x3DLxFoaVN4fZrMnzo=;
        b=XOQsCAhuKukqaYdA82/f11pfhpEdGBLJyI3+pDp1o8HxMLZLXxsnBBYfZK+66ns/kw
         ZchD/J4ot1yb/1owrJjc6/bMCSUuQ2kDGJ3Pq6y6iyIIcr4CXJQcoXc5vEd06rWZXyTY
         WQzyLNnISIUwUcmgs2ZpwjhbLhe7YdTe2kZPcBONJJDQKbVcr3dNOJTWBXXfClxNSqeY
         NYfVRe0OtiDQkGPh5PolAuZgVbPgF4hySX3DzpMPagtAuoDmQU1a9ZzfT6pprMJ0Vptx
         crFL0APCjqIhWOYI+Dh5ZRfKchlcKoo/rOZchDrLUQ6m/3EzdTU5FiNRMMKvlkcT+oLp
         tdzw==
X-Gm-Message-State: AOAM532i98ctDQ1/I+oWti/Ca1mPhjdgWz9PIu6J3ce199HsJzrytSf5
        yAaktIHLvVnE42v9+jzOk3IKhg==
X-Google-Smtp-Source: ABdhPJz8sOCHaHAk0qYyz9z+PXHXWTfZ+Im+qFLXOZieArTHZ76zLSgQz8Baq+DN3y11wEPFBpz4cw==
X-Received: by 2002:a05:6000:114c:: with SMTP id d12mr7421963wrx.265.1622192705833;
        Fri, 28 May 2021 02:05:05 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Lord <mlord@pobox.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH 01/11] ata: include: libata: Move fields commonly over-written to separate MACRO
Date:   Fri, 28 May 2021 10:04:52 +0100
Message-Id: <20210528090502.1799866-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090502.1799866-1-lee.jones@linaro.org>
References: <20210528090502.1799866-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This is a pre-cursor to some upcoming W=1 fix-ups.

Fixes the following W=1 kernel build warning(s):

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mark Lord <mlord@pobox.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/libata.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5f550eb27f811..3fcd24236793e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1397,25 +1397,28 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 	ATA_SCSI_COMPAT_IOCTL					\
 	.queuecommand		= ata_scsi_queuecmd,		\
 	.dma_need_drain		= ata_scsi_dma_need_drain,	\
-	.can_queue		= ATA_DEF_QUEUE,		\
-	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
 	.this_id		= ATA_SHT_THIS_ID,		\
 	.emulated		= ATA_SHT_EMULATED,		\
 	.proc_name		= drv_name,			\
-	.slave_configure	= ata_scsi_slave_config,	\
 	.slave_destroy		= ata_scsi_slave_destroy,	\
 	.bios_param		= ata_std_bios_param,		\
 	.unlock_native_capacity	= ata_scsi_unlock_native_capacity
 
-#define ATA_BASE_SHT(drv_name)					\
+#define ATA_SUBBASE_SHT(drv_name)				\
 	__ATA_BASE_SHT(drv_name),				\
+	.can_queue		= ATA_DEF_QUEUE,		\
+	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
+	.slave_configure	= ata_scsi_slave_config
+
+#define ATA_BASE_SHT(drv_name)					\
+	ATA_SUBBASE_SHT(drv_name),				\
 	.sdev_attrs		= ata_common_sdev_attrs
 
 #ifdef CONFIG_SATA_HOST
 extern struct device_attribute *ata_ncq_sdev_attrs[];
 
 #define ATA_NCQ_SHT(drv_name)					\
-	__ATA_BASE_SHT(drv_name),				\
+	ATA_SUBBASE_SHT(drv_name),				\
 	.sdev_attrs		= ata_ncq_sdev_attrs,		\
 	.change_queue_depth	= ata_scsi_change_queue_depth
 #endif
-- 
2.31.1

