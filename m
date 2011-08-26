From: Marc MERLIN <marc@merlins.org>
Subject: Port Multiplier vendor mismatch '0x1095' != '0x101'
Date: Thu, 25 Aug 2011 23:40:50 -0700
Message-ID: <20110826064050.GD17614@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:46188 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1HZHZp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Aug 2011 03:25:45 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Tejun & All,

I had a bad block on sdh1, so I removed it from my raidset, and then made
the raid rebuild on the drive to allocate a new block.

Soon thereafter, I got some kind of failure, and all my drives got kicked
out.

This is on 2.6.39.1 and looks similar to
http://www.spinics.net/lists/linux-ide/msg41155.html

The only thing is that the PMP worked fine for several months until it
failed after the drive error.. so I don't think your patch applies to me
since my PMP otherwise works fine.

Aug 25 23:10:51 gargamel kernel: ata11.15: Port Multiplier vendor mismatch '0x1095' != '0x101'
Aug 25 23:10:51 gargamel kernel: ata11.15: PMP revalidation failed (errno=-19)
Aug 25 23:10:51 gargamel kernel: ata11.15: failed to recover PMP after 5 tries, giving up
Aug 25 23:10:51 gargamel kernel: ata11.15: Port Multiplier detaching

At the end of this, all my drives were gone from /proc/scsi/scsi.
02:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)

I rebooted the system without power cycling anything, and everything came back.

I upgraded to 3.0.1 in the process to see if it'll make a difference. For now the
raid is rebuilding, I'll see if it completes the 24H it'll take.
Mmmh, I'm seeing more recoverable errors during rebuild, see below (second set of logs)
Can you tell what's going on from that 2nd set of logs?

Rebuild is contuing, but speed is pretty poor due to the occasional bus issues:
      7814045696 blocks super 1.2 level 5, 512k chunk, algorithm 2 [5/4] [_UUUU]
      [>....................]  recovery =  0.8% (17523056/1953511424) finish=1390.4min speed=23205K/sec



Full logs of the original failure: (other logs below)
Aug 25 23:07:56 gargamel kernel: md/raid:md7: Disk failure on sdh1, disabling device.
Aug 25 23:07:56 gargamel kernel: md/raid:md7: Operation continuing on 4 devices.
Aug 25 23:08:28 gargamel kernel: RAID conf printout:
Aug 25 23:08:28 gargamel kernel:  --- level:5 rd:5 wd:4
Aug 25 23:08:28 gargamel kernel:  disk 0, o:0, dev:sdh1
Aug 25 23:08:28 gargamel kernel:  disk 1, o:1, dev:sdl1
Aug 25 23:08:28 gargamel kernel:  disk 2, o:1, dev:sdk1
Aug 25 23:08:28 gargamel kernel:  disk 3, o:1, dev:sdj1
Aug 25 23:08:28 gargamel kernel:  disk 4, o:1, dev:sdi1
Aug 25 23:08:28 gargamel kernel: RAID conf printout:
Aug 25 23:08:28 gargamel kernel:  --- level:5 rd:5 wd:4
Aug 25 23:08:28 gargamel kernel:  disk 1, o:1, dev:sdl1
Aug 25 23:08:28 gargamel kernel:  disk 2, o:1, dev:sdk1
Aug 25 23:08:28 gargamel kernel:  disk 3, o:1, dev:sdj1
Aug 25 23:08:28 gargamel kernel:  disk 4, o:1, dev:sdi1
Aug 25 23:09:02 gargamel kernel: md: unbind<sdh1>
Aug 25 23:09:03 gargamel kernel: md: export_rdev(sdh1)
Aug 25 23:09:12 gargamel kernel: md: bind<sdh1>
Aug 25 23:09:13 gargamel kernel: RAID conf printout:
Aug 25 23:09:13 gargamel kernel:  --- level:5 rd:5 wd:4
Aug 25 23:09:13 gargamel kernel:  disk 0, o:1, dev:sdh1
Aug 25 23:09:13 gargamel kernel:  disk 1, o:1, dev:sdl1
Aug 25 23:09:13 gargamel kernel:  disk 2, o:1, dev:sdk1
Aug 25 23:09:13 gargamel kernel:  disk 3, o:1, dev:sdj1
Aug 25 23:09:13 gargamel kernel:  disk 4, o:1, dev:sdi1
Aug 25 23:09:13 gargamel kernel: md: recovery of RAID array md7
Aug 25 23:09:13 gargamel kernel: md: minimum _guaranteed_  speed: 40000 KB/sec/disk.
Aug 25 23:09:13 gargamel kernel: md: using maximum available idle IO bandwidth (but not more than 81920 KB/sec) for recovery.
Aug 25 23:09:13 gargamel kernel: md: using 128k window, over a total of 1953511424 blocks.
Aug 25 23:09:33 gargamel kernel: ata11.00: failed to read SCR 1 (Emask=0x40)
Aug 25 23:09:33 gargamel kernel: ata11.01: failed to read SCR 1 (Emask=0x40)
Aug 25 23:09:33 gargamel kernel: ata11.02: failed to read SCR 1 (Emask=0x40)
Aug 25 23:09:33 gargamel kernel: ata11.03: failed to read SCR 1 (Emask=0x40)
Aug 25 23:09:33 gargamel kernel: ata11.04: failed to read SCR 1 (Emask=0x40)
Aug 25 23:09:33 gargamel kernel: ata11.05: failed to read SCR 1 (Emask=0x40)
Aug 25 23:09:33 gargamel kernel: ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x400000 action 0x6 frozen
Aug 25 23:09:33 gargamel kernel: ata11.15: edma_err_cause=42200080 pp_flags=00000007, EDMA self-disable
Aug 25 23:09:33 gargamel kernel: ata11.15: SError: { Handshk }
Aug 25 23:09:33 gargamel kernel: ata11.00: exception Emask 0x100 SAct 0x3 SErr 0x0 action 0x6 frozen
Aug 25 23:09:33 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:09:33 gargamel kernel: ata11.00: cmd 61/f8:00:1f:d2:1a/03:00:00:00:00/40 tag 0 ncq 520192 out
Aug 25 23:09:33 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:09:33 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:09:33 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:09:33 gargamel kernel: ata11.00: cmd 61/08:08:17:d6:1a/00:00:00:00:00/40 tag 1 ncq 4096 out
Aug 25 23:09:33 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:09:33 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:09:33 gargamel kernel: ata11.01: exception Emask 0x100 SAct 0x2000 SErr 0x0 action 0x6 frozen
Aug 25 23:09:33 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:09:33 gargamel kernel: ata11.01: cmd 60/f0:68:27:d6:1a/03:00:00:00:00/40 tag 13 ncq 516096 in
Aug 25 23:09:33 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:09:33 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:09:33 gargamel kernel: ata11.02: exception Emask 0x100 SAct 0x4 SErr 0x0 action 0x6 frozen
Aug 25 23:09:33 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:09:33 gargamel kernel: ata11.02: cmd 60/f0:10:27:d6:1a/03:00:00:00:00/40 tag 2 ncq 516096 in
Aug 25 23:09:33 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:09:33 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:09:33 gargamel kernel: ata11.03: exception Emask 0x100 SAct 0x300 SErr 0x0 action 0x6 frozen
Aug 25 23:09:33 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:09:33 gargamel kernel: ata11.03: cmd 60/10:40:07:d7:1a/03:00:00:00:00/40 tag 8 ncq 401408 in
Aug 25 23:09:33 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:09:33 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:09:33 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:09:33 gargamel kernel: ata11.03: cmd 60/e8:48:1f:d6:1a/00:00:00:00:00/40 tag 9 ncq 118784 in
Aug 25 23:09:33 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:09:33 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:09:33 gargamel kernel: ata11.04: exception Emask 0x100 SAct 0x8 SErr 0x0 action 0x6 frozen
Aug 25 23:09:33 gargamel kernel: ata11.04: failed command: READ FPDMA QUEUED
Aug 25 23:09:33 gargamel kernel: ata11.04: cmd 60/f8:18:1f:d6:1a/03:00:00:00:00/40 tag 3 ncq 520192 in
Aug 25 23:09:33 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:09:33 gargamel kernel: ata11.04: status: { DRDY }
Aug 25 23:09:33 gargamel kernel: ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 25 23:09:33 gargamel kernel: ata11.15: hard resetting link
Aug 25 23:09:33 gargamel kernel: ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug 25 23:09:33 gargamel kernel: ata11.00: hard resetting link
Aug 25 23:09:33 gargamel kernel: ata11.01: hard resetting link
Aug 25 23:09:34 gargamel kernel: ata11.02: hard resetting link
Aug 25 23:09:34 gargamel kernel: ata11.03: hard resetting link
Aug 25 23:09:34 gargamel kernel: ata11.04: hard resetting link
Aug 25 23:09:35 gargamel kernel: ata11.05: hard resetting link
Aug 25 23:09:35 gargamel kernel: ata11.00: configured for UDMA/133
Aug 25 23:09:35 gargamel kernel: ata11.01: configured for UDMA/133
Aug 25 23:09:35 gargamel kernel: ata11.02: configured for UDMA/133
Aug 25 23:09:35 gargamel kernel: ata11.03: configured for UDMA/133
Aug 25 23:09:35 gargamel kernel: ata11.04: configured for UDMA/133
Aug 25 23:09:35 gargamel kernel: ata11: EH complete
Aug 25 23:10:16 gargamel kernel: ata11.00: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:16 gargamel kernel: ata11.01: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:16 gargamel kernel: ata11.02: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:16 gargamel kernel: ata11.03: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:16 gargamel kernel: ata11.04: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:16 gargamel kernel: ata11.05: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:16 gargamel kernel: ata11.15: exception Emask 0x4 SAct 0x0 SErr 0x400000 action 0x6 frozen
Aug 25 23:10:16 gargamel kernel: ata11.15: SError: { Handshk }
Aug 25 23:10:16 gargamel kernel: ata11.00: exception Emask 0x100 SAct 0x80 SErr 0x0 action 0x6 frozen
Aug 25 23:10:16 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:10:16 gargamel kernel: ata11.00: cmd 61/08:38:1f:d6:1a/00:00:00:00:00/40 tag 7 ncq 4096 out
Aug 25 23:10:16 gargamel kernel:          res 40/00:10:9f:4a:ed/00:00:e0:00:00/40 Emask 0x4 (timeout)
Aug 25 23:10:16 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:10:16 gargamel kernel: ata11.01: exception Emask 0x100 SAct 0x114 SErr 0x0 action 0x6 frozen
Aug 25 23:10:16 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:16 gargamel kernel: ata11.01: cmd 60/00:10:17:da:1a/04:00:00:00:00/40 tag 2 ncq 524288 in
Aug 25 23:10:16 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x4 (timeout)
Aug 25 23:10:16 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:16 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:16 gargamel kernel: ata11.01: cmd 60/08:20:17:de:1a/00:00:00:00:00/40 tag 4 ncq 4096 in
Aug 25 23:10:16 gargamel kernel:          res 40/00:10:9f:4a:ed/00:00:e0:00:00/40 Emask 0x4 (timeout)
Aug 25 23:10:16 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:16 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:16 gargamel kernel: ata11.01: cmd 60/08:40:4f:02:d1/00:00:02:00:00/40 tag 8 ncq 4096 in
Aug 25 23:10:16 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x4 (timeout)
Aug 25 23:10:16 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:16 gargamel kernel: ata11.02: exception Emask 0x100 SAct 0x8 SErr 0x0 action 0x6 frozen
Aug 25 23:10:16 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:16 gargamel kernel: ata11.02: cmd 60/f0:18:27:d6:1a/03:00:00:00:00/40 tag 3 ncq 516096 in
Aug 25 23:10:16 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x4 (timeout)
Aug 25 23:10:16 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:16 gargamel kernel: ata11.03: exception Emask 0x100 SAct 0x3 SErr 0x0 action 0x6 frozen
Aug 25 23:10:16 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:16 gargamel kernel: ata11.03: cmd 60/00:00:17:da:1a/04:00:00:00:00/40 tag 0 ncq 524288 in
Aug 25 23:10:16 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x4 (timeout)
Aug 25 23:10:16 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:16 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:16 gargamel kernel: ata11.03: cmd 60/08:08:17:de:1a/00:00:00:00:00/40 tag 1 ncq 4096 in
Aug 25 23:10:16 gargamel kernel:          res 40/00:04:1f:d2:1a/00:00:00:00:00/40 Emask 0x4 (timeout)
Aug 25 23:10:16 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:16 gargamel kernel: ata11.04: exception Emask 0x100 SAct 0x60 SErr 0x0 action 0x6 frozen
Aug 25 23:10:16 gargamel kernel: ata11.04: failed command: READ FPDMA QUEUED
Aug 25 23:10:16 gargamel kernel: ata11.04: cmd 60/00:28:17:da:1a/04:00:00:00:00/40 tag 5 ncq 524288 in
Aug 25 23:10:16 gargamel kernel:          res 40/00:10:9f:4a:ed/00:00:e0:00:00/40 Emask 0x4 (timeout)
Aug 25 23:10:16 gargamel kernel: ata11.04: status: { DRDY }
Aug 25 23:10:16 gargamel kernel: ata11.04: failed command: READ FPDMA QUEUED
Aug 25 23:10:16 gargamel kernel: ata11.04: cmd 60/08:30:17:de:1a/00:00:00:00:00/40 tag 6 ncq 4096 in
Aug 25 23:10:16 gargamel kernel:          res 40/00:10:9f:4a:ed/00:00:e0:00:00/40 Emask 0x4 (timeout)
Aug 25 23:10:16 gargamel kernel: ata11.04: status: { DRDY }
Aug 25 23:10:16 gargamel kernel: ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 25 23:10:16 gargamel kernel: ata11.15: hard resetting link
Aug 25 23:10:17 gargamel kernel: ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug 25 23:10:17 gargamel kernel: ata11.00: hard resetting link
Aug 25 23:10:17 gargamel kernel: ata11.01: hard resetting link
Aug 25 23:10:18 gargamel kernel: ata11.02: hard resetting link
Aug 25 23:10:18 gargamel kernel: ata11.03: hard resetting link
Aug 25 23:10:18 gargamel kernel: ata11.04: hard resetting link
Aug 25 23:10:19 gargamel kernel: ata11.05: hard resetting link
Aug 25 23:10:19 gargamel kernel: ata11.00: configured for UDMA/133
Aug 25 23:10:19 gargamel kernel: ata11.01: configured for UDMA/133
Aug 25 23:10:19 gargamel kernel: ata11.02: configured for UDMA/133
Aug 25 23:10:19 gargamel kernel: ata11.03: configured for UDMA/133
Aug 25 23:10:19 gargamel kernel: ata11.04: configured for UDMA/133
Aug 25 23:10:19 gargamel kernel: ata11: EH complete
Aug 25 23:10:35 gargamel kernel: ata11.00: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:35 gargamel kernel: ata11.01: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:35 gargamel kernel: ata11.02: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:35 gargamel kernel: ata11.03: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:35 gargamel kernel: ata11.04: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:35 gargamel kernel: ata11.05: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:35 gargamel kernel: ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x400000 action 0x6 frozen
Aug 25 23:10:35 gargamel kernel: ata11.15: edma_err_cause=42200080 pp_flags=00000007, EDMA self-disable
Aug 25 23:10:35 gargamel kernel: ata11.15: SError: { Handshk }
Aug 25 23:10:35 gargamel kernel: ata11.00: exception Emask 0x100 SAct 0x1 SErr 0x0 action 0x6 frozen
Aug 25 23:10:35 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.00: cmd 61/f8:00:77:1b:2b/03:00:00:00:00/40 tag 0 ncq 520192 out
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.01: exception Emask 0x100 SAct 0x24924490 SErr 0x0 action 0x6 frozen
Aug 25 23:10:35 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.01: cmd 60/08:20:bf:1f:2b/00:00:00:00:00/40 tag 4 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.01: cmd 60/40:38:c7:1f:2b/02:00:00:00:00/40 tag 7 ncq 294912 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.01: cmd 60/70:50:07:22:2b/01:00:00:00:00/40 tag 10 ncq 188416 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.01: cmd 60/08:70:8f:1f:2b/00:00:00:00:00/40 tag 14 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.01: cmd 60/08:88:97:1f:2b/00:00:00:00:00/40 tag 17 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.01: cmd 60/08:a0:9f:1f:2b/00:00:00:00:00/40 tag 20 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.01: cmd 60/08:b8:a7:1f:2b/00:00:00:00:00/40 tag 23 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.01: cmd 60/08:d0:af:1f:2b/00:00:00:00:00/40 tag 26 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.01: cmd 60/08:e8:b7:1f:2b/00:00:00:00:00/40 tag 29 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.02: exception Emask 0x100 SAct 0x49248120 SErr 0x0 action 0x6 frozen
Aug 25 23:10:35 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.02: cmd 60/08:28:bf:1f:2b/00:00:00:00:00/40 tag 5 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.02: cmd 60/b0:40:c7:1f:2b/03:00:00:00:00/40 tag 8 ncq 483328 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.02: cmd 60/08:78:8f:1f:2b/00:00:00:00:00/40 tag 15 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:35 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.02: cmd 60/08:90:97:1f:2b/00:00:00:00:00/40 tag 18 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.02: cmd 60/08:a8:9f:1f:2b/00:00:00:00:00/40 tag 21 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.02: cmd 60/08:c0:a7:1f:2b/00:00:00:00:00/40 tag 24 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:35 gargamel kernel: ata11.02: cmd 60/08:d8:af:1f:2b/00:00:00:00:00/40 tag 27 ncq 4096 in
Aug 25 23:10:35 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:35 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:35 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:36 gargamel kernel: ata11.02: cmd 60/08:f0:b7:1f:2b/00:00:00:00:00/40 tag 30 ncq 4096 in
Aug 25 23:10:36 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:36 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:36 gargamel kernel: ata11.03: exception Emask 0x100 SAct 0x1248024a SErr 0x0 action 0x6 frozen
Aug 25 23:10:36 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:36 gargamel kernel: ata11.03: cmd 60/08:08:b7:1f:2b/00:00:00:00:00/40 tag 1 ncq 4096 in
Aug 25 23:10:36 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:36 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:36 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:36 gargamel kernel: ata11.03: cmd 60/78:18:bf:1f:2b/01:00:00:00:00/40 tag 3 ncq 192512 in
Aug 25 23:10:36 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:36 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:36 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:36 gargamel kernel: ata11.03: cmd 60/08:30:37:21:2b/00:00:00:00:00/40 tag 6 ncq 4096 in
Aug 25 23:10:36 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:36 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:36 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:36 gargamel kernel: ata11.03: cmd 60/38:48:3f:21:2b/02:00:00:00:00/40 tag 9 ncq 290816 in
Aug 25 23:10:36 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:36 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:36 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:36 gargamel kernel: ata11.03: cmd 60/08:98:97:1f:2b/00:00:00:00:00/40 tag 19 ncq 4096 in
Aug 25 23:10:36 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:36 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:36 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:36 gargamel kernel: ata11.03: cmd 60/08:b0:9f:1f:2b/00:00:00:00:00/40 tag 22 ncq 4096 in
Aug 25 23:10:36 gargamel kernel:          res 40/00:b4:9f:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:36 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:36 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:36 gargamel kernel: ata11.03: cmd 60/08:c8:a7:1f:2b/00:00:00:00:00/40 ta0 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 25 23:10:36 gargamel kernel: ata11.15: hard resetting link
Aug 25 23:10:36 gargamel kernel: ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug 25 23:10:36 gargamel kernel: ata11.00: hard resetting link
Aug 25 23:10:37 gargamel kernel: ata11.01: hard resetting link
Aug 25 23:10:37 gargamel kernel: ata11.02: hard resetting link
Aug 25 23:10:37 gargamel kernel: ata11.03: hard resetting link
Aug 25 23:10:37 gargamel kernel: ata11.04: hard resetting link
Aug 25 23:10:38 gargamel kernel: ata11.05: hard resetting link
Aug 25 23:10:38 gargamel kernel: ata11.00: configured for UDMA/133
Aug 25 23:10:38 gargamel kernel: ata11.01: configured for UDMA/133
Aug 25 23:10:38 gargamel kernel: ata11.02: configured for UDMA/133
Aug 25 23:10:38 gargamel kernel: ata11.03: configured for UDMA/133
Aug 25 23:10:38 gargamel kernel: ata11.04: configured for UDMA/133
Aug 25 23:10:38 gargamel kernel: ata11: EH complete
Aug 25 23:10:38 gargamel kernel: ata11: Unable to stop eDMA
Aug 25 23:10:38 gargamel kernel: ata11.00: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:38 gargamel kernel: ata11.01: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:38 gargamel kernel: ata11.02: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:38 gargamel kernel: ata11.03: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:38 gargamel kernel: ata11.04: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:38 gargamel kernel: ata11.05: failed to read SCR 1 (Emask=0x40)
Aug 25 23:10:38 gargamel kernel: ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 25 23:10:38 gargamel kernel: ata11.15: edma_err_cause=40000000 pp_flags=00000007
Aug 25 23:10:38 gargamel kernel: ata11.00: exception Emask 0x100 SAct 0x1 SErr 0x0 action 0x6 frozen
Aug 25 23:10:38 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:10:38 gargamel kernel: ata11.00: cmd 61/f8:00:77:1b:2b/03:00:00:00:00/40 tag 0 ncq 520192 out
Aug 25 23:10:38 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:38 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:10:38 gargamel kernel: ata11.01: exception Emask 0x100 SAct 0x3fe SErr 0x0 action 0x6 frozen
Aug 25 23:10:38 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:38 gargamel kernel: ata11.01: cmd 60/08:08:b7:1f:2b/00:00:00:00:00/40 tag 1 ncq 4096 in
Aug 25 23:10:38 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:38 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:38 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:38 gargamel kernel: ata11.01: cmd 60/08:10:af:1f:2b/00:00:00:00:00/40 tag 2 ncq 4096 in
Aug 25 23:10:38 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:38 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:38 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:38 gargamel kernel: ata11.01: cmd 60/08:18:a7:1f:2b/00:00:00:00:00/40 tag 3 ncq 4096 in
Aug 25 23:10:38 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:38 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:38 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:38 gargamel kernel: ata11.01: cmd 60/08:20:9f:1f:2b/00:00:00:00:00/40 tag 4 ncq 4096 in
Aug 25 23:10:38 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:38 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:38 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.01: cmd 60/08:28:97:1f:2b/00:00:00:00:00/40 tag 5 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.01: cmd 60/08:30:8mel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.01: cmd 60/08:48:bf:1f:2b/00:00:00:00:00/40 tag 9 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.02: exception Emask 0x100 SAct 0x3fc00 SErr 0x0 action 0x6 frozen
Aug 25 23:10:39 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.02: cmd 60/08:50:b7:1f:2b/00:00:00:00:00/40 tag 10 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.02: cmd 60/08:58:af:1f:2b/00:00:00:00:00/40 tag 11 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.02: cmd 60/08:60:a7:1f:2b/00:00:00:00:00/40 tag 12 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.02: cmd 60/08:68:9f:1f:2b/00:00:00:00:00/40 tag 13 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.02: cmd 60/08:70:97:1f:2b/00:00:00:00:00/40 tag 14 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.02: cmd 60/08:78:8f:1f:2b/00:00:00:00:00/40 tag 15 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.02: cmd 60/b0:80:c7:1f:2b/03:00:00:00:00/40 tag 16 ncq 483328 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.02: cmd 60/08:88:bf:1f:2b/00:00:00:00:00/40 tag 17 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.03: exception Emask 0x100 SAct 0x3fc0000 SErr 0x0 action 0x6 frozen
Aug 25 23:10:39 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.03: cmd 60/08:90:af:1f:2b/00:00:00:00:00/40 tag 18 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.03: cmd 60/08:98:a7:1f:2b/00:00:00:00:00/40 tag 19 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/010:39 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.03: cmd 60/38:b0:3f:21:2b/02:00:00:00:00/40 tag 22 ncq 290816 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.03: cmd 60/08:b8:37:21:2b/00:00:00:00:00/40 tag 23 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.03: cmd 60/78:c0:bf:1f:2b/01:00:00:00:00/40 tag 24 ncq 192512 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.03: cmd 60/08:c8:b7:1f:2b/00:00:00:00:00/40 tag 25 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.04: exception Emask 0x100 SAct 0x4000000 SErr 0x0 action 0x6 frozen
Aug 25 23:10:39 gargamel kernel: ata11.04: failed command: READ FPDMA QUEUED
Aug 25 23:10:39 gargamel kernel: ata11.04: cmd 60/08:d0:4f:22:40/00:00:00:00:00/40 tag 26 ncq 4096 in
Aug 25 23:10:39 gargamel kernel:          res 40/00:cc:b7:1f:2b/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:10:39 gargamel kernel: ata11.04: status: { DRDY }
Aug 25 23:10:39 gargamel kernel: ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 25 23:10:39 gargamel kernel: ata11.15: hard resetting link
Aug 25 23:10:40 gargamel kernel: ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug 25 23:10:40 gargamel kernel: ata11.15: Port Multiplier vendor mismatch '0x1095' != '0x101'
Aug 25 23:10:40 gargamel kernel: ata11.15: PMP revalidation failed (errno=-19)
Aug 25 23:10:45 gargamel kernel: ata11.15: hard resetting link
Aug 25 23:10:45 gargamel kernel: ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug 25 23:10:45 gargamel kernel: ata11.15: Port Multiplier vendor mismatch '0x1095' != '0x101'
Aug 25 23:10:45 gargamel kernel: ata11.15: PMP revalidation failed (errno=-19)
Aug 25 23:10:45 gargamel kernel: ata11.15: limiting SATA link speed to 1.5 Gbps
Aug 25 23:10:50 gargamel kernel: ata11.15: hard resetting link
Aug 25 23:10:51 gargamel kernel: ata11.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Aug 25 23:10:51 gargamel kernel: ata11.15: Port Multiplier vendor mismatch '0x1095' != '0x101'
Aug 25 23:10:51 gargamel kernel: ata11.15: PMP revalidation failed (errno=-19)
Aug 25 23:10:51 gargamel kernel: ata11.15: failed to recover PMP after 5 tries, giving up
Aug 25 23:10:51 gargamel kernel: ata11.15: Port Multiplier detaching
Aug 25 23:10:51 gargamel kernel: ata11.00: disabled
Aug 25 23:10:51 gargamel kernel: ata11.01: disabled
Aug 25 23:10:51 gargamel kernel: ata11.02: disabled
Aug 25 23:10:51 gargamel kernel: ata11.03: disabled
Aug 25 23:10:51 gargamel kernel: ata11.04: disabled
Aug 25 23:10:51 gargamel kernel: ata11.00: disabled
Aug 25 23:10:56 gargamel kernel: ata11: hard resetting link
Aug 25 23:10:56 gargamel kernel: ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug 25 23:10:56 gargamel kernel: ata11.15: Port Multiplier <unknown>, 0x0101:0x9669 r1, 1 ports, feat 0x96690101/0x96690101
Aug 25 23:10:56 gargamel kernel: ata11.15: Asynchronous notification not supported, hotplug won't
Aug 25 23:10:56 gargamel kernel:          work on fan-out ports. Use warm-plug instead.
Aug 25 23:10:56 gargamel kernel: ata11.00: hard resetting link
Aug 25 23:10:57 gargamel kernmel kernel: sd 10:0:0:0: rejecting I/O to offline device
Aug 25 23:10:59 gargamel kernel: sd 10:1:0:0: rejecting I/O to offline device
Aug 25 23:10:59 gargamel kernel: end_request: I/O error, dev sdi, sector 71
Aug 25 23:10:59 gargamel kernel: md: super_written gets error=-5, uptodate=0
Aug 25 23:10:59 gargamel kernel: md/raid:md7: Disk failure on sdi1, disabling device.
Aug 25 23:10:59 gargamel kernel: md/raid:md7: Operation continuing on 3 devices.
Aug 25 23:10:59 gargamel kernel: sd 10:2:0:0: rejecting I/O to offline device
Aug 25 23:10:59 gargamel kernel: end_request: I/O error, dev sdj, sector 71
Aug 25 23:10:59 gargamel kernel: md: super_written gets error=-5, uptodate=0
Aug 25 23:10:59 gargamel kernel: md/raid:md7: Disk failure on sdj1, disabling device.
Aug 25 23:10:59 gargamel kernel: md/raid:md7: Operation continuing on 2 devices.
Aug 25 23:10:59 gargamel kernel: sd 10:3:0:0: rejecting I/O to offline device
Aug 25 23:10:59 gargamel kernel: sd 10:3:0:0: rejecting I/O to offline device
Aug 25 23:10:59 gargamel kernel: end_request: I/O error, dev sdk, sector 71
Aug 25 23:10:59 gargamel kernel: md: super_written gets error=-5, uptodate=0
Aug 25 23:10:59 gargamel kernel: md/raid:md7: Disk failure on sdk1, disabling device.
Aug 25 23:10:59 gargamel kernel: md/raid:md7: Operation continuing on 1 devices.
Aug 25 23:10:59 gargamel kernel: sd 10:4:0:0: rejecting I/O to offline device
Aug 25 23:10:59 gargamel kernel: end_request: I/O error, dev sdl, sector 71
Aug 25 23:10:59 gargamel kernel: md: super_written gets error=-5, uptodate=0
Aug 25 23:10:59 gargamel kernel: md/raid:md7: Disk failure on sdl1, disabling device.
Aug 25 23:10:59 gargamel kernel: md/raid:md7: Operation continuing on 0 devices.
Aug 25 23:10:59 gargamel kernel: sd 10:3:0:0: [sdk] Unhandled error code
Aug 25 23:10:59 gargamel kernel: sd 10:3:0:0: [sdk]  Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
Aug 25 23:10:59 gargamel kernel: sd 10:3:0:0: [sdk] CDB: Read(10): 28 00 70 01 dc 47 00 00 38 00
Aug 25 23:10:59 gargamel kernel: end_request: I/O error, dev sdk, sector 1879170119
Aug 25 23:10:59 gargamel kernel: sd 10:0:0:0: rejecting I/O to offline device
Aug 25 23:10:59 gargamel kernel: sd 10:0:0:0: rejecting I/O to offline device
Aug 25 23:10:59 gargamel kernel: sd 10:0:0:0: [sdh] Asking for cache data failed
Aug 25 23:10:59 gargamel kernel: sd 10:0:0:0: [sdh] Assuming drive cache: write through
Aug 25 23:10:59 gargamel kernel: ata11.00: failed to resume link (SControl 96690101)
Aug 25 23:10:59 gargamel kernel: ata11.00: failed to recover link after 3 tries, disabling
Aug 25 23:10:59 gargamel kernel: ata11.00: PHY status changed but maxed out on retries, giving up
Aug 25 23:10:59 gargamel kernel: ata11.00: Manully issue scan to resume this link
Aug 25 23:10:59 gargamel kernel: sd 10:0:0:0: [sdh]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:10:59 gargamel kernel: sd 10:0:0:0: [sdh]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:10:59 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:10:59 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:10:59 gargamel kernel:         00 2b 1f b7 
Aug 25 23:10:59 gargamel kernel: sd 10:0:0:0: [sdh]  Add. Sense: No additional sense information
Aug 25 23:10:59 gargamel kernel: sd 10:0:0:0: [sdh] CDB: Write(10): 2a 00 00 2b 1b 77 00 03 f8 00
Aug 25 23:10:59 gargamel kernel: end_request: I/O error, dev sdh, sector 2825079
Aug 25 23:10:59 gargamel kernel: sd 10:1:0:0: [sdi]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:10:59 gargamel kernel: sd 10:1:0:0: [sdi]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:10:59 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:10:59 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:10:59 gargamel kernel:         00 2b 1f b7 
Aug 25 23:10:59 gargamel kernel: sd 10:1:0:0: [sdi]  Add. Sense: No additional sense information
Aug 25 23:10:59 gargamel kernel: sd 10:1:0:0: [sdi] CDB: Read(10): 28 00 00 2b 1fe dm-3, logical block 20976160
Aug 25 23:11:00 gargamel kernel: lost page write due to I/O error on dm-3
Aug 25 23:11:00 gargamel kernel: Buffer I/O error on device dm-3, logical block 23592992
Aug 25 23:11:00 gargamel kernel: lost page write due to I/O error on dm-3
Aug 25 23:11:00 gargamel kernel: Buffer I/O error on device dm-3, logical block 23593028
Aug 25 23:11:00 gargamel kernel: lost page write due to I/O error on dm-3
Aug 25 23:11:00 gargamel kernel: Buffer I/O error on device dm-3, logical block 27263011
Aug 25 23:11:00 gargamel kernel: lost page write due to I/O error on dm-3
Aug 25 23:11:00 gargamel kernel: device-mapper: snapshots: Invalidating snapshot: Error reading/writing.
Aug 25 23:11:00 gargamel kernel: device-mapper: persistent snapshot: write header failed
Aug 25 23:11:00 gargamel kernel: Aborting journal on device dm-3-8.
Aug 25 23:11:00 gargamel kernel: Buffer I/O error on device dm-3, logical block 939556864
Aug 25 23:11:00 gargamel kernel: lost page write due to I/O error on dm-3
Aug 25 23:11:00 gargamel kernel: JBD2: I/O error detected when updating journal superblock for dm-3-8.
Aug 25 23:11:00 gargamel kernel: md: md7: recovery done.
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:00 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:00 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:00 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Add. Sense: No additional sense information
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi] CDB: Read(10): 28 00 00 2b 1f af 00 00 08 00
Aug 25 23:11:00 gargamel kernel: end_request: I/O error, dev sdi, sector 2826159
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:00 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:00 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:00 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Add. Sense: No additional sense information
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi] CDB: Read(10): 28 00 00 2b 1f a7 00 00 08 00
Aug 25 23:11:00 gargamel kernel: end_request: I/O error, dev sdi, sector 2826151
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:00 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:00 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:00 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Add. Sense: No additional sense information
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi] CDB: Read(10): 28 00 00 2b 1f 9f 00 00 08 00
Aug 25 23:11:00 gargamel kernel: end_request: I/O error, dev sdi, sector 2826143
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:00 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:00 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:00 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Add. Sense: No additional sense information
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi] CDB: Read(10): 28 00 00 2b 1f 97 00 00 08 00
Aug 25 23:11:00 gargamel kernel: end_request: I/O error, dev sdi, sector 2826135
Aug 25 23:11:00 gargamel kernel: sd 10:1:0:0: [sdi]  Result: hostbytb 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi] CDB: Read(10): 28 00 00 2b 22 07 00 01 70 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdi, sector 2826759
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi] CDB: Read(10): 28 00 00 2b 1f c7 00 02 40 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdi, sector 2826183
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi] CDB: Read(10): 28 00 00 2b 1f bf 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdi, sector 2826175
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj] CDB: Read(10): 28 00 00 2b 1f b7 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdj, sector 2826167
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj] CDB: Read(10): 28 00 00 2b 1f af 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdj, sector 2826159
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj] CDB: Read(10): 28 00 00 2b 1f a7 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdj, sector 2826151
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor senrnel: sd 10:2:0:0: [sdj]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj] CDB: Read(10): 28 00 00 2b 1f 97 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdj, sector 2826135
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj] CDB: Read(10): 28 00 00 2b 1f 8f 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdj, sector 2826127
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj] CDB: Read(10): 28 00 00 2b 1f c7 00 03 b0 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdj, sector 2826183
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj] CDB: Read(10): 28 00 00 2b 1f bf 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdj, sector 2826175
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk] CDB: Read(10): 28 00 00 2b 1f af 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdk, sector 2826159
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk] CDB: Read(10): 28 00 00 2b 1f a7 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdk, sector 2826151
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hrgamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk] CDB: Read(10): 28 00 00 2b 1f 97 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdk, sector 2826135
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk] CDB: Read(10): 28 00 00 2b 21 3f 00 02 38 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdk, sector 2826559
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk] CDB: Read(10): 28 00 00 2b 21 37 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdk, sector 2826551
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk] CDB: Read(10): 28 00 00 2b 1f bf 00 01 78 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdk, sector 2826175
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk] CDB: Read(10): 28 00 00 2b 1f b7 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdk, sector 2826167
Aug 25 23:11:02 gargamel kernel: sd 10:4:0:0: [sdl]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 25 23:11:02 gargamel kernel: sd 10:4:0:0: [sdl]  Sense Key : Aborted Command [current] [descriptor]
Aug 25 23:11:02 gargamel kernel: Descriptor sense data with sense descriptors (in hex):
Aug 25 23:11:02 gargamel kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 25 23:11:02 gargamel kernel:         00 2b 1f b7 
Aug 25 23:11:02 gargamel kernel: sd 10:4:0:0: [sdl]  Add. Sense: No additional sense information
Aug 25 23:11:02 gargamel kernel: sd 10:4:0:0: [sdl] CDB: Read(10): 28 00 00 40 22 4f 00 00 08 00
Aug 25 23:11:02 gargamel kernel: end_request: I/O error, dev sdl, sector 4203087
Aug 25 23:11:02 gargamel kernel: ata11: EH complete
Aug 25 23:11:02 gargamel kernel: ata11.00: detaching (SCSI 10:0:0:0)
Aug 25 23:11:0unable to read itable block
Aug 25 23:11:02 gargamel kernel: RAID conf printout:
Aug 25 23:11:02 gargamel kernel:  --- level:5 rd:5 wd:0
Aug 25 23:11:02 gargamel kernel:  disk 1, o:0, dev:sdl1
Aug 25 23:11:02 gargamel kernel:  disk 2, o:0, dev:sdk1
Aug 25 23:11:02 gargamel kernel:  disk 3, o:0, dev:sdj1
Aug 25 23:11:02 gargamel kernel:  disk 4, o:0, dev:sdi1
Aug 25 23:11:02 gargamel kernel: RAID conf printout:
Aug 25 23:11:02 gargamel kernel:  --- level:5 rd:5 wd:0
Aug 25 23:11:02 gargamel kernel:  disk 1, o:0, dev:sdl1
Aug 25 23:11:02 gargamel kernel:  disk 2, o:0, dev:sdk1
Aug 25 23:11:02 gargamel kernel:  disk 3, o:0, dev:sdj1
Aug 25 23:11:02 gargamel kernel:  disk 4, o:0, dev:sdi1
Aug 25 23:11:02 gargamel kernel: sd 10:0:0:0: [sdh] Stopping disk
Aug 25 23:11:02 gargamel kernel: sd 10:0:0:0: [sdh] START_STOP FAILED
Aug 25 23:11:02 gargamel kernel: sd 10:0:0:0: [sdh]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Aug 25 23:11:02 gargamel kernel: ata11.01: detaching (SCSI 10:1:0:0)
Aug 25 23:11:02 gargamel kernel: RAID conf printout:
Aug 25 23:11:02 gargamel kernel:  --- level:5 rd:5 wd:0
Aug 25 23:11:02 gargamel kernel:  disk 1, o:0, dev:sdl1
Aug 25 23:11:02 gargamel kernel:  disk 2, o:0, dev:sdk1
Aug 25 23:11:02 gargamel kernel:  disk 3, o:0, dev:sdj1
Aug 25 23:11:02 gargamel kernel: RAID conf printout:
Aug 25 23:11:02 gargamel kernel:  --- level:5 rd:5 wd:0
Aug 25 23:11:02 gargamel kernel:  disk 1, o:0, dev:sdl1
Aug 25 23:11:02 gargamel kernel:  disk 2, o:0, dev:sdk1
Aug 25 23:11:02 gargamel kernel:  disk 3, o:0, dev:sdj1
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi] Synchronizing SCSI cache
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi] Stopping disk
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi] START_STOP FAILED
Aug 25 23:11:02 gargamel kernel: sd 10:1:0:0: [sdi]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Aug 25 23:11:02 gargamel kernel: ata11.02: detaching (SCSI 10:2:0:0)
Aug 25 23:11:02 gargamel kernel: RAID conf printout:
Aug 25 23:11:02 gargamel kernel:  --- level:5 rd:5 wd:0
Aug 25 23:11:02 gargamel kernel:  disk 1, o:0, dev:sdl1
Aug 25 23:11:02 gargamel kernel:  disk 2, o:0, dev:sdk1
Aug 25 23:11:02 gargamel kernel: RAID conf printout:
Aug 25 23:11:02 gargamel kernel:  --- level:5 rd:5 wd:0
Aug 25 23:11:02 gargamel kernel:  disk 1, o:0, dev:sdl1
Aug 25 23:11:02 gargamel kernel:  disk 2, o:0, dev:sdk1
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj] Synchronizing SCSI cache
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj] Stopping disk
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj] START_STOP FAILED
Aug 25 23:11:02 gargamel kernel: sd 10:2:0:0: [sdj]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Aug 25 23:11:02 gargamel kernel: ata11.03: detaching (SCSI 10:3:0:0)
Aug 25 23:11:02 gargamel kernel: RAID conf printout:
Aug 25 23:11:02 gargamel kernel:  --- level:5 rd:5 wd:0
Aug 25 23:11:02 gargamel kernel:  disk 1, o:0, dev:sdl1
Aug 25 23:11:02 gargamel kernel: RAID conf printout:
Aug 25 23:11:02 gargamel kernel:  --- level:5 rd:5 wd:0
Aug 25 23:11:02 gargamel kernel:  disk 1, o:0, dev:sdl1
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk] Synchronizing SCSI cache
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk] Stopping disk
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk] START_STOP FAILED
Aug 25 23:11:02 gargamel kernel: sd 10:3:0:0: [sdk]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Aug 25 23:11:02 gargamel kernel: ata11.04: detaching (SCSI 10:4:0:0)
Aug 25 23:11:02 gargamel kernel: RAID conf printout:
Aug 25 23:11:02 gargamel kernel:  --- level:5 rd:5 wd:0
Aug 25 23:11:02 gargamel kernel: EXT4-fs (dm-3): previous I/O error to superblock detected
Aug 25 23:11:02 gargamel kernel: sd 10:4:0:0: [sdl] Synchronizing SCSI cache
Aug 25 23:11:02 gargamel kernel: EXT4-fs (dm-3): previous I/O error to superblock detected
Aug 25 23:11:02 gargamel kernel: sd 10:4:0:0: [sdl] Synchronizing SCSI cache
Aug 25 23:11:02 gargamel kernel: EXT4-fs error (device dm-3): __ext4_get_inode_loc:4729: inode #647171: block 2104864: comm nfsd: unable to read itable block
Aug 25 23:11:02 gargamel kernel: sd 10:4:0:0: [sdl]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Aug 25 23:11:02 gargamel kernel: sd 10:4:0:0: [sdl] Stopping disk
Aug 25 23:11:02 gargamel kernel: sd 10:4:0:0: [sdl] START_STOP FAILED
Aug 25 23:11:02 gargamel kernel: sd 10:4:0:0: [sdl]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK




After reboot, new raid rebuild with 3.0.1:
Aug 25 23:30:41 gargamel kernel: ata11.00: failed to read SCR 1 (Emask=0x40)
Aug 25 23:30:41 gargamel kernel: ata11.01: failed to read SCR 1 (Emask=0x40)
Aug 25 23:30:41 gargamel kernel: ata11.02: failed to read SCR 1 (Emask=0x40)
Aug 25 23:30:41 gargamel kernel: ata11.03: failed to read SCR 1 (Emask=0x40)
Aug 25 23:30:41 gargamel kernel: ata11.04: failed to read SCR 1 (Emask=0x40)
Aug 25 23:30:41 gargamel kernel: ata11.05: failed to read SCR 1 (Emask=0x40)
Aug 25 23:30:41 gargamel kernel: ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x400000 action 0x6 frozen
Aug 25 23:30:41 gargamel kernel: ata11.15: edma_err_cause=42200000 pp_flags=00000007
Aug 25 23:30:41 gargamel kernel: ata11.15: SError: { Handshk }
Aug 25 23:30:41 gargamel kernel: ata11.00: exception Emask 0x100 SAct 0xf6 SErr 0x0 action 0x6 frozen
Aug 25 23:30:41 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:30:41 gargamel kernel: ata11.00: cmd 61/b8:08:ff:61:80/01:00:00:00:00/40 tag 1 ncq 225280 out
Aug 25 23:30:41 gargamel kernel:          res 40/00:7c:d7:63:80/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:30:41 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:30:41 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:30:41 gargamel kernel: ata11.00: cmd 61/08:10:b7:63:80/00:00:00:00:00/40 tag 2 ncq 4096 out
Aug 25 23:30:41 gargamel kernel:          res 40/00:7c:d7:63:80/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:30:41 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:30:41 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:30:41 gargamel kernel: ata11.00: cmd 61/00:20:ff:5d:80/04:00:00:00:00/40 tag 4 ncq 524288 out
Aug 25 23:30:41 gargamel kernel:          res 40/00:7c:d7:63:80/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:30:41 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:30:41 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:30:41 gargamel kernel: ata11.00: cmd 61/08:28:bf:63:80/00:00:00:00:00/40 tag 5 ncq 4096 out
Aug 25 23:30:41 gargamel kernel:          res 40/00:7c:d7:63:80/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:30:41 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:30:41 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:30:41 gargamel kernel: ata11.00: cmd 61/08:30:c7:63:80/00:00:00:00:00/40 tag 6 ncq 4096 out
Aug 25 23:30:41 gargamel kernel:          res 40/00:7c:d7:63:80/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:30:41 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:30:41 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:30:41 gargamel kernel: ata11.00: cmd 61/08:38:cf:63:80/00:00:00:00:00/40 tag 7 ncq 4096 out
Aug 25 23:30:41 gargamel kernel:          res 40/00:7c:d7:63:80/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:30:41 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:30:41 gargamel kernel: ata11.01: exception Emask 0x100 SAct 0x20000 SErr 0x0 action 0x6 frozen
Aug 25 23:30:41 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:30:41 gargamel kernel: ata11.01: cmd 60/20:88:df:63:80/02:00:00:00:00/40 tag 17 ncq 278528 in
Aug 25 23:30:41 gargamel kernel:          res 40/00:7c:d7:63:80/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:30:41 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:30:41 gargamel kernel: hda-intel: IRQ timing workaround is activated for card #0. Suggest a bigger bdl_pos_adj.
Aug 25 23:30:41 gargamel kernel: ata11.02: exception Emask 0x100 SAct 0x1 SErr 0x0 action 0x6 frozen
Aug 25 23:30:41 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:30:41 gargamel kernel: ata11.02: cmd 60/20:00:df:63:80/02:00:00:00:00/40 tag 0 ncq 278528 in
Aug 25 23:30:41 gargamel kernel:          res 40/00:7c:d7:63:80/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:30:41 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:30:41 gargamel kernel: ata11.03: exception Emask 0x100 SAct 0x8000 SErr 0x0 action 0x6 frozen
Aug 25 23:30:41 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:30:41 gargamel kernel: ata11.03: cmd 60/28:78:d7:63:80/02:00:00:00:00/40 tag 15 ncq 282624 in
Aug 25 23:30:41 gargamel kernel:          res 40/00:7c:d7:63:80/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:30:41 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:30:41 gargamel kernel: ata11.04: exception Emask 0x100 SAct 0x8 SErr 0x0 action 0x6 frozen
Aug 25 23:30:41 gargamel kernel: ata11.04: failed command: READ FPDMA QUEUED
Aug 25 23:30:41 gargamel kernel: ata11.04: cmd 60/28:18:d7:63:80/02:00:00:00:00/40 tag 3 ncq 282624 in
Aug 25 23:30:41 gargamel kernel:          res 40/00:7c:d7:63:80/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:30:41 gargamel kernel: ata11.04: status: { DRDY }
Aug 25 23:30:41 gargamel kernel: ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 25 23:30:41 gargamel kernel: ata11.15: hard resetting link
Aug 25 23:30:41 gargamel kernel: ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug 25 23:30:41 gargamel kernel: ata11.00: hard resetting link
Aug 25 23:30:42 gargamel kernel: ata11.01: hard resetting link
Aug 25 23:30:42 gargamel kernel: ata11.02: hard resetting link
Aug 25 23:30:42 gargamel kernel: ata11.03: hard resetting link
Aug 25 23:30:43 gargamel kernel: ata11.04: hard resetting link
Aug 25 23:30:43 gargamel kernel: ata11.05: hard resetting link
Aug 25 23:30:43 gargamel kernel: ata11.00: configured for UDMA/133
Aug 25 23:30:43 gargamel kernel: ata11.01: configured for UDMA/133
Aug 25 23:30:43 gargamel kernel: ata11.02: configured for UDMA/133
Aug 25 23:30:44 gargamel kernel: ata11.03: configured for UDMA/133
Aug 25 23:30:44 gargamel kernel: ata11.04: configured for UDMA/133
Aug 25 23:30:44 gargamel kernel: ata11: EH complete
Aug 25 23:31:22 gargamel kernel: ata11.00: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:22 gargamel kernel: ata11.01: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:22 gargamel kernel: ata11.02: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:22 gargamel kernel: ata11.03: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:22 gargamel kernel: ata11.04: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:22 gargamel kernel: ata11.05: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:22 gargamel kernel: ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x400000 action 0x6 frozen
Aug 25 23:31:22 gargamel kernel: ata11.15: edma_err_cause=42200000 pp_flags=00000007
Aug 25 23:31:22 gargamel kernel: ata11.15: SError: { Handshk }
Aug 25 23:31:22 gargamel kernel: ata11.00: exception Emask 0x100 SAct 0x12d SErr 0x0 action 0x6 frozen
Aug 25 23:31:22 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:22 gargamel kernel: ata11.00: cmd 61/08:00:37:5a:b5/00:00:00:00:00/40 tag 0 ncq 4096 out
Aug 25 23:31:22 gargamel kernel:          res 40/00:44:3f:5a:b5/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:22 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:22 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:22 gargamel kernel: ata11.00: cmd 61/00:10:17:56:b5/04:00:00:00:00/40 tag 2 ncq 524288 out
Aug 25 23:31:22 gargamel kernel:          res 40/00:44:3f:5a:b5/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:22 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:22 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:22 gargamel kernel: ata11.00: cmd 61/18:18:17:5a:b5/00:00:00:00:00/40 tag 3 ncq 12288 out
Aug 25 23:31:22 gargamel kernel:          res 40/00:44:3f:5a:b5/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:22 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:22 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:22 gargamel kernel: ata11.00: cmd 61/08:28:2f:5a:b5/00:00:00:00:00/40 tag 5 ncq 4096 out
Aug 25 23:31:22 gargamel kernel:          res 40/00:44:3f:5a:b5/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:22 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:22 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:22 gargamel kernel: ata11.00: cmd 61/08:40:3f:5a:b5/00:00:00:00:00/40 tag 8 ncq 4096 out
Aug 25 23:31:22 gargamel kernel:          res 40/00:44:3f:5a:b5/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:22 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:22 gargamel kernel: ata11.01: exception Emask 0x100 SAct 0x40 SErr 0x0 action 0x6 frozen
Aug 25 23:31:22 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:31:22 gargamel kernel: ata11.01: cmd 60/c0:30:4f:5a:b5/03:00:00:00:00/40 tag 6 ncq 491520 in
Aug 25 23:31:22 gargamel kernel:          res 40/00:44:3f:5a:b5/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:22 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:31:22 gargamel kernel: ata11.02: exception Emask 0x100 SAct 0x80 SErr 0x0 action 0x6 frozen
Aug 25 23:31:22 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:31:22 gargamel kernel: ata11.02: cmd 60/c0:38:4f:5a:b5/03:00:00:00:00/40 tag 7 ncq 491520 in
Aug 25 23:31:22 gargamel kernel:          res 40/00:44:3f:5a:b5/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:22 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:31:22 gargamel kernel: ata11.03: exception Emask 0x100 SAct 0x200 SErr 0x0 action 0x6 frozen
Aug 25 23:31:22 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:31:22 gargamel kernel: ata11.03: cmd 60/c0:48:4f:5a:b5/03:00:00:00:00/40 tag 9 ncq 491520 in
Aug 25 23:31:22 gargamel kernel:          res 40/00:44:3f:5a:b5/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:22 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:31:22 gargamel kernel: ata11.04: exception Emask 0x100 SAct 0x2 SErr 0x0 action 0x6 frozen
Aug 25 23:31:22 gargamel kernel: ata11.04: failed command: READ FPDMA QUEUED
Aug 25 23:31:22 gargamel kernel: ata11.04: cmd 60/c8:08:47:5a:b5/03:00:00:00:00/40 tag 1 ncq 495616 in
Aug 25 23:31:22 gargamel kernel:          res 40/00:44:3f:5a:b5/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:22 gargamel kernel: ata11.04: status: { DRDY }
Aug 25 23:31:22 gargamel kernel: ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 25 23:31:22 gargamel kernel: ata11.15: hard resetting link
Aug 25 23:31:23 gargamel kernel: ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug 25 23:31:23 gargamel kernel: ata11.00: hard resetting link
Aug 25 23:31:23 gargamel kernel: ata11.01: hard resetting link
Aug 25 23:31:24 gargamel kernel: ata11.02: hard resetting link
Aug 25 23:31:24 gargamel kernel: ata11.03: hard resetting link
Aug 25 23:31:24 gargamel kernel: ata11.04: hard resetting link
Aug 25 23:31:25 gargamel kernel: ata11.05: hard resetting link
Aug 25 23:31:25 gargamel kernel: ata11.00: configured for UDMA/133
Aug 25 23:31:25 gargamel kernel: ata11.01: configured for UDMA/133
Aug 25 23:31:25 gargamel kernel: ata11.02: configured for UDMA/133
Aug 25 23:31:25 gargamel kernel: ata11.03: configured for UDMA/133
Aug 25 23:31:25 gargamel kernel: ata11.04: configured for UDMA/133
Aug 25 23:31:25 gargamel kernel: ata11: EH complete
Aug 25 23:31:41 gargamel kernel: ata11.00: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:41 gargamel kernel: ata11.01: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:41 gargamel kernel: ata11.02: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:41 gargamel kernel: ata11.03: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:41 gargamel kernel: ata11.04: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:41 gargamel kernel: ata11.05: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:41 gargamel kernel: ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x400000 action 0x6 frozen
Aug 25 23:31:41 gargamel kernel: ata11.15: edma_err_cause=42200000 pp_flags=00000007
Aug 25 23:31:41 gargamel kernel: ata11.15: SError: { Handshk }
Aug 25 23:31:41 gargamel kernel: ata11.00: exception Emask 0x100 SAct 0x161 SErr 0x0 action 0x6 frozen
Aug 25 23:31:41 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:41 gargamel kernel: ata11.00: cmd 61/e8:00:cf:98:cb/03:00:00:00:00/40 tag 0 ncq 512000 out
Aug 25 23:31:41 gargamel kernel:          res 40/00:1c:d7:9c:cb/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:41 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:41 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:41 gargamel kernel: ata11.00: cmd 61/08:28:b7:9c:cb/00:00:00:00:00/40 tag 5 ncq 4096 out
Aug 25 23:31:41 gargamel kernel:          res 40/00:1c:d7:9c:cb/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:41 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:41 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:41 gargamel kernel: ata11.00: cmd 61/08:30:bf:9c:cb/00:00:00:00:00/40 tag 6 ncq 4096 out
Aug 25 23:31:41 gargamel kernel:          res 40/00:1c:d7:9c:cb/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:41 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:41 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:41 gargamel kernel: ata11.00: cmd 61/08:40:c7:9c:cb/00:00:00:00:00/40 tag 8 ncq 4096 out
Aug 25 23:31:41 gargamel kernel:          res 40/00:1c:d7:9c:cb/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:41 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:41 gargamel kernel: ata11.01: exception Emask 0x100 SAct 0x8 SErr 0x0 action 0x6 frozen
Aug 25 23:31:41 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:31:41 gargamel kernel: ata11.01: cmd 60/f8:18:d7:9c:cb/03:00:00:00:00/40 tag 3 ncq 520192 in
Aug 25 23:31:41 gargamel kernel:          res 40/00:1c:d7:9c:cb/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:41 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:31:41 gargamel kernel: ata11.02: exception Emask 0x100 SAct 0x2 SErr 0x0 action 0x6 frozen
Aug 25 23:31:41 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:31:41 gargamel kernel: ata11.02: cmd 60/f8:08:d7:9c:cb/03:00:00:00:00/40 tag 1 ncq 520192 in
Aug 25 23:31:41 gargamel kernel:          res 40/00:1c:d7:9c:cb/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:41 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:31:41 gargamel kernel: ata11.03: exception Emask 0x100 SAct 0x4 SErr 0x0 action 0x6 frozen
Aug 25 23:31:41 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:31:41 gargamel kernel: ata11.03: cmd 60/f8:10:d7:9c:cb/03:00:00:00:00/40 tag 2 ncq 520192 in
Aug 25 23:31:41 gargamel kernel:          res 40/00:1c:d7:9c:cb/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:41 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:31:41 gargamel kernel: ata11.04: exception Emask 0x100 SAct 0x10 SErr 0x0 action 0x6 frozen
Aug 25 23:31:41 gargamel kernel: ata11.04: failed command: READ FPDMA QUEUED
Aug 25 23:31:41 gargamel kernel: ata11.04: cmd 60/00:20:cf:9c:cb/04:00:00:00:00/40 tag 4 ncq 524288 in
Aug 25 23:31:41 gargamel kernel:          res 40/00:1c:d7:9c:cb/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:41 gargamel kernel: ata11.04: status: { DRDY }
Aug 25 23:31:41 gargamel kernel: ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 25 23:31:41 gargamel kernel: ata11.15: hard resetting link
Aug 25 23:31:42 gargamel kernel: ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug 25 23:31:42 gargamel kernel: ata11.00: hard resetting link
Aug 25 23:31:42 gargamel kernel: ata11.01: hard resetting link
Aug 25 23:31:43 gargamel kernel: ata11.02: hard resetting link
Aug 25 23:31:43 gargamel kernel: ata11.03: hard resetting link
Aug 25 23:31:44 gargamel kernel: ata11.04: hard resetting link
Aug 25 23:31:44 gargamel kernel: ata11.05: hard resetting link
Aug 25 23:31:44 gargamel kernel: ata11.00: configured for UDMA/133
Aug 25 23:31:44 gargamel kernel: ata11.01: configured for UDMA/133
Aug 25 23:31:44 gargamel kernel: ata11.02: configured for UDMA/133
Aug 25 23:31:44 gargamel kernel: ata11.03: configured for UDMA/133
Aug 25 23:31:44 gargamel kernel: ata11.04: configured for UDMA/133
Aug 25 23:31:44 gargamel kernel: ata11: EH complete
Aug 25 23:31:58 gargamel kernel: ata11.00: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:58 gargamel kernel: ata11.01: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:58 gargamel kernel: ata11.02: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:58 gargamel kernel: ata11.03: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:58 gargamel kernel: ata11.04: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:58 gargamel kernel: ata11.05: failed to read SCR 1 (Emask=0x40)
Aug 25 23:31:58 gargamel kernel: ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x400000 action 0x6 frozen
Aug 25 23:31:58 gargamel kernel: ata11.15: edma_err_cause=42200080 pp_flags=00000007, EDMA self-disable
Aug 25 23:31:58 gargamel kernel: ata11.15: SError: { Handshk }
Aug 25 23:31:58 gargamel kernel: ata11.00: exception Emask 0x100 SAct 0x1d SErr 0x0 action 0x6 frozen
Aug 25 23:31:58 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:58 gargamel kernel: ata11.00: cmd 61/00:00:cf:bd:df/04:00:00:00:00/40 tag 0 ncq 524288 out
Aug 25 23:31:58 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:58 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:58 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:58 gargamel kernel: ata11.00: cmd 61/28:10:cf:c1:df/00:00:00:00:00/40 tag 2 ncq 20480 out
Aug 25 23:31:58 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:58 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:58 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:58 gargamel kernel: ata11.00: cmd 61/08:18:f7:c1:df/00:00:00:00:00/40 tag 3 ncq 4096 out
Aug 25 23:31:58 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:59 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:59 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:31:59 gargamel kernel: ata11.00: cmd 61/08:20:ff:c1:df/00:00:00:00:00/40 tag 4 ncq 4096 out
Aug 25 23:31:59 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:59 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:31:59 gargamel kernel: ata11.01: exception Emask 0x100 SAct 0x100 SErr 0x0 action 0x6 frozen
Aug 25 23:31:59 gargamel kernel: ata11.01: failed command: READ FPDMA QUEUED
Aug 25 23:31:59 gargamel kernel: ata11.01: cmd 60/c0:40:0f:c2:df/03:00:00:00:00/40 tag 8 ncq 491520 in
Aug 25 23:31:59 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:59 gargamel kernel: ata11.01: status: { DRDY }
Aug 25 23:31:59 gargamel kernel: ata11.02: exception Emask 0x100 SAct 0x2 SErr 0x0 action 0x6 frozen
Aug 25 23:31:59 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:31:59 gargamel kernel: ata11.02: cmd 60/c0:08:0f:c2:df/03:00:00:00:00/40 tag 1 ncq 491520 in
Aug 25 23:31:59 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:59 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:31:59 gargamel kernel: ata11.03: exception Emask 0x100 SAct 0x80 SErr 0x0 action 0x6 frozen
Aug 25 23:31:59 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:31:59 gargamel kernel: ata11.03: cmd 60/c0:38:0f:c2:df/03:00:00:00:00/40 tag 7 ncq 491520 in
Aug 25 23:31:59 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x100 (unknown error)
Aug 25 23:31:59 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:31:59 gargamel kernel: ata11.04: exception Emask 0x100 SAct 0x200 SErr 0x0 action 0x6 frozen
Aug 25 23:31:59 gargamel kernel: ata11.04: failed command: READ FPDMA QUEUED
Aug 25 23:31:59 gargamel kernel: ata11.04: cmd 60/c8:48:07:c2:df/03:00:00:00:00/40 ta0 gargamel kernel: ata11.03: hard resetting link
Aug 25 23:32:00 gargamel kernel: ata11.04: hard resetting link
Aug 25 23:32:01 gargamel kernel: ata11.05: hard resetting link
Aug 25 23:32:01 gargamel kernel: ata11.00: configured for UDMA/133
Aug 25 23:32:02 gargamel kernel: ata11.01: configured for UDMA/133
Aug 25 23:32:03 gargamel kernel: ata11.02: configured for UDMA/133
Aug 25 23:32:03 gargamel kernel: ata11.03: configured for UDMA/133
Aug 25 23:32:03 gargamel kernel: ata11.04: configured for UDMA/133
Aug 25 23:32:03 gargamel kernel: ata11: EH complete
Aug 25 23:32:31 gargamel kernel: ata11.00: failed to read SCR 1 (Emask=0x40)
Aug 25 23:32:31 gargamel kernel: ata11.01: failed to read SCR 1 (Emask=0x40)
Aug 25 23:32:31 gargamel kernel: ata11.02: failed to read SCR 1 (Emask=0x40)
Aug 25 23:32:31 gargamel kernel: ata11.03: failed to read SCR 1 (Emask=0x40)
Aug 25 23:32:31 gargamel kernel: ata11.04: failed to read SCR 1 (Emask=0x40)
Aug 25 23:32:31 gargamel kernel: ata11.05: failed to read SCR 1 (Emask=0x40)
Aug 25 23:32:31 gargamel kernel: ata11.15: exception Emask 0x4 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 25 23:32:31 gargamel kernel: ata11.00: exception Emask 0x100 SAct 0x10 SErr 0x0 action 0x6 frozen
Aug 25 23:32:31 gargamel kernel: ata11.00: failed command: WRITE FPDMA QUEUED
Aug 25 23:32:31 gargamel kernel: ata11.00: cmd 61/08:20:07:c2:df/00:00:00:00:00/40 tag 4 ncq 4096 out
Aug 25 23:32:31 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x4 (timeout)
Aug 25 23:32:31 gargamel kernel: ata11.00: status: { DRDY }
Aug 25 23:32:31 gargamel kernel: ata11.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 25 23:32:31 gargamel kernel: ata11.02: exception Emask 0x100 SAct 0xc SErr 0x0 action 0x6 frozen
Aug 25 23:32:31 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:32:31 gargamel kernel: ata11.02: cmd 60/00:10:cf:c5:df/04:00:00:00:00/40 tag 2 ncq 524288 in
Aug 25 23:32:31 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x4 (timeout)
Aug 25 23:32:31 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:32:31 gargamel kernel: ata11.02: failed command: READ FPDMA QUEUED
Aug 25 23:32:31 gargamel kernel: ata11.02: cmd 60/38:18:cf:c9:df/00:00:00:00:00/40 tag 3 ncq 28672 in
Aug 25 23:32:31 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x4 (timeout)
Aug 25 23:32:31 gargamel kernel: ata11.02: status: { DRDY }
Aug 25 23:32:31 gargamel kernel: ata11.03: exception Emask 0x100 SAct 0x40 SErr 0x0 action 0x6 frozen
Aug 25 23:32:31 gargamel kernel: ata11.03: failed command: READ FPDMA QUEUED
Aug 25 23:32:31 gargamel kernel: ata11.03: cmd 60/c0:30:0f:c2:df/03:00:00:00:00/40 tag 6 ncq 491520 in
Aug 25 23:32:31 gargamel kernel:          res 40/00:1c:d7:9c:cb/00:00:00:00:00/40 Emask 0x4 (timeout)
Aug 25 23:32:31 gargamel kernel: ata11.03: status: { DRDY }
Aug 25 23:32:31 gargamel kernel: ata11.04: exception Emask 0x100 SAct 0x3 SErr 0x0 action 0x6 frozen
Aug 25 23:32:31 gargamel kernel: ata11.04: failed command: READ FPDMA QUEUED
Aug 25 23:32:31 gargamel kernel: ata11.04: cmd 60/00:00:cf:c5:df/04:00:00:00:00/40 tag 0 ncq 524288 in
Aug 25 23:32:31 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x4 (timeout)
Aug 25 23:32:31 gargamel kernel: ata11.04: status: { DRDY }
Aug 25 23:32:31 gargamel kernel: ata11.04: failed command: READ FPDMA QUEUED
Aug 25 23:32:31 gargamel kernel: ata11.04: cmd 60/38:08:cf:c9:df/00:00:00:00:00/40 tag 1 ncq 28672 in
Aug 25 23:32:31 gargamel kernel:          res 40/00:14:cf:c1:df/00:00:00:00:00/40 Emask 0x4 (timeout)
Aug 25 23:32:31 gargamel kernel: ata11.04: status: { DRDY }
Aug 25 23:32:31 gargamel kernel: ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 25 23:32:31 gargamel kernel: ata11.15: hard resetting link
Aug 25 23:32:32 gargamel kernel: ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug 25 23:32:32 gargamel kernel: ata11.05: limiting SATA link speed to 1.5 Gbps
Aug 25 23:32:32 gargamel kernel: ata11.00: hard resetting link
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
