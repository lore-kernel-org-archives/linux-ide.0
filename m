From: Suman Tripathi <stripathi@apm.com>
Subject: Re: failed command: WRITE FPDMA QUEUED, suspiciously on two different disks
Date: Wed, 24 Jun 2015 11:58:14 +0530
Message-ID: <CAOHikRC0AnDfd=y=hbVLizAoBi8KebmamnawGAuBATU_Z6MJQA@mail.gmail.com>
References: <20150623190018.5wer6qdh467f5mud@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38766 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbFXG2R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2015 02:28:17 -0400
Received: by wibdq8 with SMTP id dq8so36311270wib.1
        for <linux-ide@vger.kernel.org>; Tue, 23 Jun 2015 23:28:14 -0700 (PDT)
In-Reply-To: <20150623190018.5wer6qdh467f5mud@m.safari.iki.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sami Farin <hvtaifwkbgefbaei@gmail.com>, Linux ide Mailing List <linux-ide@vger.kernel.org>

On Wed, Jun 24, 2015 at 12:30 AM, Sami Farin <hvtaifwkbgefbaei@gmail.com> wrote:
> I have
>
> ata10.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133
> ata10.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
> ata3.00: ATA-8: WDC WD6401AALS-00E8B0, 05.00K05, max UDMA/133
> ata3.00: 1250263728 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
> ata4.00: ATA-8: WDC WD6401AALS-00E8B0, 05.00K05, max UDMA/133
> ata4.00: 1250263728 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
> ata5.00: ATA-7: ST3320620AS, 3.AAE, max UDMA/133
> ata5.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
>
> all are LUKS-encrypted, no LVM, XFS, ata10 is root fs.
> Asus P8Z68-V PRO GEN3 mobo.  Fedora 22 and device-mapper 1.02.93-3.fc22
> was installed ten days ago..
> Ten days ago I booted 4.0.5 kernel and when mounting it I started getting
> the following errors [1], device ata4.
>
> xfs_repair cleared log and reported no other errors, and I was able to mount
> it.  Today I booted to 4.0.6 because I installed one PCI card, and
> I got identical errors happening on device ata3 now! [2] (LUKS name was
> also different so the ata devices did not just switch places.)
> lspci in [3]
>
> Troublesome sector around 625228244 in both devices.
>
> SMART does not show problems and disks are working OK, but I have not
> ran tests recently..
>
> [1]
> [  244.984949] XFS (dm-1): Mounting V4 Filesystem
> [  245.141528] XFS (dm-1): Ending clean mount
> [  245.752941] XFS (dm-2): Mounting V4 Filesystem
> [  245.881053] ata4.00: exception Emask 0x60 SAct 0xe SErr 0x800 action 0x6 frozen
> [  245.881056] ata4.00: irq_stat 0x20000000, host bus error
> [  245.881058] ata4: SError: { HostInt }
> [  245.881060] ata4.00: failed command: WRITE FPDMA QUEUED
> [  245.881063] ata4.00: cmd 61/40:08:d4:39:44/05:00:25:00:00/40 tag 1 ncq 688128 out
>                         res 40/00:1c:3c:45:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  245.881065] ata4.00: status: { DRDY }
> [  245.881066] ata4.00: failed command: WRITE FPDMA QUEUED
> [  245.881068] ata4.00: cmd 61/28:10:14:3f:44/06:00:25:00:00/40 tag 2 ncq 806912 out
>                         res 40/00:1c:3c:45:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  245.881070] ata4.00: status: { DRDY }
> [  245.881071] ata4.00: failed command: WRITE FPDMA QUEUED
> [  245.881073] ata4.00: cmd 61/98:18:3c:45:44/04:00:25:00:00/40 tag 3 ncq 602112 out
>                         res 40/00:1c:3c:45:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  245.881075] ata4.00: status: { DRDY }
> [  245.881077] ata4: hard resetting link
> [  246.186861] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  246.187479] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  246.187484] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  246.188309] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  246.188313] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  246.188491] ata4.00: configured for UDMA/133
> [  246.188505] ata4: EH complete
> [  246.202856] ata4.00: exception Emask 0x60 SAct 0xe0 SErr 0x800 action 0x6 frozen
> [  246.202858] ata4.00: irq_stat 0x20000000, host bus error
> [  246.202860] ata4: SError: { HostInt }
> [  246.202862] ata4.00: failed command: WRITE FPDMA QUEUED
> [  246.202865] ata4.00: cmd 61/98:28:3c:45:44/04:00:25:00:00/40 tag 5 ncq 602112 out
>                         res 40/00:3c:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  246.202866] ata4.00: status: { DRDY }
> [  246.202868] ata4.00: failed command: WRITE FPDMA QUEUED
> [  246.202870] ata4.00: cmd 61/28:30:14:3f:44/06:00:25:00:00/40 tag 6 ncq 806912 out
>                         res 40/00:3c:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  246.202872] ata4.00: status: { DRDY }
> [  246.202873] ata4.00: failed command: WRITE FPDMA QUEUED
> [  246.202875] ata4.00: cmd 61/40:38:d4:39:44/05:00:25:00:00/40 tag 7 ncq 688128 out
>                         res 40/00:3c:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  246.202876] ata4.00: status: { DRDY }
> [  246.202879] ata4: hard resetting link
> [  246.507670] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  246.508290] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  246.508295] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  246.510057] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  246.510061] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  246.510240] ata4.00: configured for UDMA/133
> [  246.510253] ata4: EH complete
> [  246.525663] ata4.00: exception Emask 0x60 SAct 0x1c0000 SErr 0x800 action 0x6 frozen
> [  246.525665] ata4.00: irq_stat 0x20000000, host bus error
> [  246.525666] ata4: SError: { HostInt }
> [  246.525668] ata4.00: failed command: WRITE FPDMA QUEUED
> [  246.525671] ata4.00: cmd 61/40:90:d4:39:44/05:00:25:00:00/40 tag 18 ncq 688128 out
>                         res 40/00:a4:3c:45:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  246.525673] ata4.00: status: { DRDY }
> [  246.525674] ata4.00: failed command: WRITE FPDMA QUEUED
> [  246.525677] ata4.00: cmd 61/28:98:14:3f:44/06:00:25:00:00/40 tag 19 ncq 806912 out
>                         res 40/00:a4:3c:45:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  246.525678] ata4.00: status: { DRDY }
> [  246.525679] ata4.00: failed command: WRITE FPDMA QUEUED
> [  246.525682] ata4.00: cmd 61/98:a0:3c:45:44/04:00:25:00:00/40 tag 20 ncq 602112 out
>                         res 40/00:a4:3c:45:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  246.525683] ata4.00: status: { DRDY }
> [  246.525685] ata4: hard resetting link
> [  246.830481] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  246.831090] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  246.831095] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  246.831913] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  246.831917] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  246.832092] ata4.00: configured for UDMA/133
> [  246.832105] ata4: EH complete
> [  246.846469] ata4.00: exception Emask 0x60 SAct 0x7 SErr 0x800 action 0x6 frozen
> [  246.846471] ata4.00: irq_stat 0x20000000, host bus error
> [  246.846473] ata4: SError: { HostInt }
> [  246.846474] ata4.00: failed command: WRITE FPDMA QUEUED
> [  246.846477] ata4.00: cmd 61/98:00:3c:45:44/04:00:25:00:00/40 tag 0 ncq 602112 out
>                         res 40/00:14:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  246.846479] ata4.00: status: { DRDY }
> [  246.846480] ata4.00: failed command: WRITE FPDMA QUEUED
> [  246.846482] ata4.00: cmd 61/28:08:14:3f:44/06:00:25:00:00/40 tag 1 ncq 806912 out
>                         res 40/00:14:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  246.846484] ata4.00: status: { DRDY }
> [  246.846485] ata4.00: failed command: WRITE FPDMA QUEUED
> [  246.846487] ata4.00: cmd 61/40:10:d4:39:44/05:00:25:00:00/40 tag 2 ncq 688128 out
>                         res 40/00:14:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  246.846489] ata4.00: status: { DRDY }
> [  246.846491] ata4: hard resetting link
> [  247.151287] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  247.151902] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  247.151907] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  247.152734] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  247.152738] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  247.152910] ata4.00: configured for UDMA/133
> [  247.152924] ata4: EH complete
> [  247.168278] ata4.00: exception Emask 0x60 SAct 0xe000 SErr 0x800 action 0x6 frozen
> [  247.168280] ata4.00: irq_stat 0x20000000, host bus error
> [  247.168281] ata4: SError: { HostInt }
> [  247.168283] ata4.00: failed command: WRITE FPDMA QUEUED
> [  247.168286] ata4.00: cmd 61/40:68:d4:39:44/05:00:25:00:00/40 tag 13 ncq 688128 out
>                         res 40/00:7c:3c:45:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  247.168288] ata4.00: status: { DRDY }
> [  247.168289] ata4.00: failed command: WRITE FPDMA QUEUED
> [  247.168291] ata4.00: cmd 61/28:70:14:3f:44/06:00:25:00:00/40 tag 14 ncq 806912 out
>                         res 40/00:7c:3c:45:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  247.168293] ata4.00: status: { DRDY }
> [  247.168294] ata4.00: failed command: WRITE FPDMA QUEUED
> [  247.168296] ata4.00: cmd 61/98:78:3c:45:44/04:00:25:00:00/40 tag 15 ncq 602112 out
>                         res 40/00:7c:3c:45:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  247.168298] ata4.00: status: { DRDY }
> [  247.168300] ata4: hard resetting link
> [  247.473092] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  247.473708] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  247.473714] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  247.474558] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  247.474562] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  247.475635] ata4.00: configured for UDMA/133
> [  247.475648] ata4: EH complete
> [  247.490086] ata4.00: exception Emask 0x60 SAct 0x1c000000 SErr 0x800 action 0x6 frozen
> [  247.490089] ata4.00: irq_stat 0x20000000, host bus error
> [  247.490090] ata4: SError: { HostInt }
> [  247.490092] ata4.00: failed command: WRITE FPDMA QUEUED
> [  247.490095] ata4.00: cmd 61/98:d0:3c:45:44/04:00:25:00:00/40 tag 26 ncq 602112 out
>                         res 40/00:e4:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  247.490097] ata4.00: status: { DRDY }
> [  247.490098] ata4.00: failed command: WRITE FPDMA QUEUED
> [  247.490100] ata4.00: cmd 61/28:d8:14:3f:44/06:00:25:00:00/40 tag 27 ncq 806912 out
>                         res 40/00:e4:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  247.490102] ata4.00: status: { DRDY }
> [  247.490103] ata4.00: failed command: WRITE FPDMA QUEUED
> [  247.490105] ata4.00: cmd 61/40:e0:d4:39:44/05:00:25:00:00/40 tag 28 ncq 688128 out
>                         res 40/00:e4:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  247.490107] ata4.00: status: { DRDY }
> [  247.490109] ata4: hard resetting link
> [  247.794902] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  247.795517] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  247.795522] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  247.796359] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  247.796364] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  247.796552] ata4.00: configured for UDMA/133
> [  247.796636] sd 3:0:0:0: [sdb] tag#26 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  247.796638] sd 3:0:0:0: [sdb] tag#26 Sense Key : Aborted Command [current] [descriptor]
> [  247.796640] sd 3:0:0:0: [sdb] tag#26 Add. Sense: No additional sense information
> [  247.796643] sd 3:0:0:0: [sdb] tag#26 CDB: Write(10) 2a 00 25 44 45 3c 00 04 98 00
> [  247.796660] blk_update_request: I/O error, dev sdb, sector 625231164
> [  247.796715] sd 3:0:0:0: [sdb] tag#27 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  247.796717] sd 3:0:0:0: [sdb] tag#27 Sense Key : Aborted Command [current] [descriptor]
> [  247.796719] sd 3:0:0:0: [sdb] tag#27 Add. Sense: No additional sense information
> [  247.796720] sd 3:0:0:0: [sdb] tag#27 CDB: Write(10) 2a 00 25 44 3f 14 00 06 28 00
> [  247.796722] blk_update_request: I/O error, dev sdb, sector 625229588
> [  247.796756] sd 3:0:0:0: [sdb] tag#28 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  247.796758] sd 3:0:0:0: [sdb] tag#28 Sense Key : Aborted Command [current] [descriptor]
> [  247.796759] sd 3:0:0:0: [sdb] tag#28 Add. Sense: No additional sense information
> [  247.796760] sd 3:0:0:0: [sdb] tag#28 CDB: Write(10) 2a 00 25 44 39 d4 00 05 40 00
> [  247.796762] blk_update_request: I/O error, dev sdb, sector 625228244
> [  247.796798] ata4: EH complete
> [  247.796821] XFS (dm-2): xfs_do_force_shutdown(0x1) called from line 1092 of file fs/xfs/xfs_buf.c.  Return address = 0xffffffff81366db7
> [  247.796824] XFS (dm-2): I/O Error Detected. Shutting down filesystem
> [  247.796825] XFS (dm-2): Please umount the filesystem and rectify the problem(s)
> [  247.796827] XFS (dm-2): metadata I/O error: block 0x254421d4 ("xlog_bwrite") error 5 numblks 8192
> [  247.796964] XFS (dm-2): failed to locate log tail
> [  247.796966] XFS (dm-2): log mount/recovery failed: error -5
> [  247.797015] XFS (dm-2): log mount failed
> [  253.378978] XFS (dm-2): Mounting V4 Filesystem
> [  253.499494] ata4.00: exception Emask 0x60 SAct 0x700000 SErr 0x800 action 0x6 frozen
> [  253.499497] ata4.00: irq_stat 0x20000000, host bus error
> [  253.499498] ata4: SError: { HostInt }
> [  253.499500] ata4.00: failed command: WRITE FPDMA QUEUED
> [  253.499504] ata4.00: cmd 61/68:a0:d4:39:44/05:00:25:00:00/40 tag 20 ncq 708608 out
>                         res 40/00:b4:3c:47:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  253.499505] ata4.00: status: { DRDY }
> [  253.499506] ata4.00: failed command: WRITE FPDMA QUEUED
> [  253.499509] ata4.00: cmd 61/00:a8:3c:3f:44/08:00:25:00:00/40 tag 21 ncq 1048576 out
>                         res 40/00:b4:3c:47:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  253.499510] ata4.00: status: { DRDY }
> [  253.499512] ata4.00: failed command: WRITE FPDMA QUEUED
> [  253.499514] ata4.00: cmd 61/98:b0:3c:47:44/02:00:25:00:00/40 tag 22 ncq 339968 out
>                         res 40/00:b4:3c:47:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  253.499515] ata4.00: status: { DRDY }
> [  253.499518] ata4: hard resetting link
> [  253.804305] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  253.804908] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  253.804913] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  253.805742] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  253.805747] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  253.805902] ata4.00: configured for UDMA/133
> [  253.805916] ata4: EH complete
> [  253.819300] ata4.00: exception Emask 0x60 SAct 0x7000000 SErr 0x800 action 0x6 frozen
> [  253.819302] ata4.00: irq_stat 0x20000000, host bus error
> [  253.819304] ata4: SError: { HostInt }
> [  253.819306] ata4.00: failed command: WRITE FPDMA QUEUED
> [  253.819309] ata4.00: cmd 61/98:c0:3c:47:44/02:00:25:00:00/40 tag 24 ncq 339968 out
>                         res 40/00:d4:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  253.819311] ata4.00: status: { DRDY }
> [  253.819312] ata4.00: failed command: WRITE FPDMA QUEUED
> [  253.819314] ata4.00: cmd 61/00:c8:3c:3f:44/08:00:25:00:00/40 tag 25 ncq 1048576 out
>                         res 40/00:d4:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  253.819316] ata4.00: status: { DRDY }
> [  253.819317] ata4.00: failed command: WRITE FPDMA QUEUED
> [  253.819319] ata4.00: cmd 61/68:d0:d4:39:44/05:00:25:00:00/40 tag 26 ncq 708608 out
>                         res 40/00:d4:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  253.819321] ata4.00: status: { DRDY }
> [  253.819323] ata4: hard resetting link
> [  254.124112] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  254.124732] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  254.124737] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  254.125587] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  254.125591] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  254.125764] ata4.00: configured for UDMA/133
> [  254.125778] ata4: EH complete
> [  254.141103] ata4.00: exception Emask 0x60 SAct 0x1c0 SErr 0x800 action 0x6 frozen
> [  254.141105] ata4.00: irq_stat 0x20000000, host bus error
> [  254.141107] ata4: SError: { HostInt }
> [  254.141108] ata4.00: failed command: WRITE FPDMA QUEUED
> [  254.141112] ata4.00: cmd 61/68:30:d4:39:44/05:00:25:00:00/40 tag 6 ncq 708608 out
>                         res 40/00:44:3c:47:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  254.141113] ata4.00: status: { DRDY }
> [  254.141114] ata4.00: failed command: WRITE FPDMA QUEUED
> [  254.141117] ata4.00: cmd 61/00:38:3c:3f:44/08:00:25:00:00/40 tag 7 ncq 1048576 out
>                         res 40/00:44:3c:47:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  254.141118] ata4.00: status: { DRDY }
> [  254.141119] ata4.00: failed command: WRITE FPDMA QUEUED
> [  254.141122] ata4.00: cmd 61/98:40:3c:47:44/02:00:25:00:00/40 tag 8 ncq 339968 out
>                         res 40/00:44:3c:47:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  254.141123] ata4.00: status: { DRDY }
> [  254.141126] ata4: hard resetting link
> [  254.445818] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  254.446443] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  254.446449] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  254.447268] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  254.447273] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  254.447443] ata4.00: configured for UDMA/133
> [  254.447457] ata4: EH complete
> [  254.460807] ata4.00: exception Emask 0x60 SAct 0x380000 SErr 0x800 action 0x6 frozen
> [  254.460809] ata4.00: irq_stat 0x20000000, host bus error
> [  254.460810] ata4: SError: { HostInt }
> [  254.460812] ata4.00: failed command: WRITE FPDMA QUEUED
> [  254.460816] ata4.00: cmd 61/98:98:3c:47:44/02:00:25:00:00/40 tag 19 ncq 339968 out
>                         res 40/00:ac:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  254.460817] ata4.00: status: { DRDY }
> [  254.460818] ata4.00: failed command: WRITE FPDMA QUEUED
> [  254.460821] ata4.00: cmd 61/00:a0:3c:3f:44/08:00:25:00:00/40 tag 20 ncq 1048576 out
>                         res 40/00:ac:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  254.460822] ata4.00: status: { DRDY }
> [  254.460823] ata4.00: failed command: WRITE FPDMA QUEUED
> [  254.460826] ata4.00: cmd 61/68:a8:d4:39:44/05:00:25:00:00/40 tag 21 ncq 708608 out
>                         res 40/00:ac:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  254.460827] ata4.00: status: { DRDY }
> [  254.460830] ata4: hard resetting link
> [  254.765518] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  254.766173] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  254.766178] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  254.767782] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  254.767786] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  254.767990] ata4.00: configured for UDMA/133
> [  254.768003] ata4: EH complete
> [  254.782519] ata4.00: exception Emask 0x60 SAct 0xe SErr 0x800 action 0x6 frozen
> [  254.782521] ata4.00: irq_stat 0x20000000, host bus error
> [  254.782523] ata4: SError: { HostInt }
> [  254.782525] ata4.00: failed command: WRITE FPDMA QUEUED
> [  254.782528] ata4.00: cmd 61/68:08:d4:39:44/05:00:25:00:00/40 tag 1 ncq 708608 out
>                         res 40/00:1c:3c:47:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  254.782529] ata4.00: status: { DRDY }
> [  254.782531] ata4.00: failed command: WRITE FPDMA QUEUED
> [  254.782533] ata4.00: cmd 61/00:10:3c:3f:44/08:00:25:00:00/40 tag 2 ncq 1048576 out
>                         res 40/00:1c:3c:47:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  254.782534] ata4.00: status: { DRDY }
> [  254.782536] ata4.00: failed command: WRITE FPDMA QUEUED
> [  254.782538] ata4.00: cmd 61/98:18:3c:47:44/02:00:25:00:00/40 tag 3 ncq 339968 out
>                         res 40/00:1c:3c:47:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  254.782539] ata4.00: status: { DRDY }
> [  254.782542] ata4: hard resetting link
> [  255.087220] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  255.087824] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  255.087829] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  255.088655] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  255.088659] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  255.088830] ata4.00: configured for UDMA/133
> [  255.088843] ata4: EH complete
> [  255.102206] ata4.00: exception Emask 0x60 SAct 0x1c000 SErr 0x800 action 0x6 frozen
> [  255.102209] ata4.00: irq_stat 0x20000000, host bus error
> [  255.102210] ata4: SError: { HostInt }
> [  255.102212] ata4.00: failed command: WRITE FPDMA QUEUED
> [  255.102215] ata4.00: cmd 61/98:70:3c:47:44/02:00:25:00:00/40 tag 14 ncq 339968 out
>                         res 40/00:84:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  255.102217] ata4.00: status: { DRDY }
> [  255.102218] ata4.00: failed command: WRITE FPDMA QUEUED
> [  255.102221] ata4.00: cmd 61/00:78:3c:3f:44/08:00:25:00:00/40 tag 15 ncq 1048576 out
>                         res 40/00:84:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  255.102222] ata4.00: status: { DRDY }
> [  255.102223] ata4.00: failed command: WRITE FPDMA QUEUED
> [  255.102226] ata4.00: cmd 61/68:80:d4:39:44/05:00:25:00:00/40 tag 16 ncq 708608 out
>                         res 40/00:84:d4:39:44/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  255.102227] ata4.00: status: { DRDY }
> [  255.102230] ata4: hard resetting link
> [  255.406909] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  255.407561] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  255.407566] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  255.408819] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  255.408825] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  255.409051] ata4.00: configured for UDMA/133
> [  255.409065] sd 3:0:0:0: [sdb] tag#14 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  255.409068] sd 3:0:0:0: [sdb] tag#14 Sense Key : Aborted Command [current] [descriptor]
> [  255.409069] sd 3:0:0:0: [sdb] tag#14 Add. Sense: No additional sense information
> [  255.409072] sd 3:0:0:0: [sdb] tag#14 CDB: Write(10) 2a 00 25 44 47 3c 00 02 98 00
> [  255.409074] blk_update_request: I/O error, dev sdb, sector 625231676
> [  255.409096] sd 3:0:0:0: [sdb] tag#15 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  255.409097] sd 3:0:0:0: [sdb] tag#15 Sense Key : Aborted Command [current] [descriptor]
> [  255.409099] sd 3:0:0:0: [sdb] tag#15 Add. Sense: No additional sense information
> [  255.409101] sd 3:0:0:0: [sdb] tag#15 CDB: Write(10) 2a 00 25 44 3f 3c 00 08 00 00
> [  255.409102] blk_update_request: I/O error, dev sdb, sector 625229628
> [  255.409142] sd 3:0:0:0: [sdb] tag#16 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  255.409143] sd 3:0:0:0: [sdb] tag#16 Sense Key : Aborted Command [current] [descriptor]
> [  255.409145] sd 3:0:0:0: [sdb] tag#16 Add. Sense: No additional sense information
> [  255.409146] sd 3:0:0:0: [sdb] tag#16 CDB: Write(10) 2a 00 25 44 39 d4 00 05 68 00
> [  255.409147] blk_update_request: I/O error, dev sdb, sector 625228244
> [  255.409179] ata4: EH complete
> [  255.409204] XFS (dm-2): xfs_do_force_shutdown(0x1) called from line 1092 of file fs/xfs/xfs_buf.c.  Return address = 0xffffffff81366db7
> [  255.409207] XFS (dm-2): I/O Error Detected. Shutting down filesystem
> [  255.409209] XFS (dm-2): Please umount the filesystem and rectify the problem(s)
> [  255.409210] XFS (dm-2): metadata I/O error: block 0x254421d4 ("xlog_bwrite") error 5 numblks 8192
> [  255.409336] XFS (dm-2): failed to locate log tail
> [  255.409338] XFS (dm-2): log mount/recovery failed: error -5
> [  255.409380] XFS (dm-2): log mount failed
> [  614.399141] XFS (dm-2): Mounting V4 Filesystem
> [  614.515847] XFS (dm-2): Ending clean mount
> [  658.290344] XFS (dm-2): Mounting V4 Filesystem
> [  658.407061] XFS (dm-2): Ending clean mount
>
> [2]
>
> [    0.000000] CPU0 microcode updated early to revision 0x29, date = 2013-06-12
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 4.0.6+ (x@x) (gcc version 5.1.1 20150618 (Red Hat 5.1.1-4) (GCC) ) #16 SMP Tue Jun 23 18:20:48 EEST 2015
> [    0.000000] Command line: BOOT_IMAGE=/boot/grub2/bzImage-4.0.6 rw boot=LABEL=3Tboot root=/dev/mapper/luks-bea602e1-d47d-4d88-a16a-1b06543077eb rd.luks.uuid=bea602e1-d47d-4d88-a16a-1b06543077eb rootfstype=xfs rootflags=noatime i915.modeset=1 hugepages=32 printk.time=1 log_buf_len=2048k usbhid.mousepoll=1 memtest=0 rd.info rd.md=0 rd.lvm=0 plymouth.enable=0 vconsole.keymap=fi vconsole.font=lat9w-08 SYSFONTACM=iso15 LANG=en_US.UTF-8 intel_iommu=on
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Centaur CentaurHauls
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009b3ff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009b400-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003fffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000401fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000040200000-0x00000000da390fff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000da391000-0x00000000da5f0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000da5f1000-0x00000000da674fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000da675000-0x00000000da940fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000da941000-0x00000000dab85fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000dab86000-0x00000000dab93fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000dab94000-0x00000000dabc0fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000dabc1000-0x00000000dabc5fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000dabc6000-0x00000000dac08fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000dac09000-0x00000000daffffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000db800000-0x00000000df9fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041f5fffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.6 present.
> [    0.000000] DMI: System manufacturer System Product Name/P8Z68-V PRO GEN3, BIOS 3402 05/07/2012
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] AGP: No AGP bridge found
> [    0.000000] e820: last_pfn = 0x41f600 max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-D3FFF write-protect
> [    0.000000]   D4000-E7FFF uncachable
> [    0.000000]   E8000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 000000000 mask C00000000 write-back
> [    0.000000]   1 base 400000000 mask FE0000000 write-back
> [    0.000000]   2 base 0E0000000 mask FE0000000 uncachable
> [    0.000000]   3 base 0DC000000 mask FFC000000 uncachable
> [    0.000000]   4 base 0DB800000 mask FFF800000 uncachable
> [    0.000000]   5 base 41F800000 mask FFF800000 uncachable
> [    0.000000]   6 base 41F600000 mask FFFE00000 uncachable
> [    0.000000]   7 disabled
> [    0.000000]   8 disabled
> [    0.000000]   9 disabled
> [    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC
> [    0.000000] e820: update [mem 0xdb800000-0xffffffff] usable ==> reserved
> [    0.000000] e820: last_pfn = 0xdb000 max_arch_pfn = 0x400000000
> [    0.000000] found SMP MP-table at [mem 0x000fce00-0x000fce0f] mapped at [ffff8800000fce00]
> [    0.000000] Base memory trampoline at [ffff880000095000] 95000 size 24576
> [    0.000000] reserving inaccessible SNB gfx pages
> [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
> [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
> [    0.000000] BRK [0x0304a000, 0x0304afff] PGTABLE
> [    0.000000] BRK [0x0304b000, 0x0304bfff] PGTABLE
> [    0.000000] BRK [0x0304c000, 0x0304cfff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x41f400000-0x41f5fffff]
> [    0.000000]  [mem 0x41f400000-0x41f5fffff] page 2M
> [    0.000000] BRK [0x0304d000, 0x0304dfff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x400000000-0x41f3fffff]
> [    0.000000]  [mem 0x400000000-0x41f3fffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x3e0000000-0x3ffffffff]
> [    0.000000]  [mem 0x3e0000000-0x3ffffffff] page 2M
> [    0.000000] BRK [0x0304e000, 0x0304efff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
> [    0.000000]  [mem 0x00100000-0x001fffff] page 4k
> [    0.000000]  [mem 0x00200000-0x1fffffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x20200000-0x3fffffff]
> [    0.000000]  [mem 0x20200000-0x3fffffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x40200000-0xda390fff]
> [    0.000000]  [mem 0x40200000-0xda1fffff] page 2M
> [    0.000000]  [mem 0xda200000-0xda390fff] page 4k
> [    0.000000] BRK [0x0304f000, 0x0304ffff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0xdac09000-0xdaffffff]
> [    0.000000]  [mem 0xdac09000-0xdadfffff] page 4k
> [    0.000000]  [mem 0xdae00000-0xdaffffff] page 2M
> [    0.000000] init_memory_mapping: [mem 0x100000000-0x3dfffffff]
> [    0.000000]  [mem 0x100000000-0x3dfffffff] page 2M
> [    0.000000] log_buf_len: 2097152 bytes
> [    0.000000] early log buf free: 124792(95%)
> [    0.000000] RAMDISK: [mem 0x10b6c000-0x1fffffff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000F0450 000024 (v02 ALASKA)
> [    0.000000] ACPI: XSDT 0x00000000DAB86070 000064 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: FACP 0x00000000DAB91C68 0000F4 (v04 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: DSDT 0x00000000DAB86168 00BAFE (v02 ALASKA A M I    00000015 INTL 20051117)
> [    0.000000] ACPI: FACS 0x00000000DABBFF80 000040
> [    0.000000] ACPI: APIC 0x00000000DAB91D60 000072 (v03 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: MCFG 0x00000000DAB91DD8 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
> [    0.000000] ACPI: HPET 0x00000000DAB91E18 000038 (v01 ALASKA A M I    01072009 AMI. 00000005)
> [    0.000000] ACPI: SSDT 0x00000000DAB91E50 00036D (v01 SataRe SataTabl 00001000 INTL 20091112)
> [    0.000000] ACPI: SSDT 0x00000000DAB921C0 0009AA (v01 PmRef  Cpu0Ist  00003000 INTL 20051117)
> [    0.000000] ACPI: SSDT 0x00000000DAB92B70 000A92 (v01 PmRef  CpuPm    00003000 INTL 20051117)
> [    0.000000] ACPI: BGRT 0x00000000DAB93608 000038 (v00 ALASKA A M I    01072009 AMI  00010013)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000041f5fffff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x41f3cb000-0x41f3f0fff]
> [    0.000000]  [ffffea0000000000-ffffea00107fffff] PMD -> [ffff88040ea00000-ffff88041e9fffff] on node 0
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000041f5fffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009afff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
> [    0.000000]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
> [    0.000000]   node   0: [mem 0x0000000040200000-0x00000000da390fff]
> [    0.000000]   node   0: [mem 0x00000000dac09000-0x00000000daffffff]
> [    0.000000]   node   0: [mem 0x0000000100000000-0x000000041f5fffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000041f5fffff]
> [    0.000000] On node 0 totalpages: 4167970
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 154 pages reserved
> [    0.000000]   DMA zone: 3994 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 13903 pages used for memmap
> [    0.000000]   DMA32 zone: 889736 pages, LIFO batch:31
> [    0.000000]   Normal zone: 51160 pages used for memmap
> [    0.000000]   Normal zone: 3274240 pages, LIFO batch:31
> [    0.000000] Reserving Intel graphics stolen memory at 0xdba00000-0xdf9fffff
> [    0.000000] ACPI: PM-Timer IO Port: 0x408
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> [    0.000000] e820: [mem 0xdfa00000-0xf7ffffff] available for PCI devices
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:4 nr_node_ids:1
> [    0.000000] PERCPU: Embedded 480 pages/cpu @ffff88040e200000 s1928728 r8192 d29160 u2097152
> [    0.000000] pcpu-alloc: s1928728 r8192 d29160 u2097152 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> [    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 4102689
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/grub2/bzImage-4.0.6 rw boot=LABEL=3Tboot root=/dev/mapper/luks-bea602e1-d47d-4d88-a16a-1b06543077eb rd.luks.uuid=bea602e1-d47d-4d88-a16a-1b06543077eb rootfstype=xfs rootflags=noatime i915.modeset=1 hugepages=32 printk.time=1 log_buf_len=2048k usbhid.mousepoll=1 memtest=0 rd.info rd.md=0 rd.lvm=0 plymouth.enable=0 vconsole.keymap=fi vconsole.font=lat9w-08 SYSFONTACM=iso15 LANG=en_US.UTF-8 intel_iommu=on
> [    0.000000] Intel-IOMMU: enabled
> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
> [    0.000000] AGP: Checking aperture...
> [    0.000000] AGP: No AGP bridge found
> [    0.000000] Memory: 16048916K/16671880K available (9298K kernel code, 1242K rwdata, 4164K rodata, 3232K init, 12164K bss, 622964K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]  RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=4.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.000000] NR_IRQS:8448 nr_irqs:456 16
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [tty0] enabled
> [    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.000000] ... MAX_LOCK_DEPTH:          48
> [    0.000000] ... MAX_LOCKDEP_KEYS:        8191
> [    0.000000] ... CLASSHASH_SIZE:          4096
> [    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.000000] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.000000] ... CHAINHASH_SIZE:          32768
> [    0.000000]  memory used by lock dependency info: 8639 kB
> [    0.000000]  per task-struct memory footprint: 2688 bytes
> [    0.000000] hpet clockevent registered
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] random: add_entropy_bytes (nbytes=8 source=1) called before rand_initialize
> [    0.000000] random: rand_initialize starting
> [    0.000000] random: add_entropy_bytes 144 while reseed_count == 0
> [    0.000000] random: add_entropy_bytes 312 while reseed_count == 0
> [    0.000000] random: add_entropy_bytes 390 while reseed_count == 0
> [    0.000000] random: fed 11 KiB from add_device_randomness
> [    0.000000] random: add_entropy_bytes 64 while reseed_count == 0
> [    0.000000] random: random_reseed() reseeds=1 pool0_len=910
> [    0.000000] random: rand_initialize finished (random_debug=0/debug_max=15
> [    0.000000] tsc: Detected 3310.575 MHz processor
> [    0.000002] Calibrating delay loop (skipped), value calculated using timer frequency.. 6621.15 BogoMIPS (lpj=3310575)
> [    0.000147] pid_max: default: 32768 minimum: 301
> [    0.000224] ACPI: Core revision 20150204
> [    0.012585] ACPI: All ACPI Tables successfully acquired
> [    0.229033] Security Framework initialized
> [    0.229108] Yama: becoming mindful.
> [    0.229909] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
> [    0.232443] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> [    0.233602] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
> [    0.233693] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
> [    0.234105] Initializing cgroup subsys blkio
> [    0.234177] Initializing cgroup subsys freezer
> [    0.234253] Initializing cgroup subsys net_cls
> [    0.234336] Initializing cgroup subsys perf_event
> [    0.234409] Initializing cgroup subsys net_prio
> [    0.234502] CPU: Physical Processor ID: 0
> [    0.234572] CPU: Processor Core ID: 0
> [    0.234644] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.234718] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
> [    0.234793] mce: CPU supports 9 MCE banks
> [    0.234873] CPU0: Thermal monitoring enabled (TM1)
> [    0.234953] process: using mwait in idle threads
> [    0.235026] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
> [    0.235099] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
> [    0.235269] Freeing SMP alternatives memory: 32K (ffffffff82460000 - ffffffff82468000)
> [    0.236741] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.246810] TSC deadline timer enabled
> [    0.246814] smpboot: CPU0: Intel(R) Core(TM) i5-2500K CPU @ 3.30GHz (fam: 06, model: 2a, stepping: 07)
> [    0.247051] Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge events, full-width counters, Intel PMU driver.
> [    0.247361] ... version:                3
> [    0.247432] ... bit width:              48
> [    0.247502] ... generic registers:      8
> [    0.247573] ... value mask:             0000ffffffffffff
> [    0.248289] ... max period:             0000ffffffffffff
> [    0.248362] ... fixed-purpose events:   3
> [    0.248432] ... event mask:             00000007000000ff
> [    0.249303] x86: Booting SMP configuration:
> [    0.249374] .... node  #0, CPUs:      #1
> [    0.260734] CPU1 microcode updated early to revision 0x29, date = 2013-06-12
> [    0.262885] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
> [    0.263259]  #2
> [    0.274542] CPU2 microcode updated early to revision 0x29, date = 2013-06-12
> [    0.276757]  #3
> [    0.288179] CPU3 microcode updated early to revision 0x29, date = 2013-06-12
> [    0.290275] x86: Booted up 1 node, 4 CPUs
> [    0.290450] smpboot: Total of 4 processors activated (26484.60 BogoMIPS)
> [    0.293075] devtmpfs: initialized
> [    0.293574] PM: Registering ACPI NVS region [mem 0xda5f1000-0xda674fff] (540672 bytes)
> [    0.293684] PM: Registering ACPI NVS region [mem 0xda941000-0xdab85fff] (2379776 bytes)
> [    0.293816] PM: Registering ACPI NVS region [mem 0xdab94000-0xdabc0fff] (184320 bytes)
> [    0.293921] PM: Registering ACPI NVS region [mem 0xdabc6000-0xdac08fff] (274432 bytes)
> [    0.294195] xor: automatically using best checksumming function:
> [    0.303801]    avx       : 22980.000 MB/sec
> [    0.303875] prandom: seed boundary self test passed
> [    0.304339] prandom: 100 self tests passed
> [    0.304413] atomic64_test: passed for x86-64 platform with CX8 and with SSE
> [    0.304488] pinctrl core: initialized pinctrl subsystem
> [    0.304926] NET: Registered protocol family 16
> [    0.309829] cpuidle: using governor ladder
> [    0.315844] cpuidle: using governor menu
> [    0.316031] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.316139] ACPI: bus type PCI registered
> [    0.316303] dca service started, version 1.12.1
> [    0.316405] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
> [    0.316512] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
> [    0.316656] PCI: Using configuration type 1 for base access
> [    0.342884] raid6: sse2x1    8765 MB/s
> [    0.359898] raid6: sse2x2   11105 MB/s
> [    0.376910] raid6: sse2x4   12820 MB/s
> [    0.376980] raid6: using algorithm sse2x4 (12820 MB/s)
> [    0.377052] raid6: using ssse3x2 recovery algorithm
> [    0.377244] ACPI: Added _OSI(Module Device)
> [    0.377317] ACPI: Added _OSI(Processor Device)
> [    0.377389] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.377460] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.387330] ACPI: Executed 1 blocks of module-level executable AML code
> [    0.393705] ACPI: Dynamic OEM Table Load:
> [    0.393861] ACPI: SSDT 0xFFFF88040C307000 00083B (v01 PmRef  Cpu0Cst  00003001 INTL 20051117)
> [    0.395624] ACPI: Dynamic OEM Table Load:
> [    0.395776] ACPI: SSDT 0xFFFF88040BD36000 000303 (v01 PmRef  ApIst    00003000 INTL 20051117)
> [    0.397418] ACPI: Dynamic OEM Table Load:
> [    0.397567] ACPI: SSDT 0xFFFF88040B40F400 000119 (v01 PmRef  ApCst    00003000 INTL 20051117)
> [    0.399947] ACPI: Interpreter enabled
> [    0.400028] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150204/hwxface-580)
> [    0.400223] ACPI: (supports S0 S1 S3 S5)
> [    0.400294] ACPI: Using IOAPIC for interrupt routing
> [    0.400405] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.413935] ACPI: Power Resource [FN00] (off)
> [    0.414187] ACPI: Power Resource [FN01] (off)
> [    0.414416] ACPI: Power Resource [FN02] (off)
> [    0.414646] ACPI: Power Resource [FN03] (off)
> [    0.414874] ACPI: Power Resource [FN04] (off)
> [    0.416360] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
> [    0.416439] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.416652] \_SB_.PCI0:_OSC invalid UUID
> [    0.416653] _OSC request data:1 1f 0
> [    0.416656] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
> [    0.417291] PCI host bridge to bus 0000:00
> [    0.417363] pci_bus 0000:00: root bus resource [bus 00-3e]
> [    0.417437] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.417512] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.417587] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.417689] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
> [    0.417792] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
> [    0.417895] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
> [    0.418000] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
> [    0.418103] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
> [    0.418205] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfeafffff window]
> [    0.418322] pci 0000:00:00.0: [8086:0100] type 00 class 0x060000
> [    0.418510] pci 0000:00:01.0: [8086:0101] type 01 class 0x060400
> [    0.418559] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> [    0.418663] pci 0000:00:01.0: System wakeup disabled by ACPI
> [    0.418814] pci 0000:00:02.0: [8086:0112] type 00 class 0x030000
> [    0.418827] pci 0000:00:02.0: reg 0x10: [mem 0xf7400000-0xf77fffff 64bit]
> [    0.418835] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
> [    0.418840] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
> [    0.419049] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
> [    0.419082] pci 0000:00:16.0: reg 0x10: [mem 0xf7d2c000-0xf7d2c00f 64bit]
> [    0.419196] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> [    0.419373] pci 0000:00:19.0: [8086:1503] type 00 class 0x020000
> [    0.419399] pci 0000:00:19.0: reg 0x10: [mem 0xf7d00000-0xf7d1ffff]
> [    0.419411] pci 0000:00:19.0: reg 0x14: [mem 0xf7d29000-0xf7d29fff]
> [    0.419422] pci 0000:00:19.0: reg 0x18: [io  0xf080-0xf09f]
> [    0.419527] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
> [    0.419623] pci 0000:00:19.0: System wakeup disabled by ACPI
> [    0.419772] pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
> [    0.419803] pci 0000:00:1a.0: reg 0x10: [mem 0xf7d28000-0xf7d283ff]
> [    0.419932] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> [    0.420052] pci 0000:00:1a.0: System wakeup disabled by ACPI
> [    0.420202] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
> [    0.420229] pci 0000:00:1b.0: reg 0x10: [mem 0xf7d20000-0xf7d23fff 64bit]
> [    0.420351] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    0.420449] pci 0000:00:1b.0: System wakeup disabled by ACPI
> [    0.420593] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
> [    0.420727] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.420831] pci 0000:00:1c.0: System wakeup disabled by ACPI
> [    0.420975] pci 0000:00:1c.1: [8086:1c12] type 01 class 0x060400
> [    0.421108] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> [    0.421209] pci 0000:00:1c.1: System wakeup disabled by ACPI
> [    0.421354] pci 0000:00:1c.3: [8086:1c16] type 01 class 0x060400
> [    0.421486] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> [    0.421587] pci 0000:00:1c.3: System wakeup disabled by ACPI
> [    0.421730] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
> [    0.421864] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> [    0.421964] pci 0000:00:1c.4: System wakeup disabled by ACPI
> [    0.422111] pci 0000:00:1c.6: [8086:244e] type 01 class 0x060401
> [    0.422245] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
> [    0.422345] pci 0000:00:1c.6: System wakeup disabled by ACPI
> [    0.422489] pci 0000:00:1c.7: [8086:1c1e] type 01 class 0x060400
> [    0.422621] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
> [    0.422718] pci 0000:00:1c.7: System wakeup disabled by ACPI
> [    0.422867] pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
> [    0.422896] pci 0000:00:1d.0: reg 0x10: [mem 0xf7d27000-0xf7d273ff]
> [    0.423034] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    0.423205] pci 0000:00:1f.0: [8086:1c44] type 00 class 0x060100
> [    0.423506] pci 0000:00:1f.2: [8086:1c02] type 00 class 0x010601
> [    0.423538] pci 0000:00:1f.2: reg 0x10: [io  0xf0d0-0xf0d7]
> [    0.423550] pci 0000:00:1f.2: reg 0x14: [io  0xf0c0-0xf0c3]
> [    0.423561] pci 0000:00:1f.2: reg 0x18: [io  0xf0b0-0xf0b7]
> [    0.423572] pci 0000:00:1f.2: reg 0x1c: [io  0xf0a0-0xf0a3]
> [    0.423584] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
> [    0.423596] pci 0000:00:1f.2: reg 0x24: [mem 0xf7d26000-0xf7d267ff]
> [    0.423674] pci 0000:00:1f.2: PME# supported from D3hot
> [    0.423833] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
> [    0.423854] pci 0000:00:1f.3: reg 0x10: [mem 0xf7d25000-0xf7d250ff 64bit]
> [    0.423886] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
> [    0.424113] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.424288] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    0.424510] pci 0000:03:00.0: [1b21:1042] type 00 class 0x0c0330
> [    0.424551] pci 0000:03:00.0: reg 0x10: [mem 0xf7c00000-0xf7c07fff 64bit]
> [    0.424759] pci 0000:03:00.0: PME# supported from D3hot D3cold
> [    0.424807] pci 0000:03:00.0: System wakeup disabled by ACPI
> [    0.427081] pci 0000:00:1c.1: PCI bridge to [bus 03]
> [    0.427179] pci 0000:00:1c.1:   bridge window [mem 0xf7c00000-0xf7cfffff]
> [    0.427320] pci 0000:04:00.0: [197b:2362] type 00 class 0x010185
> [    0.427369] pci 0000:04:00.0: reg 0x10: [io  0xe040-0xe047]
> [    0.427389] pci 0000:04:00.0: reg 0x14: [io  0xe030-0xe033]
> [    0.427408] pci 0000:04:00.0: reg 0x18: [io  0xe020-0xe027]
> [    0.427428] pci 0000:04:00.0: reg 0x1c: [io  0xe010-0xe013]
> [    0.427448] pci 0000:04:00.0: reg 0x20: [io  0xe000-0xe00f]
> [    0.427467] pci 0000:04:00.0: reg 0x24: [mem 0xf7b10000-0xf7b101ff]
> [    0.427487] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> [    0.427579] pci 0000:04:00.0: PME# supported from D3hot
> [    0.427626] pci 0000:04:00.0: System wakeup disabled by ACPI
> [    0.429085] pci 0000:00:1c.3: PCI bridge to [bus 04]
> [    0.429179] pci 0000:00:1c.3:   bridge window [io  0xe000-0xefff]
> [    0.429184] pci 0000:00:1c.3:   bridge window [mem 0xf7b00000-0xf7bfffff]
> [    0.429330] pci 0000:05:00.0: [1b21:1042] type 00 class 0x0c0330
> [    0.429372] pci 0000:05:00.0: reg 0x10: [mem 0xf7a00000-0xf7a07fff 64bit]
> [    0.429585] pci 0000:05:00.0: PME# supported from D3hot D3cold
> [    0.429633] pci 0000:05:00.0: System wakeup disabled by ACPI
> [    0.431089] pci 0000:00:1c.4: PCI bridge to [bus 05]
> [    0.431187] pci 0000:00:1c.4:   bridge window [mem 0xf7a00000-0xf7afffff]
> [    0.431314] pci 0000:06:00.0: [1b21:1080] type 01 class 0x060401
> [    0.431484] pci 0000:06:00.0: System wakeup disabled by ACPI
> [    0.431619] pci 0000:00:1c.6: PCI bridge to [bus 06-07] (subtractive decode)
> [    0.431698] pci 0000:00:1c.6:   bridge window [io  0xd000-0xdfff]
> [    0.431703] pci 0000:00:1c.6:   bridge window [mem 0xf7900000-0xf79fffff]
> [    0.431710] pci 0000:00:1c.6:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
> [    0.431712] pci 0000:00:1c.6:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
> [    0.431713] pci 0000:00:1c.6:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
> [    0.431715] pci 0000:00:1c.6:   bridge window [mem 0x000d4000-0x000d7fff window] (subtractive decode)
> [    0.431716] pci 0000:00:1c.6:   bridge window [mem 0x000d8000-0x000dbfff window] (subtractive decode)
> [    0.431717] pci 0000:00:1c.6:   bridge window [mem 0x000dc000-0x000dffff window] (subtractive decode)
> [    0.431718] pci 0000:00:1c.6:   bridge window [mem 0x000e0000-0x000e3fff window] (subtractive decode)
> [    0.431720] pci 0000:00:1c.6:   bridge window [mem 0x000e4000-0x000e7fff window] (subtractive decode)
> [    0.431721] pci 0000:00:1c.6:   bridge window [mem 0xdfa00000-0xfeafffff window] (subtractive decode)
> [    0.431821] pci 0000:07:02.0: [1106:3044] type 00 class 0x0c0010
> [    0.431856] pci 0000:07:02.0: reg 0x10: [mem 0xf7900000-0xf79007ff]
> [    0.431876] pci 0000:07:02.0: reg 0x14: [io  0xd000-0xd07f]
> [    0.432034] pci 0000:07:02.0: supports D2
> [    0.432035] pci 0000:07:02.0: PME# supported from D2 D3hot D3cold
> [    0.432198] pci 0000:06:00.0: PCI bridge to [bus 07] (subtractive decode)
> [    0.432283] pci 0000:06:00.0:   bridge window [io  0xd000-0xdfff]
> [    0.432289] pci 0000:06:00.0:   bridge window [mem 0xf7900000-0xf79fffff]
> [    0.432301] pci 0000:06:00.0:   bridge window [io  0xd000-0xdfff] (subtractive decode)
> [    0.432302] pci 0000:06:00.0:   bridge window [mem 0xf7900000-0xf79fffff] (subtractive decode)
> [    0.432303] pci 0000:06:00.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
> [    0.432305] pci 0000:06:00.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
> [    0.432306] pci 0000:06:00.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
> [    0.432307] pci 0000:06:00.0:   bridge window [mem 0x000d4000-0x000d7fff window] (subtractive decode)
> [    0.432308] pci 0000:06:00.0:   bridge window [mem 0x000d8000-0x000dbfff window] (subtractive decode)
> [    0.432310] pci 0000:06:00.0:   bridge window [mem 0x000dc000-0x000dffff window] (subtractive decode)
> [    0.432311] pci 0000:06:00.0:   bridge window [mem 0x000e0000-0x000e3fff window] (subtractive decode)
> [    0.432312] pci 0000:06:00.0:   bridge window [mem 0x000e4000-0x000e7fff window] (subtractive decode)
> [    0.432314] pci 0000:06:00.0:   bridge window [mem 0xdfa00000-0xfeafffff window] (subtractive decode)
> [    0.432451] pci 0000:08:00.0: [1b4b:9172] type 00 class 0x010601
> [    0.432476] pci 0000:08:00.0: reg 0x10: [io  0xc040-0xc047]
> [    0.432492] pci 0000:08:00.0: reg 0x14: [io  0xc030-0xc033]
> [    0.432508] pci 0000:08:00.0: reg 0x18: [io  0xc020-0xc027]
> [    0.432525] pci 0000:08:00.0: reg 0x1c: [io  0xc010-0xc013]
> [    0.432540] pci 0000:08:00.0: reg 0x20: [io  0xc000-0xc00f]
> [    0.432556] pci 0000:08:00.0: reg 0x24: [mem 0xf7810000-0xf78101ff]
> [    0.432572] pci 0000:08:00.0: reg 0x30: [mem 0xf7800000-0xf780ffff pref]
> [    0.432661] pci 0000:08:00.0: PME# supported from D3hot
> [    0.432701] pci 0000:08:00.0: System wakeup disabled by ACPI
> [    0.432856] pci 0000:00:1c.7: PCI bridge to [bus 08]
> [    0.432932] pci 0000:00:1c.7:   bridge window [io  0xc000-0xcfff]
> [    0.432936] pci 0000:00:1c.7:   bridge window [mem 0xf7800000-0xf78fffff]
> [    0.433808] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.434373] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 10 11 12 14 15)
> [    0.434929] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.435487] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 14 15)
> [    0.436042] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 10 11 12 14 15)
> [    0.436600] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> [    0.437263] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 10 11 12 14 15)
> [    0.437819] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *10 11 12 14 15)
> [    0.438760] ACPI: Enabled 4 GPEs in block 00 to 3F
> [    0.438948] ACPI : EC: GPE = 0x18, I/O: command/status = 0x66, data = 0x62
> [    0.439282] vgaarb: setting as boot device: PCI:0000:00:02.0
> [    0.439357] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
> [    0.439467] vgaarb: loaded
> [    0.439535] vgaarb: bridge control possible 0000:00:02.0
> [    0.439971] SCSI subsystem initialized
> [    0.440112] libata version 3.00 loaded.
> [    0.440224] EDAC MC: Ver: 3.0.0
> [    0.440543] PCI: Using ACPI for IRQ routing
> [    0.442209] PCI: pci_cache_line_size set to 64 bytes
> [    0.442310] e820: reserve RAM buffer [mem 0x0009b400-0x0009ffff]
> [    0.442312] e820: reserve RAM buffer [mem 0xda391000-0xdbffffff]
> [    0.442314] e820: reserve RAM buffer [mem 0xdb000000-0xdbffffff]
> [    0.442315] e820: reserve RAM buffer [mem 0x41f600000-0x41fffffff]
> [    0.442544] nfc: nfc_init: NFC Core ver 0.1
> [    0.442641] NET: Registered protocol family 39
> [    0.442803] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    0.443215] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> [    0.445357] Switched to clocksource hpet
> [    0.459117] pnp: PnP ACPI init
> [    0.459333] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
> [    0.459434] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.459564] system 00:01: [io  0x0680-0x069f] has been reserved
> [    0.459640] system 00:01: [io  0x0200-0x020f] has been reserved
> [    0.459715] system 00:01: [io  0xffff] has been reserved
> [    0.459787] system 00:01: [io  0xffff] has been reserved
> [    0.459861] system 00:01: [io  0x0400-0x0453] could not be reserved
> [    0.459935] system 00:01: [io  0x0458-0x047f] has been reserved
> [    0.460009] system 00:01: [io  0x0500-0x057f] has been reserved
> [    0.460082] system 00:01: [io  0x164e-0x164f] has been reserved
> [    0.460157] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.460211] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.460304] system 00:03: [io  0x0454-0x0457] has been reserved
> [    0.460398] system 00:03: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
> [    0.460541] system 00:04: [io  0x0290-0x029f] has been reserved
> [    0.460619] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.460711] system 00:05: [io  0x04d0-0x04d1] has been reserved
> [    0.460789] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.461272] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
> [    0.461361] system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
> [    0.461436] system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.461510] system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.461586] system 00:06: [mem 0xf8000000-0xfbffffff] has been reserved
> [    0.461661] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.461736] system 00:06: [mem 0xfed90000-0xfed93fff] has been reserved
> [    0.461811] system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
> [    0.461886] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
> [    0.461961] system 00:06: [mem 0xfee00000-0xfeefffff] could not be reserved
> [    0.462036] system 00:06: [mem 0xdfa00000-0xdfa00fff] has been reserved
> [    0.462113] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.462368] system 00:07: [mem 0x20000000-0x201fffff] has been reserved
> [    0.462446] system 00:07: [mem 0x40000000-0x401fffff] has been reserved
> [    0.462522] system 00:07: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.462559] pnp: PnP ACPI: found 8 devices
> [    0.470378] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
> [    0.470381] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000
> [    0.470382] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 02] add_size 200000
> [    0.470451] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff] get_res_add_size add_size 200000
> [    0.470453] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
> [    0.470454] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
> [    0.470460] pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff]
> [    0.470542] pci 0000:00:1c.0: BAR 15: assigned [mem 0xdfd00000-0xdfefffff 64bit pref]
> [    0.470646] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
> [    0.470721] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.470798] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    0.470872] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
> [    0.470950] pci 0000:00:1c.0:   bridge window [mem 0xdfb00000-0xdfcfffff]
> [    0.471029] pci 0000:00:1c.0:   bridge window [mem 0xdfd00000-0xdfefffff 64bit pref]
> [    0.471139] pci 0000:00:1c.1: PCI bridge to [bus 03]
> [    0.471216] pci 0000:00:1c.1:   bridge window [mem 0xf7c00000-0xf7cfffff]
> [    0.471302] pci 0000:04:00.0: BAR 6: assigned [mem 0xf7b00000-0xf7b0ffff pref]
> [    0.472062] pci 0000:00:1c.3: PCI bridge to [bus 04]
> [    0.472136] pci 0000:00:1c.3:   bridge window [io  0xe000-0xefff]
> [    0.472214] pci 0000:00:1c.3:   bridge window [mem 0xf7b00000-0xf7bfffff]
> [    0.472299] pci 0000:00:1c.4: PCI bridge to [bus 05]
> [    0.472390] pci 0000:00:1c.4:   bridge window [mem 0xf7a00000-0xf7afffff]
> [    0.472475] pci 0000:06:00.0: PCI bridge to [bus 07]
> [    0.472550] pci 0000:06:00.0:   bridge window [io  0xd000-0xdfff]
> [    0.472631] pci 0000:06:00.0:   bridge window [mem 0xf7900000-0xf79fffff]
> [    0.472721] pci 0000:00:1c.6: PCI bridge to [bus 06-07]
> [    0.472795] pci 0000:00:1c.6:   bridge window [io  0xd000-0xdfff]
> [    0.472874] pci 0000:00:1c.6:   bridge window [mem 0xf7900000-0xf79fffff]
> [    0.472958] pci 0000:00:1c.7: PCI bridge to [bus 08]
> [    0.473032] pci 0000:00:1c.7:   bridge window [io  0xc000-0xcfff]
> [    0.473111] pci 0000:00:1c.7:   bridge window [mem 0xf7800000-0xf78fffff]
> [    0.473198] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.473199] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.473201] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.473202] pci_bus 0000:00: resource 7 [mem 0x000d4000-0x000d7fff window]
> [    0.473203] pci_bus 0000:00: resource 8 [mem 0x000d8000-0x000dbfff window]
> [    0.473204] pci_bus 0000:00: resource 9 [mem 0x000dc000-0x000dffff window]
> [    0.473206] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000e3fff window]
> [    0.473207] pci_bus 0000:00: resource 11 [mem 0x000e4000-0x000e7fff window]
> [    0.473208] pci_bus 0000:00: resource 12 [mem 0xdfa00000-0xfeafffff window]
> [    0.473210] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
> [    0.473211] pci_bus 0000:02: resource 1 [mem 0xdfb00000-0xdfcfffff]
> [    0.473213] pci_bus 0000:02: resource 2 [mem 0xdfd00000-0xdfefffff 64bit pref]
> [    0.473214] pci_bus 0000:03: resource 1 [mem 0xf7c00000-0xf7cfffff]
> [    0.473215] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
> [    0.473217] pci_bus 0000:04: resource 1 [mem 0xf7b00000-0xf7bfffff]
> [    0.473218] pci_bus 0000:05: resource 1 [mem 0xf7a00000-0xf7afffff]
> [    0.473219] pci_bus 0000:06: resource 0 [io  0xd000-0xdfff]
> [    0.473221] pci_bus 0000:06: resource 1 [mem 0xf7900000-0xf79fffff]
> [    0.473222] pci_bus 0000:06: resource 4 [io  0x0000-0x0cf7 window]
> [    0.473223] pci_bus 0000:06: resource 5 [io  0x0d00-0xffff window]
> [    0.473224] pci_bus 0000:06: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.473226] pci_bus 0000:06: resource 7 [mem 0x000d4000-0x000d7fff window]
> [    0.473227] pci_bus 0000:06: resource 8 [mem 0x000d8000-0x000dbfff window]
> [    0.473228] pci_bus 0000:06: resource 9 [mem 0x000dc000-0x000dffff window]
> [    0.473230] pci_bus 0000:06: resource 10 [mem 0x000e0000-0x000e3fff window]
> [    0.473231] pci_bus 0000:06: resource 11 [mem 0x000e4000-0x000e7fff window]
> [    0.473232] pci_bus 0000:06: resource 12 [mem 0xdfa00000-0xfeafffff window]
> [    0.473234] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
> [    0.473235] pci_bus 0000:07: resource 1 [mem 0xf7900000-0xf79fffff]
> [    0.473236] pci_bus 0000:07: resource 4 [io  0xd000-0xdfff]
> [    0.473237] pci_bus 0000:07: resource 5 [mem 0xf7900000-0xf79fffff]
> [    0.473239] pci_bus 0000:07: resource 6 [io  0x0000-0x0cf7 window]
> [    0.473240] pci_bus 0000:07: resource 7 [io  0x0d00-0xffff window]
> [    0.473241] pci_bus 0000:07: resource 8 [mem 0x000a0000-0x000bffff window]
> [    0.473242] pci_bus 0000:07: resource 9 [mem 0x000d4000-0x000d7fff window]
> [    0.473244] pci_bus 0000:07: resource 10 [mem 0x000d8000-0x000dbfff window]
> [    0.473245] pci_bus 0000:07: resource 11 [mem 0x000dc000-0x000dffff window]
> [    0.473246] pci_bus 0000:07: resource 12 [mem 0x000e0000-0x000e3fff window]
> [    0.473248] pci_bus 0000:07: resource 13 [mem 0x000e4000-0x000e7fff window]
> [    0.473249] pci_bus 0000:07: resource 14 [mem 0xdfa00000-0xfeafffff window]
> [    0.473250] pci_bus 0000:08: resource 0 [io  0xc000-0xcfff]
> [    0.473252] pci_bus 0000:08: resource 1 [mem 0xf7800000-0xf78fffff]
> [    0.473294] NET: Registered protocol family 2
> [    0.473658] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
> [    0.474140] TCP bind hash table entries: 65536 (order: 10, 5242880 bytes)
> [    0.475961] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.476070] TCP: reno registered
> [    0.476210] UDP hash table entries: 8192 (order: 8, 1572864 bytes)
> [    0.476791] UDP-Lite hash table entries: 8192 (order: 8, 1572864 bytes)
> [    0.477396] NET: Registered protocol family 1
> [    0.477484] pci 0000:00:02.0: Video device with shadowed ROM
> [    0.723858] PCI: CLS 64 bytes, default 64
> [    0.723941] Trying to unpack rootfs image as initramfs...
> [    4.205076] Freeing initrd memory: 250448K (ffff880010b6c000 - ffff880020000000)
> [    4.205189] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    4.205263] software IO TLB [mem 0xd6391000-0xda391000] (64MB) mapped at [ffff8800d6391000-ffff8800da390fff]
> [    4.205730] RAPL PMU detected, hw unit 2^-16 Joules, API unit is 2^-32 Joules, 3 fixed counters 163840 ms ovfl timer
> [    4.206015] microcode: CPU0 sig=0x206a7, pf=0x2, revision=0x29
> [    4.206096] microcode: CPU1 sig=0x206a7, pf=0x2, revision=0x29
> [    4.206177] microcode: CPU2 sig=0x206a7, pf=0x2, revision=0x29
> [    4.206258] microcode: CPU3 sig=0x206a7, pf=0x2, revision=0x29
> [    4.206407] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
> [    4.207378] AVX version of gcm_enc/dec engaged.
> [    4.207450] AES CTR mode by8 optimization enabled
> [    4.208065] sha1_ssse3: Using AVX optimized SHA-1 implementation
> [    4.208200] sha256_ssse3: Using AVX optimized SHA-256 implementation
> [    4.208334] sha512_ssse3: Using AVX optimized SHA-512 implementation
> [    4.209315] futex hash table entries: 1024 (order: 5, 131072 bytes)
> [    4.209465] audit: initializing netlink subsys (disabled)
> [    4.209570] audit: type=2000 audit(1435074993.990:1): initialized
> [    4.210300] HugeTLB registered 2 MB page size, pre-allocated 32 pages
> [    4.213933] VFS: Disk quotas dquot_6.5.2
> [    4.214063] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    4.214953] SGI XFS with ACLs, security attributes, no debug enabled
> [    4.217516] async_tx: api initialized (async)
> [    4.217607] bounce: pool size: 64 pages
> [    4.217691] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
> [    4.217864] io scheduler noop registered
> [    4.217938] io scheduler deadline registered
> [    4.218019] io scheduler cfq registered (default)
> [    4.218092] Running resizable hashtable tests...
> [    4.218167]   Adding 2048 keys
> [    4.218800]   Traversal complete: counted=2048, nelems=2048, entries=2048
> [    4.220905]   Table expansion iteration 0...
> [    4.713352]   Verifying lookups...
> [    4.714677]   Table expansion iteration 1...
> [    4.996085]   Verifying lookups...
> [    4.997008]   Table expansion iteration 2...
> [    5.193899]   Verifying lookups...
> [    5.194632]   Table expansion iteration 3...
> [    5.205914] tsc: Refined TSC clocksource calibration: 3310.799 MHz
> [    5.295807]   Verifying lookups...
> [    5.296446]   Table shrinkage iteration 0...
> [    5.307795]   Verifying lookups...
> [    5.308519]   Table shrinkage iteration 1...
> [    5.319783]   Verifying lookups...
> [    5.320702]   Table shrinkage iteration 2...
> [    5.332769]   Verifying lookups...
> [    5.334080]   Table shrinkage iteration 3...
> [    5.344757]   Verifying lookups...
> [    5.346863]   Traversal complete: counted=2048, nelems=2048, entries=2048
> [    5.346938]   Deleting 2048 keys
> [    5.348342] xz_dec_test: module loaded
> [    5.348413] xz_dec_test: Create a device node with 'mknod xz_dec_test c 251 0' and write .xz files to it.
> [    5.349753] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    5.349883] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    5.349964] cpcihp_zt5550: ZT5550 CompactPCI Hot Plug Driver version: 0.2
> [    5.350065] cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
> [    5.350171] cpcihp_generic: not configured, disabling.
> [    5.350271] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    5.350418] intel_idle: MWAIT substates: 0x1120
> [    5.350419] intel_idle: v0.4 model 0x2A
> [    5.350420] intel_idle: lapic_timer_reliable_states 0xffffffff
> [    5.350845] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    5.350963] ACPI: Power Button [PWRB]
> [    5.351101] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> [    5.351212] ACPI: Power Button [PWRF]
> [    5.352672] thermal LNXTHERM:00: registered as thermal_zone0
> [    5.352757] ACPI: Thermal Zone [TZ00] (28 C)
> [    5.353214] thermal LNXTHERM:01: registered as thermal_zone1
> [    5.353288] ACPI: Thermal Zone [TZ01] (30 C)
> [    5.353558] GHES: HEST is not enabled!
> [    5.353642] ioatdma: Intel(R) QuickData Technology Driver 4.00
> [    5.353787] xenfs: not registering filesystem on non-xen platform
> [    5.354013] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    5.354634] random: module_init call_rand_initialize
> [    5.355001] Linux agpgart interface v0.103
> [    5.355213] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> [    5.355294] AMD IOMMUv2 functionality not available on this system
> [    5.355385] [drm] Initialized drm 1.1.0 20060810
> [    5.358438] brd: module loaded
> [    5.364194] aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 loaded
> [    5.364313] mpt3sas version 04.100.00.00 loaded
> [    5.364501] stex: Promise SuperTrak EX Driver version: 4.6.0000.4
> [    5.364609] st: Version 20101219, fixed bufsize 32768, s/g segs 256
> [    5.364714] osst :I: Tape driver with OnStream support version 0.99.4
>                osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
> [    5.364957] ahci 0000:00:1f.2: version 3.0
> [    5.375809] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3c impl SATA mode
> [    5.375924] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part ems apst
> [    5.383029] scsi host0: ahci
> [    5.383321] scsi host1: ahci
> [    5.383603] scsi host2: ahci
> [    5.383846] scsi host3: ahci
> [    5.384062] scsi host4: ahci
> [    5.384271] scsi host5: ahci
> [    5.384431] ata1: DUMMY
> [    5.384501] ata2: DUMMY
> [    5.384570] ata3: SATA max UDMA/133 abar m2048@0xf7d26000 port 0xf7d26200 irq 26
> [    5.384673] ata4: SATA max UDMA/133 abar m2048@0xf7d26000 port 0xf7d26280 irq 26
> [    5.384797] ata5: SATA max UDMA/133 abar m2048@0xf7d26000 port 0xf7d26300 irq 26
> [    5.384899] ata6: SATA max UDMA/133 abar m2048@0xf7d26000 port 0xf7d26380 irq 26
> [    5.385178] ahci 0000:04:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
> [    5.385284] ahci 0000:04:00.0: flags: 64bit ncq pm led clo pmp pio slum part
> [    5.385811] scsi host6: ahci
> [    5.386039] scsi host7: ahci
> [    5.386210] ata7: SATA max UDMA/133 abar m512@0xf7b10000 port 0xf7b10100 irq 19
> [    5.386316] ata8: SATA max UDMA/133 abar m512@0xf7b10000 port 0xf7b10180 irq 19
> [    5.386600] ahci 0000:08:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> [    5.386718] ahci 0000:08:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs
> [    5.387274] scsi host8: ahci
> [    5.387489] scsi host9: ahci
> [    5.387651] ata9: SATA max UDMA/133 abar m512@0xf7810000 port 0xf7810100 irq 27
> [    5.387782] ata10: SATA max UDMA/133 abar m512@0xf7810000 port 0xf7810180 irq 27
> [    5.388725] VFIO - User Level meta-driver version: 0.3
> [    5.388923] random: random_reseed() reseeds=2 pool0_len=318
> [    5.389155] i8042: PNP: No PS/2 controller found. Probing ports directly.
> [    5.391596] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    5.391681] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    5.391897] mousedev: PS/2 mouse device common for all mice
> [    5.392354] md: linear personality registered for level -1
> [    5.392437] md: raid0 personality registered for level 0
> [    5.392512] md: raid1 personality registered for level 1
> [    5.392585] md: raid10 personality registered for level 10
> [    5.392757] md: raid6 personality registered for level 6
> [    5.392835] md: raid5 personality registered for level 5
> [    5.392907] md: raid4 personality registered for level 4
> [    5.393215] device-mapper: ioctl: 4.30.0-ioctl (2014-12-22) initialised: dm-devel@redhat.com
> [    5.393568] AMD64 EDAC driver v3.4.0
> [    5.393713] Intel P-state driver initializing.
> [    5.393999] hidraw: raw HID events driver (C) Jiri Kosina
> [    5.394383] GACT probability on
> [    5.394456] Mirror/redirect action on
> [    5.394586] TCP: bic registered
> [    5.394656] Initializing XFRM netlink socket
> [    5.395045] NET: Registered protocol family 10
> [    5.395415] sit: IPv6 over IPv4 tunneling driver
> [    5.395660] NET: Registered protocol family 17
> [    5.395790] Key type dns_resolver registered
> [    5.395867] Key type ceph registered
> [    5.396024] libceph: loaded (mon/osd proto 15/24)
> [    5.397342] registered taskstats version 1
> [    5.398056] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> [    5.398341] random: random_int_secret_init
> [    5.689500] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    5.689641] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    5.689772] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    5.689902] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    5.690371] ACPI Error: [DSSP]
> [    5.690502] ata7: SATA link down (SStatus 0 SControl 300)
> [    5.690580] ata8: SATA link down (SStatus 0 SControl 300)
> [    5.690761]  Namespace lookup failure, AE_NOT_FOUND
> [    5.690869]  (20150204/psargs-359)
> [    5.690937] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [    5.691285] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [    5.691529] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [    5.691847] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [    5.692071] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT4._GTF] (Node ffff88040dcba708), AE_NOT_FOUND (20150204/psparse-536)
> [    5.692396] ACPI Error: [DSSP]
> [    5.692533] ata9: SATA link down (SStatus 0 SControl 300)
> [    5.692686]  Namespace lookup failure, AE_NOT_FOUND
> [    5.692794]  (20150204/psargs-359)
> [    5.692862] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT5._GTF] (Node ffff88040dcba780), AE_NOT_FOUND (20150204/psparse-536)
> [    5.693124] ata6.00: ATAPI: TSSTcorp CDDVDW SH-S223C, SB01, max UDMA/100
> [    5.693273] ata3.00: ATA-8: WDC WD6401AALS-00E8B0, 05.00K05, max UDMA/133
> [    5.693359] ata3.00: 1250263728 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
> [    5.693494] ata4.00: ATA-8: WDC WD6401AALS-00E8B0, 05.00K05, max UDMA/133
> [    5.693586] ata4.00: 1250263728 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
> [    5.694566] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [    5.694784] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [    5.695337] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [    5.695573] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [    5.695914] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [    5.696138] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT5._GTF] (Node ffff88040dcba780), AE_NOT_FOUND (20150204/psparse-536)
> [    5.696402] ata6.00: configured for UDMA/100
> [    5.696552] ata3.00: configured for UDMA/133
> [    5.696834] ata4.00: configured for UDMA/133
> [    5.696870] scsi 2:0:0:0: Direct-Access     ATA      WDC WD6401AALS-0 0K05 PQ: 0 ANSI: 5
> [    5.697395] sd 2:0:0:0: [sda] 1250263728 512-byte logical blocks: (640 GB/596 GiB)
> [    5.697469] sd 2:0:0:0: Attached scsi generic sg0 type 0
> [    5.697853] scsi 3:0:0:0: Direct-Access     ATA      WDC WD6401AALS-0 0K05 PQ: 0 ANSI: 5
> [    5.697892] sd 2:0:0:0: [sda] Write Protect is off
> [    5.697893] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    5.698014] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    5.698468] sd 3:0:0:0: [sdb] 1250263728 512-byte logical blocks: (640 GB/596 GiB)
> [    5.698543] sd 3:0:0:0: Attached scsi generic sg1 type 0
> [    5.698762] sd 3:0:0:0: [sdb] Write Protect is off
> [    5.698836] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    5.698885] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    5.733318]  sdb: sdb1
> [    5.734059] sd 3:0:0:0: [sdb] Attached SCSI disk
> [    5.734961]  sda: sda1
> [    5.735627] sd 2:0:0:0: [sda] Attached SCSI disk
> [    5.738973] ata5.00: ATA-7: ST3320620AS, 3.AAE, max UDMA/133
> [    5.739048] ata5.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
> [    5.764482] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [    5.764700] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT4._GTF] (Node ffff88040dcba708), AE_NOT_FOUND (20150204/psparse-536)
> [    5.797258] ata5.00: configured for UDMA/133
> [    5.797535] scsi 4:0:0:0: Direct-Access     ATA      ST3320620AS      E    PQ: 0 ANSI: 5
> [    5.798120] sd 4:0:0:0: Attached scsi generic sg2 type 0
> [    5.798122] sd 4:0:0:0: [sdc] 625142448 512-byte logical blocks: (320 GB/298 GiB)
> [    5.798219] sd 4:0:0:0: [sdc] Write Protect is off
> [    5.798221] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    5.798257] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    5.801013] scsi 5:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S223C  SB01 PQ: 0 ANSI: 5
> [    5.827193] sr 5:0:0:0: [sr0] scsi3-mmc drive: 52x/52x writer dvd-ram cd/rw xa/form2 cdda tray
> [    5.827322] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    5.827617] sr 5:0:0:0: Attached scsi CD-ROM sr0
> [    5.827764] sr 5:0:0:0: Attached scsi generic sg3 type 5
> [    5.847358] ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    5.848123] ata10.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133
> [    5.848200] ata10.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
> [    5.849052] ata10.00: configured for UDMA/133
> [    5.849330] scsi 9:0:0:0: Direct-Access     ATA      WDC WD30EFRX-68E 0A80 PQ: 0 ANSI: 5
> [    5.849848] sd 9:0:0:0: [sdd] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
> [    5.849977] sd 9:0:0:0: [sdd] 4096-byte physical blocks
> [    5.850076] sd 9:0:0:0: Attached scsi generic sg4 type 0
> [    5.850258] sd 9:0:0:0: [sdd] Write Protect is off
> [    5.850375] sd 9:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [    5.850447] sd 9:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    5.857686]  sdc: sdc1
> [    5.858130] sd 4:0:0:0: [sdc] Attached SCSI disk
> [    5.895116]  sdd: sdd1 sdd2 sdd3 sdd4
> [    5.896087] sd 9:0:0:0: [sdd] Attached SCSI disk
> [    5.896854] Freeing unused kernel memory: 3232K (ffffffff82138000 - ffffffff82460000)
> [    5.896958] Write protecting the kernel read-only data: 16384k
> [    5.897666] Freeing unused kernel memory: 928K (ffff880001918000 - ffff880001a00000)
> [    5.898304] Freeing unused kernel memory: 1980K (ffff880001e11000 - ffff880002000000)
> [    5.900919] systemd[1]: Inserted module 'autofs4'
> [    5.902387] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
> [    5.902750] systemd[1]: Detected architecture x86-64.
> [    5.902824] systemd[1]: Running in initial RAM disk.
> [    5.903354] systemd[1]: No hostname configured.
> [    5.903434] systemd[1]: Set hostname to <localhost>.
> [    5.903530] systemd[1]: Initializing machine ID from random generator.
> [    5.932581] systemd[1]: Reached target Timers.
> [    5.932659] systemd[1]: Starting Timers.
> [    5.933054] systemd[1]: Reached target Local File Systems.
> [    5.933132] systemd[1]: Starting Local File Systems.
> [    5.933547] systemd[1]: Reached target Swap.
> [    5.933622] systemd[1]: Starting Swap.
> [    5.934291] systemd[1]: Created slice -.slice.
> [    5.934368] systemd[1]: Starting -.slice.
> [    5.934802] systemd[1]: Listening on Journal Socket (/dev/log).
> [    5.934881] systemd[1]: Starting Journal Socket (/dev/log).
> [    5.935338] systemd[1]: Listening on udev Control Socket.
> [    5.935415] systemd[1]: Starting udev Control Socket.
> [    5.935837] systemd[1]: Listening on Journal Socket.
> [    5.935915] systemd[1]: Starting Journal Socket.
> [    5.936357] systemd[1]: Listening on udev Kernel Socket.
> [    5.936435] systemd[1]: Starting udev Kernel Socket.
> [    5.936841] systemd[1]: Listening on Journal Audit Socket.
> [    5.936917] systemd[1]: Starting Journal Audit Socket.
> [    5.937369] systemd[1]: Reached target Sockets.
> [    5.937445] systemd[1]: Starting Sockets.
> [    5.937935] systemd[1]: Created slice System Slice.
> [    5.938012] systemd[1]: Starting System Slice.
> [    5.938600] systemd[1]: Starting Create list of required static device nodes for the current kernel...
> [    5.939416] systemd[1]: Starting Setup Virtual Console...
> [    5.940237] systemd[1]: Created slice system-systemd\x2dfsck.slice.
> [    5.940319] systemd[1]: Starting system-systemd\x2dfsck.slice.
> [    5.940412] systemd[1]: Started Device-Mapper Multipath Device Controller.
> [    5.940990] systemd[1]: Starting Journal Service...
> [    5.941622] systemd[1]: Reached target Slices.
> [    5.941702] systemd[1]: Starting Slices.
> [    5.941812] systemd[1]: Started dracut ask for additional cmdline parameters.
> [    5.942493] systemd[1]: Starting Load Kernel Modules...
> [    5.945724] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice.
> [    5.945800] systemd[1]: Starting system-systemd\x2dcryptsetup.slice.
> [    5.946502] systemd[1]: Starting dracut cmdline hook...
> [    5.947807] systemd[1]: Started Create list of required static device nodes for the current kernel.
> [    5.947947] audit: type=1130 audit(1435074995.730:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    5.949471] systemd[1]: Starting Create Static Device Nodes in /dev...
> [    5.954421] systemd[1]: Started Setup Virtual Console.
> [    5.954505] audit: type=1130 audit(1435074995.737:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    5.955299] systemd[1]: Started Create Static Device Nodes in /dev.
> [    5.955369] audit: type=1130 audit(1435074995.738:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    5.980332] systemd[1]: Started Journal Service.
> [    5.980434] audit: type=1130 audit(1435074995.763:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.047786] audit: type=1130 audit(1435074995.830:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.054335] audit: type=1130 audit(1435074995.837:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
> [    6.059105] audit: type=1130 audit(1435074995.842:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.064687] RPC: Registered named UNIX socket transport module.
> [    6.064776] RPC: Registered udp transport module.
> [    6.064848] RPC: Registered tcp transport module.
> [    6.064919] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    6.102093] audit: type=1130 audit(1435074995.885:9): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.107153] audit: type=1130 audit(1435074995.890:10): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    6.183795] random: random_reseed() reseeds=3 pool0_len=270
> [    6.205035] Switched to clocksource tsc
> [    6.251308] wmi: Mapper loaded
> [    6.272436] ACPI: bus type USB registered
> [    6.275043] pps_core: LinuxPPS API ver. 1 registered
> [    6.275123] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    6.275322] usbcore: registered new interface driver usbfs
> [    6.275492] usbcore: registered new interface driver hub
> [    6.275603] usbcore: registered new device driver usb
> [    6.277297] xhci_hcd 0000:03:00.0: xHCI Host Controller
> [    6.277405] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
> [    6.278088] [drm] Memory usable by graphics device = 2048M
> [    6.278265] [drm] Replacing VGA console driver
> [    6.280866] Console: switching to colour dummy device 80x25
> [    6.281767] PTP clock support registered
> [    6.283623] firewire_ohci: Unknown symbol fw_card_add (err 0)
> [    6.283631] firewire_ohci: Unknown symbol fw_core_handle_request (err 0)
> [    6.283640] firewire_ohci: Unknown symbol fw_core_remove_card (err 0)
> [    6.283653] firewire_ohci: Unknown symbol fw_core_handle_response (err 0)
> [    6.283658] firewire_ohci: Unknown symbol fw_fill_response (err 0)
> [    6.283663] firewire_ohci: Unknown symbol fw_schedule_bus_reset (err 0)
> [    6.283668] firewire_ohci: Unknown symbol fw_card_initialize (err 0)
> [    6.283678] firewire_ohci: Unknown symbol fw_core_handle_bus_reset (err 0)
> [    6.283854] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
> [    6.283866] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
> [    6.291988] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    6.291993] [drm] Driver supports precise vblank timestamp query.
> [    6.292161] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [    6.338644] xhci_hcd 0000:03:00.0: hcc params 0x0200f180 hci version 0x96 quirks 0x00080000
> [    6.338939] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [    6.338944] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    6.338945] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    6.338946] usb usb1: Product: xHCI Host Controller
> [    6.338947] usb usb1: Manufacturer: Linux 4.0.6+ xhci-hcd
> [    6.338948] usb usb1: SerialNumber: 0000:03:00.0
> [    6.339540] hub 1-0:1.0: USB hub found
> [    6.339571] hub 1-0:1.0: 2 ports detected
> [    6.339592] acpi device:62: registered as cooling_device9
> [    6.339729] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input5
> [    6.340590] random: random_reseed() reseeds=4 pool0_len=261
> [    6.340698] [drm] Initialized i915 1.6.0 20150130 for 0000:00:02.0 on minor 0
> [    6.340943] xhci_hcd 0000:03:00.0: xHCI Host Controller
> [    6.340952] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 2
> [    6.341034] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
> [    6.341039] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    6.341044] usb usb2: Product: xHCI Host Controller
> [    6.341047] usb usb2: Manufacturer: Linux 4.0.6+ xhci-hcd
> [    6.341050] usb usb2: SerialNumber: 0000:03:00.0
> [    6.341321] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [    6.341364] hub 2-0:1.0: USB hub found
> [    6.341380] hub 2-0:1.0: 2 ports detected
> [    6.341634] xhci_hcd 0000:05:00.0: xHCI Host Controller
> [    6.341643] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 3
> [    6.343745] fbcon: inteldrmfb (fb0) is primary device
> [    6.345039] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    6.345243] ehci-pci: EHCI PCI platform driver
> [    6.371434] Console: switching to colour frame buffer device 240x75
> [    6.375408] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
> [    6.375410] i915 0000:00:02.0: registered panic notifier
> [    6.402741] xhci_hcd 0000:05:00.0: hcc params 0x0200f180 hci version 0x96 quirks 0x00080000
> [    6.403017] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
> [    6.403029] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    6.403042] usb usb3: Product: xHCI Host Controller
> [    6.403050] usb usb3: Manufacturer: Linux 4.0.6+ xhci-hcd
> [    6.403060] usb usb3: SerialNumber: 0000:05:00.0
> [    6.403273] hub 3-0:1.0: USB hub found
> [    6.403298] hub 3-0:1.0: 2 ports detected
> [    6.403492] xhci_hcd 0000:05:00.0: xHCI Host Controller
> [    6.403508] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 4
> [    6.403589] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
> [    6.403601] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    6.403613] usb usb4: Product: xHCI Host Controller
> [    6.403621] usb usb4: Manufacturer: Linux 4.0.6+ xhci-hcd
> [    6.403631] usb usb4: SerialNumber: 0000:05:00.0
> [    6.403912] hub 4-0:1.0: USB hub found
> [    6.403933] hub 4-0:1.0: 2 ports detected
> [    6.607176] e1000e 0000:00:19.0 eth0: registered PHC clock
> [    6.607189] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 54:04:a6:3c:ae:df
> [    6.607201] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
> [    6.607265] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: FFFFFF-0FF
> [    6.607577] ehci-pci 0000:00:1a.0: EHCI Host Controller
> [    6.607597] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 5
> [    6.607626] ehci-pci 0000:00:1a.0: debug port 2
> [    6.609010] e1000e 0000:00:19.0 eno1: renamed from eth0
> [    6.611587] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
> [    6.611608] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7d28000
> [    6.709371] usb 4-2: new SuperSpeed USB device number 2 using xhci_hcd
> [    6.724049] usb 4-2: New USB device found, idVendor=8564, idProduct=4000
> [    6.724079] usb 4-2: New USB device strings: Mfr=3, Product=4, SerialNumber=5
> [    6.724103] usb 4-2: Product: GL3220
> [    6.724121] usb 4-2: Manufacturer: Genesys
> [    6.724128] usb 4-2: SerialNumber: 000001272
> [    6.727104] usb-storage 4-2:1.0: USB Mass Storage device detected
> [    6.727230] usb-storage 4-2:1.0: Quirks match for vid 8564 pid 4000: 4000
> [    6.727268] scsi host10: usb-storage 4-2:1.0
> [    6.727404] usbcore: registered new interface driver usb-storage
> [    6.727858] usbcore: registered new interface driver uas
> [    6.755524] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [    6.761486] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> [    6.761884] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
> [    6.761896] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    6.761908] usb usb5: Product: EHCI Host Controller
> [    6.761916] usb usb5: Manufacturer: Linux 4.0.6+ ehci_hcd
> [    6.761925] usb usb5: SerialNumber: 0000:00:1a.0
> [    6.762224] hub 5-0:1.0: USB hub found
> [    6.762250] hub 5-0:1.0: 2 ports detected
> [    6.762903] ehci-pci 0000:00:1d.0: EHCI Host Controller
> [    6.762921] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 6
> [    6.762946] ehci-pci 0000:00:1d.0: debug port 2
> [    6.766858] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
> [    6.766884] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7d27000
> [    6.920305] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> [    6.920421] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
> [    6.920433] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    6.920444] usb usb6: Product: EHCI Host Controller
> [    6.920452] usb usb6: Manufacturer: Linux 4.0.6+ ehci_hcd
> [    6.920461] usb usb6: SerialNumber: 0000:00:1d.0
> [    6.920764] hub 6-0:1.0: USB hub found
> [    6.920782] hub 6-0:1.0: 2 ports detected
> [    6.932282] usb 3-1: New USB device found, idVendor=12d1, idProduct=157d
> [    6.932298] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    6.932310] usb 3-1: Product: HUAWEI_MOBILE
> [    6.932318] usb 3-1: Manufacturer: HUAWEI_MOBILE
> [    6.932326] usb 3-1: SerialNumber: 0123456789ABCDEF
> [    6.958933] usb-storage 3-1:1.0: USB Mass Storage device detected
> [    6.959121] scsi host11: usb-storage 3-1:1.0
> [    7.065218] usb 5-1: new high-speed USB device number 2 using ehci-pci
> [    7.179885] usb 5-1: New USB device found, idVendor=8087, idProduct=0024
> [    7.179898] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    7.180327] hub 5-1:1.0: USB hub found
> [    7.180408] hub 5-1:1.0: 6 ports detected
> [    7.222072] usb 6-1: new high-speed USB device number 2 using ehci-pci
> [    7.336738] usb 6-1: New USB device found, idVendor=8087, idProduct=0024
> [    7.336751] usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    7.337095] hub 6-1:1.0: USB hub found
> [    7.337252] hub 6-1:1.0: 8 ports detected
> [    7.613799] usb 6-1.1: new full-speed USB device number 3 using ehci-pci
> [    7.701418] usb 6-1.1: New USB device found, idVendor=04d9, idProduct=fa50
> [    7.701432] usb 6-1.1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [    7.701443] usb 6-1.1: Product: USB Laser Game Mouse
> [    7.709141] input: USB Laser Game Mouse as /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1.1/6-1.1:1.0/0003:04D9:FA50.0001/input/input6
> [    7.709372] hid-generic 0003:04D9:FA50.0001: input,hidraw0: USB HID v1.10 Mouse [USB Laser Game Mouse] on usb-0000:00:1d.0-1.1/input0
> [    7.713168] input: USB Laser Game Mouse as /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1.1/6-1.1:1.1/0003:04D9:FA50.0002/input/input7
> [    7.728573] scsi 10:0:0:0: Direct-Access     Generic  STORAGE DEVICE   TS07 PQ: 0 ANSI: 0
> [    7.729093] scsi 10:0:0:1: Direct-Access     Generic  STORAGE DEVICE   TS07 PQ: 0 ANSI: 0
> [    7.729675] scsi 10:0:0:2: Direct-Access     Generic  STORAGE DEVICE   TS07 PQ: 0 ANSI: 0
> [    7.730289] sd 10:0:0:0: Attached scsi generic sg5 type 0
> [    7.731573] sd 10:0:0:0: [sde] Attached SCSI removable disk
> [    7.732634] sd 10:0:0:1: Attached scsi generic sg6 type 0
> [    7.735820] sd 10:0:0:1: [sdf] Attached SCSI removable disk
> [    7.737893] sd 10:0:0:2: [sdg] Attached SCSI removable disk
> [    7.738531] sd 10:0:0:2: Attached scsi generic sg7 type 0
> [    7.763868] hid-generic 0003:04D9:FA50.0002: input,hidraw1: USB HID v1.10 Keyboard [USB Laser Game Mouse] on usb-0000:00:1d.0-1.1/input1
> [    7.775631] usb 6-1.2: new low-speed USB device number 4 using ehci-pci
> [    7.883094] usb 6-1.2: New USB device found, idVendor=04d9, idProduct=1818
> [    7.883108] usb 6-1.2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [    7.883119] usb 6-1.2: Product: USB Keyboard
> [    7.893956] input: USB Keyboard as /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1.2/6-1.2:1.0/0003:04D9:1818.0004/input/input8
> [    7.944623] hid-generic 0003:04D9:1818.0004: input,hidraw2: USB HID v1.10 Keyboard [USB Keyboard] on usb-0000:00:1d.0-1.2/input0
> [    7.961986] scsi 11:0:0:0: CD-ROM            HUAWEI   Mass Storage     2.31 PQ: 0 ANSI: 2
> [    7.962360] scsi 11:0:0:1: Direct-Access     HUAWEI   TF CARD Storage  2.31 PQ: 0 ANSI: 2
> [    7.963613] sr 11:0:0:0: [sr1] scsi-1 drive
> [    7.963978] sr 11:0:0:0: Attached scsi CD-ROM sr1
> [    7.964115] sr 11:0:0:0: Attached scsi generic sg8 type 5
> [    7.966197] sd 11:0:0:1: Attached scsi generic sg9 type 0
> [    7.969435] input: USB Keyboard as /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1.2/6-1.2:1.1/0003:04D9:1818.0005/input/input9
> [    7.972569] sd 11:0:0:1: [sdh] Attached SCSI removable disk
> [    8.020526] hid-generic 0003:04D9:1818.0005: input,hidraw3: USB HID v1.10 Device [USB Keyboard] on usb-0000:00:1d.0-1.2/input1
> [    8.093364] usb 6-1.4: new high-speed USB device number 5 using ehci-pci
> [    8.178522] usb 6-1.4: New USB device found, idVendor=0409, idProduct=005a
> [    8.178535] usb 6-1.4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    8.178925] hub 6-1.4:1.0: USB hub found
> [    8.179073] hub 6-1.4:1.0: 4 ports detected
> [    8.253217] usb 6-1.6: new high-speed USB device number 6 using ehci-pci
> [    8.355397] usb 6-1.6: New USB device found, idVendor=0bda, idProduct=2838
> [    8.355410] usb 6-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    8.355421] usb 6-1.6: Product: RTL2838UHIDIR
> [    8.355428] usb 6-1.6: Manufacturer: Realtek
> [    8.355435] usb 6-1.6: SerialNumber: 00000001
> [    8.437037] usb 6-1.7: new full-speed USB device number 7 using ehci-pci
> [    8.523987] usb 6-1.7: New USB device found, idVendor=0cf3, idProduct=3000
> [    8.525036] usb 6-1.7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [   13.593428] input: USB Laser Game Mouse as /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1.1/6-1.1:1.2/0003:04D9:FA50.0003/input/input10
> [   13.645532] hid-generic 0003:04D9:FA50.0003: input,hiddev0,hidraw4: USB HID v1.10 Device [USB Laser Game Mouse] on usb-0000:00:1d.0-1.1/input2
> [   13.646748] usbcore: registered new interface driver usbhid
> [   13.647930] usbhid: USB HID core driver
> [   46.225306] random: random_reseed() reseeds=5 pool0_len=582
> [   71.716746] NET: Registered protocol family 38
> [   72.198371] audit_printk_skb: 9 callbacks suppressed
> [   72.199587] audit: type=1130 audit(1435075062.043:14): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-cryptsetup@luks\x2dbea602e1\x2dd47d\x2d4d88\x2da16a\x2d1b06543077eb comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   72.203746] audit: type=1130 audit(1435075062.048:15): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   72.223833] audit: type=1130 audit(1435075062.069:16): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-pre-mount comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   72.230453] audit: type=1130 audit(1435075062.075:17): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck@dev-mapper-luks\x2dbea602e1\x2dd47d\x2d4d88\x2da16a\x2d1b06543077eb comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   72.236803] XFS (dm-0): Mounting V4 Filesystem
> [   72.368162] XFS (dm-0): Ending clean mount
> [   72.501681] audit: type=1130 audit(1435075062.347:18): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   72.503024] audit: type=1131 audit(1435075062.348:19): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   72.728488] audit: type=1130 audit(1435075062.574:20): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-pre-pivot comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   72.741991] audit: type=1130 audit(1435075062.587:21): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-ask-password-console comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   72.743445] audit: type=1131 audit(1435075062.589:22): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-ask-password-console comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   72.746728] audit: type=1130 audit(1435075062.592:23): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=initrd-cleanup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   72.927418] systemd-journald[1372]: Received SIGTERM from PID 1 (systemd).
> [   74.240234] ip_tables: (C) 2000-2006 Netfilter Core Team
> [   74.241545] systemd[1]: Inserted module 'ip_tables'
> [   77.837006] systemd-sysv-generator[2857]: Configuration file /usr/lib/systemd/system/3proxy.service is marked executable. Please remove executable permission bits. Proceeding anyway.
> [   78.376527] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/grsec.txt.service with real service
> [   78.377841] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/mysql-proxy.service with real service
> [   78.379089] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/tux.bak.service with real service
> [   78.380388] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/xttpd.service with real service
> [   78.381668] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/globus-gridftp-sshftp.service with real service
> [   78.382914] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/globus-gatekeeper.service with real service
> [   78.384222] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb-2.6.27.service with real service
> [   78.385499] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb.localnet.service with real service
> [   78.386794] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb-nohyst.service with real service
> [   78.388071] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/monotone.service with real service
> [   78.389360] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb-2.6.25.service with real service
> [   78.390636] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/smsd.service with real service
> [   78.391907] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/perlbal.service with real service
> [   78.393182] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/voms.service with real service
> [   78.394440] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/qmail.bak.service with real service
> [   78.395701] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/grsec.service with real service
> [   78.396941] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/opentracker-ipv6.service with real service
> [   78.398205] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/shmpps.service with real service
> [   78.399451] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb-100Mbps.service with real service
> [   78.400698] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb.init.service with real service
> [   78.401960] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb.service with real service
> [   78.403207] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb-ctconn.service with real service
> [   78.404467] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/mdns.service with real service
> [   78.405716] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb.sauna.service with real service
> [   78.406977] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/isicom.service with real service
> [   78.408226] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/tbf.service with real service
> [   78.409454] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/netconsole.service with real service
> [   78.410696] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb.ipy.service with real service
> [   78.411923] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/alsasound.service with real service
> [   78.413162] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/ceph-radosgw.service with real service
> [   78.414380] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/cbq.service with real service
> [   78.415591] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/alsa.service with real service
> [   78.416876] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/sysklogd.service with real service
> [   78.418118] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb.dns.service with real service
> [   78.419334] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/spawn-fcgi.service with real service
> [   78.420534] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/hfsc.service with real service
> [   78.421733] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb-safarisfq.service with real service
> [   78.422938] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb.20120530.service with real service
> [   78.424127] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/gearmand.service with real service
> [   78.425318] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb-simple.service with real service
> [   78.426485] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/powerman.service with real service
> [   78.427654] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/bayonne.service with real service
> [   78.428838] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/systemtap.service with real service
> [   78.430028] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/dpm-gsiftp.service with real service
> [   78.431209] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/rootd.service with real service
> [   78.432373] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/fcron.service with real service
> [   78.433530] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/ntpd.orig.service with real service
> [   78.434707] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/fcron_watch_config.service with real service
> [   78.435865] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/dahdi.service with real service
> [   78.437041] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb.codel.ok.service with real service
> [   78.438201] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/squid.service with real service
> [   78.439374] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/qmail.service with real service
> [   78.440542] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/opentracker-ipv4.service with real service
> [   78.441694] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb.512kbps.service with real service
> [   78.442846] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/globus-gridftp-server.service with real service
> [   78.444005] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/network.service with real service
> [   78.445161] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/rbdmap.service with real service
> [   78.446308] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/pcmcia.N.service with real service
> [   78.447436] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/i8k.service with real service
> [   78.448560] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/ntpd.bak.service with real service
> [   78.449696] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/globus-scheduler-event-generator.service with real service
> [   78.450820] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/djb.service with real service
> [   78.451959] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/ceph.service with real service
> [   78.453063] systemd-sysv-generator[2857]: Overwriting existing symlink /run/systemd/generator.late/htb-stop.service with real service
> [   79.988792] audit_printk_skb: 78 callbacks suppressed
> [   79.989860] audit: type=1130 audit(1435075069.841:50): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   79.990978] audit: type=1131 audit(1435075069.844:51): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   79.993646] audit: type=1130 audit(1435075069.846:52): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=initrd-switch-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   79.994777] audit: type=1131 audit(1435075069.847:53): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=initrd-switch-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   80.281176] audit: type=1130 audit(1435075070.133:54): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   80.282293] audit: type=1131 audit(1435075070.135:55): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   80.513171] audit: type=1130 audit(1435075070.366:56): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck@dev-mapper-luks\x2dbea602e1\x2dd47d\x2d4d88\x2da16a\x2d1b06543077eb comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   80.515381] audit: type=1131 audit(1435075070.369:57): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck@dev-mapper-luks\x2dbea602e1\x2dd47d\x2d4d88\x2da16a\x2d1b06543077eb comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   80.521379] audit: type=1130 audit(1435075070.374:58): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-cryptsetup@luks\x2dbea602e1\x2dd47d\x2d4d88\x2da16a\x2d1b06543077eb comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   80.523606] audit: type=1131 audit(1435075070.377:59): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-cryptsetup@luks\x2dbea602e1\x2dd47d\x2d4d88\x2da16a\x2d1b06543077eb comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   82.850087] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [   87.862480] audit_printk_skb: 33 callbacks suppressed
> [   87.863677] audit: type=1130 audit(1435075077.722:71): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   88.104711] audit: type=1130 audit(1435075077.964:72): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   88.268401] audit: type=1130 audit(1435075078.128:73): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
> [   88.636982] systemd-journald[2874]: Received request to flush runtime journal from PID 1
> [   90.075220] usb 6-1.4.1: new high-speed USB device number 8 using ehci-pci
> [   90.162790] usb 6-1.4.1: New USB device found, idVendor=18d1, idProduct=4ee7
> [   90.164086] usb 6-1.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   90.165359] usb 6-1.4.1: Product: XT1068
> [   90.166652] usb 6-1.4.1: Manufacturer: motorola
> [   90.167936] usb 6-1.4.1: SerialNumber: ZX1D22GKJS
> [   90.655048] audit: type=1130 audit(1435075080.517:74): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journal-flush comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   90.893180] TCP: cubic registered
> [   92.049020] audit: type=1130 audit(1435075081.912:75): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   96.687602] audit: type=1130 audit(1435075086.555:76): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   96.970308] rtc_cmos 00:02: RTC can wake from S4
> [   96.970568] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
> [   96.970607] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
> [   97.130673] audit: type=1130 audit(1435075086.999:77): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-backlight@backlight:acpi_video0 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   97.369520] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042F conflicts with OpRegion 0x0000000000000400-0x000000000000047F (\PMIO) (20150204/utaddress-254)
> [   97.369525] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   97.369529] ACPI Warning: SystemIO range 0x0000000000000540-0x000000000000054F conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\GPIO) (20150204/utaddress-254)
> [   97.369532] ACPI Warning: SystemIO range 0x0000000000000540-0x000000000000054F conflicts with OpRegion 0x0000000000000500-0x000000000000057F (\_SB_.PCI0.LPCB.GPBX) (20150204/utaddress-254)
> [   97.369534] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   97.369535] ACPI Warning: SystemIO range 0x0000000000000530-0x000000000000053F conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\GPIO) (20150204/utaddress-254)
> [   97.369537] ACPI Warning: SystemIO range 0x0000000000000530-0x000000000000053F conflicts with OpRegion 0x0000000000000500-0x000000000000057F (\_SB_.PCI0.LPCB.GPBX) (20150204/utaddress-254)
> [   97.369540] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   97.369541] ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052F conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\GPIO) (20150204/utaddress-254)
> [   97.369543] ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052F conflicts with OpRegion 0x0000000000000500-0x000000000000057F (\_SB_.PCI0.LPCB.GPBX) (20150204/utaddress-254)
> [   97.369545] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   97.369546] lpc_ich: Resource conflict(s) found affecting gpio_ich
> [   97.450825] ACPI Warning: SystemIO range 0x000000000000F040-0x000000000000F05F conflicts with OpRegion 0x000000000000F040-0x000000000000F04F (\_SB_.PCI0.SBUS.SMBI) (20150204/utaddress-254)
> [   97.450831] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   98.042173] input: PC Speaker as /devices/platform/pcspkr/input/input11
> [   99.923524] sr 11:0:0:0: [sr1] FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [   99.923528] sr 11:0:0:0: [sr1] Sense Key : Medium Error [current]
> [   99.923530] sr 11:0:0:0: [sr1] Add. Sense: Unrecovered read error
> [   99.923533] sr 11:0:0:0: [sr1] CDB: Read(10) 28 00 00 00 0f fe 00 00 02 00
> [   99.923545] blk_update_request: critical medium error, dev sr1, sector 16376
> [   99.928483] sr 11:0:0:0: [sr1] FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [   99.928488] sr 11:0:0:0: [sr1] Sense Key : Medium Error [current]
> [   99.928491] sr 11:0:0:0: [sr1] Add. Sense: Unrecovered read error
> [   99.928502] sr 11:0:0:0: [sr1] CDB: Read(10) 28 00 00 00 0f fe 00 00 02 00
> [   99.928503] blk_update_request: critical medium error, dev sr1, sector 16376
> [   99.928516] Buffer I/O error on dev sr1, logical block 2047, async page read
> [  100.460799] XFS (sdc1): Mounting V4 Filesystem
> [  100.684733] XFS (sdc1): Ending clean mount
> [  101.471050] usb 6-1.6: dvb_usb_v2: found a 'Realtek RTL2832U reference design' in warm state
> [  101.518686] iTCO_vendor_support: vendor-support=0
> [  101.528336] usb 6-1.6: dvb_usb_v2: will pass the complete MPEG2 transport stream to the software demuxer
> [  101.528394] DVB: registering new adapter (Realtek RTL2832U reference design)
> [  101.530225] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [  101.530271] iTCO_wdt: Found a Cougar Point TCO device (Version=2, TCOBASE=0x0460)
> [  101.530505] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [  101.755078] sound hdaudioC0D0: autoconfig for ALC892: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
> [  101.755081] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [  101.755082] sound hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> [  101.755083] sound hdaudioC0D0:    mono: mono_out=0x0
> [  101.755084] sound hdaudioC0D0:    dig-out=0x11/0x1e
> [  101.755085] sound hdaudioC0D0:    inputs:
> [  101.755088] sound hdaudioC0D0:      Front Mic=0x19
> [  101.755090] sound hdaudioC0D0:      Rear Mic=0x18
> [  101.755091] sound hdaudioC0D0:      Line=0x1a
> [  101.977908] i2c i2c-9: Added multiplexed i2c bus 10
> [  101.977910] rtl2832 9-0010: Realtek RTL2832 successfully attached
> [  101.977941] usb 6-1.6: DVB: registering adapter 0 frontend 0 (Realtek RTL2832 (DVB-T))...
> [  102.012623] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
> [  102.012850] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
> [  102.012958] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
> [  102.013058] input: HDA Intel PCH Line Out Front as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
> [  102.013155] input: HDA Intel PCH Line Out Surround as /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
> [  102.013251] input: HDA Intel PCH Line Out CLFE as /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
> [  102.013347] input: HDA Intel PCH Line Out Side as /devices/pci0000:00/0000:00:1b.0/sound/card0/input18
> [  102.013444] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input19
> [  102.013541] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input20
> [  102.218472] r820t 10-001a: creating new instance
> [  102.218809] XFS (sdd2): Mounting V4 Filesystem
> [  102.230195] r820t 10-001a: Rafael Micro r820t successfully identified
> [  102.591493] asus_wmi: ASUS WMI generic driver loaded
> [  102.790314] asus_wmi: Initialization: 0x0
> [  102.790349] asus_wmi: BIOS WMI version: 0.9
> [  102.790413] asus_wmi: SFUN value: 0x0
> [  102.790877] input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/input/input21
> [  102.791974] asus_wmi: Disabling ACPI video driver
> [  103.165080] media: Linux media interface: v0.10
> [  103.842528] Linux video capture interface: v2.00
> [  103.909797] Bluetooth: Core ver 2.20
> [  103.909821] NET: Registered protocol family 31
> [  103.909822] Bluetooth: HCI device and connection manager initialized
> [  103.909893] Bluetooth: HCI socket layer initialized
> [  103.909896] Bluetooth: L2CAP socket layer initialized
> [  103.909907] Bluetooth: SCO socket layer initialized
> [  104.024869] rtl2832_sdr rtl2832_sdr.0.auto: Registered as swradio0
> [  104.024872] rtl2832_sdr rtl2832_sdr.0.auto: Realtek RTL2832 SDR attached
> [  104.024873] rtl2832_sdr rtl2832_sdr.0.auto: SDR API is still slightly experimental and functionality changes may follow
> [  104.032043] Registered IR keymap rc-empty
> [  104.032242] input: Realtek RTL2832U reference design as /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1.6/rc/rc0/input22
> [  104.032322] rc0: Realtek RTL2832U reference design as /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1.6/rc/rc0
> [  104.035883] usb 6-1.6: dvb_usb_v2: schedule remote query interval to 400 msecs
> [  104.044055] usb 6-1.6: dvb_usb_v2: 'Realtek RTL2832U reference design' successfully initialized and connected
> [  104.044158] usbcore: registered new interface driver dvb_usb_rtl28xxu
> [  104.208611] IR RC5(x/sz) protocol handler initialized
> [  104.218879] IR NEC protocol handler initialized
> [  104.228405] IR RC6 protocol handler initialized
> [  104.235111] IR JVC protocol handler initialized
> [  104.242074] IR Sony protocol handler initialized
> [  104.254580] IR SANYO protocol handler initialized
> [  104.266595] IR Sharp protocol handler initialized
> [  104.276930] lirc_dev: IR Remote Control driver registered, major 244
> [  104.281895] rc rc0: lirc_dev: driver ir-lirc-codec (dvb_usb_rtl28xxu) registered at minor = 0
> [  104.281897] IR LIRC bridge handler initialized
> [  104.295201] IR XMP protocol handler initialized
> [  104.296554] input: MCE IR Keyboard/Mouse (dvb_usb_rtl28xxu) as /devices/virtual/input/input23
> [  104.296840] IR MCE Keyboard/mouse protocol handler initialized
> [  104.379081] XFS (sdd2): Ending clean mount
> [  104.392698] usbcore: registered new interface driver ath3k
> [  104.468314] usb 6-1.7: USB disconnect, device number 7
> [  104.996929] audit: type=1130 audit(1435075094.872:78): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  104.996964] audit: type=1131 audit(1435075094.873:79): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  105.020478] audit: type=1130 audit(1435075094.896:80): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  105.101990] audit: type=1130 audit(1435075094.978:81): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=fedora-autorelabel-mark comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  105.103808] audit: type=1130 audit(1435075094.979:82): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=nfs-config comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  105.129403] audit: type=1130 audit(1435075095.005:83): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journal-catalog-update comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  105.165376] audit: type=1130 audit(1435075095.041:84): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=fedora-import-state comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  105.667415] usb 6-1.7: new full-speed USB device number 9 using ehci-pci
> [  105.753396] usb 6-1.7: New USB device found, idVendor=0b05, idProduct=179c
> [  105.753402] usb 6-1.7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [  106.112576] audit: type=1130 audit(1435075095.989:85): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  106.234641] usbcore: registered new interface driver btusb
> [  106.376744] audit: type=1130 audit(1435075096.254:86): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  106.376760] audit: type=1131 audit(1435075096.254:87): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  106.760927] usb 3-1: usbfs: interface 0 claimed by usb-storage while 'usb_modeswitch' sets config #2
> [  107.100269] usb-storage 3-1:2.2: USB Mass Storage device detected
> [  107.100481] scsi host12: usb-storage 3-1:2.2
> [  108.104897] scsi 12:0:0:0: Direct-Access     HUAWEI   TF CARD Storage  2.31 PQ: 0 ANSI: 2
> [  108.105620] sd 12:0:0:0: Attached scsi generic sg8 type 0
> [  108.107186] sd 12:0:0:0: [sdh] Attached SCSI removable disk
> [  139.007071] audit_printk_skb: 13 callbacks suppressed
> [  139.007073] audit: type=1130 audit(1435075128.915:92): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=ldconfig comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  139.092268] audit: type=1130 audit(1435075129.000:93): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-update-done comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  139.099888] audit: type=1130 audit(1435075129.008:94): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=alsa-state comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  139.676038] ip6_tables: (C) 2000-2006 Netfilter Core Team
> [  139.798877] audit: type=1325 audit(1435075129.705:95): table=filter family=10 entries=0
> [  139.798955] audit: type=1300 audit(1435075129.705:95): arch=c000003e syscall=313 success=yes exit=0 a0=0 a1=41a2dc a2=0 a3=0 items=0 ppid=4424 pid=4425 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="modprobe" exe="/usr/bin/kmod" key=(null)
> [  139.798963] audit: type=1327 audit(1435075129.705:95): proctitle=2F7362696E2F6D6F6470726F6265002D71002D2D006970367461626C655F66696C746572
> [  140.006735] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
> [  140.682714] audit: type=1325 audit(1435075130.164:96): table=filter family=10 entries=4
> [  140.682743] audit: type=1300 audit(1435075130.164:96): arch=c000003e syscall=54 success=yes exit=0 a0=4 a1=29 a2=40 a3=11beac0 items=0 ppid=4409 pid=4421 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="ip6tables-resto" exe="/usr/sbin/xtables-multi" key=(null)
> [  140.682751] audit: type=1327 audit(1435075130.164:96): proctitle=6970367461626C65732D726573746F7265002F6574632F737973636F6E6669672F6970367461626C6573
> [  141.742196] audit: type=1130 audit(1435075131.652:97): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dbus comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  143.155938] w83627ehf: Found NCT6776F chip at 0x290
> [  143.290711] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [  143.290713] Bluetooth: BNEP filters: protocol multicast
> [  143.290719] Bluetooth: BNEP socket layer initialized
> [  144.097066] audit_printk_skb: 30 callbacks suppressed
> [  144.097067] audit: type=1325 audit(1435075134.009:108): table=filter family=10 entries=0
> [  144.097627] audit: type=1300 audit(1435075134.009:108): arch=c000003e syscall=272 success=yes exit=0 a0=40000000 a1=7ffd57224e50 a2=40000040 a3=7fac34214e00 items=0 ppid=1 pid=4536 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="(ostnamed)" exe="/usr/lib/systemd/systemd" key=(null)
> [  144.097635] audit: type=1327 audit(1435075134.009:108): proctitle="(ostnamed)"
> [  144.099332] audit: type=1130 audit(1435075134.012:109): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=chronyd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  144.100962] audit: type=1130 audit(1435075134.013:110): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lm_sensors comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  144.212222] audit: type=1130 audit(1435075134.125:111): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=console-kit-log-system-start comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  144.319203] audit: type=1130 audit(1435075134.232:112): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=mcelog comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  144.436917] audit: type=1130 audit(1435075134.350:113): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  144.538722] audit: type=1130 audit(1435075134.452:114): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=gssproxy comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  144.952639] audit: type=1130 audit(1435075134.866:115): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=ModemManager comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  146.318409] Process accounting resumed
> [  156.107918] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
> [  156.361770] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
> [  156.364545] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
> [  156.367597] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
> [  163.186207] cfg80211: Calling CRDA to update world regulatory domain
> [  163.380493] cfg80211: World regulatory domain updated:
> [  163.380495] cfg80211:  DFS Master region: unset
> [  163.380496] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
> [  163.380498] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
> [  163.380499] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
> [  163.380500] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A, 2000 mBm), (N/A)
> [  163.380502] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
> [  163.380503] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
> [  163.380504] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A, 2000 mBm), (0 s)
> [  163.380506] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 2000 mBm), (N/A)
> [  163.380507] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/A, 0 mBm), (N/A)
> [  165.052264] ata3.00: configured for UDMA/133
> [  165.052271] ata3: EH complete
> [  165.052551] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [  165.056192] ata4.00: configured for UDMA/133
> [  165.056195] ata4: EH complete
> [  165.056311] sd 3:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [  165.161503] ata5.00: configured for UDMA/133
> [  165.161511] ata5: EH complete
> [  165.161696] sd 4:0:0:0: [sdc] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [  165.384165] ata10.00: configured for UDMA/133
> [  165.384173] ata10: EH complete
> [  165.482110] sd 9:0:0:0: [sdd] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [  165.543200] arp_tables: (C) 2002 David S. Miller
> [  180.982194] Ebtables v2.0 registered
> [  221.910060] fuse init (API version 7.23)
> [  245.146504] Bluetooth: RFCOMM TTY layer initialized
> [  245.146514] Bluetooth: RFCOMM socket layer initialized
> [  245.146521] Bluetooth: RFCOMM ver 1.11
> [  269.176765] XFS (dm-1): Mounting V4 Filesystem
> [  269.340001] XFS (dm-1): Ending clean mount
> [  270.356397] XFS (dm-2): Mounting V4 Filesystem
> [  270.496583] ata4.00: exception Emask 0x60 SAct 0xe000 SErr 0x800 action 0x6 frozen
> [  270.496586] ata4.00: irq_stat 0x20000000, host bus error
> [  270.496587] ata4: SError: { HostInt }
> [  270.496589] ata4.00: failed command: WRITE FPDMA QUEUED
> [  270.496592] ata4.00: cmd 61/40:68:30:9d:43/05:00:25:00:00/40 tag 13 ncq 688128 out
>                         res 40/00:7c:d8:a9:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  270.496594] ata4.00: status: { DRDY }
> [  270.496595] ata4.00: failed command: WRITE FPDMA QUEUED
> [  270.496597] ata4.00: cmd 61/68:70:70:a2:43/07:00:25:00:00/40 tag 14 ncq 970752 out
>                         res 40/00:7c:d8:a9:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  270.496599] ata4.00: status: { DRDY }
> [  270.496600] ata4.00: failed command: WRITE FPDMA QUEUED
> [  270.496602] ata4.00: cmd 61/58:78:d8:a9:43/03:00:25:00:00/40 tag 15 ncq 438272 out
>                         res 40/00:7c:d8:a9:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  270.496604] ata4.00: status: { DRDY }
> [  270.496606] ata4: hard resetting link
> [  270.801290] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  270.801947] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  270.801952] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  270.803172] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  270.803177] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  270.803352] ata4.00: configured for UDMA/133
> [  270.803365] ata4: EH complete
> [  270.818274] ata4.00: exception Emask 0x60 SAct 0xe0000 SErr 0x800 action 0x6 frozen
> [  270.818276] ata4.00: irq_stat 0x20000000, host bus error
> [  270.818278] ata4: SError: { HostInt }
> [  270.818280] ata4.00: failed command: WRITE FPDMA QUEUED
> [  270.818283] ata4.00: cmd 61/58:88:d8:a9:43/03:00:25:00:00/40 tag 17 ncq 438272 out
>                         res 40/00:9c:30:9d:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  270.818284] ata4.00: status: { DRDY }
> [  270.818285] ata4.00: failed command: WRITE FPDMA QUEUED
> [  270.818288] ata4.00: cmd 61/68:90:70:a2:43/07:00:25:00:00/40 tag 18 ncq 970752 out
>                         res 40/00:9c:30:9d:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  270.818289] ata4.00: status: { DRDY }
> [  270.818290] ata4.00: failed command: WRITE FPDMA QUEUED
> [  270.818293] ata4.00: cmd 61/40:98:30:9d:43/05:00:25:00:00/40 tag 19 ncq 688128 out
>                         res 40/00:9c:30:9d:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  270.818294] ata4.00: status: { DRDY }
> [  270.818296] ata4: hard resetting link
> [  271.122988] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  271.123614] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  271.123619] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  271.124481] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  271.124486] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  271.125535] ata4.00: configured for UDMA/133
> [  271.125547] ata4: EH complete
> [  271.140972] ata4.00: exception Emask 0x60 SAct 0x40000003 SErr 0x800 action 0x6 frozen
> [  271.140975] ata4.00: irq_stat 0x20000000, host bus error
> [  271.140977] ata4: SError: { HostInt }
> [  271.140979] ata4.00: failed command: WRITE FPDMA QUEUED
> [  271.140982] ata4.00: cmd 61/68:00:70:a2:43/07:00:25:00:00/40 tag 0 ncq 970752 out
>                         res 40/00:0c:d8:a9:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  271.140983] ata4.00: status: { DRDY }
> [  271.140984] ata4.00: failed command: WRITE FPDMA QUEUED
> [  271.140987] ata4.00: cmd 61/58:08:d8:a9:43/03:00:25:00:00/40 tag 1 ncq 438272 out
>                         res 40/00:0c:d8:a9:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  271.140988] ata4.00: status: { DRDY }
> [  271.140990] ata4.00: failed command: WRITE FPDMA QUEUED
> [  271.140992] ata4.00: cmd 61/40:f0:30:9d:43/05:00:25:00:00/40 tag 30 ncq 688128 out
>                         res 40/00:0c:d8:a9:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  271.140993] ata4.00: status: { DRDY }
> [  271.140996] ata4: hard resetting link
> [  271.445679] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  271.446294] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  271.446298] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  271.447169] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  271.447173] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT3._GTF] (Node ffff88040dcba690), AE_NOT_FOUND (20150204/psparse-536)
> [  271.447343] ata4.00: configured for UDMA/133
> [  271.447356] ata4: EH complete
> [  271.502359] XFS (dm-2): Ending clean mount
> [  271.945311] do_general_protection: 27 callbacks suppressed
> [  271.945314] traps: xfdesktop[5688] general protection ip:4312a8 sp:7fff70b8b670 error:0 in xfdesktop[400000+57000]
> [  276.050009] XFS (dm-1): Mounting V4 Filesystem
> [  276.187200] ata3.00: exception Emask 0x60 SAct 0x3800000 SErr 0x800 action 0x6 frozen
> [  276.187202] ata3.00: irq_stat 0x20000000, host bus error
> [  276.187204] ata3: SError: { HostInt }
> [  276.187206] ata3.00: failed command: WRITE FPDMA QUEUED
> [  276.187209] ata3.00: cmd 61/60:b8:58:db:43/05:00:25:00:00/40 tag 23 ncq 704512 out
>                         res 40/00:cc:b8:e8:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  276.187211] ata3.00: status: { DRDY }
> [  276.187212] ata3.00: failed command: WRITE FPDMA QUEUED
> [  276.187214] ata3.00: cmd 61/00:c0:b8:e0:43/08:00:25:00:00/40 tag 24 ncq 1048576 out
>                         res 40/00:cc:b8:e8:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  276.187216] ata3.00: status: { DRDY }
> [  276.187217] ata3.00: failed command: WRITE FPDMA QUEUED
> [  276.187219] ata3.00: cmd 61/a0:c8:b8:e8:43/02:00:25:00:00/40 tag 25 ncq 344064 out
>                         res 40/00:cc:b8:e8:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  276.187221] ata3.00: status: { DRDY }
> [  276.187224] ata3: hard resetting link
> [  276.491908] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  276.492527] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  276.492531] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  276.493345] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  276.493350] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  276.493525] ata3.00: configured for UDMA/133
> [  276.493538] ata3: EH complete
> [  276.507893] ata3.00: exception Emask 0x60 SAct 0x38000000 SErr 0x800 action 0x6 frozen
> [  276.507895] ata3.00: irq_stat 0x20000000, host bus error
> [  276.507897] ata3: SError: { HostInt }
> [  276.507899] ata3.00: failed command: WRITE FPDMA QUEUED
> [  276.507902] ata3.00: cmd 61/a0:d8:b8:e8:43/02:00:25:00:00/40 tag 27 ncq 344064 out
>                         res 40/00:ec:58:db:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  276.507903] ata3.00: status: { DRDY }
> [  276.507905] ata3.00: failed command: WRITE FPDMA QUEUED
> [  276.507907] ata3.00: cmd 61/00:e0:b8:e0:43/08:00:25:00:00/40 tag 28 ncq 1048576 out
>                         res 40/00:ec:58:db:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  276.507909] ata3.00: status: { DRDY }
> [  276.507910] ata3.00: failed command: WRITE FPDMA QUEUED
> [  276.507912] ata3.00: cmd 61/60:e8:58:db:43/05:00:25:00:00/40 tag 29 ncq 704512 out
>                         res 40/00:ec:58:db:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  276.507913] ata3.00: status: { DRDY }
> [  276.507916] ata3: hard resetting link
> [  276.812604] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  276.813217] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  276.813222] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  276.814045] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  276.814050] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  276.814236] ata3.00: configured for UDMA/133
> [  276.814250] ata3: EH complete
> [  276.826591] ata3.00: exception Emask 0x60 SAct 0xe00 SErr 0x800 action 0x6 frozen
> [  276.826593] ata3.00: irq_stat 0x20000000, host bus error
> [  276.826595] ata3: SError: { HostInt }
> [  276.826596] ata3.00: failed command: WRITE FPDMA QUEUED
> [  276.826599] ata3.00: cmd 61/60:48:58:db:43/05:00:25:00:00/40 tag 9 ncq 704512 out
>                         res 40/00:5c:b8:e8:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  276.826601] ata3.00: status: { DRDY }
> [  276.826602] ata3.00: failed command: WRITE FPDMA QUEUED
> [  276.826605] ata3.00: cmd 61/00:50:b8:e0:43/08:00:25:00:00/40 tag 10 ncq 1048576 out
>                         res 40/00:5c:b8:e8:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  276.826606] ata3.00: status: { DRDY }
> [  276.826607] ata3.00: failed command: WRITE FPDMA QUEUED
> [  276.826610] ata3.00: cmd 61/a0:58:b8:e8:43/02:00:25:00:00/40 tag 11 ncq 344064 out
>                         res 40/00:5c:b8:e8:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  276.826611] ata3.00: status: { DRDY }
> [  276.826613] ata3: hard resetting link
> [  277.131300] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  277.131918] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  277.131922] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  277.132795] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  277.132799] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  277.133652] ata3.00: configured for UDMA/133
> [  277.133665] ata3: EH complete
> [  277.148286] ata3.00: exception Emask 0x60 SAct 0x1c00000 SErr 0x800 action 0x6 frozen
> [  277.148288] ata3.00: irq_stat 0x20000000, host bus error
> [  277.148290] ata3: SError: { HostInt }
> [  277.148291] ata3.00: failed command: WRITE FPDMA QUEUED
> [  277.148294] ata3.00: cmd 61/a0:b0:b8:e8:43/02:00:25:00:00/40 tag 22 ncq 344064 out
>                         res 40/00:c4:58:db:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  277.148296] ata3.00: status: { DRDY }
> [  277.148297] ata3.00: failed command: WRITE FPDMA QUEUED
> [  277.148300] ata3.00: cmd 61/00:b8:b8:e0:43/08:00:25:00:00/40 tag 23 ncq 1048576 out
>                         res 40/00:c4:58:db:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  277.148301] ata3.00: status: { DRDY }
> [  277.148302] ata3.00: failed command: WRITE FPDMA QUEUED
> [  277.148305] ata3.00: cmd 61/60:c0:58:db:43/05:00:25:00:00/40 tag 24 ncq 704512 out
>                         res 40/00:c4:58:db:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  277.148306] ata3.00: status: { DRDY }
> [  277.148308] ata3: hard resetting link
> [  277.452994] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  277.453608] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  277.453613] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  277.454422] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  277.454426] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  277.454605] ata3.00: configured for UDMA/133
> [  277.454619] ata3: EH complete
> [  277.466985] ata3.00: exception Emask 0x60 SAct 0x70 SErr 0x800 action 0x6 frozen
> [  277.466987] ata3.00: irq_stat 0x20000000, host bus error
> [  277.466989] ata3: SError: { HostInt }
> [  277.466990] ata3.00: failed command: WRITE FPDMA QUEUED
> [  277.466993] ata3.00: cmd 61/60:20:58:db:43/05:00:25:00:00/40 tag 4 ncq 704512 out
>                         res 40/00:34:b8:e8:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  277.466995] ata3.00: status: { DRDY }
> [  277.466996] ata3.00: failed command: WRITE FPDMA QUEUED
> [  277.466999] ata3.00: cmd 61/00:28:b8:e0:43/08:00:25:00:00/40 tag 5 ncq 1048576 out
>                         res 40/00:34:b8:e8:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  277.467000] ata3.00: status: { DRDY }
> [  277.467001] ata3.00: failed command: WRITE FPDMA QUEUED
> [  277.467003] ata3.00: cmd 61/a0:30:b8:e8:43/02:00:25:00:00/40 tag 6 ncq 344064 out
>                         res 40/00:34:b8:e8:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  277.467005] ata3.00: status: { DRDY }
> [  277.467007] ata3: hard resetting link
> [  277.771695] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  277.772313] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  277.772318] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  277.773136] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  277.773140] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  277.773315] ata3.00: configured for UDMA/133
> [  277.773329] ata3: EH complete
> [  277.787682] ata3.00: exception Emask 0x60 SAct 0xe0000 SErr 0x800 action 0x6 frozen
> [  277.787684] ata3.00: irq_stat 0x20000000, host bus error
> [  277.787686] ata3: SError: { HostInt }
> [  277.787688] ata3.00: failed command: WRITE FPDMA QUEUED
> [  277.787691] ata3.00: cmd 61/a0:88:b8:e8:43/02:00:25:00:00/40 tag 17 ncq 344064 out
>                         res 40/00:9c:58:db:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  277.787692] ata3.00: status: { DRDY }
> [  277.787693] ata3.00: failed command: WRITE FPDMA QUEUED
> [  277.787696] ata3.00: cmd 61/00:90:b8:e0:43/08:00:25:00:00/40 tag 18 ncq 1048576 out
>                         res 40/00:9c:58:db:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  277.787697] ata3.00: status: { DRDY }
> [  277.787698] ata3.00: failed command: WRITE FPDMA QUEUED
> [  277.787701] ata3.00: cmd 61/60:98:58:db:43/05:00:25:00:00/40 tag 19 ncq 704512 out
>                         res 40/00:9c:58:db:43/00:00:25:00:00/40 Emask 0x60 (host bus error)
> [  277.787702] ata3.00: status: { DRDY }
> [  277.787704] ata3: hard resetting link
> [  278.092392] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  278.093034] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  278.093039] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  278.094396] ACPI Error: [DSSP] Namespace lookup failure, AE_NOT_FOUND (20150204/psargs-359)
> [  278.094401] ACPI Error: Method parse/execution failed [\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88040dcba618), AE_NOT_FOUND (20150204/psparse-536)
> [  278.094559] ata3.00: configured for UDMA/133
> [  278.094571] sd 2:0:0:0: [sda] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  278.094574] sd 2:0:0:0: [sda] tag#17 Sense Key : Aborted Command [current] [descriptor]
> [  278.094576] sd 2:0:0:0: [sda] tag#17 Add. Sense: No additional sense information
> [  278.094578] sd 2:0:0:0: [sda] tag#17 CDB: Write(10) 2a 00 25 43 e8 b8 00 02 a0 00
> [  278.094580] blk_update_request: I/O error, dev sda, sector 625207480
> [  278.094680] sd 2:0:0:0: [sda] tag#18 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  278.094682] sd 2:0:0:0: [sda] tag#18 Sense Key : Aborted Command [current] [descriptor]
> [  278.094683] sd 2:0:0:0: [sda] tag#18 Add. Sense: No additional sense information
> [  278.094685] sd 2:0:0:0: [sda] tag#18 CDB: Write(10) 2a 00 25 43 e0 b8 00 08 00 00
> [  278.094686] blk_update_request: I/O error, dev sda, sector 625205432
> [  278.094731] sd 2:0:0:0: [sda] tag#19 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> [  278.094733] sd 2:0:0:0: [sda] tag#19 Sense Key : Aborted Command [current] [descriptor]
> [  278.094734] sd 2:0:0:0: [sda] tag#19 Add. Sense: No additional sense information
> [  278.094736] sd 2:0:0:0: [sda] tag#19 CDB: Write(10) 2a 00 25 43 db 58 00 05 60 00
> [  278.094737] blk_update_request: I/O error, dev sda, sector 625204056
> [  278.094772] ata3: EH complete
> [  278.094795] XFS (dm-1): xfs_do_force_shutdown(0x1) called from line 1092 of file fs/xfs/xfs_buf.c.  Return address = 0xffffffff81366cd7
> [  278.094797] XFS (dm-1): I/O Error Detected. Shutting down filesystem
> [  278.094799] XFS (dm-1): Please umount the filesystem and rectify the problem(s)
> [  278.094800] XFS (dm-1): metadata I/O error: block 0x2543c358 ("xlog_bwrite") error 5 numblks 8192
> [  278.094925] XFS (dm-1): failed to locate log tail
> [  278.094927] XFS (dm-1): log mount/recovery failed: error -5
> [  278.094965] XFS (dm-1): log mount failed
> [  279.436663] XFS (dm-2): Mounting V4 Filesystem
> [  279.603897] XFS (dm-2): Ending clean mount
> [  516.144494] XFS (dm-1): Mounting V4 Filesystem
> [  516.302218] XFS (dm-1): Ending clean mount
> [  516.858839] XFS (dm-2): Mounting V4 Filesystem
> [  517.017742] XFS (dm-2): Ending clean mount
> [  521.506007] XFS (dm-1): Mounting V4 Filesystem
> [  521.660364] XFS (dm-1): Ending clean mount
> [  522.162118] XFS (dm-2): Mounting V4 Filesystem
> [  522.320952] XFS (dm-2): Ending clean mount
>
> [3]
>
> 00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor Family DRAM Controller (rev 09)
>         Subsystem: ASUSTeK Computer Inc. P8P67/P8H67 Series Motherboard
>         Flags: bus master, fast devsel, latency 0
>         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>         Kernel driver in use: snb_uncore
>
> 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core Processor Family PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 24
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         Capabilities: [88] Subsystem: ASUSTeK Computer Inc. Device 844d
>         Capabilities: [80] Power Management version 3
>         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [a0] Express Root Port (Slot+), MSI 00
>         Capabilities: [100] Virtual Channel
>         Capabilities: [140] Root Complex Link
>         Kernel driver in use: pcieport
>
> 00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller (rev 09) (prog-if 00 [VGA controller])
>         DeviceName:  Onboard IGD
>         Subsystem: ASUSTeK Computer Inc. Device 844d
>         Flags: bus master, fast devsel, latency 0, IRQ 28
>         Memory at f7400000 (64-bit, non-prefetchable) [size=4M]
>         Memory at e0000000 (64-bit, prefetchable) [size=256M]
>         I/O ports at f000 [size=64]
>         Expansion ROM at <unassigned> [disabled]
>         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [d0] Power Management version 2
>         Capabilities: [a4] PCI Advanced Features
>         Kernel driver in use: i915
>         Kernel modules: i915
>
> 00:16.0 Communication controller: Intel Corporation 6 Series/C200 Series Chipset Family MEI Controller #1 (rev 04)
>         Subsystem: ASUSTeK Computer Inc. P8 series motherboard
>         Flags: bus master, fast devsel, latency 0, IRQ 25
>         Memory at f7d2c000 (64-bit, non-prefetchable) [size=16]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Kernel driver in use: mei_me
>
> 00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network Connection (rev 05)
>         DeviceName:  Onboard LAN
>         Subsystem: ASUSTeK Computer Inc. P8P67 Deluxe Motherboard
>         Flags: bus master, fast devsel, latency 0, IRQ 34
>         Memory at f7d00000 (32-bit, non-prefetchable) [size=128K]
>         Memory at f7d29000 (32-bit, non-prefetchable) [size=4K]
>         I/O ports at f080 [size=32]
>         Capabilities: [c8] Power Management version 2
>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [e0] PCI Advanced Features
>         Kernel driver in use: e1000e
>         Kernel modules: e1000e
>
> 00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
>         Subsystem: ASUSTeK Computer Inc. P8 series motherboard
>         Flags: bus master, medium devsel, latency 0, IRQ 16
>         Memory at f7d28000 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] Debug port: BAR=1 offset=00a0
>         Capabilities: [98] PCI Advanced Features
>         Kernel driver in use: ehci-pci
>         Kernel modules: ehci_pci
>
> 00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller (rev 05)
>         Subsystem: ASUSTeK Computer Inc. Device 8410
>         Flags: bus master, fast devsel, latency 0, IRQ 40
>         Memory at f7d20000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
>         Capabilities: [100] Virtual Channel
>         Capabilities: [130] Root Complex Link
>         Kernel driver in use: snd_hda_intel
>         Kernel modules: snd_hda_intel
>
> 00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 1 (rev b5) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>         I/O behind bridge: 00002000-00002fff
>         Memory behind bridge: dfb00000-dfcfffff
>         Prefetchable memory behind bridge: 00000000dfd00000-00000000dfefffff
>         Capabilities: [40] Express Root Port (Slot+), MSI 00
>         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P8 series motherboard
>         Capabilities: [a0] Power Management version 2
>         Kernel driver in use: pcieport
>
> 00:1c.1 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 2 (rev b5) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 17
>         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>         Memory behind bridge: f7c00000-f7cfffff
>         Capabilities: [40] Express Root Port (Slot+), MSI 00
>         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 844d
>         Capabilities: [a0] Power Management version 2
>         Kernel driver in use: pcieport
>
> 00:1c.3 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 4 (rev b5) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 19
>         Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>         I/O behind bridge: 0000e000-0000efff
>         Memory behind bridge: f7b00000-f7bfffff
>         Capabilities: [40] Express Root Port (Slot+), MSI 00
>         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 844d
>         Capabilities: [a0] Power Management version 2
>         Kernel driver in use: pcieport
>
> 00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 5 (rev b5) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
>         Memory behind bridge: f7a00000-f7afffff
>         Capabilities: [40] Express Root Port (Slot+), MSI 00
>         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 844d
>         Capabilities: [a0] Power Management version 2
>         Kernel driver in use: pcieport
>
> 00:1c.6 PCI bridge: Intel Corporation 82801 PCI Bridge (rev b5) (prog-if 01 [Subtractive decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 18
>         Bus: primary=00, secondary=06, subordinate=07, sec-latency=0
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: f7900000-f79fffff
>         Capabilities: [40] Express Root Port (Slot+), MSI 00
>         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P8 series motherboard
>         Capabilities: [a0] Power Management version 2
>
> 00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 19
>         Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
>         I/O behind bridge: 0000c000-0000cfff
>         Memory behind bridge: f7800000-f78fffff
>         Capabilities: [40] Express Root Port (Slot+), MSI 00
>         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Capabilities: [90] Subsystem: ASUSTeK Computer Inc. P8 series motherboard
>         Capabilities: [a0] Power Management version 2
>         Kernel driver in use: pcieport
>
> 00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
>         Subsystem: ASUSTeK Computer Inc. P8 series motherboard
>         Flags: bus master, medium devsel, latency 0, IRQ 23
>         Memory at f7d27000 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] Debug port: BAR=1 offset=00a0
>         Capabilities: [98] PCI Advanced Features
>         Kernel driver in use: ehci-pci
>         Kernel modules: ehci_pci
>
> 00:1f.0 ISA bridge: Intel Corporation Z68 Express Chipset Family LPC Controller (rev 05)
>         Subsystem: ASUSTeK Computer Inc. Device 844d
>         Flags: bus master, medium devsel, latency 0
>         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>         Kernel driver in use: lpc_ich
>         Kernel modules: lpc_ich
>
> 00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series Chipset Family SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
>         Subsystem: ASUSTeK Computer Inc. P8 series motherboard
>         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 26
>         I/O ports at f0d0 [size=8]
>         I/O ports at f0c0 [size=4]
>         I/O ports at f0b0 [size=8]
>         I/O ports at f0a0 [size=4]
>         I/O ports at f060 [size=32]
>         Memory at f7d26000 (32-bit, non-prefetchable) [size=2K]
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [70] Power Management version 3
>         Capabilities: [a8] SATA HBA v1.0
>         Capabilities: [b0] PCI Advanced Features
>         Kernel driver in use: ahci
>
> 00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family SMBus Controller (rev 05)
>         Subsystem: ASUSTeK Computer Inc. P8 series motherboard
>         Flags: medium devsel, IRQ 18
>         Memory at f7d25000 (64-bit, non-prefetchable) [size=256]
>         I/O ports at f040 [size=32]
>         Kernel modules: i2c_i801
>
> 03:00.0 USB controller: ASMedia Technology Inc. ASM1042 SuperSpeed USB Host Controller (prog-if 30 [XHCI])
>         Subsystem: ASUSTeK Computer Inc. P8B WS Motherboard
>         Flags: bus master, fast devsel, latency 0, IRQ 17
>         Memory at f7c00000 (64-bit, non-prefetchable) [size=32K]
>         Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
>         Capabilities: [68] MSI-X: Enable+ Count=8 Masked-
>         Capabilities: [78] Power Management version 3
>         Capabilities: [80] Express Legacy Endpoint, MSI 00
>         Capabilities: [100] Virtual Channel
>         Kernel driver in use: xhci_hcd
>         Kernel modules: xhci_pci
>
> 04:00.0 SATA controller: JMicron Technology Corp. JMB362 SATA Controller (rev 10) (prog-if 01 [AHCI 1.0])
>         Subsystem: ASUSTeK Computer Inc. P8P67 Deluxe Motherboard
>         Flags: bus master, fast devsel, latency 0, IRQ 19
>         I/O ports at e040 [size=8]
>         I/O ports at e030 [size=4]
>         I/O ports at e020 [size=8]
>         I/O ports at e010 [size=4]
>         I/O ports at e000 [size=16]
>         Memory at f7b10000 (32-bit, non-prefetchable) [size=512]
>         [virtual] Expansion ROM at f7b00000 [disabled] [size=64K]
>         Capabilities: [8c] Power Management version 3
>         Capabilities: [50] Express Legacy Endpoint, MSI 00
>         Kernel driver in use: ahci
>
> 05:00.0 USB controller: ASMedia Technology Inc. ASM1042 SuperSpeed USB Host Controller (prog-if 30 [XHCI])
>         Subsystem: ASUSTeK Computer Inc. P8B WS Motherboard
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Memory at f7a00000 (64-bit, non-prefetchable) [size=32K]
>         Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
>         Capabilities: [68] MSI-X: Enable+ Count=8 Masked-
>         Capabilities: [78] Power Management version 3
>         Capabilities: [80] Express Legacy Endpoint, MSI 00
>         Capabilities: [100] Virtual Channel
>         Kernel driver in use: xhci_hcd
>         Kernel modules: xhci_pci
>
> 06:00.0 PCI bridge: ASMedia Technology Inc. ASM1083/1085 PCIe to PCI Bridge (rev 01) (prog-if 01 [Subtractive decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 18
>         Bus: primary=06, secondary=07, subordinate=07, sec-latency=32
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: f7900000-f79fffff
>         Capabilities: [c0] Subsystem: ASMedia Technology Inc. ASM1083/1085 PCIe to PCI Bridge
>
> 07:02.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306/7/8 [Fire II(M)] IEEE 1394 OHCI Controller (rev c0) (prog-if 10 [OHCI])
>         Subsystem: ASUSTeK Computer Inc. Motherboard
>         Flags: bus master, medium devsel, latency 32, IRQ 17
>         Memory at f7900000 (32-bit, non-prefetchable) [size=2K]
>         I/O ports at d000 [size=128]
>         Capabilities: [50] Power Management version 2
>         Kernel modules: firewire_ohci
>
> 08:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 11) (prog-if 01 [AHCI 1.0])
>         Subsystem: ASUSTeK Computer Inc. Device 8477
>         Flags: bus master, fast devsel, latency 0, IRQ 27
>         I/O ports at c040 [size=8]
>         I/O ports at c030 [size=4]
>         I/O ports at c020 [size=8]
>         I/O ports at c010 [size=4]
>         I/O ports at c000 [size=16]
>         Memory at f7810000 (32-bit, non-prefetchable) [size=512]
>         Expansion ROM at f7800000 [disabled] [size=64K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [70] Express Legacy Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Kernel driver in use: ahci
>

1. Try to disable NCQ and check whether it hels by libata.force=noncq

2. I faced this issue but it was related to our host controller bug.
Check with the help of analyser whether the IDENTIFY DEVICE and other
pio mode commands cleared the BSY bit .

3. Try to disable DEVSLP in the drive with below patch :

https://lists.ubuntu.com/archives/kernel-team/2015-February/053503.html

>
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,
with regards,
Suman Tripathi
