From: Tejun Heo <htejun@gmail.com>
Subject: Re: when are buffers/caches flushed?
Date: Thu, 18 Aug 2005 20:24:02 +0900
Message-ID: <43046FD2.4080401@gmail.com>
References: <43046817.803@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:19921 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932197AbVHRLYH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Aug 2005 07:24:07 -0400
Received: by zproxy.gmail.com with SMTP id i11so253043nzh
        for <linux-ide@vger.kernel.org>; Thu, 18 Aug 2005 04:24:07 -0700 (PDT)
In-Reply-To: <43046817.803@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

Steven Scholz wrote:
> Hi there,
> 
> According to an (old) man page of sync(2)
> 
>        According to  the  standard  specification  (e.g.,  SVID),
>        sync()  schedules  the  writes,  but may return before the
>        actual writing is done.   However,  since  version  1.3.20
>        Linux  does actually wait.  (This still does not guarantee
>        data integrity: modern disks have large caches.)
> 
> How about recent kernels? Does sync() block until buffers are flushed?
> How can I find out if the disk caches are actually flushed?
> 
> I want to make sure that all data is flushed to my disk drive before 
> powering down the system.
> 
> Thanks.
> 

  All disk caches are flushed before shutdown via the following path.

kernel/sys.c::sys_reboot()
kernel/drivers/base/power/shutdown.c::device_shutdown()
  driver specific ->shutdown callback, for ide disks, the path is
drivers/ide/ide-disk.c::ide_device_shutdown()
drivers/ide/ide-disk.c::ide_cacheflush_p()
drivers/ide/ide-disk.c::do_idedisk_flushcache()

  And, AFAIK, sync() doesn't flush disk caches.

-- 
tejun
