From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/11] ahci: Export generic AHCI symbols, turn libahci
 into a separate module
Date: Wed, 03 Mar 2010 13:34:01 -0500
Message-ID: <4B8EAB99.5080804@pobox.com>
References: <20100303171713.GA6322@oksana.dev.rtsoft.ru> <20100303171749.GJ12362@oksana.dev.rtsoft.ru> <4B8EA21A.2040601@ru.mvista.com> <20100303180834.GA11184@oksana.dev.rtsoft.ru> <20100303181402.GA22792@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f198.google.com ([209.85.221.198]:44579 "EHLO
	mail-qy0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab0CCSeW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2010 13:34:22 -0500
In-Reply-To: <20100303181402.GA22792@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/03/2010 01:14 PM, Anton Vorontsov wrote:
> On Wed, Mar 03, 2010 at 09:08:34PM +0300, Anton Vorontsov wrote:
>> On Wed, Mar 03, 2010 at 08:53:30PM +0300, Sergei Shtylyov wrote:
>> [...]
>>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>>> index 01c52c4..365a9da 100644
>>>> --- a/drivers/ata/Kconfig
>>>> +++ b/drivers/ata/Kconfig
>>>> @@ -59,12 +59,18 @@ config SATA_PMP
>>>> config SATA_AHCI
>>>> 	tristate "AHCI SATA support"
>>>> -	depends on PCI
>>>> 	help
>>>> 	  This option enables support for AHCI Serial ATA.
>>>> 	  If unsure, say N.
>>>> +config SATA_AHCI_PCI
>>>> +	tristate "PCI AHCI SATA support"
>>>> +	depends on SATA_AHCI&&  PCI
>>>
>>>    Perhaps it's worth to turn that into select SATA_AHCI and make
>>> SATA_AHCI invisible to users instead, so that each particular AHCI
>>> implementation could select it.
>>
>> No, we must maintain old .config's semantics. SATA_AHCI is already
>> visible to the users, and if we remove it, we'll break
>> 'make oldconfig'.
>>
>>>> +	default y
>>>
>>>    Why force the default "y" if the predecessor option SATA_AHCI
>>> didn't do it?
>>
>> For the same reason, to keep old .configs working.
>
> OTOH, we can introduce invisible SATA_LIBAHCI, which is better,
> I think.

There is no need for any Kconfig wrangling.  Just do it in the Makefile:

obj-$(SATA_AHCI_EXAMPLE1) += sata_example1.o libahci.o
obj-$(SATA_AHCI_EXAMPLE2) += sata_example2.o libahci.o

Thus,

1) update PCI ahci's Makefile entry
2) add Kconfig and Makefile entry for platform_ahci

No need to touch PCI AHCI's Kconfig bits at all.

Regards,

	Jeff


