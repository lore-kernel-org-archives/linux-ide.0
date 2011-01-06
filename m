From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Adding runtime PM support to sata_mv driver
Date: Thu, 6 Jan 2011 16:26:56 +0100
Message-ID: <201101061626.56152.rjw@sisk.pl>
References: <20110103153134.GW18831@htj.dyndns.org> <Pine.LNX.4.44L0.1101031120230.1715-100000@iolanthe.rowland.org> <20110106045309.GD19416@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36908 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128Ab1AFP1b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jan 2011 10:27:31 -0500
In-Reply-To: <20110106045309.GD19416@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Priyanka Gupta <ankaguptaca@gmail.com>, linux-ide@vger.kernel.org

On Thursday, January 06, 2011, Tejun Heo wrote:
> Hello, sorry about the delay.
...
> 
> Omitting pci_set_power_state() on system suspend may be an
> alternative.  Again, I don't know.  The code has always been like that
> and now I'm a bit afraid to change.

It probably is not necessary to call pci_set_power_state() on suspend, but
that would require some other changes (generally speaking, SATA will have to
be converted to using struct dev_pm_ops instead of the legacy PCI-specific
callbacks - which would be a good idea anyway and should be done _before_
trying to play with SATA runtime PM IMO).

> BTW, is there any case where putting device into D3hot is necessary before
> going into system suspend?  Aren't power always cut to the controllers
> anyway?

Not necessarily.  Well, that probably doesn't affect SATA controllers, but
there are known cases where devices draw power in a sleep state if they aren't
put into D3 on suspend directly.

> > > I still can't see how this would work without low level driver's help.
> > > Who's gonna reconfigure the controller?  Or are controllers supposed
> > > to maintain all configurations across D3(hot) sleep?
> > 
> > The low-level driver has to take care of all these special
> > requirements.  Note that many PCI controllers _do_ retain their
> > configuration across D3 sleep -- maybe not SATA controllers, though.
> 
> Even if some controllers retain the configuration, I think we're
> better off with always reconfiguring them.  We need to reconfiguration
> path for system resume anyway and it's always better to use common
> code paths.  Maybe we would be able to do D3cold during runtime in the
> future, who knows?

If you mean PCI D3cold here, we can't.  In fact we can't programmatically put
any device into PCI D3cold in any other way than by either putting its bus
segment into B3 or switching its power resources off (provided that we know
how to do that).

> So, yeah, it's not a bit complicated.  If the only goal is to turn off
> unoccpuied ports, using LPM framework would be the path with the least
> amount of resistance but whether that is the right thing to do is a
> different issue.  :-(

Still, putting unused _controllers_ into D3 might be a good idea too.

Thanks,
Rafael
