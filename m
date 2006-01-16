From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fw: [Bug 5880] Transcend CF pcmcia card no longer works
Date: Mon, 16 Jan 2006 17:45:55 +0900
Message-ID: <43CB5D43.8080301@gmail.com>
References: <20060113113922.23ce6d78.akpm@osdl.org>	<43C87CF2.30402@gmail.com>	<43C88509.7090009@yahoo.com.au>	<43C88FBB.3000607@gmail.com> <20060113215218.68a68f4e.akpm@osdl.org> <43C896F0.1080005@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.205]:2390 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932246AbWAPIqC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2006 03:46:02 -0500
Received: by xproxy.gmail.com with SMTP id i30so861429wxd
        for <linux-ide@vger.kernel.org>; Mon, 16 Jan 2006 00:46:02 -0800 (PST)
In-Reply-To: <43C896F0.1080005@yahoo.com.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, axboe@suse.de, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux-ide <linux-ide@vger.kernel.org>

Nick Piggin wrote:
> Andrew Morton wrote:
> 
>> (Adding bugzilla back to cc)
>>
>> Tejun Heo <htejun@gmail.com> wrote:
>>
> 
>>>> I'm not sure that it has been deallocated, rather something has 
>>>> overwritten
>>>> it, no?
>>>
>>>
>>> The ldm validation or failure seems irrelevant.  From the original 
>>> bug report.
>>>
> 
> Looks like you're right.
> 
> It was just odd that the ldm check worked and the msdos one
> oopsed; both attempt to read the same block in the same manner.
> 
> Perhaps it may be that the queue was freed long before then, and
> only just gets reused for something else and overwritten at this
> point.
> 
> slab debugging might help?
> 

[CC'ing Bartlomiej and linux-ide]

Hello, Bartlomiej.

This thread started by Andrew forwarding bugzilla #5880 to as-iosched 
related people as the machine oopsed in anticipatory scheduler.  After 
diagnosis, it seems to be premature device release problem of IDE 
driver.  The original bug entry is

http://bugzilla.kernel.org/show_bug.cgi?id=5880

The original bug is about CF device unuseable.  The oops occurs after 
yanking out the CF device during partition check is in progress (all are 
failing due to IO error).

I've glanced through the IDE code and the problem seems to be in 
ide_disk_get().  This function doesn't get the IDE generic device 
(ide_drive_t->gendev) and so if a device is yanked out while it's still 
open, the gendev doesn't wait for the open fd's to be closed.  This 
results in dangling open block device and thus above oops.  I'm not very 
sure about this analysis and currently don't have access to 
hot-unpluggable IDE devices.

Can you please confirm this?

Thanks.

-- 
tejun
