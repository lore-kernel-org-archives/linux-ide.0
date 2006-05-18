From: Ric Wheeler <ric@emc.com>
Subject: Re: [RFT] major libata update
Date: Thu, 18 May 2006 07:58:27 -0400
Message-ID: <446C6163.7010002@emc.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com> <446A9F13.4020907@emc.com> <446AAA33.5010800@gmail.com> <446B8F25.3040907@pobox.com> <446B8FC6.5040009@garzik.org> <446B9AA7.4000305@gmail.com> <446B9C1A.1060106@rtr.ca> <446BEB11.4030703@emc.com> <446BE97A.2080303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:1902 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751289AbWERK6q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 06:58:46 -0400
In-Reply-To: <446BE97A.2080303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>



Tejun Heo wrote:

>>> Once the sysfs attr's actually work, I'll probably re-do my hdparm
>>> stuff to detect use them when available, avoiding the need for libata
>>> to snoop passthrough commands.  But Jeff may (or not) want to snoop 
>>> anyway.
>>>
>>> As a workaround for now, Ric is using the ugly hack attached here.
>>>
>>> Cheers
>>
>>
>>
>> With this patch, I can get the write cache to change properly, but I 
>> still see rates that are "too fast" until I disable the queuing as 
>> well.  I think that the barriers are supposed to work with NCQ 
>> enabled, but might there be a trace of the old "disable" barrier 
>> support if queuing is on left somewhere?
>
>
> I think the easiest way to verify basic things are working is by 
> booting the machine with write cache enabled.

You can measure the rate with barriers enabled or not on a per file 
system instance (ie, mount barrier=none) to get a quick baseline. This 
rate has been an extremely accurate way for us to diagnose big issues 
(like the barrier is just not working - you get hundreds of files/sec 
instead of tens of files/sec ;-)) or subtle ones like regressions in 
disk firmware.

For us, the broader issue is that the rest of the company only uses 
drives with write cache disabled & as the small group, we have to dip 
into their manufacturing stream and use the parts as the rest of the 
company dictates.  Being able to toggle the write cache (before mounting 
a file system) is one of the weird edge cases that few others care about ;-)

>
>> Also, disabling the queue via setting 
>> /sys/class/scsi_disk/4\:0\:0\:0/device/queue_depth does not seem to 
>> take effect unless I unmount the file system & remount.  I will  poke 
>> around to see if reiserfs is disabling with queuing enabled & only 
>> reenables on a fresh mount...
>
>
> I don't think you're supposed to change cache setting underneath a 
> live FS.


Makes sense - I don't see logic in reiserfs at least that looks at (or 
knows) about anything other than "did my barrier op" fail.  When that 
happens, it should log a "disabling barriers for /dev/sdX" and leave 
them disabled.  I did not see that message so I suspect that we still 
have some lower level mechanism. 

A different discussion is what we should do or log when we detect this - 
i.e., write cache enabled and barrier ops not supported (disable write 
cache?  log a scarier message? ignore it?).  Today's behavior is 
probably what most home users want (run as fast as I can, absolute data 
integrity over power failures not a big deal) but not the right behavior 
for critical data (i.e., forget performance, make sure my data is always 
safe ).

I will keep poking at this today to try and clarify things.

