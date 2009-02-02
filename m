From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Unregister devices if initialization fails.
Date: Mon, 2 Feb 2009 18:49:32 +0100
Message-ID: <200902021849.33036.bzolnier@gmail.com>
References: <1232715869-31039-1-git-send-email-Ian.Campbell@citrix.com> <200902011721.58648.bzolnier@gmail.com> <1233569381.9970.60.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:50228 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbZBBSgy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Feb 2009 13:36:54 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1333816fkf.5
        for <linux-ide@vger.kernel.org>; Mon, 02 Feb 2009 10:36:51 -0800 (PST)
In-Reply-To: <1233569381.9970.60.camel@zakaz.uk.xensource.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: linux-ide@vger.kernel.org

On Monday 02 February 2009, Ian Campbell wrote:
> On Sun, 2009-02-01 at 17:21 +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Friday 30 January 2009, Ian Campbell wrote:
> > > On Tue, 2009-01-27 at 17:41 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > Hi,
> > > > 
> > > > On Friday 23 January 2009, Ian Campbell wrote:
> > > > > On reboot the loop in device_shutdown gets confused by these devices
> > > > > and goes into an infinite loop. I think this is because they don't
> > > > > have dev->bus or dev->driver which is because hwif_register_devices
> > > > > doesn't get called if !hwif->present.
> > > > > 
> > > > > Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> > > > > Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > > > ---
> > > > >  drivers/ide/ide-probe.c |   10 ++++++----
> > > > >  1 files changed, 6 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> > > > > index 312127e..120f65b 100644
> > > > > --- a/drivers/ide/ide-probe.c
> > > > > +++ b/drivers/ide/ide-probe.c
> > > > > @@ -1520,6 +1520,8 @@ int ide_host_register(struct ide_host *host, const struct ide_port_info *d,
> > > > >  		if (hwif_init(hwif) == 0) {
> > > > >  			printk(KERN_INFO "%s: failed to initialize IDE "
> > > > >  					 "interface\n", hwif->name);
> > > > > +			device_unregister(&hwif->gendev);
> > > > > +			device_destroy(ide_port_class, MKDEV(0, 0));
> > > > >  			hwif->present = 0;
> > > > 
> > > > I've been wondering about this a bit and I think that we should just nuke
> > > > port from struct ide_host in such situation so I added ide_disable_port()
> > > > helper for this (+ fixed ide_register_port() handling while at it).
> > > > 
> > > > Could you please re-base your fix on top of attached patch?
> > > 
> > > Sure.
> > > 
> > > Subject: IDE: Disable and unregister devices if initialization fails.
> > > 
> > > On reboot the loop in device_shutdown gets confused by these partially
> > > initialized devices and goes into an infinite loop. Therefore disable
> > > and unregister these devices.
> > > 
> > > Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> > > 
> > > ---
> > >  drivers/ide/ide-probe.c |   10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff -r 12d1a7848ddf drivers/ide/ide-probe.c
> > > --- a/drivers/ide/ide-probe.c	Fri Jan 30 16:37:15 2009 +0000
> > > +++ b/drivers/ide/ide-probe.c	Fri Jan 30 17:00:08 2009 +0000
> > > @@ -1549,6 +1549,8 @@
> > >  		if (hwif_init(hwif) == 0) {
> > >  			printk(KERN_INFO "%s: failed to initialize IDE "
> > >  					 "interface\n", hwif->name);
> > > +			ide_disable_port(hwif);
> > > +			device_unregister(&hwif->gendev);
> > >  			hwif->present = 0;
> > >  			continue;
> > 
> > Hmmm, ide_disable_port() may free hwif so it needs to happen last...
> 
> Oops, new version below.
> 
> > Also did you have a chance to retest this? [ I couldn't reproduce
> > the issue so was hoping that you could test combined fixes. ]
> 
> Yep, I can easily repro. I've actually fixed the underlying issue (a Xen
> IRQ problem) causing the probe to fail but can easily revert that fix to
> test these patches. If you wanted to repro yourself you could probably
> make the request_irq() in init_irq() artificially fail.
> 
> Ian.

Ok, thanks for explaining this (I get "The Big Picture" now).

> IDE: Disable and unregister devices if initialization fails.
> 
> On reboot the loop in device_shutdown gets confused by these partially
> initialized devices and goes into an infinite loop. Therefore disable
> and unregister these devices.
> 
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> ---
>  drivers/ide/ide-probe.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> 
> diff -r 9d5441419978 -r f596f17b02c3 drivers/ide/ide-probe.c
> --- a/drivers/ide/ide-probe.c	Fri Jan 30 17:39:53 2009 +0000
> +++ b/drivers/ide/ide-probe.c	Mon Feb 02 10:02:32 2009 +0000
> @@ -1549,6 +1549,8 @@
>  		if (hwif_init(hwif) == 0) {
>  			printk(KERN_INFO "%s: failed to initialize IDE "
>  					 "interface\n", hwif->name);
> +			device_unregister(&hwif->gendev);
> +			ide_disable_port(hwif);
>  			hwif->present = 0;

I applied the patch (removing leftover hwif->present while at it)
and sucessfully tested it locally (by making hwif_init() to fail).

Thanks,
Bart
