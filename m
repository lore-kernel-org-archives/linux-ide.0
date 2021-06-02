Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9853C47096
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7328613B8
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhFBKUM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhFBKTm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DD7C061761
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o127so908573wmo.4
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zE6oZe1kBhGirjXSzVIMgawNguodFCFABhPx7JeRjyY=;
        b=wB0s8OGcZQIBjcRX1Bz+xqXw1bfT+Lnt7oXITnkwQRtuxBqR4R3zNKHc2Tde1PnPsU
         p0ktvhXjM0D1+g8WzN8D+AiU+OYwrZAQL92YB7VgcNvwb8U0qTCWgmXt2sE347ayu1tm
         ZYpV8GGvH3aVzCjq9pvH7ynkDm965oMzCQ8dlKH9jJuM+mpVK54xr0DyVS1UuGL4JDel
         irwrYMmOEjbORzk/+h9+P2teEFeMb2QCusMMTqFez9rgLPCtM1OcxvoyYweQKG0OvIjd
         1+M5AWqGLl0laIqeuSdP81vWEUChXvTGjUP7FSgar3bhuD0Zv2+q3oF9JzRmxK0EEG5b
         XVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zE6oZe1kBhGirjXSzVIMgawNguodFCFABhPx7JeRjyY=;
        b=A3dfjOA97M7jXt9V5MWVoDBSAkYhx6AZOdyXJX1jE123ebcD8NGRXlHs52iYXS2+E3
         p6CoSo7uDR2ojFlmMwfUx/z9MeL4jyLUvGWkWrO7wM1fV3Tul9ynjgDxUkyGlIoOhxXU
         b1IvnhfJbwpy7yyrIC/CBlsytSqj9It8e7/ZSvVnzBf0zXi8LQH7lg22Doxfibv0MMHy
         O3n1rA0E7y2nf/kqf8dCz7gUnI8OfmBEKUfGLtUxYDWLgszjiRh9fNHn+1Wips078U79
         EN1KqGYb9wyrsQlv0V56U8TOgplsY5TcBZaki2+jv/ymoqcaF0d076fcmAlJuW6axOOA
         EIsg==
X-Gm-Message-State: AOAM533AbCso6cGgiaT9BucQ4bOfXvhRwfq3huui8uupSEXiaulbdNrm
        ZgZCFiBMcoe/VSsGwyusMsz8vGLns6kZEg==
X-Google-Smtp-Source: ABdhPJwBkFs0G1HfVBAVacPTxpUaZWui9Qw4YuegR/FlDN75E+Vs0l1k1deOKhJlk7KLN1D9F3tvjw==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr4288251wmj.81.1622629068325;
        Wed, 02 Jun 2021 03:17:48 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Scott Snyder <snyder@fnald0.fnal.gov>,
        Erik Andersen <andersee@debian.org>,
        Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
Subject: [PATCH 15/21] ide: ide-cd_ioctl: Remove unused variable 'stat'
Date:   Wed,  2 Jun 2021 11:17:16 +0100
Message-Id: <20210602101722.2276638-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-cd_ioctl.c: In function ‘ide_cdrom_select_speed’:
 drivers/ide/ide-cd_ioctl.c:212:6: warning: variable ‘stat’ set but not used [-Wunused-but-set-variable]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Scott Snyder <snyder@fnald0.fnal.gov>
Cc: Erik Andersen <andersee@debian.org>
Cc: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-cd_ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 011eab9c69b7e..22ec8b7a6b90f 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -209,7 +209,6 @@ int ide_cdrom_select_speed(struct cdrom_device_info *cdi, int speed)
 	ide_drive_t *drive = cdi->handle;
 	struct cdrom_info *cd = drive->driver_data;
 	u8 buf[ATAPI_CAPABILITIES_PAGE_SIZE];
-	int stat;
 	unsigned char cmd[BLK_MAX_CDB];
 
 	if (speed == 0)
@@ -230,7 +229,7 @@ int ide_cdrom_select_speed(struct cdrom_device_info *cdi, int speed)
 		cmd[5] = speed & 0xff;
 	}
 
-	stat = ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, NULL, 0, 0);
+	ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, NULL, 0, 0);
 
 	if (!ide_cdrom_get_capabilities(drive, buf)) {
 		ide_cdrom_update_speed(drive, buf);
-- 
2.31.1

