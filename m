From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: when are buffers/caches flushed?
Date: Thu, 18 Aug 2005 14:12:13 +0200
Message-ID: <43047B1D.9010601@imc-berlin.de>
References: <43046817.803@imc-berlin.de> <43046FD2.4080401@gmail.com> <43047229.7010007@imc-berlin.de> <43047830.4060705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:7179 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S932214AbVHRMMR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 08:12:17 -0400
In-Reply-To: <43047830.4060705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Tejun,

>>>> How about recent kernels? Does sync() block until buffers are flushed?
>>>> How can I find out if the disk caches are actually flushed?
>>>>
>>>> I want to make sure that all data is flushed to my disk drive before 
>>>> powering down the system.
>>>
>>>  All disk caches are flushed before shutdown via the following path.
>>>
>>> kernel/sys.c::sys_reboot()
>>> kernel/drivers/base/power/shutdown.c::device_shutdown()
>>>  driver specific ->shutdown callback, for ide disks, the path is
>>> drivers/ide/ide-disk.c::ide_device_shutdown()
>>> drivers/ide/ide-disk.c::ide_cacheflush_p()
>>> drivers/ide/ide-disk.c::do_idedisk_flushcache()
>>>
>>>  And, AFAIK, sync() doesn't flush disk caches.
>>
>> How about umount?
>>
> 
> [CC'ing Bartlomiej (Hi!)]
> 
>  Hmmm, umount doesn't.  I think maybe adding cache flushing to sync and 
> umount can be helpful.

Ehm. So you're saying umount does _not_ flush the disk caches? BUT it will flush 
the the fs buffers, right?

>  And one more thing, ide-disk doesn't flush cache when shutting down. It 
> flushes only when rebooting.

How about ide-cs then? When I unregister a drive?

--
Steven
