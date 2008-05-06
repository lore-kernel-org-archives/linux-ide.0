From: Holger Macht <hmacht@suse.de>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Tue, 6 May 2008 19:27:43 +0200
Message-ID: <20080506172743.GD20797@homac>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac> <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com> <20080506084625.GA10817@srcf.ucam.org> <48201C7D.1070303@gmail.com> <20080506091718.GA11617@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47677 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445AbYEFRZe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 13:25:34 -0400
Content-Disposition: inline
In-Reply-To: <20080506091718.GA11617@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>


( I still had to poll linux-ide archives... )

>> Not by default. The dock driver immediately undocks unless
>> immediate_undock parameter is set to 0. Any access to the bay inside the
>> dock afterwards might freeze the system.
>> 
>> Actually I was talking about the "bay not in the dock"-case here.

> In that case, the effect differs depending on the hardware. In the ideal 
> universe, Thinkpad users flick out the eject lever and wait for a 
> confirmation that they can pull out the drive. Dell and HP users have to 
> request a safe remove in advance.

If you need to make clear that the user has to wait for a notification
before he removes the device, you could just make him clear that he has to
request a safe remove in advance.

But yes, I see your point.

>> There are those which do simple PCI hotplugging without the involvement of
>> ACPI (many/all HPs AFAIK) and those which present themselves as a
>> dockstation through ACPI (those with a _DCK method). The thinkpad X60 dock
>> I have here has the request button, too.

> Right. In that case, it needs to be possible for userspace to indicate 
> that the eject request should not automatically destroy the device. 
> Actually removing the dock should do so in all circumstances.

That's what I'm trying to say.

Just to make clear that we agree on the design, if so, I'll try to provide
a patch:

 1. Dock event: libata immediately detaches the device

    (libata will need another sysfs flag is_on_dock userspace can query)

 2. Bay event: libata signals a BAY_EVENT through uevent, userspace writes
    	       1 to /sys/.../device/delete

Regards,
	Holger
