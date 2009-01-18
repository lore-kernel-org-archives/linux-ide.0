From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Sun, 18 Jan 2009 13:58:43 +0300
Message-ID: <49730B63.4080500@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl>	<20090114131727.5b0e5193@lxorguk.ukuu.org.uk>	<49708C55.1020204@ru.mvista.com>	<200901161603.03699.stf_xl@wp.pl>	<4970A8FF.4080404@ru.mvista.com> <20090116161342.4229667f@lxorguk.ukuu.org.uk> <49723AB5.7000809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:20030 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761043AbZARK6y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Jan 2009 05:58:54 -0500
In-Reply-To: <49723AB5.7000809@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ddaney@caviumnetworks.com

Hello, I wrote:

>>> the PIO transfer speeds (very significantly) though I'm not sure of 
>>> the current state of affairs...
>>>     
>>
>> 16bit only performance is identical (as you'd expect)
>
>   Well, I don't know what to expect, having seen figures like 0.5 (or 
> 1.5) MB/s cited on this list...

   Instead of going to bed, I tried booting FC8 (2.6.23.y) off DVD in 
rescue mode and suppressing libata's DMA use: hdparm -t topped at around 
1 MB/s from both SATA hard drive and PATA DVD drive with sata_sil driven 
the former and pata_atiixp the latter... I wasn't able to compare 
results with IDE core of course.

>> identical with the 32bit pio patches applied
>>   
> 32bit is now
>
>   Hm, I didn't realize 32-bit I/O really can really boost the IDE 
> speed. I vaguely remember (or misremember) benchmarking drives under 
> DOS (many years ago) with and without 32-bit access enabled in the 
> BIOS Setup and not seeing any significant differences. Perhpas it's 
> worth to re-benchmark this in Linux if I find the time...

   With hdparm being able to control that via its -c option when using 
IDE driver, it shouldn't take much time...

MBR, Sergei


