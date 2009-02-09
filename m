From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide.c 'clear' fix, ide=nodma documentation
Date: Mon, 9 Feb 2009 20:57:54 +0100
Message-ID: <200902092057.54850.bzolnier@gmail.com>
References: <20090208220956.GA3278@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:38217 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbZBIT5l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2009 14:57:41 -0500
In-Reply-To: <20090208220956.GA3278@spacedout.fries.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Fries <david@fries.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Sunday 08 February 2009, David Fries wrote:
> From: David Fries <david@fries.net>
> 
> Documentation/kernel-parameters.txt
> ide=nodma is no longer valid
> 
> drivers/ide/Kconfig
> the module is ide-core.ko not ide
> 
> drivers/ide/ide.c
> It took me a while to figure out what the arguments %d.%d:%d to nodma
> module parameter ment, so I added a comment to each.

This is documented in Documentation/ide/ide.txt however having
more documentation won't hurt.

> Added a comment to each of the sscanf lines to
> There is a bug, if j is 0 it would previously clear all the other bits
> except the current device, changed in three different places.
> mask &= (1 << i)     should be     mask &= ~(1 << i)

Good catch.

> Signed-off-by: David Fries <david@fries.net>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied, thanks!

> ---
> I pretty much wasted my Saturday on this.  This is an older VIA
> vt82c586b (rev 41) IDE UDMA33 and I've seen disk corruption in the
> past with dma enabled, I can't use hdparm because those settings don't
> persist across hibernate and restore (that should be another bug
> report).  ide=nodma was working on the last 2.6.24 kernel, and
> kernel-parameters.txt still lists it.  I had to go through the change
> logs to figure out what happened to ide=nodma, then ide.c to figure
> out what replaced it and what %d.%d:%d means (so I documented it so
> other would have an easier time), then figure out how to set a module
> parameter on the kernel command line when Kconfig said the module name
> was ide and ide.nodma=0.0 didn't work, it was ide-core.nodma=0.0.
> 
> Now instead of,
> ide=nodma
> I have the following.
> ide-core.nodma=0.0 ide-core.nodma=0.1 ide-core.nodma=1.0 ide-core.nodma=1.1

The important question is why do you have to use debug "=nodma" option?

Is the corruption present in any recent kernels?

What disk is it?  Do we need to add it to DMA blacklist?

I don't recall any reports about such issues and via82cxxx host driver,
have you tried to verify that this is not a faulty hardware?

> Where else is hdc written 1.0 ?  Why doesn't it take ide-core.nodma=hdc ?

- simpler code, without parsing of parameters

- no dependence on legacy /dev/hd* naming

- makes people think harder about reporting/investigating issues instead of
  covering them up with using debug kernel parameters ;-)

[...]

> --- a/drivers/ide/ide.c
> +++ b/drivers/ide/ide.c
> @@ -337,6 +337,7 @@ static int ide_set_dev_param_mask(const char *s, struct kernel_param *kp)
>  	int a, b, i, j = 1;
>  	unsigned int *dev_param_mask = (unsigned int *)kp->arg;
>  
> +	/* controller . disk (0 or 1) [ : 1 (set) | 0 (clear) ] */

I did s/disk/device/ here and in other places while merging the patch.

Thanks,
Bart
