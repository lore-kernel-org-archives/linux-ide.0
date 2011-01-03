From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Adding runtime PM support to sata_mv driver
Date: Mon, 3 Jan 2011 11:42:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101031120230.1715-100000@iolanthe.rowland.org>
References: <20110103153134.GW18831@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34520 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932069Ab1ACQmw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 11:42:52 -0500
In-Reply-To: <20110103153134.GW18831@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Priyanka Gupta <ankaguptaca@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org

On Mon, 3 Jan 2011, Tejun Heo wrote:

> > Runtime suspend should not occur unless all the child devices (i.e.,
> > the attached drives) are already suspended.  This means it is not
> > necessary to synchronize any operations, since there shouldn't be any
> > other accesses to the hardware going on.  Therefore there is no need to
> > use the error handler.
> 
> Well, it's not that simple I'm afraid.  EH actions are asynchronous.
> Even if all the downstream devices are suspended, PHY events can
> happen any time and EH could be active.  Hmmm... a delta but it would
> make more sense to put only the controller into hot sleep while
> leaving the disk alone for rotating devices.

That could be done.  How do you tell whether a particular drive is
rotational?

Do you have to worry about a rotating drive that gets its power from
the SATA bus (what happens if that power is suddenly no longer
available because the controller is suspended)?

> Also, on resume, as the controller was out, libata needs to do full
> revalidation & reconfiguration.  There's no way to avoid EH.

There's no way to tell if a drive was disconnected while the controller 
was suspended?

> > > * EH kicks in.  Mark the port inactive so that further commands
> > >   processing won't happen (it would probably be nice if this is
> > >   something the PM framework can guarantee but I don't think it's done
> > >   that way, is it?)
> > 
> > Why must the port be marked inactive?  If any further commands need to
> > be processed then they should cause the controller to be resumed, at
> > which point the port will be active again.
> 
> Then, at least we would need to plug EH because commands aren't the
> only intiation vector.

I have no idea how libata is designed, and of course the runtime PM
implementation will depend heavily on those details.  All I can do is 
offer advice about runtime PM.  There are two major design options: You 
can leave the controller powered on as long as any of the attached 
drives are running, or you can power-down the controller in between 
accesses.  The runtime PM core supports both approaches.

> > > * EH skips all other EH actions and put the controller in sleep.
> > 
> > The PCI core already takes care of putting device into D3.  The EH 
> > doesn't need to do it.  And there shouldn't be any other EH actions 
> > pending.
> 
> So, it behaves differently from the usual suspend/resume?

The PCI subsystem's implementation is somewhat different.

>  We have
> .suspend callback which puts the controller into D3.

It does so by calling pci_prepare_to_sleep()?  Compare that with 
pci_finish_runtime_suspend(), which is called directly by 
pci_pm_runtime_suspend().

>  Are you saying
> for runtime PM that isn't necessary?  If so, wouldn't it be better to
> unify behaviors between the two paths?

I don't know.  Certainly for runtime suspend it is necessary to put a
PCI device into D3hot.  For system suspend it might not be necessary,
depending on the platform.

> > > On runtime resume
> > > 
> > > * Tell EH to kick in and wake up the controller.
> > 
> > The PCI core already puts devices back into D0.
> 
> I still can't see how this would work without low level driver's help.
> Who's gonna reconfigure the controller?  Or are controllers supposed
> to maintain all configurations across D3(hot) sleep?

The low-level driver has to take care of all these special
requirements.  Note that many PCI controllers _do_ retain their
configuration across D3 sleep -- maybe not SATA controllers, though.

> > > * EH kicks in.  Powers up the controller and revalidates all the
> > >   attached devices.
> > 
> > At this point the attached devices should still be suspended.  
> > Presumably you would not want to revalidate them until their own 
> > runtime resumes occur.
> 
> Controller resume involves SATA bus resets.  As there can be multiple
> devices per bus, you can't really divide things that neatly.  The
> hardware isn't designed that way.

Obviously, runtime PM has to be implemented in a way that will work 
with the hardware design.

> > > So, it's gonna take a bit more code than posted.
> > 
> > On the contrary, there should be almost no new code needed.  In fact,
> > calling pm_runtime_put_noidle() in the probe routine and
> > pm_runtime_get_noresume() in the remove routine should be almost good 
> > enough.
> 
> Yeah, that would be nice.  I'm quite doubtful that would work as well
> as you would expect it to tho.

Well, perhaps not...

Alan Stern

