From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PCI Constants Update for SATA Driver
Date: Wed, 02 Mar 2005 00:49:49 -0500
Message-ID: <422553FD.2050000@pobox.com>
References: <1109526163.19325.2.camel@forge.intermeta.de>	 <42220CAA.90702@pobox.com> <1109728077.5610.78.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64706 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262185AbVCBFuL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Mar 2005 00:50:11 -0500
In-Reply-To: <1109728077.5610.78.camel@gaston>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Henning Schmiedehausen <hps@intermeta.de>, Linux IDE Mailingliste <linux-ide@vger.kernel.org>

Benjamin Herrenschmidt wrote:
> On Sun, 2005-02-27 at 13:08 -0500, Jeff Garzik wrote:
> 
>>Henning Schmiedehausen wrote:
>>
>>>Hi,
>>>
>>>having the various constants in pci_ids.h is a really good thing for
>>>grepping through the kernel source. And if they were used, it would be
>>>even better (if you e.g. are looking for which driver claims an SIImage
>>>3112 card...). However, the sata_xxx.c files in the drivers/scsi
>>>directory are notorious for not using the PCI Ids but just hard coded
>>>numbers.
>>>
>>>This patch tries to fix this. It is against the 2.6.10 tree from Fedora
>>>Core 3 but should apply to a regular 2.6.10 too.
>>
>>"Notorious", heh.  This is quite intentional.
>>
>>PCI device ids are just random numbers that vendors pick out of thin 
>>air.  Device id symbolic constants have little value, and creates churn 
>>whereby every kernel hacker is patching include/linux/pci_ids.h.
> 
> 
> I still agree that it's handy to use the constants in pci_ids.h when
> available, I do that for grepping regulary.
> 
> What I usually do is that I separately send patches updating pci_ids.h
> and driver patches. In some cases, I leave the numeric constant in the
> driver until I'm sure the pci_ids.h patch got in, then eventually fix up
> the driver to use the constant.

Well, for SATA and net drivers, I strongly prefer

	{ PCI_VENDOR_ID_xxx, 0x1234, PCI_ANY_ID, PCI_ANY_ID, ... }
		or
	{ PCI_DEVICE(PCI_VENDOR_ID_xxx, 0x1234), ... }

IFF [1] the PCI device id is used in more than one place in the entire 
kernel, then using PCI_DEVICE_ID_xxx is OK.

Regards,

	Jeff


[1] - that's "if and only if", for the non-math types

