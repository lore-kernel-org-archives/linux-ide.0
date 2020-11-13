Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD7CC6369E
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9C2208D5
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 16:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qCKhKMuX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JI7mWy+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKMQKe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgKMQKd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2020 11:10:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32405C0617A6
        for <linux-ide@vger.kernel.org>; Fri, 13 Nov 2020 08:10:33 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605283831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AtTI7NFycMlcXCxrx0rhwpmFlRCD+YdkiRGEFXOES9w=;
        b=qCKhKMuXBw9aE8dNEVCXvfu774/HzCHTzrEKWkLDK/Vss2c7EWZDA0SDrG8jw6jcx/7DIH
        Ns4zhQQ7R33PZDUxQdK7M03lfKzXr2qXSnIqwEwE+6mE23iKh7n4yM3u8XjT8wKk8YQLKK
        ANJXJukENLDOUjdB50tfAFjd7/XQ2asmud6DWv4KSN1FhrzocEYb/rQjFI7CScxQXvjMOo
        ccyOctEvwD2QO9sbXhtMNwczqfVJgJakgGWAo54D1h3/Hr+MzE69PyNDcRQDV1yTF5Wu/U
        PcKov0+taEGkFGNyKP58C77aFs2etKTY2jT0TszllWLhbFmK7fqu/XGAjAEi5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605283831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AtTI7NFycMlcXCxrx0rhwpmFlRCD+YdkiRGEFXOES9w=;
        b=JI7mWy+j4k+Cnt5A5ZtrtGSn8spL4EZTf2lW7zZKgXfJFXLJvWwLclXX8D6YHefkXBFCfO
        gqFP2w9m/f1iM+CA==
To:     linux-ide@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 1/2] ide/Falcon: Remove in_interrupt() usage.
Date:   Fri, 13 Nov 2020 17:10:20 +0100
Message-Id: <20201113161021.2217361-2-bigeasy@linutronix.de>
In-Reply-To: <20201113161021.2217361-1-bigeasy@linutronix.de>
References: <20201113161021.2217361-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

falconide_get_lock() is called by ide_lock_host() and its caller
(ide_issue_rq()) has already a might_sleep() check.

stdma_lock() has wait_event() which also has a might_sleep() check.

Remove the in_interrupt() check.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/ide/falconide.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ide/falconide.c b/drivers/ide/falconide.c
index dbeb2605e5f6e..77af4c1a3f38c 100644
--- a/drivers/ide/falconide.c
+++ b/drivers/ide/falconide.c
@@ -51,8 +51,6 @@ static void falconide_release_lock(void)
 static void falconide_get_lock(irq_handler_t handler, void *data)
 {
 	if (falconide_intr_lock =3D=3D 0) {
-		if (in_interrupt() > 0)
-			panic("Falcon IDE hasn't ST-DMA lock in interrupt");
 		stdma_lock(handler, data);
 		falconide_intr_lock =3D 1;
 	}
--=20
2.29.2

