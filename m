From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] libata: use AC_ERR_TIMEOUT err_mask for time out
Date: Sat, 01 Apr 2006 03:14:18 +0900
Message-ID: <442D717A.7080501@gmail.com>
References: <442CC185.3060200@tw.ibm.com> <442D4561.60705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:37445 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932187AbWCaSOZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 13:14:25 -0500
Received: by zproxy.gmail.com with SMTP id o37so990948nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 10:14:24 -0800 (PST)
In-Reply-To: <442D4561.60705@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, IDE Linux <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Albert Lee wrote:
>> Use AC_ERR_TIMEOUT err_mask for time out,
>> instead of generating err_mask from drv_stat.
>>
>> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
>> ---
>> This patch was accepted in irq-pio before.
>>
>> Patch against upstream (8b316a3973f05e572b4edeeda9072987f6bbaa44).
>> For your review, thanks.
>>
>> Albert
>>
>> --- upstream0/drivers/scsi/libata-core.c    2006-03-31 
>> 13:33:15.000000000 +0800
>> +++ upstream1/drivers/scsi/libata-core.c    2006-03-31 
>> 13:34:59.000000000 +0800
>> @@ -3827,7 +3827,7 @@ static void ata_qc_timeout(struct ata_qu
>>                 ap->id, qc->tf.command, drv_stat, host_stat);
>>  
>>          /* complete taskfile transaction */
>> -        qc->err_mask |= ac_err_mask(drv_stat);
>> +        qc->err_mask |= AC_ERR_TIMEOUT;
> 
> The intention here is to catch missed interrupts; due to flaky hardware 
> or buggy drivers, we may miss an interrupt, but still be able to 
> complete the qc in the timeout handler.  Thus, if the ac_err_mask() 
> indicates a BSY or DRQ or DF is asserted, it will indicate an error, 
> otherwise not.
> 
> So, NAK, and we should fix irq-pio for this as well...
> 

Hello, Jeff. Hello, Albert.

I think we must not successfully finish a qc after timeout. If a device 
hasn't replied in 30 seconds, it's best to assume the device is in an 
unknown state. ATA TF registers just don't have enough information to 
tell whether it looks like that because it finished the command or it 
has simply forgotten about everything.

For example, if a communication error occurs while a qc is being issued 
and the controller fails to report, the device would have been in the 
ready state until the qc times out. It does know nothing about the 
command but ->eng_timeout will complete the command successfully 
potentially causing data corruption.

Or, if a power fluctation or static discharge breaks the link while a qc 
is in progress (this happens very easily with SATA, gigahertz serial 
signals are easy to disrupt), it can result in PHY reset causing the 
device to forget about the command. Similar result can be obtained with 
the right combination of device and controller by simply unplugging and 
replugging the cable while commands are in progress. (I've done a lot of 
it.)

It just isn't worth to successfully complete a command after 30 seconds 
at the risk of data corruption. If the device/controller times out on 
most of commands, the combination is unuseable no matter what we do on 
timeout (one command every 30secs..). If the combination fails 
occasionally, retrying doesn't take little time and is much safer.

Thanks.

-- 
tejun
