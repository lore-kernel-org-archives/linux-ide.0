Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CADC63697
	for <linux-ide@archiver.kernel.org>; Sat, 21 Nov 2020 12:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C934C2245F
	for <linux-ide@archiver.kernel.org>; Sat, 21 Nov 2020 12:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vVIaU4KT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HTbQbhST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgKUMoa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 21 Nov 2020 07:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgKUMoa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 21 Nov 2020 07:44:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8AAC0613CF;
        Sat, 21 Nov 2020 04:44:29 -0800 (PST)
Date:   Sat, 21 Nov 2020 13:44:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605962665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3JgvCM546ovpbDedKqjj0qgeJF/wEzSc2VuDzZWEIeg=;
        b=vVIaU4KTYY0QZAbC0UQweTZrK+ugmnFDqAdG4pVkcxdcHMsf6Ncdoj4KmyIT7aMLNhZsL3
        Af7Yd95iylfsUQTtfG5I+QustBmbd4dr07s99L2tioQ800NY9ZH3Vsr0u6UqjZ4ALblvMi
        FbuOkP+1hiizgdM9j7DpnhU9NqouiVMkmyprkDzc+jOEZ2r2zVYDNB3toPe6QY2YsC5a1Y
        6jC0KZ8SOyfeyfiUle1o9kdInKOMQXwMDKFIBXaxP3oNMFJ4oZpS6rQ/9JmO9NtUCZFetn
        AToqdKGGBxjbwk1qnOhEDJv9aI6SliYMyMvoaX7oX6pxOSXgoTvbxdx0jlTx4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605962665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3JgvCM546ovpbDedKqjj0qgeJF/wEzSc2VuDzZWEIeg=;
        b=HTbQbhSTYSAdAh2GB/XgYDeewKXgX/cBppUU2j1e+UxdY3XTrRrLuDNzcJNzBBImyrFZyo
        rBQ3G9BSdnwbpdDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>, tglx@linutronix.de
Subject: Re: [PATCH v2 1/2] ide/Falcon: Remove in_interrupt() usage.
Message-ID: <20201121124424.oyr74bwxvwmvxln2@linutronix.de>
References: <20201120092421.1023428-1-bigeasy@linutronix.de>
 <20201120092421.1023428-2-bigeasy@linutronix.de>
 <20201120143535.fa533caeb5486f8c3abd605a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120143535.fa533caeb5486f8c3abd605a@linux-foundation.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2020-11-20 14:35:35 [-0800], Andrew Morton wrote:
> On Fri, 20 Nov 2020 10:24:20 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > falconide_get_lock() is called by ide_lock_host() and its caller
> > (ide_issue_rq()) has already a might_sleep() check.
> > 
> > stdma_lock() has wait_event() which also has a might_sleep() check.
> > 
> > Remove the in_interrupt() check.
> > 
> > ...
> >
> > --- a/drivers/ide/falconide.c
> > +++ b/drivers/ide/falconide.c
> > @@ -51,8 +51,6 @@ static void falconide_release_lock(void)
> >  static void falconide_get_lock(irq_handler_t handler, void *data)
> >  {
> >  	if (falconide_intr_lock == 0) {
> > -		if (in_interrupt() > 0)
> > -			panic("Falcon IDE hasn't ST-DMA lock in interrupt");
> >  		stdma_lock(handler, data);
> >  		falconide_intr_lock = 1;
> >  	}
> 
> The current mainline falconide_get_lock() is very different:

I have this patch on-top of next-20201120 so it should apply. You
realize that the above hunk is against falconide_get_lock() while
the below is falconide_release_lock().
If there is something wrong with the patch (or its commit message) I'm
sorry but I don't understand your signal :)

> static void falconide_release_lock(void)
> {
> 	if (falconide_intr_lock == 0) {
> 		printk(KERN_ERR "%s: bug\n", __func__);
> 		return;
> 	}
> 	falconide_intr_lock = 0;
> 	stdma_release();
> }

Sebastian
