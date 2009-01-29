From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 29 Jan 2009 18:22:05 +0300
Message-ID: <4981C99D.3090801@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <49787929.2010305@ru.mvista.com> <497F2C5E.9020205@ru.mvista.com> <200901291548.33238.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:43558 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753556AbZA2PVj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jan 2009 10:21:39 -0500
In-Reply-To: <200901291548.33238.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Hello.

Stanislaw Gruszka wrote:

>>>>>>Well, we could add #ifdef with diffrent implementation of 
>>>>>>init_smc_mode(), set_8bit_mode(), etc... 

>>>>>  No, #ifdef'ery is certainly not an option.

>>>>Why?

>>>   It's totally ugly and unacceptable way of doing things. It seems also 
>>>totally wrong to add support for totally incompatible SMC to this driver 
>>>(especially with #ifdef's). Another driver should be written if CF 
>>>support is required.

>>>>Other option is create some header files and implement and exporting 
>>>>these
>>>>functions from processor specific code. This add files dependencies 
>>>>and spread
>>>>things across sources, FWIW.

>>>   I don't think it's feasible as that SMC is just too different.

>>    Besides, AT91RM9200 code turned out to already be registering a platform 
>>device called at91_cf -- driver for which I have located in drivers/pcmcia/, 
>>so apparently they're not interested in True IDE mode support (and have 
>>overgeneralized the name as well :-).

> There can be AT91RM9200 boards where is only IDE hardware instead
> "full" Compact Flash support.

> Atmel publish application note with description how connect HDD to AT91RM9200.
> Connection is very similar as for SAM9, the major difference is using GPIO to control 
> CF ~CSx signals. Here is document:

    Horror... Frankly speaking, I don't see why they had to use GPIO and not 
the same decoding scheme as on AT91SAM9xxx.

> http://www.atmel.com/dyn/resources/prod_documents/doc6023.pdf

> Currently people at at91.com forum did board with HDD. As driver
> they use pata_platform with some hacks, which look very similar
> as things in this driver, except they use polling and not need irq quirk:

> http://www.at91.com/samphpbb/viewtopic.php?f=9&t=4528&p=15739

    It's not clear why they define IRQ resource not having IRQ.

> Stanislaw Gruszka

MBR, Sergei
