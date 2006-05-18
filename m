From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Thu, 18 May 2006 12:26:50 +0900
Message-ID: <446BE97A.2080303@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com> <446A9F13.4020907@emc.com> <446AAA33.5010800@gmail.com> <446B8F25.3040907@pobox.com> <446B8FC6.5040009@garzik.org> <446B9AA7.4000305@gmail.com> <446B9C1A.1060106@rtr.ca> <446BEB11.4030703@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:21452 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750804AbWERD1A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 23:27:00 -0400
Received: by ug-out-1314.google.com with SMTP id a2so388348ugf
        for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 20:26:59 -0700 (PDT)
In-Reply-To: <446BEB11.4030703@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

Ric Wheeler wrote:
> 
> Mark Lord wrote:
> 
>> Tejun Heo wrote:
>>
>>> ..
>>> Right.  Also, we need to snoop some passthrough commands and 
>>> revalidate/reconfigure when configuration is explicitly changed.
>>
>>
>> Once the sysfs attr's actually work, I'll probably re-do my hdparm
>> stuff to detect use them when available, avoiding the need for libata
>> to snoop passthrough commands.  But Jeff may (or not) want to snoop 
>> anyway.
>>
>> As a workaround for now, Ric is using the ugly hack attached here.
>>
>> Cheers
> 
> 
> With this patch, I can get the write cache to change properly, but I 
> still see rates that are "too fast" until I disable the queuing as 
> well.  I think that the barriers are supposed to work with NCQ enabled, 
> but might there be a trace of the old "disable" barrier support if 
> queuing is on left somewhere?

I think the easiest way to verify basic things are working is by booting 
the machine with write cache enabled.

> Also, disabling the queue via setting 
> /sys/class/scsi_disk/4\:0\:0\:0/device/queue_depth does not seem to take 
> effect unless I unmount the file system & remount.  I will  poke around 
> to see if reiserfs is disabling with queuing enabled & only reenables on 
> a fresh mount...

I don't think you're supposed to change cache setting underneath a live FS.

-- 
tejun
