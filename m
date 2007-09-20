From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] [POWERPC] Fix build errors when BLOCK=n
Date: Thu, 20 Sep 2007 10:58:46 +1000
Message-ID: <18161.50630.769910.207866@cargo.ozlabs.ibm.com>
References: <1190227172-593-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:54090 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbXITBTD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Sep 2007 21:19:03 -0400
In-Reply-To: <1190227172-593-1-git-send-email-Emilian.Medve@Freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
Cc: kumar.gala@Freescale.com, linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, bzolnier@gmail.com, linux-ide@vger.kernel.org

Emil Medve writes:

> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -12,12 +12,15 @@
>  #include <linux/irq.h>
>  #include <linux/pci.h>
>  #include <linux/delay.h>
> +#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
>  #include <linux/ide.h>
> +#endif

Why are we still including linux/ide.h at all here?

>  #include <linux/bitops.h>
>  
>  #include <asm/page.h>
>  #include <asm/semaphore.h>
>  #include <asm/processor.h>
> +#include <asm/cacheflush.h>

What's the point of adding this?

Paul.
