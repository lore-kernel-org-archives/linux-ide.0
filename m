From: Brad Campbell <brad@wasp.net.au>
Subject: Marvell 6141 on an ASUS M2N32-WS Motherboard
Date: Sat, 07 Jun 2008 11:22:21 +0400
Message-ID: <484A372D.5080307@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:52343 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969AbYFGH13 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jun 2008 03:27:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

G'day all,

The archives tell of many tales of woe regarding this chip (which matches my experience).

I've added the PCI ID for it into the ahci driver, and provided I only use one of the ports it works 
(tho it's kinda slow). As per everyone elses experience, if I try and read from more than one port 
at one time the whole shooting match dies thusly..

Begin with modprobe ahci as it does not seem to support hotplug, so rmmod/plug drives/modprobe

[  798.035338] ahci 0000:08:00.0: version 3.0
[  798.035338] ACPI: PCI Interrupt 0000:08:00.0[A] -> Link [APC7] -> GSI 16 (level, low) -> IRQ 16
[  798.035338] ahci 0000:08:00.0: controller can't do NCQ, turning off CAP_NCQ
[  798.035338] ahci 0000:08:00.0: MV_AHCI HACK: port_map 1f -> f
[  799.138768] ahci 0000:08:00.0: AHCI 0001.0000 32 slots 5 ports 3 Gbps 0xf impl SATA mode
[  799.138814] ahci 0000:08:00.0: flags: 64bit stag nz only pmp slum part
[  799.138841] PCI: Setting latency timer of device 0000:08:00.0 to 64
[  799.146573] scsi17 : ahci
[  799.148746] scsi18 : ahci
[  799.148746] scsi19 : ahci
[  799.148746] scsi20 : ahci
[  799.148746] scsi21 : ahci
[  799.148746] ata17: SATA max UDMA/133 abar m1024@0xfddff000 port 0xfddff100 irq 16
[  799.148746] ata18: SATA max UDMA/133 abar m1024@0xfddff000 port 0xfddff180 irq 16
[  799.148746] ata19: SATA max UDMA/133 abar m1024@0xfddff000 port 0xfddff200 irq 16
[  799.148746] ata20: SATA max UDMA/133 abar m1024@0xfddff000 port 0xfddff280 irq 16
[  799.148746] ata21: DUMMY
[  799.765643] ata17: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
[  799.765986] ata17.00: ATA-7: Maxtor 7Y250M0, YAR51EW0, max UDMA/133
[  799.766013] ata17.00: 490234752 sectors, multi 0: LBA48
[  799.766393] ata17.00: configured for UDMA/133
[  800.189721] ata18: SATA link down (SStatus 0 SControl 0)
[  800.784449] ata19: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
[  800.784439] ata19.00: ATA-7: MAXTOR STM3250310AS, 3.AAC, max UDMA/133
[  800.784439] ata19.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[  800.784439] ata19.00: configured for UDMA/133
[  801.166661] ata20: SATA link down (SStatus 0 SControl 0)
[  801.173122] scsi 17:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[  801.173122] sd 17:0:0:0: [sdc] 490234752 512-byte hardware sectors (251000 MB)
[  801.173122] sd 17:0:0:0: [sdc] Write Protect is off
[  801.173122] sd 17:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  801.173122] sd 17:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  801.173122] sd 17:0:0:0: [sdc] 490234752 512-byte hardware sectors (251000 MB)
[  801.173122] sd 17:0:0:0: [sdc] Write Protect is off
[  801.173122] sd 17:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  801.173122] sd 17:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  801.173122]  sdc: sdc1
[  801.185510] sd 17:0:0:0: [sdc] Attached SCSI disk
[  801.185576] sd 17:0:0:0: Attached scsi generic sg2 type 0
[  801.185672] scsi 19:0:0:0: Direct-Access     ATA      MAXTOR STM325031 3.AA PQ: 0 ANSI: 5
[  801.185792] sd 19:0:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
[  801.185837] sd 19:0:0:0: [sdd] Write Protect is off
[  801.185862] sd 19:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[  801.185891] sd 19:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  801.185973] sd 19:0:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
[  801.186016] sd 19:0:0:0: [sdd] Write Protect is off
[  801.186039] sd 19:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[  801.186068] sd 19:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  801.186099]  sdd: sdd1 sdd2 sdd3
[  801.213127] sd 19:0:0:0: [sdd] Attached SCSI disk
[  801.213127] sd 19:0:0:0: Attached scsi generic sg3 type 0

Reading from disk 1 at ~50MB/s is all going nicely until I try to do a simultaneous read from disk 2

[  860.647967] ata19.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  860.647967] ata19.00: cmd c8/00:c0:08:23:00/00:00:00:00:00/e0 tag 0 dma 98304 in
[  860.647967]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  860.647967] ata19.00: status: { DRDY }
[  860.647967] ata19: hard resetting link
[  860.647967] ata17.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  860.647967] ata17.00: cmd c8/00:68:98:a9:23/00:00:00:00:00/e0 tag 0 dma 53248 in
[  860.647967]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  860.647967] ata17.00: status: { DRDY }
[  860.647967] ata17: hard resetting link
[  861.187467] ata19: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
[  861.187467] ata17: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
[  893.964245] ata17.00: qc timeout (cmd 0xec)
[  893.964245] ata17.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  893.964245] ata17.00: revalidation failed (errno=-5)
[  893.964245] ata17: failed to recover some devices, retrying in 5 secs
[  893.964245] ata19.00: qc timeout (cmd 0xec)
[  893.964245] ata19.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  893.964245] ata19.00: revalidation failed (errno=-5)
[  893.964245] ata19: failed to recover some devices, retrying in 5 secs
[  899.502826] ata19: hard resetting link
[  899.502826] ata17: hard resetting link
[  900.070618] ata19: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
[  900.070670] ata17: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
[  933.375102] ata17.00: qc timeout (cmd 0xec)
[  933.375143] ata17.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  933.385090] ata17.00: revalidation failed (errno=-5)
[  933.385090] ata17: failed to recover some devices, retrying in 5 secs
[  933.385090] ata19.00: qc timeout (cmd 0xec)
[  933.385090] ata19.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  933.385090] ata19.00: revalidation failed (errno=-5)
[  933.385090] ata19: failed to recover some devices, retrying in 5 secs
[  938.851258] ata19: hard resetting link
[  938.851258] ata17: hard resetting link
[  939.417249] ata17: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
[  939.417300] ata19: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
[  971.973737] ata19.00: qc timeout (cmd 0xec)
[  971.973777] ata19.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  971.973802] ata19.00: revalidation failed (errno=-5)
[  971.983725] ata19.00: disabled
[  971.983725] ata17.00: qc timeout (cmd 0xec)
[  971.983725] ata17.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  971.983725] ata17.00: revalidation failed (errno=-5)
[  971.983725] ata17.00: disabled
[  972.493721] ata17: hard resetting link
[  972.493721] ata19: hard resetting link
[  973.035698] ata17: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
[  973.035739] ata17: EH complete
[  973.045683] sd 17:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  973.045683] end_request: I/O error, dev sdc, sector 2337176
[  973.045683] Buffer I/O error on device sdc, logical block 292147
[  973.045683] Buffer I/O error on device sdc, logical block 292148
[  973.045683] Buffer I/O error on device sdc, logical block 292149
[  973.045683] Buffer I/O error on device sdc, logical block 292150
[  973.045683] Buffer I/O error on device sdc, logical block 292151
[  973.045683] Buffer I/O error on device sdc, logical block 292152
[  973.045683] Buffer I/O error on device sdc, logical block 292153
[  973.045683] Buffer I/O error on device sdc, logical block 292154
[  973.045683] Buffer I/O error on device sdc, logical block 292155
[  973.045683] Buffer I/O error on device sdc, logical block 292156
[  973.045683] sd 17:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  973.045683] end_request: I/O error, dev sdc, sector 2337280
[  973.045683] ata19: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
[  973.045683] ata19: EH complete
[  973.045683] sd 17:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  973.045683] end_request: I/O error, dev sdc, sector 2337176
[  973.045683] sd 19:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  973.045683] end_request: I/O error, dev sdd, sector 8968
[  973.045683] sd 19:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  973.045683] end_request: I/O error, dev sdd, sector 9160
[  973.045683] sd 19:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  973.045683] end_request: I/O error, dev sdd, sector 8968
[  973.045683] sd 17:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[  973.045683] end_request: I/O error, dev sdc, sector 2337176
[  973.055683] sd 19:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  973.055683] end_request: I/O error, dev sdd, sector 8968

I've seen plenty of reports of this floating around. I have this board on the desk for a while 
before I need to install it so I can help out testing and debugging if anyone is interested.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
