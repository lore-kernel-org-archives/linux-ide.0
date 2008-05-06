From: Holger Macht <hmacht@suse.de>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Tue, 6 May 2008 13:21:45 +0200
Message-ID: <20080506112145.GA8560@homac>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac> <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com> <20080506084625.GA10817@srcf.ucam.org> <48201C7D.1070303@gmail.com> <20080506091718.GA11617@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36108 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037AbYEFLTg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 07:19:36 -0400
Content-Disposition: inline
In-Reply-To: <20080506091718.GA11617@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Hi,

(Can you please keep me CC'ed, I'm not on linux-ide)

Quoting your mail from the archives:

>> Right, so you never can rely on receiving a BAY_EVENT. Why not just
>> disregard this case and looking for a common solution?

> Oh, I agree - we need to solve this in any case. But for hardware where 
> there is a separate request event before the device is pulled, users 
> already have scripts that prompt them to unmount hardware. These worked 
> in <2.6.25, but they're broken now. It'd be nice to get them working 
> again.

Yes, the scripts were broken for the advantage to not freeze some devices ;-)

But I agree, we need such a possibility.

>> No. The moment when the bay event is generated, the moment the user pushes
>> the lever on the bay, the user might immediately pull out the device,
>> letting no chance for cleaning up...There must be an event before the user
>> touches anything, to have the time to unmount etc. and then tell "now it's
>> save to remove the bay device". This would also solve the "there's no bay
>> event" case.

> Hm. The hardware I have here has a separate "eject request" button and 
> "physical eject" button. Hitting the former sends the request to the OS, 
> and the light then pulses until the OS confirms that the dock can be 
> removed. If the user removes the dock before this happens, that's user 
> error.

Not by default. The dock driver immediately undocks unless
immediate_undock parameter is set to 0. Any access to the bay inside the
dock afterwards might freeze the system.

Actually I was talking about the "bay not in the dock"-case here.

Unfortunately, the hardware in question doesn't contain a bay.

> The only dock I have with no request button doesn't present as an ACPI 
> dock to begin with. Do Thinkpad docks differ from this?

There are those which do simple PCI hotplugging without the involvement of
ACPI (many/all HPs AFAIK) and those which present themselves as a
dockstation through ACPI (those with a _DCK method). The thinkpad X60 dock
I have here has the request button, too.

Regards,
	Holger
