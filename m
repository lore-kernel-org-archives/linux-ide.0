From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Tue, 6 May 2008 09:21:10 +0100
Message-ID: <20080506082110.GA10355@srcf.ucam.org>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:53680 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1757528AbYEFIVW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 04:21:22 -0400
Content-Disposition: inline
In-Reply-To: <20080506081347.GA8688@homac>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, htejun@gmail.com, Jeff Garzik <jeff@garzik.org>

On Tue, May 06, 2008 at 10:13:47AM +0200, Holger Macht wrote:
> On Mo 05. Mai - 23:33:57, Matthew Garrett wrote:
> > 48feb3c419508487becfb9ea3afcc54c3eac6d80 appears to flag a device as 
> > detached if an acpi eject request is received. In 2.6.24 and earlier, an 
> > eject request merely sent an event to userland which could then cleanly 
> > unmount the device and let the user know when it was safe to remove the 
> > drive. Removing the device would then send another acpi request that 
> > triggered the actual hotplug and bus rescan.
> 
> What second acpi request are you referring to?

For bay devices, the sequence is an optional eject request (before 
removal, and not implemented on all hardware) followed by either a bus 
or device check request (after removal).

> > This seems like a regression - it's no longer possible to ensure that a 
> > bay device is cleanly unmounted. Was this really the desired behaviour? 
> 
> I'm thinking about his for several days now and looking for a proper
> solution how to ensure that userland has the possibility to cleanly
> unmount a device. But it's definitely no regression. Before...systems with
> a bay in a dock stations simply froze hard in certain circumstances. It
> was pure luck that it worked for one major kernel version or so.

Ah. I think the issue here is that you're trying to treat bays in docks 
in the same way as internal bays. These should probably be different 
callbacks.

> The only sane way for me seems that userland has to be involved before
> actually triggering any event or removing any device. Something like
> "savely remove this piece of hardware".

That's what the eject request is for.

> For this to archive, we would need another sysfs entry flagging a bay
> device as "on dock station", so that userland knows what to unmount/eject
> before a dock event. Userspace relying on the bay event on the device is
> not a proper solution. The device may have been gone before userland
> finishes his work, or as you mention, there's no bay event.

Yes. The user can, of course, do bad things. That doesn't mean we should 
avoid the opportunity to cleanly unmount filesystems when the user 
doesn't behave pathologically.

> > It should be noted that not all hardware sends the eject request at all 
> > (Thinkpads do, but Dell and HP laptops don't), so we can't depend on 
> > receiving this when dealing with a bay event.
> 
> I don't think we depend on the event. If the device gets removed without
> an appropriate event, the behaviour should be the same as before. If not,
> that wasn't the intentional behaviour.

What ought to be possible for dock devices is something like "Receive 
eject request, clean up anything that has to be done in kernel, allow 
userspace to intervene and tidy up its side of things, let userspace 
signal completion, complete the undocking sequence". For internal bays, 
we certainly shouldn't be detaching the device when all we've received 
is an eject request.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
