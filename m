From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sil and PMP...
Date: Fri, 31 Aug 2007 13:39:30 -0400
Message-ID: <46D85252.3060301@garzik.org>
References: <20070823062740.GA16458@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48020 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965454AbXHaRjc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 13:39:32 -0400
In-Reply-To: <20070823062740.GA16458@vana.vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <petr@vandrovec.name>
Cc: linux-ide@vger.kernel.org

Petr Vandrovec wrote:
> Hello,
>   maybe I should have trusted SiliconImage...  But, well, it is not true that
> you cannot use PMP with Sil 3512 and 3114.  You can, if you try hard enough.
> Patch below tries hard enough ;-)  Unfortunately it has few drawbacks:
> 
> (1) Hardware ignores PMP field in received frames, so when D2H FIS arrives
> from device not selected, you have last chance to record what's current
> device state.
> 
> (2) When NIEN bit is set on device, every interrupt source seems to be
> disabled.  Not good when interlocked FIS arrives while bus is resetted,
> which happens almost always...
> 
> (3) And due to all this interrupts are always left enabled on the device,
> and driver just tries to provide some more compatible view to remaining
> parts of libata.
> 
> Driver as is below works with Sil 3726 port multiplier with couple devices
> attached.  I did not test it without port multiplier (I think it will
> break) as card I have has only eSATA ports and I currently do not
> have eSATA non-PMP enclosure around.
> 
> So patch is definitely not intended for merge, and most probably it would
> have to be separate driver anyway as I have some doubts about compatibility
> between interrupts being always enabled and various ATI clones.  So this
> is more or less just FYI, unless you believe that it is possible to get
> this patch to some mergeable shape.  I have some doubts, so I've ordered
> 3124 based card.  Maybe I should have done that week ago... 
> 
> On other side driver works with PMP as well as AHCI driver (i.e. full
> SDB_NOTIFY support, but command based switching and no NCQ - I think I
> could implement NCQ if I would try hard enough via interlocked FIS, but 
> it does not look like worth of effort).
> 
> Anyway, here it goes.  Good night.

Quite impressive, I must say :)

It is similar to how NCQ is implemented in sata_nv ('SW NCQ'), and how I 
am contemplating support for ATAPI on a few controllers that do not 
support it.

With regards to interrupts, sata_sil provides hardware registers to mask 
and monitor the interrupt condition, so I don't see much danger in 
interrupts always being enabled.  EH will need to mess with interrupt 
delivery on a per-port granularity, but that's probably about it.

	Jeff



