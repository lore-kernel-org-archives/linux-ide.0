From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 09 Apr 2009 09:33:20 -0400
Message-ID: <49DDF920.70801@garzik.org>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>	<49DDEF02.7090004@garzik.org>	<20090409135323.5b2bed4b@lxorguk.ukuu.org.uk>	<49DDF33E.6000102@garzik.org> <20090409141254.283d9f11@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55254 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759139AbZDINdX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 09:33:23 -0400
In-Reply-To: <20090409141254.283d9f11@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
>> With the attached patch, you can use ->flags for the two new flags, and 
>> you can set those bits in the driver where you set the other 
>> ATA_FLAG_xxx bits.
> 
> Its half way but I realised there is another reason that doesn't work
> (and indeed why the device private flags are asking for trouble)
> 
> What are the locking sematics for ap->flags ?

In general, for both driver-private flags and ATA_FLAG_xxx, the flags 
should be set at compile or pci_driver::probe() time, and never touched 
after that.

So your patch is a bit of abuse, really, by fiddling with ap->flags at 
all ;-)  The drivers, for example, never touch the driver-private flags 
after they are set at init.  The core will occasionally twiddle flags, 
inside of spin_lock_irqsave(ap->lock)

Since they are legacy ioctls, I think that reflecting current reality 
should be sufficient.  That is what the current set does:

	* GET: return "16 bit"
	* SET: if "16 bit" return success else fail

Thus 'set' has always been an illusion for libata.  It's really been 
read-only.

	Jeff




