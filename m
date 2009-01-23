From: Mark Lord <liml@rtr.ca>
Subject: Re: libata, devm_*, and MSI ?
Date: Fri, 23 Jan 2009 13:11:02 -0500
Message-ID: <497A0836.5060707@rtr.ca>
References: <4975F5C1.8090107@rtr.ca>	 <alpine.LNX.1.00.0901201626090.19665@iabervon.org>	 <497698E2.7090807@rtr.ca>	 <da824cf30901202002g52fb73f9v8229fb702dcd033d@mail.gmail.com> <1232511378.11241.64.camel@localhost> <4977399F.7000104@rtr.ca> <4977BED4.6010702@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4977BED4.6010702@shaw.ca>
Sender: linux-pci-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: michael@ellerman.id.au, Grant Grundler <grundler@google.com>, Daniel Barkalow <barkalow@iabervon.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Robert Hancock wrote:
> Mark Lord wrote:
>> Michael Ellerman wrote:
>>> On Tue, 2009-01-20 at 20:02 -0800, Grant Grundler wrote:
>> ..
..
>>> The kernel shouldn't let you enable MSI if that's the case, ie.
>>> pci_enable_msi() should fail.
>> ..
>> Exactly.  So it shouldn't be that, then.
>>
>>> It might still be worth looking at the quirks though, in case there's
>>> one for a previous revision of your bridge or something.
>>>
>>>> 3) Make sure MMIO ranges for 0xfee00000 are routed to local APIC
>>>>    ie each bridge needs to route that address somehow (negative decode
>>>> is common for upstream).
>>>> 4) manually trigger the MSI by doing a MMIO write to the correct
>>>> 0xfee00000 address with the assigned vector in order to see if your
>>>> interrupt handler gets called.
>>>
>>> And can you plug something directly into the PCIe bus? If so does MSI
>>> work on that?
>> ..
>>
>> Yup.  PCIe cards have no problem with MSI in that box.
>>
>> More later..
> 
> What kind of PCI-X bridge does that machine have? I know some AMD 
> HyperTransport to PCI-X bridges have broken MSI, but those should be 
> blacklisted already in the kernel..
..

Okay, I'm back looking at this now.  In the interim, the box has undergone
a complete re-install, and I think the original boot logs are gone for good.

Now (with 2.6.28.1), the boot code identifies a quirk, and pci_enable_msi()
does indeed fail where it once succeeded.  So all is well, but I don't know
why it wasn't working correctly earlier.

Oh well.

Cheers
