From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Adding runtime PM support to sata_mv driver
Date: Thu, 6 Jan 2011 10:40:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101061018250.1916-100000@iolanthe.rowland.org>
References: <20110106045309.GD19416@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40657 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753036Ab1AFPkd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 10:40:33 -0500
In-Reply-To: <20110106045309.GD19416@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Priyanka Gupta <ankaguptaca@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org

On Wed, 5 Jan 2011, Tejun Heo wrote:

> > Do you have to worry about a rotating drive that gets its power from
> > the SATA bus (what happens if that power is suddenly no longer
> > available because the controller is suspended)?
> 
> No, SATA bus doesn't carry any power.  There are some drives (WD
> mybook) which power down when SATA link goes offline tho and they may
> spin down/up too often if the controller gets turned off aggressively.
> Anyways, there are only a handful of them so no big deal.

If you say so.

The drives we're talking about use the SCSI sd driver, right?  And the 
libata error handler is invoked by the regular SCSI EH?

This means that the call to scsi_autopm_get_host() in
scsi_error_handler() has to be removed.  I was planning to do that
while integrating runtime PM into the block layer.  But it will be
difficult; it will require that every block request sent while the
device is suspending or resuming be marked with a special request type
(something like REQ_TYPE_PM_SUSPEND and REQ_TYPE_PM_RESUME, as used
currently by the IDE driver).  Otherwise the block core will think that
it's a regular I/O request and will delay it until the device is fully
powered up again.

> There are multiple layers of powersaving, so it's a bit complicated.
> 
> * Spinning down hard drives: This is difficult to get right, because
>   spinning up not only consumes quite a bit of power but also involves
>   significant latency (usually somewhere around or over 10secs) which
>   can affect the general interactiveness of the system.  Furthermore,
>   ATA hard drives already have hardware features to control this so
>   implementing this in software again could be a bit silly.  Another
>   danger is that hardware standby and STANDBYNOW issued by OS may
>   interact weirdly.  Some (too many) drives would spin up to just spin
>   down again if they receieve STANDBYNOW while already spun down.

These are not new problems.  The SCSI disk driver has to cope with them 
already during system suspend.

> * SATA link: This is called LPM and basically puts the link into
>   powersave mode.  Again, there is hardware support for it on both
>   controller (HIPM) and drive side (DIPM).  I personally think it
>   should just have been DIPM but well...  Anyways, libata implements
>   LPM and it's exported via SCSI sysfs.  The support can easily be
>   extended to allow powering down unused ports.  Given the low latency
>   dynamic nature of LPM, I'm not sure whether this would fit software
>   runtime PM very well.

I don't know either.  In theory runtime PM can be pretty low latency,
i.e., usable from within an interrupt handler, if the underlying I/O
operations can be carried out without blocking.

> * SATA port/controller: This currently isn't implemented and could fit
>   software runtime PM but for offline ports at least it can also be
>   achieved using LPM support.  Not quite sure which way would be
>   better.  It would be much nicer to integrate everything into the
>   runtime PM framework but then again LPM doesn't really fit it.  If
>   powering off occupied controllers has enough benefits, it definitely
>   makes sense to implement it in the runtime PM framework but then we
>   end up with separate LPM and runtime PM impelmentations.  Maybe it's
>   inevitable.  I don't know.

It might be a good idea to step back and think about what form the 
final implementation should take.  At this point we may not have enough 
information to do that, however.

> > I don't know.  Certainly for runtime suspend it is necessary to put a
> > PCI device into D3hot.  For system suspend it might not be necessary,
> > depending on the platform.
> 
> Omitting pci_set_power_state() on system suspend may be an
> alternative.  Again, I don't know.  The code has always been like that
> and now I'm a bit afraid to change.  BTW, is there any case where
> putting device into D3hot is necessary before going into system
> suspend?  Aren't power always cut to the controllers anyway?

I think it depends on the platform.  Non-ACPI systems tend to be 
different from ACPI-based systems.

> So, yeah, it's not a bit complicated.  If the only goal is to turn off
> unoccpuied ports, using LPM framework would be the path with the least
> amount of resistance but whether that is the right thing to do is a
> different issue.  :-(

For now it might be the easiest.  Runtime PM can be revisited later.

Alan Stern

