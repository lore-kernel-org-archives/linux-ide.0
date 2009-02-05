From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] AT91: initialize IDE driver on AT91SAM9263 cpu
Date: Thu, 05 Feb 2009 15:03:00 +0300
Message-ID: <498AD574.9050003@ru.mvista.com>
References: <200902031147.41822.stf_xl@wp.pl> <cd73a99e0902031227x678ebfa3h14207aeaf00a406c@mail.gmail.com> <200902041036.30785.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:49708 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752889AbZBEMDI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Feb 2009 07:03:08 -0500
In-Reply-To: <200902041036.30785.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <avictor.za@gmail.com>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Hello.

Stanislaw Gruszka wrote:

>>> +void __init at91_add_device_ide(struct at91_ide_data *data)
>>> +{
>>>       
>> This platform initialization code is virtually identical to the
>> at91_cf version submitted by Uros Bizjak, albeit for the SAM9260.
>> Similarly the "at91_cf_data" and "at91_ide_data" structs.
>>
>> Wouldn't it be better to have a single CF initialization function, and
>> you specify whether you want "plain CF" mode or True-IDE mode?
>> You could even pass the same platform-resources structure (ie,
>> base-address of CF region), and have at91_ide setup the location of
>> the task-file and control registers from that base address.
>>     
> Yes, this can be merged together. Ronetix already did a SAM9263 board
> and linux patch with "full" CF device.
>
> http://download.ronetix.info/sk-eb926x/linux/kernel/2.6.28/003_linux-2.6.28-at91-ronetix-12012009.patch
>   

   This patch is clearly incomplete because drivers/pcmcia/at91_cf.c 
does accesses AT91RM9200 specific SMC register, but the patch does 
nothing about making this work on AT91SAM9. Though it indeed seems that 
AT91SAM9 can be supported by that driver with minimum change -- perhaps 
by using cpi_is_*()...
   And WTF is that: sound/arm/at91-ac97.c.rej? :-/

> There are some difference,

   The CF memory mappings seem compatible b/w AT91SAM9 and AT91RM9200, 
except the latter doesn't support True IDE mode.

> but I think CF stuff can have one initialization function. Could this be a separate patch in later date? I would like marge
> at91_ide into mainline without changes if there will be no objections.
>   

   I would still like 2 resources merged into 1 -- however, possibly 
from the offset 0x00c00000, i.e. not including PCMCIA compatible memory 
space.

> Cheers
> Stanislaw Gruszka
>   

MBR, Sergei


