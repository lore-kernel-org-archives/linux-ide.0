From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 01/15] ide: include <asm/ide.h> only when needed
Date: Mon, 2 Feb 2009 08:49:16 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0902020847410.11930@anakin>
References: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
 <20090201174916.19144.11318.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753465AbZBBHtc@vger.kernel.org>
In-Reply-To: <20090201174916.19144.11318.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, 1 Feb 2009, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: include <asm/ide.h> only when needed
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-io-std.c |    7 +++++++
>  drivers/ide/tx4938ide.c  |    2 ++
>  drivers/ide/tx4939ide.c  |    2 ++
>  include/linux/ide.h      |    7 -------
>  4 files changed, 11 insertions(+), 7 deletions(-)
> 
> Index: b/drivers/ide/ide-io-std.c
> ===================================================================
> --- a/drivers/ide/ide-io-std.c
> +++ b/drivers/ide/ide-io-std.c
> @@ -2,6 +2,13 @@
>  #include <linux/kernel.h>
>  #include <linux/ide.h>
>  
> +#if defined(CONFIG_ARM) || defined(CONFIG_M68K) || defined(CONFIG_MIPS) || \
> +    defined(CONFIG_PARISC) || defined(CONFIG_PPC) || defined(CONFIG_SPARC)
> +#include <asm/ide.h>
> +#else
> +#include <asm-generic/ide_iops.h>
> +#endif
> +
>  /*
>   *	Conventional PIO operations for ATA devices
>   */
> Index: b/drivers/ide/tx4938ide.c
> ===================================================================
> --- a/drivers/ide/tx4938ide.c
> +++ b/drivers/ide/tx4938ide.c
> @@ -15,6 +15,8 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> +
> +#include <asm/ide.h>

Did you try checkpatch.pl?

    [...]

> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -193,13 +193,6 @@ static inline void ide_std_init_ports(hw
>  	hw->io_ports.ctl_addr = ctl_addr;
>  }
>  
> -#if defined(CONFIG_ARM) || defined(CONFIG_M68K) || defined(CONFIG_MIPS) || \
> -    defined(CONFIG_PARISC) || defined(CONFIG_PPC) || defined(CONFIG_SPARC)
> -#include <asm/ide.h>
> -#else
> -#include <asm-generic/ide_iops.h>
> -#endif
> -
>  #define MAX_HWIFS	10
>  
>  /*

As checkpatch.pl complains about any include of asm/*.h where the corresponding
linux/*.h exists, this `fix' is incompatible with it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
