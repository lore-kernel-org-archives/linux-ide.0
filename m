From: Mark Lord <liml@rtr.ca>
Subject: Re: libata, devm_*, and MSI ?
Date: Wed, 21 Jan 2009 10:05:03 -0500
Message-ID: <4977399F.7000104@rtr.ca>
References: <4975F5C1.8090107@rtr.ca>	 <alpine.LNX.1.00.0901201626090.19665@iabervon.org>	 <497698E2.7090807@rtr.ca>	 <da824cf30901202002g52fb73f9v8229fb702dcd033d@mail.gmail.com> <1232511378.11241.64.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:52840 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145AbZAUPFG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jan 2009 10:05:06 -0500
In-Reply-To: <1232511378.11241.64.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: michael@ellerman.id.au
Cc: Grant Grundler <grundler@google.com>, Daniel Barkalow <barkalow@iabervon.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-pci@vger.kernel.org

Michael Ellerman wrote:
> On Tue, 2009-01-20 at 20:02 -0800, Grant Grundler wrote:
..
>> 1) post lspci -v output to verify device (and bridges) is programmed correctly.
>> 2) look for chipset quirks that disable global msi
> 
> The kernel shouldn't let you enable MSI if that's the case, ie.
> pci_enable_msi() should fail.
..

Exactly.  So it shouldn't be that, then.

> It might still be worth looking at the quirks though, in case there's
> one for a previous revision of your bridge or something.
> 
>> 3) Make sure MMIO ranges for 0xfee00000 are routed to local APIC
>>    ie each bridge needs to route that address somehow (negative decode
>> is common for upstream).
>> 4) manually trigger the MSI by doing a MMIO write to the correct
>> 0xfee00000 address with the assigned vector in order to see if your
>> interrupt handler gets called.
> 
> And can you plug something directly into the PCIe bus? If so does MSI
> work on that?
..

Yup.  PCIe cards have no problem with MSI in that box.

More later..
