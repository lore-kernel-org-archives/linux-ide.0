From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata: Fix experimental tags
Date: Tue, 21 Oct 2008 10:32:28 -0400
Message-ID: <48FDE7FC.2050303@garzik.org>
References: <20081021124529.31706.54794.stgit@localhost.localdomain> <48FDE78A.2000008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50924 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbYJUOci (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2008 10:32:38 -0400
In-Reply-To: <48FDE78A.2000008@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Hello.
> 
> Alan Cox wrote:
> 
>> Various tags are now way out of date
> 
>> Signed-off-by: Alan Cox <alan@redhat.com>
> 
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 78fbec8..4095a2c 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
> [...]
>> @@ -389,7 +389,7 @@ config PATA_HPT3X3_DMA
>>        problems with DMA on this chipset.
>>  
>>  config PATA_ISAPNP
>> -    tristate "ISA Plug and Play PATA support (Experimental)"
>> +    tristate "ISA Plug and Play PATA support"
>>      depends on EXPERIMENTAL && ISAPNP
>>      help
>>        This option enables support for ISA plug & play ATA
> [...]
>> @@ -507,7 +507,7 @@ config PATA_NS87410
>>        If unsure, say N.
>>  
>>  config PATA_NS87415
>> -    tristate "Nat Semi NS87415 PATA support (Experimental)"
>> +    tristate "Nat Semi NS87415 PATA support"
>>      depends on PCI && EXPERIMENTAL
>>      help
>>        This option enables support for the National Semiconductor
>> @@ -544,7 +544,7 @@ config PATA_PCMCIA
>>        If unsure, say N.
>>  
>>  config PATA_PDC_OLD
>> -    tristate "Older Promise PATA controller support (Experimental)"
>> +    tristate "Older Promise PATA controller support"
>>      depends on PCI && EXPERIMENTAL
>>      help
>>        This option enables support for the Promise 20246, 20262, 20263,
> [...]
>> @@ -586,7 +586,7 @@ config PATA_RZ1000
>>        If unsure, say N.
>>  
>>  config PATA_SC1200
>> -    tristate "SC1200 PATA support (Very Experimental)"
>> +    tristate "SC1200 PATA support"
>>      depends on PCI && EXPERIMENTAL
>>      help
>>        This option enables support for the NatSemi/AMD SC1200 SoC
>> @@ -620,7 +620,7 @@ config PATA_SIL680
>>        If unsure, say N.
>>  
>>  config PATA_SIS
>> -    tristate "SiS PATA support (Experimental)"
>> +    tristate "SiS PATA support"
>>      depends on PCI && EXPERIMENTAL
> 
>    Didn't you forget to remove EXPERIMENTAL as well on the above?

Indeed he does...


