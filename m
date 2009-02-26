From: Mark Lord <liml@rtr.ca>
Subject: Re: Backplane mystery
Date: Thu, 26 Feb 2009 10:34:27 -0500
Message-ID: <49A6B683.9060806@rtr.ca>
References: <49A6B441.8010605@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:36155 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755092AbZBZPeb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Feb 2009 10:34:31 -0500
In-Reply-To: <49A6B441.8010605@seiner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: linux-ide@vger.kernel.org

Yan Seiner wrote:
> I have an external enclosure with an SATA backplane with 20 drive 
> slots.  I am using 4 port multipliers to drive all 20 slots.
> 
> One set of 5 slots connected to a single port multiplier always fails with
> 
> [   16.449673] ata2: FORCE: PHY spd limit set to 1.5Gbps
> [   16.449740] ata2: SATA max UDMA/100 host m128@0xfdeff000 port 
> 0xfdefa000 irq 16
> [   20.616038] ata2: SATA link down (SStatus 0 SControl 10)
> [   80.596644] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
> frozen
> [   80.596956] ata2: irq_stat 0x00a00080, device exchanged
> [   80.597039] ata2: hard resetting link
> [   90.604024] ata2: softreset failed (timeout)
> [   90.604108] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> [   90.604183] ata2: link online but device misclassified, retrying
> [   90.604264] ata2: hard resetting link
> [  100.604026] ata2: softreset failed (timeout)
> [  100.604109] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> [  100.604186] ata2: link online but device misclassified, retrying
> [  100.604259] ata2: hard resetting link
> [  135.612026] ata2: softreset failed (timeout)
> [  135.612109] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> [  135.612191] ata2: link online but device misclassified, retrying
> [  135.612273] ata2: hard resetting link
> [  140.616024] ata2: softreset failed (timeout)
> [  140.616107] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> [  140.616183] ata2: link online but device misclassified, device 
> detection might fail
> [  140.616296] ata2: EH complete
> 
> I've swapped cables, port multipliers, and so on.  It's not the 
> backplace, as I can swap cables from one of the port multipliers that 
> works and it will detect drives.  It's not the port multiplier, as I've 
> swapped those.  The only thing I can think of is that it's failing 
> initialization.  If I swap cables from a port multiplier that's 
> initialized while the system is running, it works.
> 
> Before I start taking random actions, can someone interpret the above 
> for me?  What's it telling me?
> 
> For comparison, here's the initialization sequence from the adjacent 
> port multiplier:
> 
> [   16.449504] ata1: FORCE: PHY spd limit set to 1.5Gbps
> [   16.449571] ata1: SATA max UDMA/100 host m128@0xfdeff000 port 
> 0xfdef8000 irq 16
> [   18.536033] ata1: SATA link down (SStatus 0 SControl 10)
> [   19.374191] ata10: SATA max UDMA/133 cmd 0xbc00 ctl 0xb800 bmdma 
> 0xb408 irq 21
> [   80.596647] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
> frozen
> [   80.596649] ata1: irq_stat 0x00a00080, device exchanged
> [   80.596653] ata1: hard resetting link
> [   82.796045] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> [   82.796408] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, 
> feat 0x1/0x9
> [   82.796796] ata1.00: hard resetting link
> [   83.116406] ata1.00: SATA link down (SStatus 0 SControl 10)
> [   83.116482] ata1.01: hard resetting link
> [   83.436402] ata1.01: SATA link down (SStatus 0 SControl 310)
> [   83.436479] ata1.02: hard resetting link
> [   83.756394] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   83.756467] ata1.03: hard resetting link
> [   84.076432] ata1.03: SATA link down (SStatus 0 SControl 310)
> [   84.076510] ata1.04: hard resetting link
> [   84.396387] ata1.04: SATA link down (SStatus 0 SControl 310)
> [   84.396465] ata1.05: hard resetting link
> [   84.716330] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   84.828010] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
> [   84.828082] ata1.15: hard resetting link
> [   84.828145] ata1: controller in dubious state, performing PORT_RST
> [   87.060032] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> [   87.060351] ata1.00: hard resetting link
> [   87.380330] ata1.00: SATA link down (SStatus 0 SControl 10)
> [   87.380404] ata1.01: hard resetting link
> [   87.700329] ata1.01: SATA link down (SStatus 0 SControl 310)
> [   88.756028] ata1.02: hard resetting link
> [   89.076366] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   89.716017] ata1.05: hard resetting link
> [   90.036392] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   90.148021] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
> [   90.148104] ata1.15: hard resetting link
> [   90.148177] ata1: controller in dubious state, performing PORT_RST
> [   92.380043] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> [   92.380415] ata1.00: hard resetting link
> [   92.700329] ata1.00: SATA link down (SStatus 0 SControl 10)
> [   92.700398] ata1.01: hard resetting link
> [   93.020334] ata1.01: SATA link down (SStatus 0 SControl 310)
> [   94.076081] ata1.02: hard resetting link
> [   94.396398] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   94.396479] ata1.03: hard resetting link
> [   94.716392] ata1.03: SATA link down (SStatus 0 SControl 310)
> [   94.716465] ata1.04: hard resetting link
> [   95.036397] ata1.04: SATA link down (SStatus 0 SControl 310)
> [   95.036474] ata1.05: hard resetting link
> [   95.356426] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   95.369116] ata1.02: ATA-8: Hitachi HDT721010SLA360, ST6OA31B, max 
> UDMA/133
> [   95.369193] ata1.02: 1953525168 sectors, multi 0: LBA48 NCQ (depth 
> 31/32)
> [   95.370256] ata1.02: configured for UDMA/100
> [   95.370769] ata1: EH complete
> 
> If I swap cables from ata1 to ata2 while the system is running, the 
> backplane will detect drives and work fine.
> 
> I'm already forcing a slower speed:
> 
> yan@selene:/etc/modprobe.d$ cat libata
> options libata force=1.15:1.5Gbps,2.15:1.5Gbps,3.15:1.5Gbps,4.15:1.5Gbps
> 
> I'm using a Sil 3132 controller:
> 
> 02:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA 
> Raid II Controller (rev 01)
> 
> The system sees 3 port multipliers; not 4 as it should:
> 
> [   82.488354] ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, 
> feat 0x1/0x9
> [   82.488507] ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, 
> feat 0x1/0x9
> [   82.796408] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, 
> feat 0x1/0x9
> 
> I suspect it's cabling length as the 5 "dead" slots are the farthest 
> down the backplane but swapping cables randomly just doesn't seem like a 
> good approach.
> 
> What's my next step?
..

Perhaps try a different chipset controller card,
in hope that it will have stronger drive capability?

