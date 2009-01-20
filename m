From: Grant Grundler <grundler@google.com>
Subject: Re: libata, devm_*, and MSI ?
Date: Tue, 20 Jan 2009 10:51:47 -0800
Message-ID: <da824cf30901201051v66ae13c4i3476097ee31db281@mail.gmail.com>
References: <4975F5C1.8090107@rtr.ca>
	 <da824cf30901200944x545431b2va0233abc14e81f9b@mail.gmail.com>
	 <497614F5.6000301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:17482 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbZATSvw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jan 2009 13:51:52 -0500
In-Reply-To: <497614F5.6000301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-pci@vger.kernel.org

On Tue, Jan 20, 2009 at 10:16 AM, Mark Lord <liml@rtr.ca> wrote:
...
>> I don't think that's necessary if free_irq() or disable_irq() are called.
>> However, I'm not seeing those get called either.
...
> The linux/Documentation/PCI/MSI-HOWTO.txt information is rather explicit
> about it, and the pci core code does seem to expect it.

It looks like pci_disable_msi() requires free_irq() to be called first in order
to guarantee the vectors are no longer in use. But I didn't see any code to
enforce that. Which code was "expecting free_irq()" to be called?

I've learned that anything in Documentation/ is explicit - and sometimes stale
and/or just missing (like you are rediscovering). Two years ago I took a whack
at Documentation/PCI/pci.txt and it's probably time to revisit that again and
add references to pci_intx().


> Those calls to pci_intx() are definitely redundant,
> as the pci core already does that for us on the relevant paths.

True. Want to submit a patch to remove the redundant code?

>
>>> Perhaps somebody from the PCI side of things might enlighten us all.
>>
>>    http://lists.linuxcoding.com/kernel/2005-q3/msg11296.html
>>
>> Shows when pci_intx() was added. linux-pci was NOT cc'd on that email.
>> And no one asked for Documentation/ update. C'est la vie.
>
> ..
>
> I still think the documentation matches the code in the pci core, though.

Yeah, I think you are right.

grant

>
> Patch for sata_mv coming shortly.
>
> Cheers
>
