From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Tue, 17 Aug 2010 18:59:38 +0200
Message-ID: <4C6ABFFA.2000502@kernel.org>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>	<4C6AB68D.8000102@kernel.org>	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>	<4C6AB919.7060203@kernel.org> <20100817180158.179e7780@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33552 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757496Ab0HQRDW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2010 13:03:22 -0400
In-Reply-To: <20100817180158.179e7780@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org

Hello, Alan.

On 08/17/2010 07:01 PM, Alan Cox wrote:
>> ata_piix already has list of all the devices it supports, so maybe
>> it's safe to grab all intel IDE devices from ata_generic?  ata_piix
> 
> I can't guarantee that and I'm not sure I can find anyone at Intel with
> that deep a knowledge of the earliest chip errata.

But ata_generic grabbing a controller doesn't mean it's gonna be
messed up in anyway.  That's what windows does for unknown IDE
controllers after all.  The problem we want to avoid here is using
ata_generic for a controller which already has a proper driver.

>> always has higher priority than ata_generic anyway and if a device
>> isn't grabbed by ata_piix, we don't lose anything by grabbing it from
>> ata_generic.
> 
> Priority only works if you know what is there to use, and the piix one is
> for example broken if you change the bindings with sysfs. You don't for
> example want to forget to compile in one driver and get generic when that
> is unsafe.

I don't really think it would be dangerous to grab intel IDE
controllers with ata_generic.  Again, that's what windows would do.
And for sysfs unbind case, if the user specifically unbinds the
controller from ata_piix, what is broken?

> The extreme example would be if you have ata_generic binding to all
> devices and you forgot to compile in RZ1000 support. On the relevant
> board that just ate your file system.
> 
> So the grab it all approach was dismissed.

For RZ1000, sure, but we're talking about only intel IDEs here.

>>> Is it documented ? The instructions it was written to came from the
>>> people who do the chips.
>>
>> Yeap, that's much better, but I still think it would be better to
>> avoid such detection magics if possible.
> 
> Well yes but the logic is simple.
> 
> 0xF8 is non zero on all later Intel ATA PCI chipsets
> 0x40 is writable on all earlier Intel ATA PCI chipsets, and zero + non
> writable on the IDE-R devices.

Maybe it's okay now but who's gonna remember what's going on there
after five years and nobody guarantees the above would continue to
hold in the future.

> The other thing I did consider was submitting an Intel IDE-R driver that
> contained the check and matched IDE CLASS & vendor == INTEL. That has the
> advantage of not getting autoloaded unnecessarily so easily, but means we
> have another driver.

Yeah, I think it would be better to do it in ata_generic one way or
the other.

Thanks.

-- 
tejun
