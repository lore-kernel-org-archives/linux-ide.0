From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] resolve collision of generic ATA_FLAG_LOWTAG and driver
 specific flag
Date: Fri, 10 Apr 2015 19:55:25 +0300
Message-ID: <5528007D.1080703@cogentembedded.com>
References: <201504092009.08703.ronny.hegewald@online.de> <20150410111516.GA15230@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:33598 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbbDJQz3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Apr 2015 12:55:29 -0400
Received: by layy10 with SMTP id y10so17566337lay.0
        for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2015 09:55:27 -0700 (PDT)
In-Reply-To: <20150410111516.GA15230@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Ronny Hegewald <ronny.hegewald@online.de>
Cc: linux-ide@vger.kernel.org

Hello.

On 04/10/2015 02:15 PM, Christoph Hellwig wrote:

>> The patch "libata: allow sata_sil24 to opt-out of tag ordered submission"
>> (72dd299d5039a336493993dcc63413cf31d0e662) introduces a regression with the
>> sata_sil24 driver.

>> The new flag ATA_FLAG_LOWTAG accidentially uses the same bit as
>> SIL24_FLAG_PCIX_IRQ_WOC in the driver. This activates code for Silicon Image
>> 3132, which is only suppossed to run under 3124.
>>
>> ATA_FLAG_LOWTAG is only used in sata_sil24 and is planned to be removed soon,
>> so lets just use another bit for the flag in sata_sil24.
>>
>> Signed-off-by: Ronny Hegewald <Ronny.Hegewald@online.de>
>> Cc: stable@vger.kernel.org
>>
>> --- linux-3.18.5/drivers/ata/sata_sil24.c.org
>> +++ linux-3.18.5/drivers/ata/sata_sil24.c
>> @@ -247,7 +247,7 @@
>>   	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
>>   				  ATA_FLAG_NCQ | ATA_FLAG_ACPI_SATA |
>>   				  ATA_FLAG_AN | ATA_FLAG_PMP | ATA_FLAG_LOWTAG,
>> -	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
>> +	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 25), /* IRQ loss errata on PCI-X */

    This one also collides with ATA_FLAG_SAS_HOST.

> And this will clash as soon as the next flag is added.  Please don't
> abuse the common flag space for driver specific ones, and add a separate
> flags field for driver specific flags.

    Actually, bits 24-31 are reserved for the low-level driver usage (see the 
comment below ATA_FLAG_*), so it's the new ATA_FLAG_LOWTAG and 
ATA_FLAG_SAS_HOST that have violated the convention and should be moved 
(there's plenty of lower bits due to the removal of some obsolete flags).

WBR, Sergei

