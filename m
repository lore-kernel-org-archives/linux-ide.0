From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: merge irq-pio
Date: Tue, 23 May 2006 16:09:39 -0400
Message-ID: <44736C03.8050104@pobox.com>
References: <11473544042174-git-send-email-htejun@gmail.com> <4472DE75.6010507@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41931 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751223AbWEWUJz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2006 16:09:55 -0400
In-Reply-To: <4472DE75.6010507@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
>> diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
>> index 9646c39..0372be7 100644
>> --- a/drivers/scsi/sata_vsc.c
>> +++ b/drivers/scsi/sata_vsc.c
>> @@ -221,14 +221,21 @@ static irqreturn_t vsc_sata_interrupt (i
>>  
>>  			ap = host_set->ports[i];
>>  
>> -			if (ap && !(ap->flags &
>> -				    (ATA_FLAG_DISABLED|ATA_FLAG_NOINTR))) {
>> +			if (is_vsc_sata_int_err(i, int_status)) {
>> +				u32 err_status;
>> +				printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
>> +				err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
>> +				vsc_sata_scr_write(ap, SCR_ERROR, err_status);
>> +				handled++;
>> +			}
>> +
>> +			if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
>>  				struct ata_queued_cmd *qc;
>>  
> 
> The if(is_vsc_sata_int_err(i, int_status)) { } block is not irq-pio related.
> Maybe it is from somewhere else?

It is from the merge I did with upstream, which conflicted in this area. 
  Is it not correct somehow, or just unexpected?

Your 'minor fix' patch is now in my Pending folder.

	Jeff


