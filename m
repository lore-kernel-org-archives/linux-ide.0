From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] libata-2.6: Ignore interrupt before the ATAPI CDB
 is sent to the device
Date: Mon, 27 Jun 2005 23:06:36 -0400
Message-ID: <42C0BEBC.9080900@pobox.com>
References: <4271FE02.1080009@tw.ibm.com> <427200B4.4050308@tw.ibm.com> <4287D1E3.9070606@pobox.com> <428877F4.5050405@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:21972 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262473AbVF1DGu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2005 23:06:50 -0400
In-Reply-To: <428877F4.5050405@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Jens Axboe <axboe@suse.de>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> 
> Jeff:
> 
>>
>> There is an additional complication:
>>
>> As specified in IDENTIFY PACKET DEVICE Word 0, in some older ATAPI 
>> devices, the device will assert an interrupt after the CDB has been 
>> submitted to the device.
>>
>> Your patch is moving in the right direction...   but I think we should 
>> check Word 0 and perform actions accordingly, as some ATAPI devices 
>> appear to expect it.
> 
> 
> I didn't consider this case.
> Just take a look at the ATA-4 draft spec:
> 
> http://www.t13.org/project/d1153r18-ATA-ATAPI-4.pdf
> (Fig. 16, page. 236)
> "Some devices prior to ATA/ATAPI-4 assert INTRQ if enabled at this 
> point. See
> IDENTIFY PACKET DEVICE, word 0, bits 5-6 to determine if an interrupt 
> will occur."
> 
> The interrupt seems to be after PACKET but before CDB is sent.
> It looks like a good news, since the previous patch can almost handle 
> such interrupt.
> We can add IDENTIFY PACKET DEVICE Word 0 checking, if bit 6-5 is 01, 
> then we return irq_handled
> instead of ignoring the interrupt. Attached please find the revised 
> patch for your review.
> 
> 
>>
>> I wonder if your ATAPI device is one of these?
>>
> 
> My ATAPI devices at hand do not generate the interrupt before CDB is sent.
> (I wish I have one to test this patch.)
> The unexpected interrupt is caused by a pdc2027x hardware problem:
> When both primary/secondary channels of the pdc20275 are stressed,
> sometimes the interrupt in the 2nd channel will cause the ATA_DMA_INTR 
> bit of the 1st
> channel to be set. If only 1 channel is used, the unexpected interrupt 
> is never seen.
> 
> 
> Albert
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

You don't need to ignore the interrupt.  If you follow the host state 
machine, you need a cycle through INTRQ->check-status states, before 
proceeding with the rest of the transaction.

	Jeff



