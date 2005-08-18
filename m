From: Tejun Heo <htejun@gmail.com>
Subject: Re: when are buffers/caches flushed?
Date: Thu, 18 Aug 2005 21:19:01 +0900
Message-ID: <43047CB5.4080803@gmail.com>
References: <43046817.803@imc-berlin.de> <43046FD2.4080401@gmail.com> <43047229.7010007@imc-berlin.de> <43047830.4060705@gmail.com> <43047B1D.9010601@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:41885 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932217AbVHRMTW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Aug 2005 08:19:22 -0400
Received: by zproxy.gmail.com with SMTP id r28so272529nza
        for <linux-ide@vger.kernel.org>; Thu, 18 Aug 2005 05:19:20 -0700 (PDT)
In-Reply-To: <43047B1D.9010601@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Steven Scholz wrote:
> Tejun,
> 
>>>>> How about recent kernels? Does sync() block until buffers are flushed?
>>>>> How can I find out if the disk caches are actually flushed?
>>>>>
>>>>> I want to make sure that all data is flushed to my disk drive 
>>>>> before powering down the system.
>>>>
>>>>
>>>>  All disk caches are flushed before shutdown via the following path.
>>>>
>>>> kernel/sys.c::sys_reboot()
>>>> kernel/drivers/base/power/shutdown.c::device_shutdown()
>>>>  driver specific ->shutdown callback, for ide disks, the path is
>>>> drivers/ide/ide-disk.c::ide_device_shutdown()
>>>> drivers/ide/ide-disk.c::ide_cacheflush_p()
>>>> drivers/ide/ide-disk.c::do_idedisk_flushcache()
>>>>
>>>>  And, AFAIK, sync() doesn't flush disk caches.
>>>
>>>
>>> How about umount?
>>>
>>
>> [CC'ing Bartlomiej (Hi!)]
>>
>>  Hmmm, umount doesn't.  I think maybe adding cache flushing to sync 
>> and umount can be helpful.
> 
> 
> Ehm. So you're saying umount does _not_ flush the disk caches? BUT it 
> will flush the the fs buffers, right?

  Yeap, but it seems that currently ide-disk seems to flush only on 
reboot not on halt.  As soon as Bartlomiej confirms it, I'll submit a 
patch or he'll fix it.

> 
>>  And one more thing, ide-disk doesn't flush cache when shutting down. 
>> It flushes only when rebooting.
> 
> 
> How about ide-cs then? When I unregister a drive?
> 

  ide-cs is low-level driver, it just registers ide device with upper 
ide midlayer and ide-disk handles all the rest, so it's all the same there.

-- 
tejun
