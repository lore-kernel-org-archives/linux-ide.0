Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3678CC47093
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20709613B8
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhFBKUR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhFBKTn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81078C0613ED
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so3427906wmk.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tYu84XEdUSREmqYuOdJdmWRVylLsrzssqO4s6Rt4FM=;
        b=dNNpkAf0u21yPj8DOlUixn9NR1aoURLKxFc1WiwjrFPrVxOAKf5UbiJx39t/8Dz5jT
         ZwPGgfft+ER8lPeZzFD1v0CQRDoEl7ehn9dZYXUqD0p79/q0QEgiPE6nWpz7t6BMXhwF
         jfmKtDLhFy3aVmB5LmXG3VgKChzEQbvaMqVy+AGf9cAxW9Sb3QHoYAbdTtjTRlfVRklT
         2yZA7INgiKYonhkPE51/YlJm1FWR2AemX4fpKICC9TYB/LsXBLgd6TYnoj7iGx7gS/Rb
         pPm5qg3b2KzeuErA+NJmw/bUp9pPGeCqF17Ho9D1pc5PXs0aWuLqLn6KGpkdi/1OhhAA
         CdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tYu84XEdUSREmqYuOdJdmWRVylLsrzssqO4s6Rt4FM=;
        b=NmkfYFPN2NuZeDlerPsgLJhVtA9legCADyFXZLZJ976g1riLlUwNSH8Y4WGhrAD1Wg
         5OiIj6CHG03QtdvJPTCvzNE7m8+aWEOVsOfoxmKMBWs87CmVwfMUIIRRrkDq2REFbEyg
         2WlyRPgb88wEDZ2fl5VEveRCc8cDPCqNKjjblexw7JIGo22lv2OQQNw1xh58X65AFh6a
         BPWViPXSXJbgc/MuIL2/rDzGny50NNEPAtkbR88TAuFa+90XJHcrs1r3azUJwPSxRcp7
         usbIWAZSk3d11gKT1NH7+/q8UpOtYs4oILwCKWdr4c9Lm1XbtUJ1Rsa65C4csY8BhNMA
         z1Dg==
X-Gm-Message-State: AOAM532MopJGhD7LnRc8G4h/ez3rCL9XlHRagh40E9WiE2ii3iU6Zrb6
        1hrx1w/pJwQ30gJuk+Vn6KdoSjz6zZrsjg==
X-Google-Smtp-Source: ABdhPJxBuw05znOQnIu8WhxlpMLB4/v32lhm44FXCUfzaGCOZA2x1XW5M0Hi3oGGlUfoNsjg5AoA/Q==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr4475789wmk.118.1622629069181;
        Wed, 02 Jun 2021 03:17:49 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Scott Snyder <snyder@fnald0.fnal.gov>,
        Erik Andersen <andersee@debian.org>,
        Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
Subject: [PATCH 16/21] ide: ide-cd: Demote kernel-doc abuse
Date:   Wed,  2 Jun 2021 11:17:17 +0100
Message-Id: <20210602101722.2276638-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-cd.c:285: warning: Function parameter or member 'drive' not described in 'cdrom_decode_status'
 drivers/ide/ide-cd.c:285: warning: Function parameter or member 'stat' not described in 'cdrom_decode_status'
 drivers/ide/ide-cd.c:285: warning: expecting prototype for Returns(). Prototype was for cdrom_decode_status() instead

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Scott Snyder <snyder@fnald0.fnal.gov>
Cc: Erik Andersen <andersee@debian.org>
Cc: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-cd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index cffbcc27a34cc..5adbb22116fe1 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -275,7 +275,7 @@ static void ide_cd_free_sense(ide_drive_t *drive)
 	drive->sense_rq_armed = false;
 }
 
-/**
+/*
  * Returns:
  * 0: if the request should be continued.
  * 1: if the request will be going through error recovery.
-- 
2.31.1

