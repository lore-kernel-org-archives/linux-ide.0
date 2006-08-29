From: Tejun Heo <htejun@gmail.com>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710,
 pcmcia based sata_sil24, PMP, and NCQ drive
Date: Tue, 29 Aug 2006 22:27:26 +0900
Message-ID: <44F440BE.80000@gmail.com>
References: <20060828230132.GB20189@geeks.org> <44F3A8FD.6090108@gmail.com> <20060829045816.GA21746@geeks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:27335 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964957AbWH2N2T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 09:28:19 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1283377nzf
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2006 06:28:19 -0700 (PDT)
In-Reply-To: <20060829045816.GA21746@geeks.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derek Taubert <taubert@geeks.org>
Cc: linux-ide@vger.kernel.org

Derek Taubert wrote:
>> >From iostat -k 10:
>>> Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
>>> sda            2428.64      2422.46       667.66      24273       6690
>>> sda              36.84        23.72      1667.87        237      16662
>>> sda            2440.60      2434.90       616.00      24349       6160
>>> The read rate is curious (should be 0)...
>>>
>>> Top shows 1% user, 3% system, 93% wait.
>> It seems some kind of read IO is in progress.  Can you repeat the test 
>> on an unused/idle (iostat -k 10 shows all zeros...) drive?  The above 
>> result actually looks good if you consider both read and write sides. 
> 
> I think that 3MBytes/sec total for a drive that can read at 50MBytes/sec
> on the same system is quite bad, especially since we're talking about
> a linear write test.

True, I was referring to both reads and writes.  If both are in progress 
and they're apart on disk, the result looks normal.

>> The result doesn't seem to indicate any problem in libata or any storage 
>> related kernel subsystem.  I would track down the reader first.
> 
> This drive has only been partitioned; there is no filesystem on it.  So,
> it certainly isn't mounted anywhere.  There honestly isn't _anything_
> other than the dd going on to sda1, and that's the only partition on
> sda.

Hmmm...

>>> 2) hdparm -C for all 4 drives always shows "drive state is:  standby"
>>>   even when I'm certain that the drives are active.
>> hdparm -C says the same thing for my drive.  I think it's safe to 
>> ignore.  Hmmm... it needs to be tracked down.  Maybe some problem in 
>> HDIO ioctl implementation in libata.
> 
> It's a "nice to have" for using smartd.  ie: don't spin the drives up to
> poll the failure attributes, but they should be checked if the drive's
> already active.

I don't really understand what you mean.  Can you elaborate?

>>> I'd really like some assistance debugging the write performance issue.
>>> The "hdparm -C" issue would be gravy...
>> Please track down the reader.
> 
> Before running dd (fuser -v /dev/sda1 shows nothing):
[--snip--]

Can you try 'dd if=/dev/zero of=/dev/sdX bs=4M count=1'?

-- 
tejun
