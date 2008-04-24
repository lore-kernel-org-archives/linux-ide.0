From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 2/2] libata: power off unused ports
Date: Thu, 24 Apr 2008 10:45:00 -0700
Message-ID: <20080424104500.57a48683@appleyard>
References: <20080325221646.567639335@intel.com>
	<20080325152813.0b34761f@appleyard>
	<48003A5D.9000306@garzik.org>
	<20080414161122.03b2211d@appleyard>
	<4804FBD0.8060900@rtr.ca>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16628 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbYDXRva (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Apr 2008 13:51:30 -0400
In-Reply-To: <4804FBD0.8060900@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, arjan@linux.intel.com

On Tue, 15 Apr 2008 15:02:40 -0400
Mark Lord <liml@rtr.ca> wrote:

> Kristen Carlson Accardi wrote:
> > On Sat, 12 Apr 2008 00:28:13 -0400
> > Jeff Garzik <jeff@garzik.org> wrote:
> ..
> >> Thinking about the bigger pictures, powering off the phy is something we 
> >> want to do in a lot more cases than this, but there is a stumbling 
> >> block:  we wander into the realm of policy.
> >>
> >> For most users most of the time, empty SATA ports are needlessly 
> >> powered.  The problem is that, at any given moment, a device may be 
> >> hot-plugged, so we must be ready for that.  We need some way for the 
> >> user to let the driver know that they will not be hotplugging anything 
> >> anytime soon, permitting power savings to be enabled.
> >>
> >> A compromise solution that avoids adding a userspace "knob" has also 
> >> been proposed (by Tejun, I think?):  power up the phy every N seconds, 
> >> check for device, power down phy if nothing.  That should provide some 
> >> power savings, though not as much as with a "knob" switched to "hotplug: 
> >> off"
> ..
> 
> How long does a poll actually take, in real time?
> Probably a hundred milliseconds or two, to see if the PHY syncs up?
> 
> So with a knob set to, say 2 seconds (sysfs), then this would
> save 90% of the power of a permanent "off".  That's pretty good,
> and setting that same knob to "infinity" (-1 ?) would achieve 100%.
> Definitely a good way to go, IMHO.
> 
> > I think that for the common case - we should use HPCP to determine if
> > the suggested use of the port is for hot plug.  I can see your point
> > about wanting to give the user the option to just disregard the intended
> > use of the port and do what they want, but I say we don't make that
> > the default behavior.  And, I don't like the idea of adding another
> > wakeup in the driver to do polling - seems like 99% of users are
> > going to be just fine with a knob - and that they should only
> > have to use the knob to override the default (or how bout a 
> > module param?).  I don't think we should compromise power for a 
> > feature that most people are unlikely to use (if HPCP is not set).
> ..
> 
> I worry that this is far too x86 / vendor specific.
> Most of the SATA ports I have here, for example, probably lack this HPCP bit
> even on x86, and on other arch's it likely doesn't exist at all, right?
> 
> For arch/system/device that does have HPCP implemented, then sure,
> it could be used to automatically tweak the sysfs knob.
> But from userspace perhaps, rather than kernel ?
> 
> Thanks
> 

the HPCP bit is defined in the AHCI specification, so it is
architecture independent - as far as actual implementations
go, I don't know which system vendors have implemented it -
this should be set by firmware according to the spec (section
10.1.1), so you can have the same vendor/device chipset with
this set differently depending on the system configuration.  
I've also realized we want to leave phy powered on
by default if ESP is set as well, since that is another likely
case where the user would want hot plug on by default.  I think
the sysfs knob can override the default, but the kernel should
set the default to be based on the most likely usage scenario -
phy off if this port isn't exposed externally for hot 
plug either because it's an external sata port of because it's
got "signal and power connectors are externally accessible via 
a joint signal and power connector for blindmate device hot plug"
(e.g. removable drive bays).

