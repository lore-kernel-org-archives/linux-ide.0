From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH 1/3] ide: use MODULE_VERSION()
Date: Tue, 1 Jan 2008 19:53:34 +0200
Message-ID: <20080101175333.GA27566@does.not.exist>
References: <200801011840.38757.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755906AbYAARx6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200801011840.38757.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jan 01, 2008 at 06:40:38PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> * Replace driver versions in comments by DRV_VERSION define.
> 
> * Add MODULE_VERSION(DRV_VERSION) to drivers defining DRV_VERSION.
>...

Could you limit this to actively maintained version numbers and also 
remove the others from .version, printk's,...?

An example:

> --- a/drivers/ide/legacy/umc8672.c
> +++ b/drivers/ide/legacy/umc8672.c
> @@ -1,5 +1,5 @@
>  /*
> - *  linux/drivers/ide/legacy/umc8672.c		Version 0.05	Jul 31, 1996
> + *  linux/drivers/ide/legacy/umc8672.c
>   *
>   *  Copyright (C) 1995-1996  Linus Torvalds & author (see below)
>   */
> @@ -53,6 +53,8 @@
>  
>  #include <asm/io.h>
>  
> +#define DRV_VERSION	"0.05"
> +
>  /*
>   * Default speeds.  These can be changed with "auto-tune" and/or hdparm.
>   */
> @@ -185,3 +187,4 @@ module_init(umc8672_init);
>  MODULE_AUTHOR("Wolfram Podien");
>  MODULE_DESCRIPTION("Support for UMC 8672 IDE chipset");
>  MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
>...

I do not see any value in printing a version number from 1996 (sic),
and the driver has for sure changed without any update of the 
version number.

For actively maintained version numbers (and even more when 
distributions backport more recent versions of a driver) printing a 
(maintained) driver version number makes sense, but otherwise the kernel 
version contains more information and a stale version number only gives 
the false impression the driver hadn't changed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

