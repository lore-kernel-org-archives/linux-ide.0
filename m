From: Tejun Heo <htejun@gmail.com>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710,
 pcmcia based sata_sil24, PMP, and NCQ drive
Date: Fri, 01 Sep 2006 22:32:12 +0900
Message-ID: <44F8365C.2020609@gmail.com>
References: <20060828230132.GB20189@geeks.org> <44F3A8FD.6090108@gmail.com> <20060829045816.GA21746@geeks.org> <44F440BE.80000@gmail.com> <20060829164424.GA1603@geeks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:25056 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751360AbWIAPKd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Sep 2006 11:10:33 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1028677wxc
        for <linux-ide@vger.kernel.org>; Fri, 01 Sep 2006 08:10:33 -0700 (PDT)
In-Reply-To: <20060829164424.GA1603@geeks.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derek Taubert <taubert@geeks.org>
Cc: linux-ide@vger.kernel.org

Derek Taubert wrote:
> On Tue, Aug 29, 2006 at 10:27:26PM +0900, Tejun Heo wrote:
>>>>> 2) hdparm -C for all 4 drives always shows "drive state is:  standby"
>>>>>  even when I'm certain that the drives are active.
>>>> hdparm -C says the same thing for my drive.  I think it's safe to 
>>>> ignore.  Hmmm... it needs to be tracked down.  Maybe some problem in 
>>>> HDIO ioctl implementation in libata.
>>> It's a "nice to have" for using smartd.  ie: don't spin the drives up to
>>> poll the failure attributes, but they should be checked if the drive's
>>> already active.
>> I don't really understand what you mean.  Can you elaborate?
> 
> Sure.  See the "-n standby" option here:
> 
> http://smartmontools.sourceforge.net/man/smartd.conf.5.html
> 
> If the driver always reports "standby", then smartd effectively won't
> monitor the device if "-n standby" is configured.
> 
> Now I can certainly eliminate the -n option from smartd.conf, but
> then smartd will cause the drive(s) to spin up when it polls (see the
> -p, -u, -t options).

Ah.. I see.  I'll try to track down that ioctl problem.

>>>>> I'd really like some assistance debugging the write performance issue.
>>>>> The "hdparm -C" issue would be gravy...
>>>> Please track down the reader.
>>> Before running dd (fuser -v /dev/sda1 shows nothing):
>> [--snip--]
>>
>> Can you try 'dd if=/dev/zero of=/dev/sdX bs=4M count=1'?
> 
> Increasing the block size eliminates the reads (presumably because the
> block driver doesn't have to fetch lines to read/modify/write),

That's actually page cache trying to fill the rest of the page.

 > but the write throughput is still very slow:
> # dd if=/dev/zero of=/dev/sda1 bs=4M count=512
> 
> avg-cpu:  %user   %nice    %sys %iowait   %idle
>            0.90    0.00    1.30   97.80    0.00
> 
> Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
> sda              15.00         0.00      1920.00          0      19200

Hmm... this really is weird.  FYI, you're the first to report such 
problem.  As Jeff said, turning off write-back caching can have adverse 
effect on write performance, but, then again, you previously reported 
that the command queue is full.  Please update us on the write-back stuff.

Thanks.

-- 
tejun

