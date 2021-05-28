Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2DDC47087
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1861E6124B
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhE1JGp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 May 2021 05:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbhE1JGo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2021 05:06:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ED8C061763
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q5so2536960wrs.4
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWSksrnLWe4rDC76GwKSgT0nD4m0QGDvpuLUlTafu1Q=;
        b=kJXsfDn0XaU4cBTj1nb9UvuC8NlYm5WwSe0bvsqxaGAPcWn8DZNl+nxf201jW2NY/j
         de/HX/HtwUIlDjJwJ1VMJ/G1YciU8SmD2mvCR3xvAmUTYTRcA0fScrb9YwBt0uClAK7U
         bGnOgHgExwMDlOwD9TmJawkid80aeoc4BJMQ1XYUrvqcy4AGGW32xFUr/KYsoFr8xt96
         O/HXuDzhogExJdWWnZcOPpf/vfWByiBbmwp4Mv0D6LoNm2v1Inq8+OpQ39DWPCK+glKI
         POUq+yAs5ZEH4JRt7lkBPv49cVI+VMg0/Lhbn0zUyJAIwUqS9vWvfu9iCzpvA7IYda+s
         WR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWSksrnLWe4rDC76GwKSgT0nD4m0QGDvpuLUlTafu1Q=;
        b=RKr8XlB7mddTwBM0orITqb4GBhl+zuCzmnIbzJIjeks7Ndff/cMND6YC/Q4fkTgQsb
         gVXuwHXZ5ViD6i91sxBpv/8r3nILgbP5Skyn7icmjWNiMa1XUGCREbuC1l29BZqRM09u
         vidXA9SdPy+z3ITNSAId5pEDiyEFxntAeOyNskG49uqTEZ16MjSxc+2tPUkqeSULTjMY
         Q5qlzexqtB//ciz5e4CSpeeMVyvoPcAUnam9G+lfFXp+vg7+IIzcbwnym6HC6HbLmDTo
         XKnKUBOdmi5a7s3dFS60MlMV57arrggptsnutR+T5Bg1S3HaN5s83sCKNTQcCrgC0xsH
         /yPg==
X-Gm-Message-State: AOAM533PF1zqcMXlYsREsAN1QbAVDobdNl+c67tA9oGolP8+jHh2no1r
        V7Ty9mLj+nKWczdatWhfY2Vouw==
X-Google-Smtp-Source: ABdhPJx0FrZCOBPidHiKTi8G58//zi9pKaWjPvkgzW/FrwQMwNICVMXLsnGsFZiRwlRTSCA9b+xAjg==
X-Received: by 2002:a5d:514b:: with SMTP id u11mr7541900wrt.350.1622192706896;
        Fri, 28 May 2021 02:05:06 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>,
        ALWAYS copy <linux-ide@vger.kernel.org>
Subject: [PATCH 02/11] ata: ahci: Ensure initialised fields are not overwritten in AHCI_SHT()
Date:   Fri, 28 May 2021 10:04:53 +0100
Message-Id: <20210528090502.1799866-3-lee.jones@linaro.org>
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

  In file included from drivers/ata/ahci_platform.c:21:
  drivers/ata/ahci.h:388:16: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:388:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
  drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
  drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  In file included from drivers/ata/ahci_mtk.c:18:
  drivers/ata/ahci.h:388:16: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:388:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
  drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
  drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
  In file included from drivers/ata/ahci_dm816.c:16:
  drivers/ata/ahci.h:388:16: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:388:16: note: (near initialization for ‘ahci_dm816_platform_sht.can_queue’)
  drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: note: (near initialization for ‘ahci_dm816_platform_sht.sdev_attrs’)
  drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’

  NB: Snipped 150 lines of this for brevity!

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/ahci.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index d1f284f0c83d9..2e89499bd9c3d 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -384,12 +384,15 @@ extern struct device_attribute *ahci_sdev_attrs[];
  * for ATA_BASE_SHT
  */
 #define AHCI_SHT(drv_name)						\
-	ATA_NCQ_SHT(drv_name),						\
+	__ATA_BASE_SHT(drv_name),					\
 	.can_queue		= AHCI_MAX_CMDS,			\
 	.sg_tablesize		= AHCI_MAX_SG,				\
 	.dma_boundary		= AHCI_DMA_BOUNDARY,			\
 	.shost_attrs		= ahci_shost_attrs,			\
-	.sdev_attrs		= ahci_sdev_attrs
+	.sdev_attrs		= ahci_sdev_attrs,			\
+	.change_queue_depth     = ata_scsi_change_queue_depth,		\
+	.tag_alloc_policy       = BLK_TAG_ALLOC_RR,             	\
+	.slave_configure        = ata_scsi_slave_config
 
 extern struct ata_port_operations ahci_ops;
 extern struct ata_port_operations ahci_platform_ops;
-- 
2.31.1

