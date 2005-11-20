From: linux@horizon.com
Subject: sata_sil24 testing results
Date: 20 Nov 2005 17:02:35 -0500
Message-ID: <20051120220235.14764.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:54832 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932092AbVKTWCy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Nov 2005 17:02:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux@horizon.com, linux-ide@vger.kernel.org

On an AMD64 board (uniprocessor core, nForce4-SLI chipset) with
3x Sil323s controllers and 6x 400 GB Seagate 7200.8 drives,
I've been running continuous "badblocks -w -t random" on all drives
this weekend.  However, one drive stopped working after completing

> badblocks -w -t random -v -p20 -b4096 -c4096 /dev/sde4
> Checking for bad blocks in read-write mode
> From block 0 to 85957790
> Testing with random pattern: done                        
> Reading and comparing: done                        
> Pass completed, 0 bad blocks found.
> Checking for bad blocks in read-write mode
> From block 0 to 85957790
> Testing with random pattern: done                        
> Reading and comparing: done                        
> Pass completed, 0 bad blocks found.
> Checking for bad blocks in read-write mode
> From block 0 to 85957790
> Testing with random pattern: done                        
> Reading and comparing: done                        
> Pass completed, 0 bad blocks found.
> Checking for bad blocks in read-write mode
> From block 0 to 85957790
> Testing with random pattern: done                        
> Reading and comparing: done                        
> Pass completed, 0 bad blocks found.
> Checking for bad blocks in read-write mode
> From block 0 to 85957790
> Testing with random pattern: done                        
> Reading and comparing: done                        
> Pass completed, 0 bad blocks found.
> Checking for bad blocks in read-write mode
> From block 0 to 85957790
> Testing with random pattern: done                        
> Reading and comparing: done                        
> Pass completed, 0 bad blocks found.
> Checking for bad blocks in read-write mode
> From block 0 to 85957790
> Testing with random pattern: done                        
> Reading and comparing: done                        
> Pass completed, 0 bad blocks found.
> Checking for bad blocks in read-write mode
> From block 0 to 85957790
> Testing with random pattern: 

The kernel logs contain 48 hours of silence, followed suddenly by:

Nov 20 13:55:45 $host kernel: ata5: command timeout
Nov 20 13:55:45 $host kernel: ata5: status=0x50 { DriveReady SeekComplete }
Nov 20 13:55:45 $host kernel: sde: Current: sense key: No Sense
Nov 20 13:55:45 $host kernel:     Additional sense: No additional sense information
Nov 20 13:55:45 $host kernel: sata_sil24 ata5: resetting controller...
Nov 20 13:56:15 $host kernel: ata5: command timeout
Nov 20 13:56:15 $host kernel: ata5: status=0x50 { DriveReady SeekComplete }
Nov 20 13:56:15 $host kernel: sde: Current: sense key: No Sense
Nov 20 13:56:15 $host kernel:     Additional sense: No additional sense information
Nov 20 13:56:15 $host kernel: sata_sil24 ata5: resetting controller...
Nov 20 13:56:45 $host kernel: ata5: command timeout

...repeats every 30 seconds...

Nov 20 16:37:15 $host kernel: sata_sil24 ata5: resetting controller...
Nov 20 16:37:45 $host kernel: ata5: command timeout
Nov 20 16:37:45 $host kernel: ata5: status=0x50 { DriveReady SeekComplete }
Nov 20 16:37:45 $host kernel: sde: Current: sense key: No Sense
Nov 20 16:37:45 $host kernel:     Additional sense: No additional sense information
Nov 20 16:37:45 $host kernel: sata_sil24 ata5: resetting controller...

The previous kernel message was a note about RAID reconstruction finishing
on Nov. 18.

The badblocks running on /dev/hde is immune to kill -9, but another
program I tried to access the disk with came back after several minutes.
(I don't know exactly how long; I tried to kill it for a while, then
started writing this mail, and just noticed the prompt reappeared while
I wasn't watching.)

The other 5 drives are still chugging along, including /dev/sdf.  No
disk errors have been reported.

The machine is currently up and running in the stuck state if there
is any useful debugging info I can extract from it.

Anyway, I hope this is of some use.
