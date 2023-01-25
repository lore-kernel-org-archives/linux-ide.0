Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F7C54E94
	for <linux-ide@archiver.kernel.org>; Wed, 25 Jan 2023 13:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjAYNXZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Jan 2023 08:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAYNXZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jan 2023 08:23:25 -0500
Received: from mx.bauer-kirch.de (mx.bauer-kirch.de [87.230.111.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8B9CA3D
        for <linux-ide@vger.kernel.org>; Wed, 25 Jan 2023 05:23:23 -0800 (PST)
Received: by mail.bauer-kirch.de with ESMTPSA id 1pKfkG-0000pB-Q6
        authenticated id <420001312>
        (TLS1.2:ECDHE_RSA_SECP256R1__AES_128_GCM:128); Wed, 25 Jan 2023 14:23:20 +0100
Message-ID: <db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de>
Date:   Wed, 25 Jan 2023 14:23:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
Subject: Marvel 88SE6121 fails with SATA-2/3 HDDs
To:     linux-ide@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        damien.lemoal@opensource.wdc.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Bug report for Seagate Blackarmor NAS440 with Marvel 88SE6121 controller (AHCI kernel module): Very old SATA-1 HDDs (mostly laptop HDDs in my tests) work flawlessly, SATA-2/3 consistently fail. Limiting SATA speed (libata.force=1.5G ...) does not help.

Interestingly, SATA-2/3 HDDs do work with U-Boot and 'ancient' 3.x kernels. There was a suspicion that it was the PCI subsystem (the change in kernel 3.16 from kirkwood/pci.c to mvebu-pci). Pali Rohár did a great job to investigate this problem very persistently, but in the end we did not find a solution.

Without knowing anything about this area, there was the assumption that the problem must be at one of the lower levels close to the hardware.

During some older tests with kernel 5.x I tried to re-integrate a modification from the Seagate vendor 2.6 kernel annotated there with "set 6121 Transmitter Pre-Emphasis to 4", but this did not change anything  (but it may be that I didn't do it right).

You can find all the details and a lot of logs in Bug https://bugzilla.kernel.org/show_bug.cgi?id=216094

Please find [1] U-Boot and [2] Kernel (vanilla 6.2.0-rc5) logs attached, with:
88SE6121-port0 is a SATA-2 ST3500418AS (works with u-boot, fails with linux kernel >3.16)
88SE6121-port1 is a SATA-1 ST3250310NS (always works)
88SE6121-port2 is (unused / not wired) PATA
(during my tests I tried other SATA-1/2/3 drives to rule out a problem with a specific drive or vendor)

I've been trying to resurrect my NAS440 for over 10 years with all the components (https://github.com/hn/seagate-blackarmor-nas), so I have the hardware available and am happy to persevere to try things or otherwise help.

Hajo


[1] U-Boot Log

nas440> version
U-Boot 2022.04 (Apr 11 2022 - 15:58:53 +0200)
NAS 440
nas440> pci enum
pcie0.0: Link up
nas440> scsi reset

Reset SCSI
scanning bus for devices...
Target spinup took 0 ms.
Target spinup took 0 ms.
SATA link 2 timeout.
AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
flags: 64bit ncq stag led pmp slum part
  Device 0: (0:0) Vendor: ATA Prod.: ST3500418AS Rev: CC38
            Type: Hard Disk
            Capacity: 476940.0 MB = 465.7 GB (976773168 x 512)
  Device 1: (1:0) Vendor: ATA Prod.: ST3250310NS Rev: SN04
            Type: Hard Disk
            Capacity: 238475.1 MB = 232.8 GB (488397168 x 512)
nas440> scsi part 0

Partition Map for SCSI device 0  --   Partition Type: DOS

Part    Start Sector    Num Sectors     UUID            Type
  1     2048            209715200       cba79dc0-01     83
  2     209717248       767055920       cba79dc0-02     eb
nas440> ext2ls scsi 0:1
<DIR>       4096 .
<DIR>       4096 ..
<DIR>      16384 lost+found
       568888832 foo


[2] U-Boot Log

root@nas440:~# uname -a
Linux nas440 6.2.0-rc5 #1 Tue Jan 24 23:41:07 CET 2023 armv5tel GNU/Linux
root@nas440:~# modprobe pci-mvebu

[  208.588347] mvebu-pcie mbus@f1000000:pcie@82000000: host bridge /mbus@f1000000/pcie@82000000 ranges:
[  208.597651] mvebu-pcie mbus@f1000000:pcie@82000000:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
[  208.611351] mvebu-pcie mbus@f1000000:pcie@82000000:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
[  208.621380] mvebu-pcie mbus@f1000000:pcie@82000000:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
[  208.641381] mvebu-pcie mbus@f1000000:pcie@82000000: pcie0.0: legacy INTx interrupts cannot be masked individually, /mbus@f1000000/pcie@82000000/pcie@1,0 does not contain intx interrupt
[  208.667286] mvebu-pcie mbus@f1000000:pcie@82000000: PCI host bridge to bus 0000:00
[  208.684189] pci_bus 0000:00: root bus resource [bus 00-ff]
[  208.689802] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus address [0x00040000-0x00041fff])
[  208.705363] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xefffffff]
[  208.712352] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
[  208.723392] pci 0000:00:01.0: [11ab:6281] type 01 class 0x060400
[  208.739782] PCI: bus0: Fast back to back transfers disabled
[  208.745470] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[  208.766397] pci 0000:01:00.0: [11ab:6121] type 00 class 0x01018f
[  208.772921] pci 0000:01:00.0: reg 0x10: [io  0xc0000000-0xc0000007]
[  208.779272] pci 0000:01:00.0: reg 0x14: [io  0xc0000008-0xc000000b]
[  208.785607] pci 0000:01:00.0: reg 0x18: [io  0xc0000010-0xc0000017]
[  208.791937] pci 0000:01:00.0: reg 0x1c: [io  0xc0000018-0xc000001b]
[  208.798267] pci 0000:01:00.0: reg 0x20: [io  0xc0000020-0xc000002f]
[  208.804598] pci 0000:01:00.0: reg 0x24: [mem 0x90000000-0x900003ff]
[  208.818936] pci 0000:01:00.0: supports D1
[  208.823276] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
[  208.840601] PCI: bus1: Fast back to back transfers disabled
[  208.846297] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[  208.879294] pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
[  208.886183] pci 0000:00:01.0: BAR 7: assigned [io  0x10000-0x10fff]
[  208.901547] pci 0000:01:00.0: BAR 5: assigned [mem 0xe0000000-0xe00003ff]
[  208.908459] pci 0000:01:00.0: BAR 4: assigned [io  0x10000-0x1000f]
[  208.914896] pci 0000:01:00.0: BAR 0: assigned [io  0x10010-0x10017]
[  208.921238] pci 0000:01:00.0: BAR 2: assigned [io  0x10018-0x1001f]
[  208.927576] pci 0000:01:00.0: BAR 1: assigned [io  0x10020-0x10023]
[  208.933905] pci 0000:01:00.0: BAR 3: assigned [io  0x10024-0x10027]
[  208.940240] pci 0000:00:01.0: PCI bridge to [bus 01]
[  208.945257] pci 0000:00:01.0:   bridge window [io  0x10000-0x10fff]
[  208.951596] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
[  208.992175] pcieport 0000:00:01.0: enabling device (0140 -> 0143)
[  209.007014] ahci 0000:01:00.0: Disabling your PATA port. Use the boot option 'ahci.marvell_enable=0' to avoid this.
[  209.017595] ahci 0000:01:00.0: controller can't do NCQ, turning off CAP_NCQ
[  209.024616] ahci 0000:01:00.0: controller can't do PMP, turning off CAP_PMP
[  209.031635] ahci 0000:01:00.0: masking port_map 0x7 -> 0x3
[  209.067304] ahci 0000:01:00.0: SSS flag set, parallel bus scan disabled
[  209.074078] ahci 0000:01:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x3 impl IDE mode
[  209.082187] ahci 0000:01:00.0: flags: 64bit stag led slum part
[  209.107629] scsi host3: ahci
[  209.117716] scsi host4: ahci
[  209.131433] scsi host5: ahci
[  209.134706] ata3: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000100 irq 39
[  209.142214] ata4: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000180 irq 39
[  209.149676] ata5: DUMMY
[  209.469562] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  214.631228] ata3.00: qc timeout after 5000 msecs (cmd 0xec)
[  214.636919] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  214.957579] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  225.127261] ata3.00: qc timeout after 10000 msecs (cmd 0xec)
[  225.133030] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  225.139184] ata3: limiting SATA link speed to 1.5 Gbps
[  225.457616] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  257.127404] ata3.00: qc timeout after 30000 msecs (cmd 0xec)
[  257.133181] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  257.453758] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  257.773761] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  257.781254] ata4.00: ATA-6: ST3250310NS, SN04, max UDMA/133
[  257.786916] ata4.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[  257.796826] ata4.00: configured for UDMA/133
[  257.801537] scsi 4:0:0:0: Direct-Access     ATA      ST3250310NS      SN04 PQ: 0 ANSI: 5
[  257.820228] sd 4:0:0:0: [sdd] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[  257.828149] sd 4:0:0:0: Attached scsi generic sg3 type 0
[  257.843562] sd 4:0:0:0: [sdd] Write Protect is off
[  257.859628] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  257.879625] sd 4:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
[  257.918058]  sdd: sdd1 sdd2
[  257.920294] sd 4:0:0:0: [sdd] Attached SCSI disk

