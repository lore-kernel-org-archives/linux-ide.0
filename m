From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem with disk
Date: Sun, 07 May 2006 22:41:37 +0900
Message-ID: <445DF911.1020408@gmail.com>
References: <Pine.LNX.4.44.0605061420340.5626-100000@coffee.psychology.mcmaster.ca> <445D29A1.5000402@gmail.com> <445DF445.6070803@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.206]:50652 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932166AbWEGNmL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 May 2006 09:42:11 -0400
Received: by nz-out-0102.google.com with SMTP id 13so1005280nzn
        for <linux-ide@vger.kernel.org>; Sun, 07 May 2006 06:42:11 -0700 (PDT)
In-Reply-To: <445DF445.6070803@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, David.Ronis@McGill.CA, linux-ide@vger.kernel.org, neilb@suse.de

Ric Wheeler wrote:
> 
> 
> Tejun Heo wrote:
>>
>>
>> Unfortunately, this can result in *massive* destruction of the 
>> filesystem.  I lost my RAID-1 array earlier this year this way.  The 
>> FS code systematically destroyed metadata of the filesystem and, on 
>> the following reboot, fsck did the final blow, I think.  I ended up 
>> with 100+Gbytes of unorganized data and I had to recover data by grep 
>> + bvi.
> 
> Were you running with Neil's fixes that make MD devices properly handle 
> write barrier requests?  Until fairly recently (not sure when this was 
> fixed), MD devices more or less dropped the barrier requests.
> 
> With properly working barriers, any journal file system should get you 
> back to a consistent state after a power drop (although there are many 
> less common ways that drives can potentially drop data).

I'm not sure whether the barrier was working or not.  Ummm.. Are you 
saying that MD is capable of recovering from data drop *during* 
operation?  ie. the system didn't go out, just the harddrives.  Data is 
lost no matter what MD does and MD and the filesystem don't have any way 
to tell which bits made it to the media and which are lost whether 
barriers are working or not.

To handle such conditions, device driver should tell upper layer that 
PHY status has changed (or something weird happened which could lead to 
data loss) and the fs, in return, perform journal replay while still 
online.  I'm pretty sure that isn't implemented in the current kernel.

>>
>> This is an extreme case but it shows turning off writeback has its 
>> advantages.  After the initial stress & panic attack subsided, I tried 
>> to think about how to prevent such catastrophes, but there doesn't 
>> seem to be a good way.  There's no way to tell 1. if the harddrive 
>> actually lost the writeback cache content 2. if so, how much it has 
>> lost.  So, unless the OS halts the system everytime something seems 
>> weird with the disk, turning off writeback cache seems to be the only 
>> solution.
>>
> 
> Turning off the writeback cache is definitely the safe and conservative 
> way to go for mission critical data unless you can be very certain that 
> your barriers are properly working on the drive & IO stack.  We validate 
> the cache flush commands with a s-ata analyzer (making sure that we see 
> them on sync/transaction commits) and that they take a reasonable amount 
> of time at the drive...
> 

One thing I'm curious about is how much performance benefit can be 
obtained from write-back caching.  With NCQ/TCQ, latency is much less of 
an issue and I don't think scheduling and/or buffering inside the drive 
would result in significant performance increase when so much is done by 
the vm and block layer (aside from scheduling of currently queued commands).

Some linux elevators try pretty hard to not mix read and write requests 
as they mess up statistics (write back cache absorbs write requests very 
fast then affect following read requests).  So, they basically try to 
eliminate the effect of write-back caching.

Well, benchmark time, it seems.  :)

-- 
tejun
