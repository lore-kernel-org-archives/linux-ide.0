From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_it8213: MWDMA0 is unsupported
Date: Thu, 26 Nov 2009 21:33:14 +0300
Message-ID: <4B0EC9EA.9000608@ru.mvista.com>
References: <200911261728.36433.bzolnier@gmail.com> <200911261903.01199.bzolnier@gmail.com> <4B0EC52B.2070805@ru.mvista.com> <200911261927.00597.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:49958 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751512AbZKZScR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 13:32:17 -0500
In-Reply-To: <200911261927.00597.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>>>>>MWDMA0 timings cannot be met with the PIIX based controller
>>>>>>>programming interface.

>>>>>>>This change should be safe as this is how we have been doing
>>>>>>>things in IDE it8213 host driver for years.

>>>>>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>>>>>>---
>>>>>>>Verified with the documentation (similar case as with pata_efar).

>>>>>>Uhhh, no...

>>>>>>Too many damn drivers.

>>>>>>Too much damn duplication.

>>>>>>Too much damn subtle differences here and there.

>>>>>>The hardware is probably fine for MWMDA0 when it comes to pata_{efar,it8213},
>>>>>>it just not documented properly in the data sheet.

>>>>>   How so with pata_efar? The active/recovery bitfields are still 2-bit 
>>>>>wide, no?

>>>>Yes but when TIMEx bit is disabled we are using XFER_PIO_SLOW timings.

>>    600 ns cycle vs spec'ed 480 ns? Is it really worth it?

> 960 ns actually

    That table you're looking at (probably in the SLC90E66 datasheet?) must 
be screwed up. 960 ns is used for command cycles, according to Intel's docs, 
data cycles run at 600 ns...

>>>>All data sheets including original Intel ones are a complete crap when it
>>>>comes to explicitly documenting this behavior.

>>>OTOH all drivers set TIMEx for MWDMA0 currently.. ?
>>
>>    ... which would give a grossly overclocked timing.

> Except ata_piix which blacklists MWDMA0 for _all_ PATA controllers.. :)

    :-)

> I'm leaving my patches as they were for now, unless somebody wants to
> untangle this mess this is a safest and quickest way forward..

MBR, Sergei
