From: Mark Lord <liml@rtr.ca>
Subject: Re: libata, devm_*, and MSI ?
Date: Tue, 20 Jan 2009 13:16:21 -0500
Message-ID: <497614F5.6000301@rtr.ca>
References: <4975F5C1.8090107@rtr.ca> <da824cf30901200944x545431b2va0233abc14e81f9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <da824cf30901200944x545431b2va0233abc14e81f9b@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Grant Grundler wrote:
> On Tue, Jan 20, 2009 at 8:03 AM, Mark Lord <liml@rtr.ca> wrote:
..
>> For starters, the MSI HOW-TO suggests that drivers must be careful
>> to invoke pci_disable_msi() on module unload, but I don't see that
>> happening anywhere in libata.
> 
> I don't think that's necessary if free_irq() or disable_irq() are called.
> However, I'm not seeing those get called either.
..

The linux/Documentation/PCI/MSI-HOWTO.txt information is rather explicit
about it, and the pci core code does seem to expect it.

> However, I'm not seeing those get called either.
..

The devres code takes care of the free_irq() normally,
but does not do the pci_disable_msi(), because it doesn't
know enough about the device to do it right now.

..
>> Eg. from ahci.c, we have this:
>>
>>       if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
>>               pci_intx(pdev, 1);
>>
>> Which agrees with the existing code in sata_mv:
>>
>>       if (msi && hi jiqi(pdev))
>>               pci_intx(pdev, 1);
..
>>       if (pci_enable_msi(pdev) == 0)
>>               pci_intx(pdev, 0);
>>
>> Either that one is wrong, or pci_intx() is unnecessary in all cases.
..

Those calls to pci_intx() are definitely redundant,
as the pci core already does that for us on the relevant paths.

>> Perhaps somebody from the PCI side of things might enlighten us all.
> 
>     http://lists.linuxcoding.com/kernel/2005-q3/msg11296.html
> 
> Shows when pci_intx() was added. linux-pci was NOT cc'd on that email.
> And no one asked for Documentation/ update. C'est la vie.
..

I still think the documentation matches the code in the pci core, though.

Patch for sata_mv coming shortly.

Cheers
