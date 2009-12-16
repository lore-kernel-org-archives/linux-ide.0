From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: fix reporting of drained bytes when clearing
 DRQ
Date: Wed, 16 Dec 2009 05:21:30 -0500
Message-ID: <4B28B4AA.9080102@garzik.org>
References: <4B1F0FEA.7070403@gmail.com> <4B283507.1090808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:56884 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768AbZLPKVe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Dec 2009 05:21:34 -0500
Received: by gxk3 with SMTP id 3so798104gxk.1
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 02:21:33 -0800 (PST)
In-Reply-To: <4B283507.1090808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: ide <linux-ide@vger.kernel.org>

On 12/15/2009 08:16 PM, Robert Hancock wrote:
> On 12/08/2009 08:48 PM, Robert Hancock wrote:
>> When we drain data from a device to clear DRQ during error recovery,
>> the number
>> of bytes reported as drained is too low by a factor of 2 because the
>> count
>> is actually reporting the number of words drained, not bytes. Fix this.
>>
>> Signed-off-by: Robert Hancock<hancockrwd@gmail.com>
>>
>> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
>> index 51eb1e2..3afa21b 100644
>> --- a/drivers/ata/libata-sff.c
>> +++ b/drivers/ata/libata-sff.c
>> @@ -2275,7 +2275,7 @@ void ata_sff_drain_fifo(struct ata_queued_cmd *qc)
>> ap = qc->ap;
>> /* Drain up to 64K of data before we give up this recovery method */
>> for (count = 0; (ap->ops->sff_check_status(ap)& ATA_DRQ)
>> - && count< 32768; count++)
>> + && count< 65536; count += 2)
>> ioread16(ap->ioaddr.data_addr);
>>
>> /* Can become DEBUG later */
>
> Jeff, ping?

No worries, it's in the local queue...

	Jeff



