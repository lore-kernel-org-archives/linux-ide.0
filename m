From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 06/15] drivers: ide: ide-tape.c removed duplicated
 #include
Date: Thu, 5 Aug 2010 16:27:36 +0200
Message-ID: <20100805142736.GA25859@a1.tnic>
References: <1281016299-23958-1-git-send-email-andrea.gelmini@gelma.net>
 <1281016299-23958-6-git-send-email-andrea.gelmini@gelma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35450 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756867Ab0HEO1k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Aug 2010 10:27:40 -0400
Content-Disposition: inline
In-Reply-To: <1281016299-23958-6-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: gelma@gelma.net, "David S. Miller" <davem@davemloft.net>, Borislav Petkov <petkovbb@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Thu, Aug 05, 2010 at 03:51:30PM +0200

Hi,

> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  drivers/ide/ide-tape.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index b072328..24d0332 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -35,7 +35,6 @@
>  #include <linux/slab.h>
>  #include <linux/pci.h>
>  #include <linux/ide.h>
> -#include <linux/smp_lock.h>
>  #include <linux/completion.h>
>  #include <linux/bitops.h>
>  #include <linux/mutex.h>

I don't see the duplicates, are you sure about this?

-- 
Regards/Gruss,
Boris.
