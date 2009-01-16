From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Fri, 16 Jan 2009 18:34:23 +0300
Message-ID: <4970A8FF.4080404@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <20090114131727.5b0e5193@lxorguk.ukuu.org.uk> <49708C55.1020204@ru.mvista.com> <200901161603.03699.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:51191 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752863AbZAPPdv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jan 2009 10:33:51 -0500
In-Reply-To: <200901161603.03699.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ddaney@caviumnetworks.com

Hello.

Stanislaw Gruszka wrote:

>>>You really don't want to put special board specific code in generic
>>>locations. In the libata case you don't need to and I think in the ide
>>>case you can avoid it too by wrapping the IRQ handler.

>>   Unfortunately, it seems you can't wrap ide_intr(), at least with the 
>>current code.

> Perhaps only EXPORT_SYMBOL is missed.

    No, init_irq() always calls request_irq() with ide_intr as argument.

>>>Libata also supports polled mode.

>>   Yeah. Stanslaw, I'd (have to) advise going the libata way in this 
>>case -- in case you want to avoid the additional trouble of porting this 
>>broken-minded IRQ implementation to the IDE core... 

> I think, I will try to add AT91 stuff for pata_at91 to have this hardware
> support in mineline. I will also finish at91_ide for my company usage with
> older kernel.

    Well, it can also be accepted into the IDE subsystem (minus the IRQ hack) 
-- it would fit the embedded use case better due to a lower memory  footprint 
(and not having to emulate SCSI). Libata has been known to lose to IDE core in 
the PIO transfer speeds (very significantly) though I'm not sure of the 
current state of affairs...

>>   Stanislaw's patch is adding the DIOx- to address hold time (t9) to 
>>the existing ones. While there's has been already a patch by David Daney 
>>adding this timing to libata (however, the author have ditched this idea 
>>finally), the table in ide-timings.c still misses it, as well as the PIO 
>>mode 6 timings...

> I use t9 for calculating memory controller settings, but maybe it is unneeded,
> pata_at91 don't use this value.

    You mean pata_at32? It might have been that this detail was missed...

> Cheers
> Stanislaw Gruszka

WBR, Sergei
