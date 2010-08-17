From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Tue, 17 Aug 2010 19:23:53 +0100
Message-ID: <20100817192353.3529733c@lxorguk.ukuu.org.uk>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
	<4C6AB68D.8000102@kernel.org>
	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>
	<4C6AB919.7060203@kernel.org>
	<20100817180158.179e7780@lxorguk.ukuu.org.uk>
	<4C6ABFFA.2000502@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55909 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753492Ab0HQSIk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2010 14:08:40 -0400
In-Reply-To: <4C6ABFFA.2000502@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org

> I don't really think it would be dangerous to grab intel IDE
> controllers with ata_generic.  Again, that's what windows would do.
> And for sysfs unbind case, if the user specifically unbinds the
> controller from ata_piix, what is broken?

If the user changes the PCI id list what happens ?

> 
> > The extreme example would be if you have ata_generic binding to all
> > devices and you forgot to compile in RZ1000 support. On the relevant
> > board that just ate your file system.
> > 
> > So the grab it all approach was dismissed.
> 
> For RZ1000, sure, but we're talking about only intel IDEs here.

I don't know. I do know what the Intel folks have told me about detecting
them.

> > 0xF8 is non zero on all later Intel ATA PCI chipsets
> > 0x40 is writable on all earlier Intel ATA PCI chipsets, and zero + non
> > writable on the IDE-R devices.
> 
> Maybe it's okay now but who's gonna remember what's going on there
> after five years and nobody guarantees the above would continue to

Add a comment ?

> hold in the future.

It did occur to me to check this would be true in the future. Either way
- an id table would go out of date more often.

Alan

