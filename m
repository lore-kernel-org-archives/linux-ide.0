From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Tue, 6 May 2008 18:48:06 +0100
Message-ID: <20080506174806.GB21563@srcf.ucam.org>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac> <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com> <20080506084625.GA10817@srcf.ucam.org> <48201C7D.1070303@gmail.com> <20080506091718.GA11617@srcf.ucam.org> <20080506172743.GD20797@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:40111 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1761738AbYEFRsS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 13:48:18 -0400
Content-Disposition: inline
In-Reply-To: <20080506172743.GD20797@homac>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Tue, May 06, 2008 at 07:27:43PM +0200, Holger Macht wrote:

> Just to make clear that we agree on the design, if so, I'll try to provide
> a patch:
> 
>  1. Dock event: libata immediately detaches the device
> 
>     (libata will need another sysfs flag is_on_dock userspace can query)

Hm. I'm not absolutely certain about this. Do we get a bus check 
notification after the dock has been removed? If so, I think it ought to 
be handled the same way as the internal bay (ie, signal userspace and 
let it clean up and destroy the device - if it fails to do so, then 
destroy the device when the dock is actually removed, by catching the 
bus/device check, calling the _STA method on the bay and destroying the 
device if it's present)

>  2. Bay event: libata signals a BAY_EVENT through uevent, userspace writes
>     	       1 to /sys/.../device/delete

In the case of an eject request, yes. In the case of a bus or device 
check, we should call _STA and then delete/hotplug the device as 
appropriate.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
