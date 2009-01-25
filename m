From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Switching from (deprecated) IDE driver -> SATA (PATA support)
Date: Sun, 25 Jan 2009 22:39:25 +0100
Message-ID: <200901252239.26268.bzolnier@gmail.com>
References: <alpine.DEB.1.10.0901250553430.2441@p34.internal.lan> <200901252027.43376.bzolnier@gmail.com> <alpine.DEB.1.10.0901251612310.16676@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:25261 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbZAYVjS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jan 2009 16:39:18 -0500
In-Reply-To: <alpine.DEB.1.10.0901251612310.16676@p34.internal.lan>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 25 January 2009, Justin Piszcz wrote:
> 
> On Sun, 25 Jan 2009, Bartlomiej Zolnierkiewicz wrote:
> 
> > On Sunday 25 January 2009, Justin Piszcz wrote:
> >> When switching (removing IDE support) in favor of the new PATA support
> >> under the SATA menu, is there any best practice/or method of knowing what
> >> the new root hdd will be upon reboot?
> >>
> >> Example:
> >> If I have 10 sata disks and 2 IDE disks on various cards/controllers, how
> >> do I know /dev/hda will become /dev/sda?  In one test on a system I have
> >> here, /dev/hda became /dev/sdb2 after reboot, not an issue if the box is
> >> local, but if the box is remote, how do you cope with this?  I ask now
> >> because some IDE drivers have been removed (nvidia I believe? in 2.6.28)
> >> and I cannot upgrade the kernel anymore unless I move to the
> >> PATA-supported SATA driver, but I have no idea what the root disk will be
> >> after a reboot and there is a high probability it will not come back after
> >> a reboot..
> >
> > Hmmm?  That's news to me and I wonder where did you hear that?
> >
> > The only driver that got removed recently was HPT34X (for very, very
> > old HPT controllers) which was broken for ages.  In reality we are
> > adding new IDE host drivers and not removing them.
> >
> > In 2.6.28 we got support for TX4938 and TX4939 chipsets.  2.6.29-rc1
> > contains a new driver for IT8172 and 2.6.29-final will hopefully have
> > drivers for AT91 and CS5536 chipsets.  Moreover except CS5536 all of
> > above chipsets are not support in other ways under Linux...
> >
> > While we are at it 2.6.29 also got a whole bunch of updates to the core
> > IDE code -- this includes complete rewrite of locking scheme (which
> > is now superior to some other solutions), latency improvements for IRQ
> > handling and port of ide-cd over generic ATAPI support (not to mention
> > whole stack of bugfixes and cleanups).
> >
> > Thanks,
> > Bart
> >
> > PS as usual I encourage people to try different solutions and choose
> > whatever works best for them (please also remember that giving feedback
> > is very important if you want to see some things improved).
> >
> 
> Correction, it was the HPT controller as you noted, broken? Was working 
> for me in 2.6.26.3 :)
> 
> CONFIG_BLK_DEV_HPT34X=y
> # CONFIG_HPT34X_AUTODMA is not set
> CONFIG_BLK_DEV_HPT366=y

HPT34X driver got removed not HPT366.

However if you need we can bring support for HPT34x hardware back. :)
