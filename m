From: Ric Wheeler <ric@emc.com>
Subject: Re: Problem with disk
Date: Sun, 07 May 2006 09:21:09 -0400
Message-ID: <445DF445.6070803@emc.com>
References: <Pine.LNX.4.44.0605061420340.5626-100000@coffee.psychology.mcmaster.ca> <445D29A1.5000402@gmail.com>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:56028 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S932160AbWEGNV3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 May 2006 09:21:29 -0400
In-Reply-To: <445D29A1.5000402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, David.Ronis@McGill.CA, linux-ide@vger.kernel.org, neilb@suse.de



Tejun Heo wrote:
> 
> 
> Unfortunately, this can result in *massive* destruction of the 
> filesystem.  I lost my RAID-1 array earlier this year this way.  The FS 
> code systematically destroyed metadata of the filesystem and, on the 
> following reboot, fsck did the final blow, I think.  I ended up with 
> 100+Gbytes of unorganized data and I had to recover data by grep + bvi.

Were you running with Neil's fixes that make MD devices properly handle write 
barrier requests?  Until fairly recently (not sure when this was fixed), MD 
devices more or less dropped the barrier requests.

With properly working barriers, any journal file system should get you back to a 
consistent state after a power drop (although there are many less common ways 
that drives can potentially drop data).

> 
> This is an extreme case but it shows turning off writeback has its 
> advantages.  After the initial stress & panic attack subsided, I tried 
> to think about how to prevent such catastrophes, but there doesn't seem 
> to be a good way.  There's no way to tell 1. if the harddrive actually 
> lost the writeback cache content 2. if so, how much it has lost.  So, 
> unless the OS halts the system everytime something seems weird with the 
> disk, turning off writeback cache seems to be the only solution.
> 

Turning off the writeback cache is definitely the safe and conservative way to 
go for mission critical data unless you can be very certain that your barriers 
are properly working on the drive & IO stack.  We validate the cache flush 
commands with a s-ata analyzer (making sure that we see them on sync/transaction 
commits) and that they take a reasonable amount of time at the drive...

ric

