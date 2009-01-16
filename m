From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Fri, 16 Jan 2009 16:32:05 +0300
Message-ID: <49708C55.1020204@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <20090114131727.5b0e5193@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:49114 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758849AbZAPNcN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jan 2009 08:32:13 -0500
In-Reply-To: <20090114131727.5b0e5193@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ddaney@caviumnetworks.com

Hello.

Alan Cox wrote:

>> +#ifdef AT91_GPIO_IRQ_HACK
>> +#define NR_TRIES 10
>> +	int ntries = 0;
>> +	int pin_val1, pin_val2;	
>> +	do {
>> +		pin_val1 = at91_get_gpio_value(AT91_PIN_PB20);
>> +		pin_val2 = at91_get_gpio_value(AT91_PIN_PB20);
>> +	} while (pin_val1 != pin_val2 && ntries++ < NR_TRIES);
>>     
>
> You really don't want to put special board specific code in generic
> locations. In the libata case you don't need to and I think in the ide
> case you can avoid it too by wrapping the IRQ handler.

   Unfortunately, it seems you can't wrap ide_intr(), at least with the 
current code.

> Libata also supports polled mode.
>   

   Yeah. Stanslaw, I'd (have to) advise going the libata way in this 
case -- in case you want to avoid the additional trouble of porting this 
broken-minded IRQ implementation to the IDE core... although the real 
issue seems to olny be with the development board.

> Other comments:
> 	- The old and new ATA layers both have timing tables and timing
> functions so you don't need all the duplicated timing table logic.
>   

   Stanislaw's patch is adding the DIOx- to address hold time (t9) to 
the existing ones. While there's has been already a patch by David Daney 
adding this timing to libata (however, the author have ditched this idea 
finally), the table in ide-timings.c still misses it, as well as the PIO 
mode 6 timings...
   Hm, besides the address setup and active/recovery times there seem 
wrong for the PIO mode 5: they should be 15 and 65/25, not 20 and 50/30. 
Bart, are you reading this? :-)

WBR, Sergei


