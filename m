Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A60EC63697
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444F32076E
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 16:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sP2lOmN3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1sxM/Vfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgKMQKe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgKMQKd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2020 11:10:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66211C0617A7
        for <linux-ide@vger.kernel.org>; Fri, 13 Nov 2020 08:10:33 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605283831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1w3yjPRtORE4NOObQSdQ4B9t7jLlM7676y+/oFEEmaY=;
        b=sP2lOmN3Mpyie297gMiayh6rEui1hL+XRvLYpAKJAejrLVx67XR6SREXJmJYOm6EEUFVy1
        JQKbLJuFutHQ9KaBX+IHoepZMUTEr8qL6jVIv5BpNNgVq3Fb08nBoMwF4NkZBqLidRUkyc
        Z6sEhRPoiy7fAcVw00fDVaLRmapaW1iZ+zHOiwCRQ7EJWQHMpIsvGsh2zBg02r2XRdXxYE
        eXcIMvj9FVUeAvTmmgmGhLwZfXbACuQ+5DbH075yfl6we67uEU0X6RYhg+a6fUyalzRRrC
        EiHAn3Dom8qeGARpe8R6QJNkuIQHnsNID7D0et17LnyH2PcfgcV+Vnitwedj2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605283831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1w3yjPRtORE4NOObQSdQ4B9t7jLlM7676y+/oFEEmaY=;
        b=1sxM/VfsPpp3PYsgiq+HtZVs/29n9HnDocrukQWU3AZ6E3ATtenRYwTimhzOEQfI6OTKNU
        NFFUK0TM8jpz85Dg==
To:     linux-ide@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 2/2] ide: Remove BUG_ON(in_interrupt() || irqs_disabled()) from ide_unregister()
Date:   Fri, 13 Nov 2020 17:10:21 +0100
Message-Id: <20201113161021.2217361-3-bigeasy@linutronix.de>
In-Reply-To: <20201113161021.2217361-1-bigeasy@linutronix.de>
References: <20201113161021.2217361-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Both BUG_ON() were introduced in commit
   4015c949fb465 ("[PATCH] update ide core")

when ide_unregister() was extended with semaphore based locking. Both
checks won't complain about disabled preemption which is also wrong.

The might_sleep() in today's mutex_lock() will complain about the
missuses.

Remove the BUG_ON() statements.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/ide/ide-probe.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 1c1567bb51942..aefd74c0d8628 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1539,9 +1539,6 @@ EXPORT_SYMBOL_GPL(ide_port_unregister_devices);
=20
 static void ide_unregister(ide_hwif_t *hwif)
 {
-	BUG_ON(in_interrupt());
-	BUG_ON(irqs_disabled());
-
 	mutex_lock(&ide_cfg_mtx);
=20
 	if (hwif->present) {
--=20
2.29.2

