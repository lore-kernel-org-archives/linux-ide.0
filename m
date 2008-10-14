From: "Eugene San" <eugenesan@gmail.com>
Subject: sata_mv link recognition problems?
Date: Tue, 14 Oct 2008 10:15:49 +0200
Message-ID: <e9390a2c0810140115h29125635s28bda6c793f9f9fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:39875 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbYJNIPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 04:15:52 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2049585fkq.5
        for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 01:15:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: saeed@marvell.com, buytenh@marvell.com

Hi all,

Recently, I was testing one of 2.6.27-rc on arm device with sata_mv
(integrated to soc) and there seems to be a problem.
Controller seems to be working (perfectly) only with devices that does
support SATA3.0 and NCQ31, rest of drives does not work at all or
almost does not work.

Note: sata_mv history in my tree is identical to the one is in linus's
tree (http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/ata/sata_mv.c;h=2b24ae58b52ee557e9d028e06e83de405a121a40;hb=7591103c08abade60aeddb432ed0686ddd0de1c6)
at the moment.

============================================
This is output on  boot with drive that system manages to see:
-------------------------------------------------------------------------------
 Driver 'sd' needs updating - please use bus_type methods sata_mv
sata_mv.0: version 1.24 sata_mv sata_mv.0: slots 32 ports 2 scsi0 :
sata_mv
scsi1 : sata_mv
ata1: SATA max UDMA/133 irq 21
ata2: SATA max UDMA/133 irq 21
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: HPA detected: current 156299375, native 156301488
ata1.00: ATA-7: HTS721080G9SA00, MC4OC10H, max UDMA/100
ata1.00: 156299375 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/100
ata1: exception Emask 0x10 SAct 0x0 SErr 0x10000000 action 0x1 t4
ata1: edma_err_cause=00000020 pp_flags=00000000, SError=10180000
ata1: SError: { }
ata1.00: configured for UDMA/100
ata1: EH complete
ata2: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      HTS721080G9SA00  MC4O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156299375 512-byte hardware sectors (80025 MB) sd
0:0:0:0: [sda] Write Protect is off sd 0:0:0:0: [sda] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA sd 0:0:0:0:
[sda] 156299375 512-byte hardware sectors (80025 MB) sd 0:0:0:0: [sda]
Write Protect is off sd 0:0:0:0: [sda] Write cache: enabled, read
cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
-------------------------------------------------------------------------------

===============================
This is kernel output when drive is accessed:
--------------------------------------------------------
sata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
sd 0:0:0:0: [sda] 156299375 512-byte hardware sectors (80025 MB) sd
0:0:0:0: [sda] Write Protect is off sd 0:0:0:0: [sda] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
ata1.00: limiting speed to UDMA/66:PIO4
ata1.00: exception Emask 0x10 SAct 0x7f067 SErr 0x10100000 action 0x6 frozen
ata1.00: edma_err_cause=00000020 pp_flags=00000003, SError=10100000
ata1: SError: { Dispar }
ata1.00: cmd 61/08:00:41:78:80/00:00:06:00:00/40 tag 0 ncq 4096 out
         res 50/00:08:a1:42:89/00:00:06:00:00/40 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: cmd 61/08:08:41:78:88/00:00:06:00:00/40 tag 1 ncq 4096 out
         res 50/00:08:a1:42:89/00:00:06:00:00/40 Emask 0x10 (ATA bus
error) ------------[ cut here ]------------
WARNING: at drivers/ata/libata-sff.c:1101
ata_sff_hsm_move+0x44/0x6dc() Modules linked in:
[<c00274e8>] (dump_stack+0x0/0x14) from [<c003225c>]
(warn_on_slowpath+0x4c/0x68) [<c0032210>] (warn_on_slowpath+0x0/0x68)
from [<c0218cfc>] (ata_sff_hsm_move+0x44/0x6dc)  r6:df8db260
r5:00000009 r4:df8da000 [<c0218cb8>] (ata_sff_hsm_move+0x0/0x6dc) from
[<c021a508>] (ata_pio_task+0xe4/0x100) [<c021a424>]
(ata_pio_task+0x0/0x100) from [<c00440c0>] (run_workqueue+0xdc/0x1b0)
r7:df8dbd2c r6:df84b220 r5:df8d0000 r4:df8dbd30 [<c0043fe4>]
(run_workqueue+0x0/0x1b0) from [<c0044de0>] (worker_thread+0xac/0xc0)
r9:00000000 r8:00000000 r7:df84b220 r6:df8a8ce0 r5:df8d1fb8
r4:df84b228
[<c0044d34>] (worker_thread+0x0/0xc0) from [<c00480d4>]
(kthread+0x54/0x80)  r7:00000000 r6:00000000 r5:c0044d34 r4:df84b220
[<c0048080>] (kthread+0x0/0x80) from [<c00354ac>] (do_exit+0x0/0x7ec)
r5:00000000 r4:00000000 ---[ end trace 3651d9b389f69494 ]---
ata1.00: failed to read native max address (err_mask=0x100)
ata1.00: HPA support seems broken, skipping HPA handling
ata1.00: revalidation failed (errno=-5)
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/33
ata1: exception Emask 0x10 SAct 0x0 SErr 0x10000000 action 0x1 t4
ata1: edma_err_cause=00000020 pp_flags=00000002, SError=10180000
ata1: SError: { }
ata1.00: configured for UDMA/33
ata1: EH complete

ata1.00: exception Emask 0x10 SAct 0x1 SErr 0x10380000 action 0x6 frozen
ata1.00: edma_err_cause=00000020 pp_flags=00000003, SError=10180000
ata1: SError: { 10B8B Dispar BadCRC }
ata1.00: cmd 60/00:00:a1:bd:49/01:00:06:00:00/40 tag 0 ncq 131072 in
         res 50/00:00:a1:bd:49/00:01:06:00:00/40 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/33
ata1: EH complete
sd 0:0:0:0: [sda] 156299375 512-byte hardware sectors (80025 MB) sd
0:0:0:0: [sda] Write Protect is off sd 0:0:0:0: [sda] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
ata1.00: exception Emask 0x10 SAct 0x1 SErr 0x10100000 action 0x6 frozen
ata1.00: edma_err_cause=00000020 pp_flags=00000003, SError=10100000
ata1: SError: { Dispar }
ata1.00: cmd 60/00:00:a1:cb:49/01:00:06:00:00/40 tag 0 ncq 131072 in
         res 50/00:00:a1:cb:49/00:01:06:00:00/40 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/33
ata1: EH complete
sd 0:0:0:0: [sda] 156299375 512-byte hardware sectors (80025 MB) sd
0:0:0:0: [sda] Write Protect is off sd 0:0:0:0: [sda] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
ata1.00: exception Emask 0x10 SAct 0x1 SErr 0x10380000 action 0x6 frozen
ata1.00: edma_err_cause=00000020 pp_flags=00000003, SError=10180000
ata1: SError: { 10B8B Dispar BadCRC }
ata1.00: cmd 60/f8:00:a9:d3:49/00:00:06:00:00/40 tag 0 ncq 126976 in
         res 50/00:f8:a9:d3:49/00:00:06:00:00/40 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/33
ata1: EH complete
sd 0:0:0:0: [sda] 156299375 512-byte hardware sectors (80025 MB) sd
0:0:0:0: [sda] Write Protect is off sd 0:0:0:0: [sda] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
ata1.00: exception Emask 0x10 SAct 0x2 SErr 0x10380000 action 0x6 frozen
ata1.00: edma_err_cause=00000020 pp_flags=00000003, SError=10180000
ata1: SError: { 10B8B Dispar BadCRC }
ata1.00: cmd 60/00:08:81:47:4a/01:00:06:00:00/40 tag 1 ncq 131072 in
         res 50/00:00:81:47:4a/00:01:06:00:00/40 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/33
ata1: EH complete
sd 0:0:0:0: [sda] 156299375 512-byte hardware sectors (80025 MB) sd
0:0:0:0: [sda] Write Protect is off sd 0:0:0:0: [sda] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
--------------------------------------------------------

==========================================
This is output with drive that refuses to be even recognized:
----------------------------------------------------------------------------
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: link online but device misclassified, retrying
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: link online but device misclassified, retrying
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: link online but device misclassified, retrying
ata1: limiting SATA link speed to 1.5 Gbps
ata1: SATA link down (SStatus 111 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: link online but device misclassified, retrying
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: link online but device misclassified, retrying
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: link online but device misclassified, retrying
ata1: SRST failed (errno=-16)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: link online but device misclassified, device detection might fail
ata1: exception Emask 0x10 SAct 0x0 SErr 0x10180000 action 0x6 frozen t4
ata1: edma_err_cause=00000020 pp_flags=00000000, SError=10180000
ata1: SError: { 10B8B Dispar }
ata1: hard resetting link
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: link online but device misclassified, retrying
ata1: hard resetting link
ata1: SATA link down (SStatus 111 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1: hard resetting link
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: link online but device misclassified, retrying
ata1: hard resetting link
ata1: SATA link down (SStatus 111 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1: hard resetting link
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: link online but device misclassified, retrying
ata1: hard resetting link
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: link online but device misclassified, retrying
ata1: hard resetting link
ata1: link is slow to respond, please be patient (ready=0)
----------------------------------------------------------------------------

Thanks ahead.
Eugene San
