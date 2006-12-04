From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Date: Mon, 4 Dec 2006 14:05:22 +0100
Message-ID: <F327897F-38A9-4FEF-9140-F623B0B70445@kernel.crashing.org>
References: <20061130165202.GA23205@aepfle.de> <20061204123854.GA28159@aepfle.de> <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org> <20061204125646.GA28600@aepfle.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:36737 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S936801AbWLDNGt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 08:06:49 -0500
In-Reply-To: <20061204125646.GA28600@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

>>> --- a/arch/powerpc/kernel/pci_64.c
>>> +++ b/arch/powerpc/kernel/pci_64.c
>>> @@ -1234,6 +1234,14 @@ static void __devinit fixup_resource(str
>>> 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
>>> 	unsigned long start, end, mask, offset;
>>>
>>> +	/*
>>> +	 * tell the core code that this ressource is unassigned
>>> +	 * fixes p630 winbond IDE with libata
>>> +	 */
>>> +	if (res->start == 0) {
>>> +		res->flags = 0;
>>> +		return;
>>> +	}
>>> 	if (res->flags & IORESOURCE_IO) {
>>> 		offset = (unsigned long)hose->io_base_virt - pci_io_base;
>>
>> Please make this run on pSeries only; on a PowerMac for
>
> I could just match for winbond an start == 0.

Why not fix it properly?  The "0 means unassigned" thing is
something this specific firmware does, it is not a standard
or anything, and certainly not a property of the winbond
hardware (it _will_ react to legacy I/O at address 0).

So make this new code only run when this firmware is used,
too (perhaps do a check in prom_init and remove this BAR
from the assigned addresses property?)


Segher

