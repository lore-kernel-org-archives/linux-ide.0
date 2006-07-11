From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: PATCH: Move IDE to unmaintained, drop reference to old git tree
Date: Tue, 11 Jul 2006 22:20:35 +0200
Message-ID: <58cb370e0607111320u6ac331ddk20eda0ea1bcab02a@mail.gmail.com>
References: <1152014372.28597.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:33921 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750948AbWGKUUl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jul 2006 16:20:41 -0400
Received: by py-out-1112.google.com with SMTP id t32so4304818pyc
        for <linux-ide@vger.kernel.org>; Tue, 11 Jul 2006 13:20:36 -0700 (PDT)
In-Reply-To: <1152014372.28597.39.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

On 7/4/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Bart's git IDE tree ends at 2.6.15-rc5 and he doesn't appear to have
> posted anything since April 7th.
>
> Cc'd in case he's still around or someone knows where he is or has
> gone ?

I'm still around but I've had no time and motivation to do IDE stuff lately.
For me git tree is over, IDE - don't know yet (I'll decide after OLS2006).

Bart

> Signed-off-by: Alan Cox <alan@redhat.com>
>
> --- linux.vanilla-2.6.17/MAINTAINERS    2006-06-19 17:29:44.000000000 +0100
> +++ linux-2.6.17/MAINTAINERS    2006-07-04 12:23:06.244268008 +0100
> @@ -1286,8 +1286,7 @@
>  M:     B.Zolnierkiewicz@elka.pw.edu.pl
>  L:     linux-kernel@vger.kernel.org
>  L:     linux-ide@vger.kernel.org
> -T:     git kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git
> -S:     Maintained
> +S:     Unmaintained
>
>  IDE/ATAPI CDROM DRIVER
>  P:     Jens Axboe
