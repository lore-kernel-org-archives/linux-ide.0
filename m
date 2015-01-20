From: Gene Heskett <gheskett@wdtv.com>
Subject: Re: 64 bit kernel won't mount /
Date: Tue, 20 Jan 2015 07:03:44 -0500
Message-ID: <201501200703.44125.gheskett@wdtv.com>
References: <201501191145.41492.gheskett@wdtv.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.wdtv.com ([66.118.69.84]:37264 "EHLO mail.wdtv.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbbATMDp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2015 07:03:45 -0500
In-Reply-To: <201501191145.41492.gheskett@wdtv.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Monday 19 January 2015 11:45:41 Gene Heskett did opine
And Gene did reply:
> Greetings;
> 
> Amd Phenom, 8Gb of dram on an Asus M2N-SLI Deluxe board.  So old USB3
> isn't.
> 
> Ubuntu 10.04.4 LTS 32 bit server install here.  A recent experiment
> with a 32 bit Wheezy (2.7) worked extremely well when I enabled it to
> install an amd64 kernel, fastest and smoothest this machine has ever
> worked. Unfortunately I destroyed it by installing a library firefox
> was complaining about the lack thereof, it pulled in about 20 other
> packages and destroyed what little KDE I had installed to be able to
> use kmail.
> 
> I have been reading up on man fstab, but it has not solved my problem
> of the boot waiting, sometimes for 30 seconds, for the drive to be
> mounted at / to appear.  There is no disk activity during this wait
> period, and it does not always do it when booting a 32 bit PAE kernel.
> 
> But if I build an amd64 version of that kernel, it stops dead, no disk
> activity after announcing that the / device has not yet checked in.
> 
> But, after waiting a minute, I hit m to get what is marked as a root
> terminal, but which has no rights, I see that the directory contents of
> / are visible.
> 
> Fdisk complains that there are 3503 unallocated 512 byte sectors after
> partition 1 on the disk, but its been doing that for 3 or 4 years.
> Terrabyte disk so its not seriously effected unless it slows it somehow
> that I haven't noticed.
> 
> On wheezy, for as long as it worked, it worked a treat.
> 
> Suggested fix for the 64 bit boot stall? I am familiar with make
> xconfig.
> 
> Thanks all.
> 
> Cheers, Gene Heskett

Ping?

Secondary problem, seems like a miss-match between partitioning tools.

2 of my 4 1Tb drives can do 4096 byte sectors.
fdisk complains noisily about the partitions I have setup on one of these 
disks not being starting sector aligned, yet when I did the partitioning 
with gparted, the align with "cylinders" was checked.

Do we have a partitioning tool that can actually sort this correctly on a 
4k sector disk?

Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
US V Castleman, SCOTUS, Mar 2014 is grounds for Impeaching SCOTUS
