From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] ide: use MODULE_VERSION()
Date: Tue, 1 Jan 2008 19:33:43 +0100
Message-ID: <200801011933.43930.bzolnier@gmail.com>
References: <200801011840.38757.bzolnier@gmail.com> <20080101175333.GA27566@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:2669 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbYAASWv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jan 2008 13:22:51 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2429211ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 01 Jan 2008 10:22:50 -0800 (PST)
In-Reply-To: <20080101175333.GA27566@does.not.exist>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 01 January 2008, Adrian Bunk wrote:
> On Tue, Jan 01, 2008 at 06:40:38PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > * Replace driver versions in comments by DRV_VERSION define.
> > 
> > * Add MODULE_VERSION(DRV_VERSION) to drivers defining DRV_VERSION.
> >...
> 
> Could you limit this to actively maintained version numbers and also 
> remove the others from .version, printk's,...?
> 
> An example:
> 
> > --- a/drivers/ide/legacy/umc8672.c
> > +++ b/drivers/ide/legacy/umc8672.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - *  linux/drivers/ide/legacy/umc8672.c		Version 0.05	Jul 31, 1996
> > + *  linux/drivers/ide/legacy/umc8672.c
> >   *
> >   *  Copyright (C) 1995-1996  Linus Torvalds & author (see below)
> >   */
> > @@ -53,6 +53,8 @@
> >  
> >  #include <asm/io.h>
> >  
> > +#define DRV_VERSION	"0.05"
> > +
> >  /*
> >   * Default speeds.  These can be changed with "auto-tune" and/or hdparm.
> >   */
> > @@ -185,3 +187,4 @@ module_init(umc8672_init);
> >  MODULE_AUTHOR("Wolfram Podien");
> >  MODULE_DESCRIPTION("Support for UMC 8672 IDE chipset");
> >  MODULE_LICENSE("GPL");
> > +MODULE_VERSION(DRV_VERSION);
> >...
> 
> I do not see any value in printing a version number from 1996 (sic),
> and the driver has for sure changed without any update of the 
> version number.
> 
> For actively maintained version numbers (and even more when 
> distributions backport more recent versions of a driver) printing a 
> (maintained) driver version number makes sense, but otherwise the kernel 
> version contains more information and a stale version number only gives 
> the false impression the driver hadn't changed.

Good point.

On the second thought: maybe we will be better off with limiting
MODULE_VERSION() to the device drivers and the IDE core module for now,
and just removing all these private version numbers from host drivers
(with one or two exceptions they are not printed or exported currently,
moreover exceptions are the cases like stale version numbers from 199x)?

Bart
