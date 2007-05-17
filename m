From: Paul Sokolovsky <pmiscml@gmail.com>
Subject: Re: [PATCH] ide.c: microscopic size and readability optimization
Date: Thu, 17 May 2007 14:33:54 +0300
Message-ID: <1726326841.20070517143354@gmail.com>
References: <20070517112554.GA32183@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:62540 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370AbXEQLd6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 07:33:58 -0400
Received: by nz-out-0506.google.com with SMTP id r28so914808nza
        for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 04:33:57 -0700 (PDT)
In-Reply-To: <20070517112554.GA32183@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Hello Borislav,

Thursday, May 17, 2007, 2:25:54 PM, you wrote:

> -----
> From: bbpetkov@yahoo.de

> A very small size (object file 432 bytes smaller) and readability optimization of ide.c

        And how these "optimizations" fit with BUG_ON() purpose - to
be able to easily identify cause and place of the failure? You
could just remove them altogether and claim that you did even "better"
"optimization".

> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

> --
> Index: 22-rc1/drivers/ide/ide.c
> ===================================================================
> --- 22-rc1/drivers/ide/ide.c.orig
> +++ 22-rc1/drivers/ide/ide.c
> @@ -568,10 +568,8 @@ void ide_unregister(unsigned int index)
>         ide_hwgroup_t *hwgroup;
>         int irq_count = 0, unit;

> -       BUG_ON(index >= MAX_HWIFS);
> +       BUG_ON(index >= MAX_HWIFS || in_interrupt() || irqs_disabled());

> -       BUG_ON(in_interrupt());
> -       BUG_ON(irqs_disabled());
>         down(&ide_cfg_sem);



-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com

