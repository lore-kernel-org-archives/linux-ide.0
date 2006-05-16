From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] Make number of IDE interfaces configurable
Date: Tue, 16 May 2006 18:02:50 +0200
Message-ID: <20060516160250.GE5677__20340.5228247449$1147796424$gmane$org@stusta.de>
References: <20060512222952.GQ6616@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23558 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751657AbWEPQSR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 12:18:17 -0400
Content-Disposition: inline
In-Reply-To: <20060512222952.GQ6616@waste.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl, liux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 05:29:52PM -0500, Matt Mackall wrote:
>...
> --- 2.6.orig/include/linux/ide.h	2006-05-11 15:07:32.000000000 -0500
> +++ 2.6/include/linux/ide.h	2006-05-12 14:01:53.000000000 -0500
> @@ -252,7 +252,8 @@ static inline void ide_std_init_ports(hw
>  
>  #include <asm/ide.h>
>  
> -#ifndef MAX_HWIFS
> +#if !defined(MAX_HWIFS) || defined(CONFIG_EMBEDDED)
> +#undef MAX_HWIFS
>  #define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
>  #endif

Why do you need this?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

