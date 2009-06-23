From: David Miller <davem@davemloft.net>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Tue, 23 Jun 2009 03:15:06 -0700 (PDT)
Message-ID: <20090623.031506.214747802.davem@davemloft.net>
References: <200906221938.27574.bzolnier@gmail.com>
	<200906222101.38586.elendil@planet.nl>
	<200906222335.06700.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60381
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752048AbZFWKPB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 06:15:01 -0400
In-Reply-To: <200906222335.06700.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: elendil@planet.nl, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 22 Jun 2009 23:35:06 +0200

> On Monday 22 June 2009 21:01:37 Frans Pop wrote:
>> yet have the DMA problem. The commit above is from the 2.6.30 development 
>> cycle, so that fits. I expect you can verify it from the identify data.
> 
> I had the same idea initially, unfortunately bit 1 is set for word 53 so this
> must be something else...

So this change should have had zero effect for Frans's case.

I double checked everything with test programs going over his
ID dump and it all checks out.

We might need to bisect this one.  But Frans, just for the record
could you simply test reverting just that hunk?  Thanks!

>> @@ -396,15 +393,14 @@ int ide_id_dma_bug(ide_drive_t *drive)
>>  
>>  	if (id[ATA_ID_FIELD_VALID] & 4) {
>>  		if ((id[ATA_ID_UDMA_MODES] >> 8) &&
>>  		    (id[ATA_ID_MWDMA_MODES] >> 8))
>>  			goto err_out;
>> -	} else if (id[ATA_ID_FIELD_VALID] & 2) {
>> -		if ((id[ATA_ID_MWDMA_MODES] >> 8) &&
>> -		    (id[ATA_ID_SWDMA_MODES] >> 8))
>> -			goto err_out;
>> -	}
>> +	} else if ((id[ATA_ID_MWDMA_MODES] >> 8) &&
>> +		   (id[ATA_ID_SWDMA_MODES] >> 8))
>> +		goto err_out;
