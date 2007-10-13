From: jeffunit <jeff@jeffunit.com>
Subject: marvell 88SX6081 and linux 2.6.23.1
Date: Sat, 13 Oct 2007 11:57:11 -0700
Message-ID: <S1756649AbXJMTC2/20071013190228Z+1695@xvger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: (root@vger.kernel.org) by vger.kernel.org id S1753843AbXJNA3j
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Oct 2007 20:29:39 -0400
Received: from sccrmhc14.comcast.net ([204.127.200.84]:51362 "EHLO
	sccrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649AbXJMTC2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 15:02:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I built a kernel, 2.6.23.1 today.
My motherboard is an intel stl2, dual pentium 933 motherboard, with 
about 3gb of ram.
I also have a promise tx100 controller with an ata hard drive for the 
os, and a sony dvdrw drive.
There is an intel gigabit ethernet card, and an ati pci video card.

I have an 8 port supermicro sata II controller with the marvell 
888SX6081 chipset.
I have four 500gb sata II maxtor hard drives attached to it.

All except /dev/sda1 seem to work fine.
When I copy/modify files on /dev/sda1, I get the following dmesg errors:

The machine is designed to be a fileserver, but I am happy to help 
debug this issue to the best
of my abilities.

When I boot windows xp, xp sees all 4 of the sata drives, and they 
work without any problems.

Please advise,
jeff

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         05 90 02 37
sd 0:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 93323831
ReiserFS: sda1: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [68977 68978 0x0 SD]
ata1: EH complete
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         05 90 02 37
sd 0:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 93323831
ata1: EH complete
ReiserFS: sda1: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [68983 68984 0x0 SD]
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:1f:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:26:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:26:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:26:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:26:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:26:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         08 58 02 26
sd 0:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 139985446
ata1: EH complete
ReiserFS: sda1: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [259213 259497 0x0 SD]
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:26:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:26:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:26:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:26:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:26:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:1f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:26:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         08 58 02 26
sd 0:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 139985446
ReiserFS: sda1: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [259213 259518 0x0 SD]
ata1: EH complete
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:2f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:32:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:2f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:32:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:2f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:32:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:2f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:32:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:2f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:32:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:2f:02:58/00:00:00:00:00/e8 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:32:02:58/00:00:00:00:00/e8 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         08 58 02 32
sd 0:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 139985458
ata1: EH complete
ReiserFS: sda1: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [259213 259564 0x0 SD]
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         05 90 02 37
sd 0:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 93323831
ata1: EH complete
ReiserFS: sda1: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [68977 68978 0x0 SD]
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         05 90 02 37
sd 0:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 93323831
ReiserFS: sda1: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [68981 68982 0x0 SD]
ata1: EH complete
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         05 90 02 37
sd 0:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 93323831
ReiserFS: sda1: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [68983 68984 0x0 SD]
ata1: EH complete
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd 25/00:08:2f:06:44/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:35:06:44/40:00:10:00:00/e0 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd 25/00:08:2f:06:44/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:35:06:44/40:00:10:00:00/e0 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd 25/00:08:2f:06:44/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:35:06:44/40:00:10:00:00/e0 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd 25/00:08:2f:06:44/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:35:06:44/40:00:10:00:00/e0 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: edma_err 0x00000084, EDMA self-disable
ata1.00: cmd 25/00:08:2f:06:44/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:35:06:44/40:00:10:00:00/e0 Emask 0x9 (media error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd 25/00:08:2f:06:44/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 40/00:00:35:06:44/40:00:10:00:00/e0 Emask 0x4 (timeout)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
         10 44 06 35
sd 0:0:0:0: [sda] Add. Sense: No additional sense information
end_request: I/O error, dev sda, sector 272893487
ata1: EH complete
ReiserFS: sda1: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [78843 83201 0x0 SD]
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd 25/00:08:2f:06:44/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 40/00:00:35:06:44/40:00:10:00:00/e0 Emask 0x4 (timeout)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd 25/00:08:2f:06:44/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 40/00:00:35:06:44/40:00:10:00:00/e0 Emask 0x4 (timeout)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1: limiting SATA link speed to 1.5 Gbps
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 25/00:08:2f:06:44/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 40/00:00:35:06:44/40:00:10:00:00/e0 Emask 0x4 (timeout)
ata1: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd 25/00:08:2f:06:44/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 40/00:00:35:06:44/40:00:10:00:00/e0 Emask 0x4 (timeout)
ata1: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd 25/00:08:2f:06:44/00:00:10:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 40/00:00:35:06:44/40:00:10:00:00/e0 Emask 0x4 (timeout)
ata1: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete


