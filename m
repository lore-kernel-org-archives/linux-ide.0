From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] simplify MAX_HWIFS setting
Date: Sun, 27 Jul 2008 16:32:16 +0200
Message-ID: <200807271632.16417.bzolnier@gmail.com>
References: <20080727130448.GK9301@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:18284 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbYG0Ofl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jul 2008 10:35:41 -0400
Received: by mu-out-0910.google.com with SMTP id w8so4422513mue.1
        for <linux-ide@vger.kernel.org>; Sun, 27 Jul 2008 07:35:39 -0700 (PDT)
In-Reply-To: <20080727130448.GK9301@cs181140183.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 27 July 2008, Adrian Bunk wrote:
> The sh systemh_defconfig currently fails to build with the following 
> error:
> 
> <--  snip  -->
> 
> ...
>   CC      arch/sh/boards/renesas/systemh/irq.o
> In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/boards/renesas/systemh/irq.c:16:
> /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/ide.h:645: error: 'CONFIG_IDE_MAX_HWIFS' undeclared here (not in a function)
> make[2]: *** [arch/sh/boards/renesas/systemh/irq.o] Error 1

Please also fix the source root of the problem:

arch/sh/boards/renesas/systemh/irq.c should have no bussiness in
including include/linux/ide.h (which is for drivers/ide/ _only_)

> <--  snip  -->
> 
> Considering the little benefits of all this fiddling with IDE_MAX_HWIFS 
> I decided to fix it through a simplification:
> - always #define MAX_HWIFS      CONFIG_IDE_MAX_HWIFS
> - always set CONFIG_IDE_MAX_HWIFS in kconfig
> - let IDE_MAX_HWIFS default to 10
> - allow changing the value of IDE_MAX_HWIFS only if IDE && EMBEDDED

I was actually wondering whether it is worth to keep IDE_MAX_HWIFS
now that ide_hwif_t instances are allocated dynamically.

[ The difference between MAX_HWIFS == 10 and MAX_HWIFS == 2 is now
  ~100 bytes (x86_32) and between MAX_HWIFS == 10 and MAX_HWIFS == 1
  it is ~1kb (IIRC). ]

Since there were also many other improvements in shrinking drivers/ide/
code size which should keep embedded users happy and compensate for
the above 1kB-worst-case I would prefer to have IDE_MAX_HWIFS removed
completely.

> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 
>  drivers/ide/Kconfig |    9 ++++-----
>  include/linux/ide.h |   11 -----------
>  2 files changed, 4 insertions(+), 16 deletions(-)
> 
> fd8ca9d5fefc48c04caa910adb753924454d9cfc 
> diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
> index 130ef64..174b627 100644
> --- a/drivers/ide/Kconfig
> +++ b/drivers/ide/Kconfig
> @@ -52,18 +52,17 @@ menuconfig IDE
>  
>  	  If unsure, say Y.
>  
> -if IDE
> -
>  config IDE_MAX_HWIFS
> -	int "Max IDE interfaces"
> -	depends on ALPHA || SUPERH || IA64 || EMBEDDED
> +	int "Max IDE interfaces" if IDE && EMBEDDED
>  	range 1 10
> -	default 4
> +	default 10
>  	help
>  	  This is the maximum number of IDE hardware interfaces that will
>  	  be supported by the driver. Make sure it is at least as high as
>  	  the number of IDE interfaces in your system.
>  
> +if IDE
> +
>  config BLK_DEV_IDE
>  	tristate "Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support"
>  	---help---
> diff --git a/include/linux/ide.h b/include/linux/ide.h
> index b846bc4..b5b84fe 100644
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -219,18 +219,7 @@ static inline int __ide_default_irq(unsigned long base)
>  #include <asm-generic/ide_iops.h>
>  #endif
>  
> -#ifndef MAX_HWIFS
> -#if defined(CONFIG_BLACKFIN) || defined(CONFIG_H8300) || defined(CONFIG_XTENSA)
> -# define MAX_HWIFS	1
> -#else
> -# define MAX_HWIFS	10
> -#endif
> -#endif
> -
> -#if !defined(MAX_HWIFS) || defined(CONFIG_EMBEDDED)
> -#undef MAX_HWIFS
>  #define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
> -#endif
>  
>  /* Currently only m68k, apus and m8xx need it */
>  #ifndef IDE_ARCH_ACK_INTR
