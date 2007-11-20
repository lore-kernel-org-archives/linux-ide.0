From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/21] ide: move CONFIG_IDE_ETRAX to drivers/ide/Kconfig
Date: Wed, 21 Nov 2007 00:10:47 +0100
Message-ID: <200711210010.47772.bzolnier@gmail.com>
References: <200711182317.04300.bzolnier@gmail.com> <4741DE33.3000904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:58713 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbXKTXGW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Nov 2007 18:06:22 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1276549ugc
        for <linux-ide@vger.kernel.org>; Tue, 20 Nov 2007 15:06:21 -0800 (PST)
In-Reply-To: <4741DE33.3000904@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Mikael Starvik <starvik@axis.com>

On Monday 19 November 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Move ETRAX_IDE and friends from arch/cris/arch-{v10,v32}/drivers/Kconfig
> >   to drivers/ide/Kconfig.
> 
> > * Don't force selecting ide-disk and ide-cd device drivers
> >   (please handle this through defconfig if necessary).
> 
> > * Make ETRAX_IDE depend on BROKEN for the time being
> >   (it doesn't even compile currently).
> 
> > Cc: Mikael Starvik <starvik@axis.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/Kconfig
> > ===================================================================
> > --- a/drivers/ide/Kconfig
> > +++ b/drivers/ide/Kconfig
> > @@ -870,6 +870,41 @@ config BLK_DEV_IDE_BAST
> >  	  Say Y here if you want to support the onboard IDE channels on the
> >  	  Simtec BAST or the Thorcom VR1000
> >  
> > +config ETRAX_IDE
> > +	bool "ETRAX IDE support"
> > +	depends on CRIS && BROKEN
> > +	select BLK_DEV_IDEDMA
> 
>     Shouldn't it be the other way around, i.e. BLK_DEV_IDEDMA is enabled by 
> ETRAX_IDE as is the case with this option otherwise?

Well, having a simple

config BLK_DEV_IDEDMA
	bool

and making the other options select it seems to be a better solution.

Thanks,
Bart
