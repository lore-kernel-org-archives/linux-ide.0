From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem with disk
Date: Sun, 07 May 2006 07:56:33 +0900
Message-ID: <445D29A1.5000402@gmail.com>
References: <Pine.LNX.4.44.0605061420340.5626-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:59435 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932099AbWEFW5F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 May 2006 18:57:05 -0400
Received: by py-out-1112.google.com with SMTP id x31so1138729pye
        for <linux-ide@vger.kernel.org>; Sat, 06 May 2006 15:57:04 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44.0605061420340.5626-100000@coffee.psychology.mcmaster.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Ric Wheeler <ric@emc.com>, David.Ronis@McGill.CA, linux-ide@vger.kernel.org

Mark Hahn wrote:
[--snip--]
> I assume that the disk will indeed do writeback if left idle for a little
> while.  on machines where this is a  real problem, I would start out by
> waving relevant chickens like the following to give the best chance of
> shutting down cleanly: 
> 	sync
> 	blockdev --flushbufs
> 	hdparm -W 0
> 	sleep 2
> 	hdparm -y
> 	sleep 5
> 	halt -hp
> 
> rather than _always_ suffering the penalty of disabled write cache, 
> especially on a single slow laptop drive...

This is slightly OT as this thread is talking about normal power down 
but disabling writeback cache has its advantages.  When you have power 
fluctation (e.g. power source fluctation or new device hot plugged and 
crappy PSU can't hold the voltage), the harddisk could briefly power 
down while other parts of system keep running.  If the disk was under 
active FS writes, this ends up in inconsistencies between what the OS 
thinks the disk has and the disk actually has.

Unfortunately, this can result in *massive* destruction of the 
filesystem.  I lost my RAID-1 array earlier this year this way.  The FS 
code systematically destroyed metadata of the filesystem and, on the 
following reboot, fsck did the final blow, I think.  I ended up with 
100+Gbytes of unorganized data and I had to recover data by grep + bvi.

This is an extreme case but it shows turning off writeback has its 
advantages.  After the initial stress & panic attack subsided, I tried 
to think about how to prevent such catastrophes, but there doesn't seem 
to be a good way.  There's no way to tell 1. if the harddrive actually 
lost the writeback cache content 2. if so, how much it has lost.  So, 
unless the OS halts the system everytime something seems weird with the 
disk, turning off writeback cache seems to be the only solution.

-- 
tejun
