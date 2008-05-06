From: Holger Macht <hmacht@suse.de>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Tue, 6 May 2008 10:40:18 +0200
Message-ID: <20080506084018.GC8688@homac>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:54111 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755022AbYEFIif (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 04:38:35 -0400
Content-Disposition: inline
In-Reply-To: <20080506081347.GA8688@homac>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide@vger.kernel.org, tejun@gmail.com, Jeff Garzik <jeff@garzik.org>

On Tue 06. May - 10:13:47, Holger Macht wrote:
> On Mo 05. Mai - 23:33:57, Matthew Garrett wrote:
> > 48feb3c419508487becfb9ea3afcc54c3eac6d80 appears to flag a device as 
> > detached if an acpi eject request is received. In 2.6.24 and earlier, an 
> > eject request merely sent an event to userland which could then cleanly 
> > unmount the device and let the user know when it was safe to remove the 
> > drive. Removing the device would then send another acpi request that 
> > triggered the actual hotplug and bus rescan.
> 
> What second acpi request are you referring to?
> 
> > This seems like a regression - it's no longer possible to ensure that a 
> > bay device is cleanly unmounted. Was this really the desired behaviour? 
> 
> I'm thinking about his for several days now and looking for a proper
> solution how to ensure that userland has the possibility to cleanly
> unmount a device. But it's definitely no regression. Before...systems with
> a bay in a dock stations simply froze hard in certain circumstances. It
> was pure luck that it worked for one major kernel version or so.
> 
> The only sane way for me seems that userland has to be involved before
> actually triggering any event or removing any device. Something like
> "savely remove this piece of hardware".
> 
> For this to archive, we would need another sysfs entry flagging a bay
> device as "on dock station", so that userland knows what to unmount/eject
> before a dock event. Userspace relying on the bay event on the device is
> not a proper solution. The device may have been gone before userland
> finishes his work, or as you mention, there's no bay event.
> 
> > It should be noted that not all hardware sends the eject request at all 
> > (Thinkpads do, but Dell and HP laptops don't), so we can't depend on 
> > receiving this when dealing with a bay event.
> 
> I don't think we depend on the event. If the device gets removed without
> an appropriate event, the behaviour should be the same as before. If not,
> that wasn't the intentional behaviour.

AFAICT!

I just saw that the initial mail was not explicitly meant for me and the
patches regarding bay devices I've sent a couple of weeks ago.

Regards,
	Holger
