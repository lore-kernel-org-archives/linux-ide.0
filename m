Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A82C2D0E4
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 22:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4096D2240C
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 22:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BWK7MRbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgKTWfi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 20 Nov 2020 17:35:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbgKTWfh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 20 Nov 2020 17:35:37 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF9C22269;
        Fri, 20 Nov 2020 22:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1605911737;
        bh=Y4cvf5RC2ssuhHBYS3IqmrRFACKno+MLsJ+UiiiI9EE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BWK7MRbx0TVoEVvaVs6pfp/+TZ1QqJE/6/OKxUhXYp45dRn/QWhD5XO1+FkPN/nRO
         DVX0eYrkHD07pqr+Vw8tfJnkY2SRyC/gDUVSpnLhZVyaaZgXRQBOUw3eALk2CtIX6/
         NIME6h/eVqVpxbISd7+hDpxc/kvrmTX/+x1CtNoI=
Date:   Fri, 20 Nov 2020 14:35:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>, tglx@linutronix.de
Subject: Re: [PATCH v2 1/2] ide/Falcon: Remove in_interrupt() usage.
Message-Id: <20201120143535.fa533caeb5486f8c3abd605a@linux-foundation.org>
In-Reply-To: <20201120092421.1023428-2-bigeasy@linutronix.de>
References: <20201120092421.1023428-1-bigeasy@linutronix.de>
        <20201120092421.1023428-2-bigeasy@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, 20 Nov 2020 10:24:20 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> falconide_get_lock() is called by ide_lock_host() and its caller
> (ide_issue_rq()) has already a might_sleep() check.
> 
> stdma_lock() has wait_event() which also has a might_sleep() check.
> 
> Remove the in_interrupt() check.
> 
> ...
>
> --- a/drivers/ide/falconide.c
> +++ b/drivers/ide/falconide.c
> @@ -51,8 +51,6 @@ static void falconide_release_lock(void)
>  static void falconide_get_lock(irq_handler_t handler, void *data)
>  {
>  	if (falconide_intr_lock == 0) {
> -		if (in_interrupt() > 0)
> -			panic("Falcon IDE hasn't ST-DMA lock in interrupt");
>  		stdma_lock(handler, data);
>  		falconide_intr_lock = 1;
>  	}

The current mainline falconide_get_lock() is very different:

static void falconide_release_lock(void)
{
	if (falconide_intr_lock == 0) {
		printk(KERN_ERR "%s: bug\n", __func__);
		return;
	}
	falconide_intr_lock = 0;
	stdma_release();
}

