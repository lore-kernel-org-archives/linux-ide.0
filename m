Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFEDC63798
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 09:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D446E22226
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 09:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yi6nX2m7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0cT/CpDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbgKTJYc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 20 Nov 2020 04:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKTJYa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Nov 2020 04:24:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D0EC0613CF;
        Fri, 20 Nov 2020 01:24:30 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605864268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evkJle6KQ9RlDyKInI5DtbsECAQK8KNp1Yio1JQMV00=;
        b=Yi6nX2m7fbZRrygQjLRv5tbqGP81pIzZWcXojuCrSe17eOzUdkoNkBNW4kUD7PZkXwS/Vs
        agg1szSQdGlMnQx/lwZueN+BUciAU8epGOyUcwhstybg9obJgR7GUJz/pKeCI/hRn4+of6
        IQaNhIPwEQbEFgVoHGrIusCfQMak7o6Mt1Gr5gMMN28FUxH1hgZHgc2Oh4RtJ6omnMT8o4
        Gnr+O796UplowgglDamd9lzsdvtf0QaXZtB230sKhXgWzDJmdDnaVn3jpdCaog5b/6t8CN
        GA5zH0geW2+6MSv9bXeJ9m5vaw739sQ0PbY4iW2IvQ639XLBHxmVPinssBRpwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605864268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evkJle6KQ9RlDyKInI5DtbsECAQK8KNp1Yio1JQMV00=;
        b=0cT/CpDhQeZhbJmJTE8TevQNJ5tx/nGAYTShn7Z0lJbaM4l2FjMxiyxwa46NqxkAjTJ9B2
        B3Klg8UZLVejiDAQ==
To:     linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/2] ide/Falcon: Remove in_interrupt() usage.
Date:   Fri, 20 Nov 2020 10:24:20 +0100
Message-Id: <20201120092421.1023428-2-bigeasy@linutronix.de>
In-Reply-To: <20201120092421.1023428-1-bigeasy@linutronix.de>
References: <20201120092421.1023428-1-bigeasy@linutronix.de>
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
Acked-by: Jens Axboe <axboe@kernel.dk>
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

