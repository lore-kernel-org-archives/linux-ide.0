Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AD3C47092
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18C9613B8
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFBKTa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhFBKTX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C0DC06174A
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n4so1722143wrw.3
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QpdMnI6lZJkCsy5Zu72i+Sr+X0vOIx3MmORUdfJ8hyo=;
        b=qo69oY96cVUgH8CpEF59JQYnnYv8mujBkgwt6mI0UM9Ft4rpPiJVpF3/ba9d0F/VWp
         L9FyXSWm1qMTX5tTrEYMOVMoSnt7amQatRyAXHjUrb+Fo0zLT/SkHNEjSVL5CLbo0cwu
         sM94BJzV5T+oXjhDiLZJMmZVUy+9XpegtpAl0AkDWJewnPL6kGFDxX3NBb127iv1JbF6
         depeUZtcFTTJIl1UvHaBEMQnMhbJURuxwlMt+1tCBXKpuYVBInsqz17O2ThoNFiGmtP9
         TosOsEmGLtJ+TEHCtLSJg1rbTa/x3cf2Dl2pwpLsbzHYylMToTjlOWt5qMVdHwJ6pWJ9
         DkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QpdMnI6lZJkCsy5Zu72i+Sr+X0vOIx3MmORUdfJ8hyo=;
        b=nPCG04vobH3/Wu5+JbFspz2i7DCqk+azAJcB4Q8HfGWF6N7yDtbzhzlVKWPQaa8T80
         Lu1rIK1OuIOUwCZjK0JTlnpxg61r74+19mmF76zQ1bVZqa8MGqcgvANXN51jRdngPkis
         CL5IJy5d8Thw/8abO2SSapd++8fNpIitUWPFlbjDsydmSoKzHgQtYsEwb1VgVl15zma9
         8OcY7B/BiyuiUjCm1oMbDPpfJGDqik0/6ewjVarF18jUWVyaw5rowARZx5iXtPMjadcV
         YeKU25sR1oAvRJ2X8qR0tlRj/VBKFphL9gOcyxEHy8J1fNcfqX7ySUD5GtcX7o4Wpp7p
         B1rA==
X-Gm-Message-State: AOAM530Y+k5PkzfyM5gDvCJzHjVAn4KvXiwJNelFk+qaX9BlKJk71pIF
        af0cHm6plSuY7JKqHK/pZ+RfSQ==
X-Google-Smtp-Source: ABdhPJyqhVwJ6SErn3vAKpl//MuZ6EJt1iRS2OS+xAv6VopJ6veIdjnTf69oRlL5y6+EI+yzQuWlgw==
X-Received: by 2002:a5d:59a4:: with SMTP id p4mr33511361wrr.248.1622629057868;
        Wed, 02 Jun 2021 03:17:37 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 04/21] ide: ide-io: Fix a few kernel-doc misdemeanours
Date:   Wed,  2 Jun 2021 11:17:05 +0100
Message-Id: <20210602101722.2276638-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-io.c:268: warning: expecting prototype for execute_drive_command(). Prototype was for execute_drive_cmd() instead
 drivers/ide/ide-io.c:320: warning: Function parameter or member 'drive' not described in 'start_request'
 drivers/ide/ide-io.c:320: warning: Function parameter or member 'rq' not described in 'start_request'
 drivers/ide/ide-io.c:618: warning: Function parameter or member 't' not described in 'ide_timer_expiry'
 drivers/ide/ide-io.c:618: warning: Excess function parameter 'data' description in 'ide_timer_expiry'
 drivers/ide/ide-io.c:775: warning: Excess function parameter 'regs' description in 'ide_intr'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 4867b67b60d69..bd3e78985bcc7 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -252,7 +252,7 @@ void ide_init_sg_cmd(struct ide_cmd *cmd, unsigned int nr_bytes)
 EXPORT_SYMBOL_GPL(ide_init_sg_cmd);
 
 /**
- *	execute_drive_command	-	issue special drive command
+ *	execute_drive_cmd	-	issue special drive command
  *	@drive: the drive to issue the command on
  *	@rq: the request structure holding the command
  *
@@ -309,6 +309,8 @@ static ide_startstop_t ide_special_rq(ide_drive_t *drive, struct request *rq)
 
 /**
  *	start_request	-	start of I/O and command issuing for IDE
+ *	@drive: the drive to issue the command on
+ *	@rq: the request structure holding the command
  *
  *	start_request() initiates handling of a new I/O request. It
  *	accepts commands and I/O (read/write) requests.
@@ -602,7 +604,7 @@ static int drive_is_ready(ide_drive_t *drive)
 
 /**
  *	ide_timer_expiry	-	handle lack of an IDE interrupt
- *	@data: timer callback magic (hwif)
+ *	@t: timer callback magic (hwif)
  *
  *	An IDE command has timed out before the expected drive return
  *	occurred. At this point we attempt to clean up the current
@@ -748,9 +750,7 @@ static void unexpected_intr(int irq, ide_hwif_t *hwif)
 
 /**
  *	ide_intr	-	default IDE interrupt handler
- *	@irq: interrupt number
  *	@dev_id: hwif
- *	@regs: unused weirdness from the kernel irq layer
  *
  *	This is the default IRQ handler for the IDE layer. You should
  *	not need to override it. If you do be aware it is subtle in
-- 
2.31.1

