From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Sat, 17 Jan 2009 19:45:27 +0300
Message-ID: <49720B27.2030103@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <20090114131727.5b0e5193@lxorguk.ukuu.org.uk> <49708C55.1020204@ru.mvista.com> <200901161758.38037.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:8815 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757781AbZAQQpi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jan 2009 11:45:38 -0500
In-Reply-To: <200901161758.38037.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Stanislaw Gruszka <stf_xl@wp.pl>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, ddaney@caviumnetworks.com

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>> +#ifdef AT91_GPIO_IRQ_HACK
>>>> +#define NR_TRIES 10
>>>> +	int ntries = 0;
>>>> +	int pin_val1, pin_val2;	
>>>> +	do {
>>>> +		pin_val1 = at91_get_gpio_value(AT91_PIN_PB20);
>>>> +		pin_val2 = at91_get_gpio_value(AT91_PIN_PB20);
>>>> +	} while (pin_val1 != pin_val2 && ntries++ < NR_TRIES);
>>>>     
>>>>         
>>> You really don't want to put special board specific code in generic
>>> locations. In the libata case you don't need to and I think in the ide
>>> case you can avoid it too by wrapping the IRQ handler.
>>>       
>>    Unfortunately, it seems you can't wrap ide_intr(), at least with the 
>> current code.
>>     
>
> Well... there shouldn't be much problem with:
>
> * adding ->irq_handler method to struct ide_port_info and struct ide_host
>
>   [ which reminds me that struct ide_port_info would be better named struct
>     ide_host_info and IIRC somebody has already noticed it in the past ;-) ]
>
> * exporting ide_intr()
>
> * adding ide_interrupt() wrapper around ide_intr() which will do sth like:
>
> 	if (host->irq_handler)
> 		return host->irq_handler()
> 	else
> 		return ide_intr()
>
>   and then passing &ide_interrupt instead of &ide_intr to request_irq()
>
> * implementing at91_irq_handler()
>
> * Et Voila!
>
> In the longer term it would also be useful for other purposes
> (like adding ATA-like flash devices support to IDE).
>   

   Oh, you must be meaning that brain damaged Disk-On-Chip H3... but I 
don't think it would need to wrap ide_intr() as it should have its own 
"class driver" (like ide-disk).

>>> Other comments:
>>> 	- The old and new ATA layers both have timing tables and timing
>>> functions so you don't need all the duplicated timing table logic.
>>>   
>>>       
>>    Stanislaw's patch is adding the DIOx- to address hold time (t9) to 
>> the existing ones. While there's has been already a patch by David Daney 
>> adding this timing to libata (however, the author have ditched this idea 
>> finally), the table in ide-timings.c still misses it, as well as the PIO 
>> mode 6 timings...
>>     
>
> Indeed... should be easy and quick to fix though.
>   

   We need to add support for CFA's MWDMA modes 3 and 4 then as well...

>>    Hm, besides the address setup and active/recovery times there seem 
>> wrong for the PIO mode 5: they should be 15 and 65/25, not 20 and 50/30. 
>> Bart, are you reading this? :-)
>>     
>
> Yeah.  Where's the patch? :-)
>   

   I was not feeling confident because the address setup and recovery 
times defined by CF spec. are less than those we have (that were spec'ed 
by Quantum I guess?). However, Wikipedia's article about PIO tells me 
that no PIO5 capable hard disks were manufactured...

> Thanks,
> Bart

MBR, Sergei


