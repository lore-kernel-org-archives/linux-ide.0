From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] ide: remove unused macros from <asm-parisc/ide.h>
Date: Sun, 10 Aug 2008 11:54:37 -0400
Message-ID: <20080810155437.GA6576@phobos.i.cabal.ca>
References: <200808101747.08025.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200808101747.08025.bzolnier@gmail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, linux-parisc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Aug 10, 2008 at 05:47:07PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Cc: Kyle McMartin <kyle@mcmartin.ca>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  include/asm-parisc/ide.h |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: b/include/asm-parisc/ide.h
> ===================================================================
> --- a/include/asm-parisc/ide.h
> +++ b/include/asm-parisc/ide.h
> @@ -13,10 +13,6 @@
>  
>  #ifdef __KERNEL__
>  
> -#define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
> -#define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
> -#define ide_request_region(from,extent,name)	request_region((from), (extent), (name))
> -#define ide_release_region(from,extent)		release_region((from), (extent))
>  /* Generic I/O and MEMIO string operations.  */
>  

Thanks Bart!

Groovy... Want me to merge this, or will you shepherd it in?

Acked-by: Kyle McMartin <kyle@mcmartin.ca>

regards, Kyle
