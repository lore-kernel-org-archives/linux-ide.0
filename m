From: Chase Venters <chase.venters@clientec.com>
Subject: Questions about ATA Command Timeouts and kernel lockups
Date: Sat, 12 Nov 2005 18:10:34 -0600
Message-ID: <200511121810.57220.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay00.pair.com ([209.68.5.9]:28430 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S964890AbVKMALG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Nov 2005 19:11:06 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Greetings,
	I'm using an ICH6. I have four WD 7200RPM SATA 320GB hard drives hanging off 
of it, on top of which I'm running raid10 and reiserfs. Over the last month 
and a half, I've started to have an excessive amount of hardware problems.
	The first sign of trouble was when I got one or two lockups that seemed to be 
caused by overheating. Then I had an expensive GeForce die on me. I started a 
process of replacing hardware, while attempting to diagnose the problem. I 
switched from a quiet fan (on a Prescott, which run way hot) to a bigger 
Thermaltake cooler. I swapped in a brand new 550 Watt PSU with 2 independent 
12V rails. I replaced the GeForce, and replaced the motherboard with 
(another) ASUS P5GDC-V. 
	In this process, I've had to deal with data corruption severe enough to 
totally bork my system on two occasions. One one occasion, I kept having 
random reboots / crashes that. After a series of many of these crashes, tree 
nodes on ReiserFS got so badly damaged that attempting to access certain 
parts of the disk resulted in kernel panics.
	After swapping in the PSU, I rebuilt the system on a fresh ReiserFS 
partition. It seemed to be working quite well until I started getting lockups 
again within the last week. 
	This time, I was equipped with a serial console and SysRQ to see what the 
hell was going on. Long story short, I'm experiencing random lockups under IO 
load. This is all the kernel has to say before totally locking up:

ATA: abnormal status 0x80 on port 0x9807
ATA: abnormal status 0x80 on port 0x9807
ATA: abnormal status 0x80 on port 0x9807
ata2: command 0x25 timeout, stat 0x51 host_stat 0x61
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }

	After getting this message, the kernel refuses to answer even SysRQ. 
	I posted about this once before and had a private conversation with another 
member about the possibility of heat or power issues. I no longer believe 
this to be the case - the 550 Watt supply is brand new, and I'm now in the 
process of rebuilding Gentoo on *another* fresh ReiserFS partition (the 
lockup pertaining to the messages above occurred last night and left 2 drives 
out of sync, while a third was already sitting out with a backup of my data 
from a month ago). The drives are cooled by a 120mm fan, and even under the 
load of an md resync and a compile, I can rest my hands on them for long 
periods of time without getting burned. They're a little warm, but nothing 
they shouldn't be able to handle.
	The reason I'm sending this in to the list is because the last option I feel 
that I have is to buy a new motherboard other than the P5GDC-V. This process 
is getting expensive and I'd like to stop having crashes. I can accept that I 
am dealing with a hardware issue, but my big question is this:

	Is it considered normal for the kernel to lock up, not responding to SysRQ 
over RS232, upon experiencing a command timeout as shown above? 

	I'll admit to not being really up to speed on the interaction between the 
kernel and the bus over DMA, but it seems to me that since this diagnostic 
information *does* get printed, followed by a total lockup, that the kernel 
may be falling into a tight loop with interrupts disabled. To this end, I'm 
building the kernel that will run on my system once it's rebuilt to include 
sleep while holding spinlock checking.
	Is there anything else I can do, in case this crash hits me again?

Thanks,
Chase Venters
