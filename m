From: Ric Wheeler <ric@emc.com>
Subject: Re: Problem with disk
Date: Sat, 06 May 2006 14:17:07 -0400
Message-ID: <445CE823.2040203@emc.com>
References: <Pine.LNX.4.44.0605061304560.5626-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:59789 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751066AbWEFSQp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 May 2006 14:16:45 -0400
In-Reply-To: <Pine.LNX.4.44.0605061304560.5626-100000@coffee.psychology.mcmaster.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: David.Ronis@McGill.CA, linux-ide@vger.kernel.org



Mark Hahn wrote:

>>The write cache in modern drives is multiple megabytes - 8 or 16MB is 
>>not uncommon. The chances that you have data that is lost on a power 
>>failure in the write cache is actually quite high...
>>    
>>
>
>but we're not talking about power failures in the middle of peak activity.
>afaikt, drives also never dedicate their whole cache to writeback - they 
>keep plenty available for reads, as well.  it would also be rather surprising
>if the firmware was completely oblivious about limiting the age of
>writebacks; after all always delaying writes until you run out of cache 
>capacity is _not_ a winning strategy (even ignoring safety issues.)
>  
>

If you have drives/hardware to test on, you can easily verify (which we 
do on a regular basis) that running with barriers over power fail 
testing gets you a solid recovery. Running with write cache on and no 
barriers gets you file system corruption. As I said before, the data you 
just wrote (or the file system wrote for you) most recently is the same 
data that you stand to lose on a powerloss.

>during a normal shutdown, can you think of some reason the drive would have 
>LOTS of outstanding writes?  that's the real point.  depending on kernel
>version, linux should be doing a cache-flush command and standby, then
>eventually calling bios poweroff.  it's very possible that this is going 
>wrong (rumors of disks that claim to implement, but ignore cache-flush,
>or perhaps ones that stupidly don't flush on standby, or even bios poweroff
>that happens so fast that the disks isn't done flushing...)  but turning 
>off all writeback is overkill (especially when there's some other obvious 
>sign of distress...)
>
>  
>
We don't test every make of drive, but the modern drives we do test do 
honor the cache flush commands. It is important to note that drive 
firmware is like any other bit of code - it can have bugs so this 
support does need to be reverified on each drive (and version of 
firmware) before you can trust high value data ;-)

If there is a hole in the sequence, dropping to standby could be the 
source of issues...

ric

