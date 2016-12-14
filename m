From: Emilio Lazo Zaia <emiliolazozaia@gmail.com>
Subject: Errors on Marvell
Date: Wed, 14 Dec 2016 17:00:00 -0400
Message-ID: <c3c2d832-7b3e-ca85-ea0f-071273181028@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36227 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753250AbcLNVAE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 14 Dec 2016 16:00:04 -0500
Received: by mail-yw0-f178.google.com with SMTP id a10so2499470ywa.3
        for <linux-ide@vger.kernel.org>; Wed, 14 Dec 2016 13:00:04 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Hello!

I have a 4xSATA PCI-E card (SYBA brand, Marvell chipset) which behaves
bad on some circumstances that aren't clear to me, so I call that
behavior random.

My mobo is a Gigabyte GA-A75-UD4H/GA-A75-UD4H. The problem consists in
the quoted errors/debug info. I can't write DVD and sometimes
reading/writing to hard disks is slow.

I've disabled the Native Command Queue via kernel parameters
(libata.force=noncq); also I've lowered the speed of all ATA controllers
to 1,5Gbps. There is no difference. The issue persists.

--- lspci -v:

01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9215 (rev
11) (prog-if 01 [AHCI 1.0])
        Subsystem: Marvell Technology Group Ltd. Device 9215
        Flags: bus master, fast devsel, latency 0, IRQ 38
        I/O ports at bf00 [size=8]
        I/O ports at be00 [size=4]
        I/O ports at bd00 [size=8]
        I/O ports at bc00 [size=4]
        I/O ports at bb00 [size=32]
        Memory at fdbff000 (32-bit, non-prefetchable) [size=2K]
        [virtual] Expansion ROM at fdb00000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [70] Express Legacy Endpoint, MSI 00
        Capabilities: [e0] SATA HBA v0.0
        Capabilities: [100] Advanced Error Reporting
        Kernel driver in use: ahci
        Kernel modules: ahci

---

I don't have more options to test. Do you have one? If I can help
improving something I'll do whatever steps necessary to provide debug
information to the kernel developers regarding this problem.

Kind regards

Emilio.


--- dmesg info

[434967.722795] ata9: exception Emask 0x10 SAct 0x0 SErr 0x4050000
action 0xe frozen
[434967.722807] ata9: irq_stat 0x80400040, connection status changed
[434967.722815] ata9: SError: { PHYRdyChg CommWake DevExch }
[434967.722827] ata9: hard resetting link
[434969.192373] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[434969.193014] ata9.00: FORCE: horkage modified (noncq)
[434969.215990] ata9.00: ATA-7: WDC WD3200AAJS-22RYA0, 12.01B01, max
UDMA/133
[434969.215997] ata9.00: 625142448 sectors, multi 0: LBA48 NCQ (not used)
[434969.216882] ata9.00: configured for UDMA/133
[434969.216903] ata9: EH complete
[434970.126924] ata9: exception Emask 0x10 SAct 0x0 SErr 0x190002 action
0xe frozen
[434970.126934] ata9: irq_stat 0x80400000, PHY RDY changed
[434970.126940] ata9: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[434970.126949] ata9: hard resetting link
[434970.836345] ata9: SATA link down (SStatus 0 SControl 300)
[434970.916242] ata9: hard resetting link
[434974.892261] ata9: SATA link down (SStatus 0 SControl 300)
[434974.892269] ata9.00: link offline, clearing class 1 to NONE
[434974.892277] ata9: limiting SATA link speed to 1.5 Gbps
[434975.320012] ata9: hard resetting link
[434977.432186] ata9: SATA link down (SStatus 0 SControl 310)
[434977.432194] ata9.00: link offline, clearing class 1 to NONE
[434977.432201] ata9.00: disabled
[434977.432226] ata9: EH complete
[434977.432327] ata9.00: detaching (SCSI 8:0:0:0)
[434977.898235] ata9: exception Emask 0x10 SAct 0x0 SErr 0x4000000
action 0xe frozen
[434977.898248] ata9: irq_stat 0x80000040, connection status changed
[434977.898255] ata9: SError: { DevExch }
[434977.898267] ata9: hard resetting link
[434983.748063] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[434983.748703] ata9.00: FORCE: horkage modified (noncq)
[434983.771571] ata9.00: ATA-7: WDC WD3200AAJS-22RYA0, 12.01B01, max
UDMA/133
[434983.771579] ata9.00: 625142448 sectors, multi 0: LBA48 NCQ (not used)
[434983.772480] ata9.00: configured for UDMA/133
[434983.772501] ata9: EH complete
[435061.615367] ata9: exception Emask 0x10 SAct 0x0 SErr 0x190002 action
0xe frozen
[435061.615378] ata9: irq_stat 0x80400000, PHY RDY changed
[435061.615386] ata9: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[435061.615396] ata9: hard resetting link
[435062.326353] ata9: SATA link down (SStatus 0 SControl 300)
[435067.386234] ata9: hard resetting link
[435067.702284] ata9: SATA link down (SStatus 0 SControl 300)
[435067.702297] ata9: limiting SATA link speed to 1.5 Gbps
[435072.762107] ata9: hard resetting link
[435073.078040] ata9: SATA link down (SStatus 0 SControl 310)
[435073.078052] ata9.00: disabled
[435073.078078] ata9: EH complete
[435073.078105] ata9.00: detaching (SCSI 8:0:0:0)
[435101.716072] ata8: exception Emask 0x10 SAct 0x0 SErr 0x4050000
action 0xe frozen
[435101.716084] ata8: irq_stat 0x80400040, connection status changed
[435101.716091] ata8: SError: { PHYRdyChg CommWake DevExch }
[435101.716104] ata8: hard resetting link
[435102.585464] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[435102.586086] ata8.00: FORCE: horkage modified (noncq)
[435102.607691] ata8.00: ATA-7: WDC WD3200AAJS-22RYA0, 12.01B01, max
UDMA/133
[435102.607699] ata8.00: 625142448 sectors, multi 0: LBA48 NCQ (not used)
[435102.608621] ata8.00: configured for UDMA/133
[435102.608642] ata8: EH complete
[435205.123301] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
0x6 frozen
[435205.123328] ata7.00: cmd a0/00:00:00:02:00/00:00:00:00:00/a0 tag 24
pio 16388 in
[435205.123335] ata7.00: status: { DRDY }
[435205.123342] ata7: hard resetting link
[435205.599244] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[435205.605549] ata7.00: configured for UDMA/100
[435205.607873] ata7: EH complete
[435471.690523] ata8: exception Emask 0x10 SAct 0x0 SErr 0x190002 action
0xe frozen
[435471.690534] ata8: irq_stat 0x80400000, PHY RDY changed
[435471.690542] ata8: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[435471.690552] ata8: hard resetting link
[435472.401447] ata8: SATA link down (SStatus 0 SControl 300)
[435477.489306] ata8: hard resetting link
[435477.805479] ata8: SATA link down (SStatus 0 SControl 300)
[435477.805492] ata8: limiting SATA link speed to 1.5 Gbps
[435482.865194] ata8: hard resetting link
[435483.181208] ata8: SATA link down (SStatus 0 SControl 310)
[435483.181216] ata8.00: disabled
[435483.181240] ata8: EH complete
[435483.181310] ata8.00: detaching (SCSI 7:0:0:0)
[435484.957529] ata9: exception Emask 0x10 SAct 0x0 SErr 0x4040000
action 0xe frozen
[435484.957541] ata9: irq_stat 0x80000040, connection status changed
[435484.957548] ata9: SError: { CommWake DevExch }
[435484.957560] ata9: hard resetting link
[435485.829144] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[435485.829757] ata9.00: FORCE: horkage modified (noncq)
[435485.852091] ata9.00: ATA-7: WDC WD3200AAJS-22RYA0, 12.01B01, max
UDMA/133
[435485.852097] ata9.00: 625142448 sectors, multi 0: LBA48 NCQ (not used)
[435485.852972] ata9.00: configured for UDMA/133
[435485.853104] ata9: EH complete
[435491.987610] ata9: exception Emask 0x10 SAct 0x0 SErr 0x190002 action
0xe frozen
[435491.987622] ata9: irq_stat 0x80400000, PHY RDY changed
[435491.987629] ata9: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[435491.987639] ata9: hard resetting link
[435492.696998] ata9: SATA link down (SStatus 0 SControl 300)
[435497.712883] ata9: hard resetting link
[435498.028521] ata9: SATA link down (SStatus 0 SControl 300)
[435498.028534] ata9: limiting SATA link speed to 1.5 Gbps
[435503.088781] ata9: hard resetting link
[435503.404705] ata9: SATA link down (SStatus 0 SControl 310)
[435503.404717] ata9.00: disabled
[435503.404744] ata9: EH complete
[435503.404862] ata9.00: detaching (SCSI 8:0:0:0)

