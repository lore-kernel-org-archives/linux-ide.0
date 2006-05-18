From: Ric Wheeler <ric@emc.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 23:33:37 -0400
Message-ID: <446BEB11.4030703@emc.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com> <446A9F13.4020907@emc.com> <446AAA33.5010800@gmail.com> <446B8F25.3040907@pobox.com> <446B8FC6.5040009@garzik.org> <446B9AA7.4000305@gmail.com> <446B9C1A.1060106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:8544 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751213AbWERCde (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 22:33:34 -0400
In-Reply-To: <446B9C1A.1060106@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>


Mark Lord wrote:

> Tejun Heo wrote:
>
>> ..
>> Right.  Also, we need to snoop some passthrough commands and 
>> revalidate/reconfigure when configuration is explicitly changed.
>
>
> Once the sysfs attr's actually work, I'll probably re-do my hdparm
> stuff to detect use them when available, avoiding the need for libata
> to snoop passthrough commands.  But Jeff may (or not) want to snoop 
> anyway.
>
> As a workaround for now, Ric is using the ugly hack attached here.
>
> Cheers


With this patch, I can get the write cache to change properly, but I 
still see rates that are "too fast" until I disable the queuing as 
well.  I think that the barriers are supposed to work with NCQ enabled, 
but might there be a trace of the old "disable" barrier support if 
queuing is on left somewhere?

Also, disabling the queue via setting 
/sys/class/scsi_disk/4\:0\:0\:0/device/queue_depth does not seem to take 
effect unless I unmount the file system & remount.  I will  poke around 
to see if reiserfs is disabling with queuing enabled & only reenables on 
a fresh mount...

ric


