From: Jonas Lundgren <jonas@local.se>
Subject: problem with ata_piix + ICH8 on Abit AB9 Pro
Date: Mon, 20 Nov 2006 16:34:40 +0100
Message-ID: <4561CB10.8040506@local.se>
Reply-To: jonas@local.se
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxfep02.bredband.com ([195.54.107.73]:48061 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S965904AbWKTPem (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Nov 2006 10:34:42 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20061120153440.NHKA16896.mxfep02.bredband.com@ironport.bredband.com>
          for <linux-ide@vger.kernel.org>; Mon, 20 Nov 2006 16:34:40 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

I've got some big performance related problem with my Abit AB9 pro mobo, 
the ICH8 controller and my SATA disks.. I've got 2 64GB WD raptor disks 
in a raid0(These are the disks I have used dd/hdparm on in the commands 
below), and a 2x250GB WD disk raid0, and I used to get around 
130-140mb/sec seq write with them, but now with my new mobo I'm lucky if 
I get 10mb/sec. During heavy disk activity the system locks up, until 
the write is completed (Ie, no other read or write is being made, it's 
like heavy IO completely starves all other processes until it's finished)..

Running 2.6.19-rc5-mm2 atm, but I've tried a few diffrent kernels, same 
thing.

Also, it doesn't matter if I enable AHCI in the BIOS (But with AHCI 
enabled the disks spin down/power down when I boot, just to power up 
again a few seconds after. The boot progress freezes until the disks 
have spun up again. (This happens when the kernel probes the sata 
controller ports at bootup, the disks spin down at the same time, but 
spin up one by one as they're getting probed))

I've tried changing I/O scheduler, only noticable diffrence is when I 
use "noop". Then I get like 20mb/sec write instead of 4mb/sec. I have no 
idea why this is :P

Example of what I mean with crappy performance:
dd if=/dev/zero of=test232 bs=1M count=100; time sync
100+0 records in
100+0 records out
104857600 bytes (105 MB) copied, 0.130424 s, 804 MB/s
real 0m21.104s
user 0m0.000s
sys 0m0.011s

21 seconds to do a seq write of 100mb.. And during this time ALL other 
disk IO gets starved, I can't do anything that uses disk IO for the 
duration.. (not even `ls`)

Yet, a hdparm shows a decent read
hdparm -tT /dev/md4
/dev/md4:
Timing cached reads: 8060 MB in 1.99 seconds = 4042.19 MB/sec
Timing buffered disk reads: 400 MB in 3.00 seconds = 133.28 MB/sec

dd if=1GBzeroFile of=/dev/null bs=1M count=1000
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB) copied, 11.4335 s, 91.7 MB/s

This is the cpu usage stats I get from top when running the dd write:
Cpu0 : 0.0%us, 0.0%sy, 0.0%ni, 0.0%id, 99.0%wa, 0.5%hi, 0.5%si, 0.0%st
Cpu1 : 0.0%us, 0.0%sy, 0.0%ni,100.0%id, 0.0%wa, 0.0%hi, 0.0%si, 0.0%st

Pretty crappy read speeds compared to what I got on my previous mobo 
(around 140mb/sec), but still alot better than the 4mb/sec I get when 
writing..

I've also googled this for many hours, I've searched the lkml, checked 
these gentoo forums, as well as other distro forums, I just don't know 
what else to do. I'll appreciate any help or hints I can get.

-- 
-Jonas

Name:   Jonas Lundgren
ICQ#:   52064961
Mail:   jonas@local.se
IRC:    neon / neonman @ EFnet, Undernet, Quakenet, freenode
