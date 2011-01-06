From: Tejun Heo <tj@kernel.org>
Subject: Re: Adding runtime PM support to sata_mv driver
Date: Wed, 5 Jan 2011 20:53:09 -0800
Message-ID: <20110106045309.GD19416@mtj.dyndns.org>
References: <20110103153134.GW18831@htj.dyndns.org>
 <Pine.LNX.4.44L0.1101031120230.1715-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49699 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab1AFExS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2011 23:53:18 -0500
Received: by ywl5 with SMTP id 5so6293872ywl.19
        for <linux-ide@vger.kernel.org>; Wed, 05 Jan 2011 20:53:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1101031120230.1715-100000@iolanthe.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Priyanka Gupta <ankaguptaca@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org

Hello, sorry about the delay.

On Mon, Jan 03, 2011 at 11:42:51AM -0500, Alan Stern wrote:
> > Well, it's not that simple I'm afraid.  EH actions are asynchronous.
> > Even if all the downstream devices are suspended, PHY events can
> > happen any time and EH could be active.  Hmmm... a delta but it would
> > make more sense to put only the controller into hot sleep while
> > leaving the disk alone for rotating devices.
> 
> That could be done.  How do you tell whether a particular drive is
> rotational?

As pointed out already, it's in the identify data.  Block layer also
keeps track of it using QUEUE_FLAG_NONROT (sd queries libata and sets
it), but I don't think it would be necessary to discern them.  Issuing
STANDBYNOW to SSDs would usually be noop.  Handling HDDs and SSDs the
same would work just fine.

> Do you have to worry about a rotating drive that gets its power from
> the SATA bus (what happens if that power is suddenly no longer
> available because the controller is suspended)?

No, SATA bus doesn't carry any power.  There are some drives (WD
mybook) which power down when SATA link goes offline tho and they may
spin down/up too often if the controller gets turned off aggressively.
Anyways, there are only a handful of them so no big deal.

> > Also, on resume, as the controller was out, libata needs to do full
> > revalidation & reconfiguration.  There's no way to avoid EH.
> 
> There's no way to tell if a drive was disconnected while the controller 
> was suspended?

Well, that's the EH reset/revalidation.  SATA has PHY events but there
are some issues.

* Link powersave effectively disables PHY event detection.

* PHY events can and do happen for other reasons so we can't afford to
  detach and reattach a SATA hard drive after a PHY event.  It could
  result in "when my air conditioner compressor kicks in, the root fs
  sometimes goes away".

So, the PHY events can be used as trigger to start rescan/revalidation
of the bus but not as the sole indication to base further actions
upon.

> > Then, at least we would need to plug EH because commands aren't the
> > only intiation vector.
> 
> I have no idea how libata is designed, and of course the runtime PM
> implementation will depend heavily on those details.  All I can do is 
> offer advice about runtime PM.  There are two major design options: You 
> can leave the controller powered on as long as any of the attached 
> drives are running, or you can power-down the controller in between 
> accesses.  The runtime PM core supports both approaches.

There are multiple layers of powersaving, so it's a bit complicated.

* Spinning down hard drives: This is difficult to get right, because
  spinning up not only consumes quite a bit of power but also involves
  significant latency (usually somewhere around or over 10secs) which
  can affect the general interactiveness of the system.  Furthermore,
  ATA hard drives already have hardware features to control this so
  implementing this in software again could be a bit silly.  Another
  danger is that hardware standby and STANDBYNOW issued by OS may
  interact weirdly.  Some (too many) drives would spin up to just spin
  down again if they receieve STANDBYNOW while already spun down.

* SATA link: This is called LPM and basically puts the link into
  powersave mode.  Again, there is hardware support for it on both
  controller (HIPM) and drive side (DIPM).  I personally think it
  should just have been DIPM but well...  Anyways, libata implements
  LPM and it's exported via SCSI sysfs.  The support can easily be
  extended to allow powering down unused ports.  Given the low latency
  dynamic nature of LPM, I'm not sure whether this would fit software
  runtime PM very well.

* SATA port/controller: This currently isn't implemented and could fit
  software runtime PM but for offline ports at least it can also be
  achieved using LPM support.  Not quite sure which way would be
  better.  It would be much nicer to integrate everything into the
  runtime PM framework but then again LPM doesn't really fit it.  If
  powering off occupied controllers has enough benefits, it definitely
  makes sense to implement it in the runtime PM framework but then we
  end up with separate LPM and runtime PM impelmentations.  Maybe it's
  inevitable.  I don't know.

> > So, it behaves differently from the usual suspend/resume?
> 
> The PCI subsystem's implementation is somewhat different.
> 
> >  We have
> > .suspend callback which puts the controller into D3.
> 
> It does so by calling pci_prepare_to_sleep()?  Compare that with 
> pci_finish_runtime_suspend(), which is called directly by 
> pci_pm_runtime_suspend().

Hmm... the PCI part of libata suspend is ata_pci_device_do_suspend()
and it calls pci_set_power_state() explicitly.

> > Are you saying for runtime PM that isn't necessary?  If so,
> > wouldn't it be better to unify behaviors between the two paths?
> 
> I don't know.  Certainly for runtime suspend it is necessary to put a
> PCI device into D3hot.  For system suspend it might not be necessary,
> depending on the platform.

Omitting pci_set_power_state() on system suspend may be an
alternative.  Again, I don't know.  The code has always been like that
and now I'm a bit afraid to change.  BTW, is there any case where
putting device into D3hot is necessary before going into system
suspend?  Aren't power always cut to the controllers anyway?

> > I still can't see how this would work without low level driver's help.
> > Who's gonna reconfigure the controller?  Or are controllers supposed
> > to maintain all configurations across D3(hot) sleep?
> 
> The low-level driver has to take care of all these special
> requirements.  Note that many PCI controllers _do_ retain their
> configuration across D3 sleep -- maybe not SATA controllers, though.

Even if some controllers retain the configuration, I think we're
better off with always reconfiguring them.  We need to reconfiguration
path for system resume anyway and it's always better to use common
code paths.  Maybe we would be able to do D3cold during runtime in the
future, who knows?

So, yeah, it's not a bit complicated.  If the only goal is to turn off
unoccpuied ports, using LPM framework would be the path with the least
amount of resistance but whether that is the right thing to do is a
different issue.  :-(

-- 
tejun
