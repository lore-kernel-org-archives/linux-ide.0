From: Holger Macht <hmacht@suse.de>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Wed, 7 May 2008 00:06:34 +0200
Message-ID: <20080506220634.GA3466@homac>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac> <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com> <20080506084625.GA10817@srcf.ucam.org> <48201C7D.1070303@gmail.com> <20080506091718.GA11617@srcf.ucam.org> <20080506183612.GE20797@homac> <20080506184828.GA22634@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40084 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757765AbYEFWE0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 18:04:26 -0400
Content-Disposition: inline
In-Reply-To: <20080506184828.GA22634@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, hmact@suse.de

On Di 06. Mai - 19:48:28, Matthew Garrett wrote:
> On Tue, May 06, 2008 at 08:36:12PM +0200, Holger Macht wrote:
> > Hi Matthew,
> > 
> > ( Please TO or CC hmacht@suse.de ! )
> 
> Then stop setting Mail-Followup-To: :)
> 
> > > Hm. I'm not absolutely certain about this. Do we get a bus check 
> > > notification after the dock has been removed? If so, I think it ought to 
> > > be handled the same way as the internal bay (ie, signal userspace and 
> > > let it clean up and destroy the device - if it fails to do so, then 
> > > destroy the device when the dock is actually removed, by catching the 
> > > bus/device check, calling the _STA method on the bay and destroying the 
> > > device if it's present)
> > 
> > libata is notified through the dock driver when a dock event occurs, just
> > before the dock driver undocks, giving no time to userspace to clean
> > up. libata doesn't receive an additional acpi bay event.
> 
> That's the current situation, I'm not sure it's ideal. But I'll skip 

What exactly do you think is not ideal?

> worrying about that until I've actually got some hardware to work out 
> how to do it properly :)

Maybe this is what you're thinking of?:
  http://marc.info/?l=linux-acpi&m=121009411900390&w=2

> 
> > >>  2. Bay event: libata signals a BAY_EVENT through uevent, userspace writes
> > >>     	       1 to /sys/.../device/delete
> > 
> > > In the case of an eject request, yes. In the case of a bus or device 
> > > check, we should call _STA and then delete/hotplug the device as 
> > > appropriate.
> > 
> > Yes.
> 
> Excellent. I /think/ the patch I sent earlier basically does this - 
> you'll want to register a separate callback for the dock event in that 
> case, though.

I'll take a look the following days, thanks.

Regards,
	Holger
