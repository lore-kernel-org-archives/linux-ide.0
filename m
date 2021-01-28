Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345A5C4332B
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C04364E20
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhA1SHp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhA1SFH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:05:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952EC06121D
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s7so3347763wru.5
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxf8NqRslTnnCXUblNlG5//kELg1DL3clvbNvmI4mXU=;
        b=UntfUA2Vm6vrDU0WjZudlXKWSikByvxdHCdDF5CbmQw3+MSfBhMuBIX9Enta75PVUy
         ZafVqU2JFFP2bgb/HB9XGStGpkBLCINlVTYcWr277dRkq3KHOHi8RpFY03XKOKFFZWQr
         ugd8TxEpgC8eHyHl43kMeekO21MEKrYzyUYn+hrZX5eyGuJLtVrQqaoWaYwReXkffcAU
         npHQo6LDWhX6wqeRMdzJ0F11GT0gYkcRECALKZXMgSprXWMMW1a3C0h2fmW+DhjzN1EP
         D1sn+56xVrQJIbe5lRXBVSBWVEix2KyPEM5d1r4RRkGW8mk2q+t7ro/403rhrJNc0rg2
         Jz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxf8NqRslTnnCXUblNlG5//kELg1DL3clvbNvmI4mXU=;
        b=EsaNlje3mH5G+axEX9HqrfYsHksviIS4eZWhp+pq/dLKHIdy+wOsSCBBun1eZuN+Hh
         eRg3gkrb450yxGKvleSPPbZ3uqVahd1bommwmLM+ecjUIGt3oLulzp8MyXmEGSeBA4Cc
         q0qlE28hcRq8DJ0WWTM9VCwMcEJBaWNcMaFIq4UpWghzeQLFYrPYdMuCYAgEjISUs+Qr
         dXjMEimwhAyRxGE8UrD5+KuX+dHeYuW8wWpF2OCKDuEwQ/qmneHyIVLtXM+SrIQtnTvw
         bPkYFyLc1M/8XOfRCLzVUURSiUzSQ9NvzG664aQX0BJiULnbZSI8ElKjwcOi27PFdK0R
         fSgg==
X-Gm-Message-State: AOAM532+VeVfVD/4dMK+B8pHjLo55SW977EIVqJxmDpWy3JuoqzdVW31
        /vdh+DfK8XHcbfXxjZ2G++RFoQ==
X-Google-Smtp-Source: ABdhPJx5KaLH/cy/rUYXXolnbXr9+dS6SYxaMQVUWhpOrqyckolzbwAaCpN7Ih3WkdcMbMbbGlfKww==
X-Received: by 2002:a5d:6311:: with SMTP id i17mr264514wru.195.1611856974407;
        Thu, 28 Jan 2021 10:02:54 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 09/20] ata: acard-ahci: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:28 +0000
Message-Id: <20210128180239.548512-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Some ATA drivers use the SCSI host template, a series of interwoven
macros, to aid with initialisation.  Some of these macros conflict,
resulting in the over-writing of previously set values.

This is known behaviour and can be safely ignored.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/ata/acard-ahci.c:33:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/acard-ahci.c:70:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘acard_ahci_sht.can_queue’)
 drivers/ata/acard-ahci.c:70:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/acard-ahci.c:70:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘acard_ahci_sht.sdev_attrs’)
 drivers/ata/acard-ahci.c:70:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 79c59550c23a0..4542f101042ac 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS_acard-ahci.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_mtk.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_platform.o		= $(call cc-disable-warning, override-init)
-- 
2.25.1

