From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: ide/arm/bast-ide.c compile error
Date: Sun, 10 Feb 2008 11:36:56 +0000
Message-ID: <20080210113656.GA3678@flint.arm.linux.org.uk>
References: <20080209001515.GF6505@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53261 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333AbYBJLhn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 06:37:43 -0500
Content-Disposition: inline
In-Reply-To: <20080209001515.GF6505@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>, Simtec Support <support@simtec.co.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

FYI, from maintainers:

SIMTEC EB2410ITX (BAST)
P:      Ben Dooks
P:      Vincent Sanders
M:      support@simtec.co.uk
W:      http://www.simtec.co.uk/products/EB2410ITX/
S:      Supported

On Sat, Feb 09, 2008 at 02:15:15AM +0200, Adrian Bunk wrote:
> Commit 9e016a719209d95338e314b46c3012cc7feaaeec causes the following 
> compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/ide/arm/bast-ide.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/arm/bast-ide.c: In function 'bastide_register':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/arm/bast-ide.c:31: error: 'hwif' redeclared as different kind of symbol
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/arm/bast-ide.c:29: error: previous definition of 'hwif' was here
> make[4]: *** [drivers/ide/arm/bast-ide.o] Error 1
> 
> <--  snip  -->
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
