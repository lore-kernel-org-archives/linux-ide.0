From: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Subject: understanding the cause of ATA failures
Date: Thu, 18 Mar 2010 14:50:39 -0700
Message-ID: <4BA2A02F.7040200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:33857 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab0CRVuq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2010 17:50:46 -0400
Received: by fxm19 with SMTP id 19so107330fxm.21
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2010 14:50:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I am trying to understand what might have been the cause for the
following two errors. The machine has 6 SATA drives, configured with
software RAID6.


> [513080.136611] ata5: exception Emask 0x50 SAct 0x0 SErr 0x4090800 action 0xe frozen
> [513080.136632] ata5: irq_stat 0x00400040, connection status changed
> [513080.136648] ata5: SError: { HostInt PHYRdyChg 10B8B DevExch }
> [513080.136666] ata5: hard resetting link
> [513080.878347] ata5: SATA link down (SStatus 0 SControl 300)
> [513085.869812] ata5: hard resetting link
> [513086.219198] ata5: SATA link down (SStatus 0 SControl 300)
> [513086.219206] ata5: limiting SATA link speed to 1.5 Gbps
> [513091.210623] ata5: hard resetting link
> [513091.560036] ata5: SATA link down (SStatus 0 SControl 310)
> [513091.560044] ata5.00: disabled
> [513091.560055] ata5: EH complete
> [513091.560128] ata5.00: detaching (SCSI 4:0:0:0)
> [513091.560492] sd 4:0:0:0: [sde] Stopping disk
> [513091.560522] sd 4:0:0:0: [sde] START_STOP FAILED
> [513091.560524] sd 4:0:0:0: [sde] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> [513659.777152] ata5: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xe frozen
> [513659.777173] ata5: irq_stat 0x00000040, connection status changed
> [513659.777189] ata5: SError: { CommWake DevExch }
> [513659.777206] ata5: hard resetting link
> [513665.555794] ata5: link is slow to respond, please be patient (ready=0)
> [513669.808493] ata5: COMRESET failed (errno=-16)
> [513669.808509] ata5: hard resetting link
> [513672.593726] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [513674.832573] ata5.00: ATA-8: WDC WD20EADS-00S2B0, 01.00A01, max UDMA/133
> [513674.832577] ata5.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [513674.835549] ata5.00: configured for UDMA/133
> [513674.835557] ata5: EH complete
> [513674.835716] scsi 4:0:0:0: Direct-Access     ATA      WDC WD20EADS-00S 01.0 PQ: 0 ANSI: 5
> [513674.835860] sd 4:0:0:0: Attached scsi generic sg4 type 0
> [513674.836739] sd 4:0:0:0: [sde] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
> [513674.836783] sd 4:0:0:0: [sde] Write Protect is off
> [513674.836786] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
> [513674.836807] sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [513674.836936]  sde: unknown partition table
> [513674.849972] sd 4:0:0:0: [sde] Attached SCSI disk

One month later

> [2953663.906081] ata3.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
> [2953663.906136] ata3.00: cmd 61/08:00:9d:87:e0/00:00:e8:00:00/40 tag 0 ncq 4096 out
> [2953663.906137]          res 40/00:14:1d:69:81/00:00:77:00:00/40 Emask 0x4 (timeout)
> [2953663.906226] ata3.00: status: { DRDY }
> [2953663.906254] ata3: hard resetting link
> [2953669.287889] ata3: link is slow to respond, please be patient (ready=0)
> [2953673.900888] ata3: COMRESET failed (errno=-16)
> [2953673.900917] ata3: hard resetting link
> [2953679.282709] ata3: link is slow to respond, please be patient (ready=0)
> [2953683.895706] ata3: COMRESET failed (errno=-16)
> [2953683.895735] ata3: hard resetting link
> [2953689.277538] ata3: link is slow to respond, please be patient (ready=0)
> [2953718.872602] ata3: COMRESET failed (errno=-16)
> [2953718.872632] ata3: limiting SATA link speed to 1.5 Gbps
> [2953718.872635] ata3: hard resetting link
> [2953723.894975] ata3: COMRESET failed (errno=-16)
> [2953723.895005] ata3: reset failed, giving up
> [2953723.895030] ata3.00: disabled
> [2953723.895040] ata3: EH complete
> [2953723.895053] sd 2:0:0:0: [sdc] Unhandled error code
> [2953723.895056] sd 2:0:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> [2953723.895060] end_request: I/O error, dev sdc, sector 3907028893

I believe that the same error also happened for the other drives. The
RAID6 failed because other drivers were removed as faulty. I have no
logs though.

Here are some info from the kernel log.
> [    3.115992] ahci 0000:00:1f.2: version 3.0
> [    3.116003]   alloc irq_desc for 19 on node 0
> [    3.116004]   alloc kstat_irqs on node 0
> [    3.116008] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> [    3.116045]   alloc irq_desc for 58 on node 0
> [    3.116047]   alloc kstat_irqs on node 0
> [    3.116052] ahci 0000:00:1f.2: irq 58 for MSI/MSI-X
> [    3.116081] ahci: SSS flag set, parallel bus scan disabled
> [    3.116116] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
> [    3.116119] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems 
> [    3.116122] ahci 0000:00:1f.2: setting latency timer to 64
> [    3.220868] scsi0 : ahci
> [    3.220942] scsi1 : ahci
> [    3.220987] scsi2 : ahci
> [    3.221032] scsi3 : ahci
> [    3.221078] scsi4 : ahci
> [    3.221119] scsi5 : ahci
> [    3.221215] ata1: SATA max UDMA/133 abar m2048@0xfbed6000 port 0xfbed6100 irq 58
> [    3.221218] ata2: SATA max UDMA/133 abar m2048@0xfbed6000 port 0xfbed6180 irq 58
> [    3.221220] ata3: SATA max UDMA/133 abar m2048@0xfbed6000 port 0xfbed6200 irq 58
> [    3.221222] ata4: SATA max UDMA/133 abar m2048@0xfbed6000 port 0xfbed6280 irq 58
> [    3.221225] ata5: SATA max UDMA/133 abar m2048@0xfbed6000 port 0xfbed6300 irq 58
> [    3.221227] ata6: SATA max UDMA/133 abar m2048@0xfbed6000 port 0xfbed6380 irq 58
> [...]
> [    5.117816] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    5.121331] ata3.00: ATA-8: WDC WD20EADS-00S2B0, 01.00A01, max UDMA/133
> [    5.121335] ata3.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    5.124641] ata3.00: configured for UDMA/133
> [    5.137847] scsi 2:0:0:0: Direct-Access     ATA      WDC WD20EADS-00S 01.0 PQ: 0 ANSI: 5
> [    5.137947] sd 2:0:0:0: Attached scsi generic sg2 type 0
> [    5.137968] sd 2:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
> [    5.137991] sd 2:0:0:0: [sdc] Write Protect is off
> [    5.137993] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    5.138005] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    5.138072]  sdc: sdc1 sdc2
> [    5.196726] sd 2:0:0:0: [sdc] Attached SCSI disk

The full log is at
http://www.cs.ucsb.edu/~cavedon/dmesg.log.gz

Controller, form lspci:
> 00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA AHCI Controller

Is there any way to understand what caused the failures? Is it possible
to exclude that is was the hard drive, or cable, or controller, or
kernel fault?

Thank you in advance for any hint,
Cheers,
Ludovico




