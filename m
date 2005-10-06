From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: highmem pages
Date: Thu, 06 Oct 2005 18:35:25 +0800
Message-ID: <4344FDED.1080402@tw.ibm.com>
References: <43438258.9080706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:64479 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750804AbVJFKfo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 06:35:44 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j96AZcjN028634
	for <linux-ide@vger.kernel.org>; Thu, 6 Oct 2005 06:35:38 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j96AZct2099106
	for <linux-ide@vger.kernel.org>; Thu, 6 Oct 2005 06:35:38 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j96AZbvn019179
	for <linux-ide@vger.kernel.org>; Thu, 6 Oct 2005 06:35:37 -0400
In-Reply-To: <43438258.9080706@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Jeff Garzik wrote:
> 
> Here is an interesting code snippet from ide-scsi, that could be useful 
> in libata:
> 
>>                 count = min(pc->sg->length - pc->b_count, bcount);
>>                 if (PageHighMem(pc->sg->page)) {
>>                         unsigned long flags;
>>
>>                         local_irq_save(flags);
>>                         buf = kmap_atomic(pc->sg->page, KM_IRQ0) + 
>> pc->sg->offse
>> t;
>>                         drive->hwif->atapi_input_bytes(drive, buf + 
>> pc->b_count,
>>  count);
>>                         kunmap_atomic(buf - pc->sg->offset, KM_IRQ0);
>>                         local_irq_restore(flags);
>>                 } else {
>>                         buf = page_address(pc->sg->page) + 
>> pc->sg->offset;
>>                         drive->hwif->atapi_input_bytes(drive, buf + 
>> pc->b_count,
>>  count);
>>                }
> 

Thanks for the advice. The kmap_atomic() usage optimization patches are ready:

   patch 1/3: reorganize ata_pio_sector() and __atapi_pio_bytes()
   patch 2/3: reorganize "buf + offset"
   patch 3/3: use PageHighMem() to optimize the kmap_atomic() usage

Patch against libata-dev irq-pio branch (c71c18576d0d8aa4db876c737c3c597c724cf02f).
For your review and advice, thanks.

Albert


