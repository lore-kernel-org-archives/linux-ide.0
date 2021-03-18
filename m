Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3ACC43333
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2065D64F3B
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhCRIwQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCRIv7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:51:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD1C06175F
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:51:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso2862552wmi.0
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ww/weUvcZaIAW1/4IpRQWiCV/q1/L856MjOkNuPC5RA=;
        b=FhDE3pfDksVXYUzEAGqiZS7G/a/+SpHaqrnIPtUgrDi7hdV61S1cwwFL6WibH4DVQA
         7BYLoK7xBgnnaaP3+FWe5Hx1ZSFbe0tB3LfaFiEBebsk859pSyITDQVX+R8WXg6OFWJR
         WMroLtrHgqmabUKp8sMZ9k7h6cQA+N+6QmL1e42KvPqFkT51/V4/BY2am8yYv8shTfA3
         jlGnlEPSO5cObJFOlKN+7u3g3RaqtppW57ikKS4C4nh60k2kn4HZyX/LuKLmWBeR0o/a
         focEbvW9E3SfdgGhbW2y5cput/Td7tTJH8s7WCvsgvDpwZL77dZfrOszNjEfmrlEi787
         bTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ww/weUvcZaIAW1/4IpRQWiCV/q1/L856MjOkNuPC5RA=;
        b=YNAcdZuLqYNnLr3ANRLAjV21NFfV4nRXvNSxbQfhmAmapUGGqs5M/WQrgaAsZBN8KX
         XYRLHoKsfaGWgyy/hrK0EgfqXgCvU+v2RhdKwUlicl7dM9ZUA/s5+VxhTEGgQyURB+uN
         LhP+KE6wvO1OlxiCTVx5YRqoTA7MDYIWW14BitqotbcjWMHJwQoOIbl0QGvN+2jx4mBd
         G/3jRCD5NBxGxl7u+MgG+8gjweDkd6diQ7UyTyaFaqaiv5ZqVaJRyiAy+bVhQLXc9ZRF
         XQ+OzP6bf6QZx5UpLV9hEQQmJKQx0IPA5bh7Uu0rAxD5NNr3PctjYA7CwetjCNNUxbnj
         TOEA==
X-Gm-Message-State: AOAM531A2c2Yl/4KnRVHXDzDMwN9p1SUeX4p3eOgWjN4fifUk8epqMb4
        Thk++eFSV68KWc8ab+Q/k+0kyXKm8P02Mg==
X-Google-Smtp-Source: ABdhPJyolUMm6pIu0p+Uaj0fKL7mW2TP2e9kaIVExOqOtxpFxB3CiGiRHpoOpYTwD5PBccU6tDJZdw==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr2515271wmf.99.1616057517906;
        Thu, 18 Mar 2021 01:51:57 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 06/15] ata: pata_via: Fix a kernel-doc formatting issue
Date:   Thu, 18 Mar 2021 08:51:41 +0000
Message-Id: <20210318085150.3131936-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_via.c:675: warning: Function parameter or member 'pdev' not described in 'via_reinit_one'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_via.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 38044e6797951..4750320489843 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -663,7 +663,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 #ifdef CONFIG_PM_SLEEP
 /**
  *	via_reinit_one		-	reinit after resume
- *	@pdev; PCI device
+ *	@pdev: PCI device
  *
  *	Called when the VIA PATA device is resumed. We must then
  *	reconfigure the fifo and other setup we may have altered. In
-- 
2.27.0

