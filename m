From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: merge irq-pio
Date: Fri, 26 May 2006 16:14:24 +0800
Message-ID: <4476B8E0.2090408@tw.ibm.com>
References: <11473544042174-git-send-email-htejun@gmail.com> <4472DE75.6010507@tw.ibm.com> <44736C03.8050104@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:28582 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750703AbWEZIOa
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 May 2006 04:14:30 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4Q8ETln020909
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 04:14:29 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4Q8ERjP198844
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 02:14:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4Q8EQC5032220
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 02:14:27 -0600
In-Reply-To: <44736C03.8050104@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Jeff Garzik wrote:
> Albert Lee wrote:
> 
>>> diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
>>> index 9646c39..0372be7 100644
>>> --- a/drivers/scsi/sata_vsc.c
>>> +++ b/drivers/scsi/sata_vsc.c
>>> @@ -221,14 +221,21 @@ static irqreturn_t vsc_sata_interrupt (i
>>>  
>>>              ap = host_set->ports[i];
>>>  
>>> -            if (ap && !(ap->flags &
>>> -                    (ATA_FLAG_DISABLED|ATA_FLAG_NOINTR))) {
>>> +            if (is_vsc_sata_int_err(i, int_status)) {
>>> +                u32 err_status;
>>> +                printk(KERN_DEBUG "%s: ignoring interrupt(s)\n",
>>> __FUNCTION__);
>>> +                err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
>>> +                vsc_sata_scr_write(ap, SCR_ERROR, err_status);
>>> +                handled++;
>>> +            }
>>> +
>>> +            if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
>>>                  struct ata_queued_cmd *qc;
>>>  
>>
>>
>> The if(is_vsc_sata_int_err(i, int_status)) { } block is not irq-pio
>> related.
>> Maybe it is from somewhere else?
> 
> 
> It is from the merge I did with upstream, which conflicted in this area.
>  Is it not correct somehow, or just unexpected?
> 

Just unexpected. The merge looks ok.
--
albert

