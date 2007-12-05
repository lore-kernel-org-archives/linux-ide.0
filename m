From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 01/14] libata: update atapi_eh_request_sense() such that
 lbam/lbah contains buffer size
Date: Wed, 05 Dec 2007 09:47:29 +0900
Message-ID: <4755F521.1020201@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468181752-git-send-email-htejun@gmail.com> <4755AA23.7010108@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:28208 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbXLEArp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 19:47:45 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6625734wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 16:47:44 -0800 (PST)
In-Reply-To: <4755AA23.7010108@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> While updating lbam/h for ATAPI commands, atapi_eh_request_sense() was
>> left out.  Update it.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>>  drivers/ata/libata-eh.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 77083b5..2e3d3a2 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -1302,8 +1302,8 @@ static unsigned int
>> atapi_eh_request_sense(struct ata_queued_cmd *qc)
>>          tf.feature |= ATAPI_PKT_DMA;
>>      } else {
>>          tf.protocol = ATA_PROT_ATAPI;
>> -        tf.lbam = (8 * 1024) & 0xff;
>> -        tf.lbah = (8 * 1024) >> 8;
>> +        tf.lbam = SCSI_SENSE_BUFFERSIZE;
>> +        tf.lbah = 0;
> 
> seems like #upstream-fixes material?

I'm not too sure yet whether we'll need to revert ATAPI transfer chunk
size change for #upstream-fixes or not.  It fixes some cases while
breaking others.  Dunno which side is larger but we definitely don't
wanna regress in a released kernel.  I thought adding full chunk
draining would fix regressions but apparently not.  Fortunately, with
full ATAPI data transfer improvement patch applied, it works.  I'll
investigate more.

Thanks.

-- 
tejun
