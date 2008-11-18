From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Tue, 18 Nov 2008 19:03:13 +0100
Message-ID: <49230361.2010001@how.dk>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org> <18719.65298.689618.835202@harpo.it.uu.se> <492059B1.4030708@how.dk> <49205AD7.3080009@how.dk> <4920D093.2030508@kernel.org> <492159E0.1050804@how.dk> <4922165E.9070203@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:40739 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbYKRSDR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Nov 2008 13:03:17 -0500
In-Reply-To: <4922165E.9070203@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Hi Tejun & list

Tejun Heo wrote:
> Peter Favrholdt wrote:
>> I tried removing sata_promise the nice way using modprobe:
>>
>> # modprobe -r -f sata_promise
>> FATAL: Module sata_promise is in use.
>>
>> then the not-so-nice way using rmmod -f and inserting it again. It
>> doesn't work. Here are the relevant parts from dmesg (removing and
>> inserting):
> 
> Oh... you first need to wait for the kernel to be done with the devices.
>  ie. unmount all filesystems living on those && wait till EH finishes.

I didn't have any filesystems mounted but learned that the 4 disks
participate in a md raid5 set. To be sure I tried everything again from 
the beginning (reboot) without enabling md on the four drives. Here are 
the results:

1. started the four dd processes which ran to completion without any 
errors. Started them again and this time sda failed as usual.

2. modprobe -r sata_promise - no warnings/errors: removed successfully

3. modprobe sata_promise - only three drives show up

4. modprobe -r sata_promise - no warnings/errors: removed successfully

5. modprobe sata_promise - more channels complain - no drives are found

dmesg:

[21626.490086] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x6 frozen
[21626.490096] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
[21626.490105] ata1.00: cmd 25/00:00:00:1f:e6/00:02:01:00:00/e0 tag 0 
dma 262144 in
[21626.490107]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask 
0x4 (timeout)
[21626.490110] ata1.00: status: { DRDY }
[21626.490162] ata1: hard resetting link
[21631.881055] ata1: link is slow to respond, please be patient (ready=-19)
[21636.500030] ata1: COMRESET failed (errno=-16)
[21636.500068] ata1: hard resetting link
[21641.890034] ata1: link is slow to respond, please be patient (ready=-19)
[21646.510903] ata1: COMRESET failed (errno=-16)
[21646.510919] ata1: hard resetting link
[21651.900107] ata1: link is slow to respond, please be patient (ready=-19)
[21681.540037] ata1: COMRESET failed (errno=-16)
[21681.540047] ata1: limiting SATA link speed to 1.5 Gbps
[21681.540074] ata1: hard resetting link
[21686.570034] ata1: COMRESET failed (errno=-16)
[21686.570043] ata1: reset failed, giving up
[21686.570047] ata1.00: disabled
[21686.570070] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
frozen t4
[21686.570073] ata1: hotplug_status 0x80
[21686.570124] ata1: hard resetting link
[21692.360323] ata1: link is slow to respond, please be patient (ready=-19)
[21696.620070] ata1: COMRESET failed (errno=-16)
[21696.620099] ata1: hard resetting link
[21702.410066] ata1: link is slow to respond, please be patient (ready=-19)
[21706.670033] ata1: COMRESET failed (errno=-16)
[21706.670084] ata1: hard resetting link
[21712.460035] ata1: link is slow to respond, please be patient (ready=-19)
[21741.680037] ata1: COMRESET failed (errno=-16)
[21741.680054] ata1: limiting SATA link speed to 1.5 Gbps
[21741.680089] ata1: hard resetting link
[21746.690034] ata1: COMRESET failed (errno=-16)
[21746.690042] ata1: reset failed, giving up
[21746.690055] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
frozen t3
[21746.690057] ata1: hotplug_status 0x80
[21746.690116] ata1: hard resetting link
[21752.480034] ata1: link is slow to respond, please be patient (ready=-19)
[21756.740031] ata1: COMRESET failed (errno=-16)
[21756.740076] ata1: hard resetting link
[21762.530038] ata1: link is slow to respond, please be patient (ready=-19)
[21766.792415] ata1: COMRESET failed (errno=-16)
[21766.792454] ata1: hard resetting link
[21772.580049] ata1: link is slow to respond, please be patient (ready=-19)
[21801.800038] ata1: COMRESET failed (errno=-16)
[21801.800221] ata1: limiting SATA link speed to 1.5 Gbps
[21801.800297] ata1: hard resetting link
[21806.810027] ata1: COMRESET failed (errno=-16)
[21806.810036] ata1: reset failed, giving up
[21806.810050] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
frozen t2
[21806.810052] ata1: hotplug_status 0x80
[21806.810110] ata1: hard resetting link
[21812.600033] ata1: link is slow to respond, please be patient (ready=-19)
[21816.860033] ata1: COMRESET failed (errno=-16)
[21816.860085] ata1: hard resetting link
[21822.650036] ata1: link is slow to respond, please be patient (ready=-19)
[21826.910107] ata1: COMRESET failed (errno=-16)
[21826.910158] ata1: hard resetting link
[21832.700074] ata1: link is slow to respond, please be patient (ready=-19)
[21861.920041] ata1: COMRESET failed (errno=-16)
[21861.920058] ata1: limiting SATA link speed to 1.5 Gbps
[21861.920106] ata1: hard resetting link
[21866.940034] ata1: COMRESET failed (errno=-16)
[21866.940043] ata1: reset failed, giving up
[21866.940056] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
frozen t1
[21866.940059] ata1: hotplug_status 0x80
[21866.940118] ata1: hard resetting link
[21872.730031] ata1: link is slow to respond, please be patient (ready=-19)
[21877.000085] ata1: COMRESET failed (errno=-16)
[21877.000117] ata1: hard resetting link
[21882.793307] ata1: link is slow to respond, please be patient (ready=-19)
[21887.050045] ata1: COMRESET failed (errno=-16)
[21887.050088] ata1: hard resetting link
[21892.840068] ata1: link is slow to respond, please be patient (ready=-19)
[21922.060035] ata1: COMRESET failed (errno=-16)
[21922.060046] ata1: limiting SATA link speed to 1.5 Gbps
[21922.060073] ata1: hard resetting link
[21927.070032] ata1: COMRESET failed (errno=-16)
[21927.070040] ata1: reset failed, giving up
[21927.070047] ata1: EH pending after 5 tries, giving up
[21927.070069] sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
[21927.070073] sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
[21927.070078] Descriptor sense data with sense descriptors (in hex):
[21927.070080]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[21927.070088]         00 00 00 00
[21927.070091] sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
[21927.070094] end_request: I/O error, dev sda, sector 31858432
[21927.070099] Buffer I/O error on device sda, logical block 3982304
[21927.070104] Buffer I/O error on device sda, logical block 3982305
[21927.070107] Buffer I/O error on device sda, logical block 3982306
[21927.070110] Buffer I/O error on device sda, logical block 3982307
[21927.070114] Buffer I/O error on device sda, logical block 3982308
[21927.070117] Buffer I/O error on device sda, logical block 3982309
[21927.070120] Buffer I/O error on device sda, logical block 3982310
[21927.070124] Buffer I/O error on device sda, logical block 3982311
[21927.070127] Buffer I/O error on device sda, logical block 3982312
[21927.070131] Buffer I/O error on device sda, logical block 3982313
[21927.070177] ata1: EH complete
[21927.070186] ata1.00: detaching (SCSI 0:0:0:0)
[21927.071140] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[21927.072425] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[21927.072431] sd 0:0:0:0: [sda] Stopping disk
[21927.072439] sd 0:0:0:0: [sda] START_STOP FAILED
[21927.072441] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[24533.844877] ata2.00: disabled
[24533.845094] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[24533.845129] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[24533.845133] sd 1:0:0:0: [sdb] Stopping disk
[24533.845140] sd 1:0:0:0: [sdb] START_STOP FAILED
[24533.845142] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[24533.845402] ata3.00: disabled
[24533.845544] sd 2:0:0:0: [sdc] Synchronizing SCSI cache
[24533.845567] sd 2:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[24533.845571] sd 2:0:0:0: [sdc] Stopping disk
[24533.845578] sd 2:0:0:0: [sdc] START_STOP FAILED
[24533.845580] sd 2:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[24533.845693] ata4.00: disabled
[24533.845833] sd 3:0:0:0: [sdd] Synchronizing SCSI cache
[24533.845856] sd 3:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[24533.845859] sd 3:0:0:0: [sdd] Stopping disk
[24533.845866] sd 3:0:0:0: [sdd] START_STOP FAILED
[24533.845868] sd 3:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[24533.846012] sata_promise 0000:01:08.0: PCI INT A disabled
[24551.960098] sata_promise 0000:01:08.0: version 2.12
[24551.960353] sata_promise 0000:01:08.0: PCI INT A -> Link[APC3] -> GSI 
18 (level, high) -> IRQ 18
[24551.961961] scsi4 : sata_promise
[24551.970471] scsi5 : sata_promise
[24551.970683] scsi6 : sata_promise
[24551.972392] scsi7 : sata_promise
[24551.972633] ata5: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024380 irq 18
[24551.972640] ata6: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024280 irq 18
[24551.972645] ata7: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024200 irq 18
[24551.972649] ata8: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024300 irq 18
[24557.360017] ata5: link is slow to respond, please be patient (ready=-19)
[24561.980015] ata5: COMRESET failed (errno=-16)
[24567.370014] ata5: link is slow to respond, please be patient (ready=-19)
[24571.990013] ata5: COMRESET failed (errno=-16)
[24577.380015] ata5: link is slow to respond, please be patient (ready=-19)
[24607.020010] ata5: COMRESET failed (errno=-16)
[24607.020019] ata5: limiting SATA link speed to 1.5 Gbps
[24612.050010] ata5: COMRESET failed (errno=-16)
[24612.050017] ata5: reset failed, giving up
[24612.400045] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[24612.459926] ata6.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[24612.459930] ata6.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[24612.551577] ata6.00: configured for UDMA/133
[24612.900042] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[24612.961700] ata7.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[24612.961707] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[24613.053320] ata7.00: configured for UDMA/133
[24613.400045] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[24613.461067] ata8.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[24613.461072] ata8.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[24613.552710] ata8.00: configured for UDMA/133
[24613.553014] scsi 5:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[24613.559489] sd 5:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[24613.559589] sd 5:0:0:0: [sda] Write Protect is off
[24613.559594] sd 5:0:0:0: [sda] Mode Sense: 00 3a 00 00
[24613.559741] sd 5:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[24613.559901] sd 5:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[24613.560029] sd 5:0:0:0: [sda] Write Protect is off
[24613.560033] sd 5:0:0:0: [sda] Mode Sense: 00 3a 00 00
[24613.560104] sd 5:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[24613.560109]  sda: unknown partition table
[24613.575844] sd 5:0:0:0: [sda] Attached SCSI disk
[24613.576017] sd 5:0:0:0: Attached scsi generic sg0 type 0
[24613.576147] scsi 6:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[24613.576267] sd 6:0:0:0: [sdb] 976773168 512-byte hardware sectors 
(500108 MB)
[24613.576308] sd 6:0:0:0: [sdb] Write Protect is off
[24613.576312] sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[24613.576366] sd 6:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[24613.576460] sd 6:0:0:0: [sdb] 976773168 512-byte hardware sectors 
(500108 MB)
[24613.576495] sd 6:0:0:0: [sdb] Write Protect is off
[24613.576498] sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[24613.576520] sd 6:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[24613.576524]  sdb: unknown partition table
[24613.602070] sd 6:0:0:0: [sdb] Attached SCSI disk
[24613.602163] sd 6:0:0:0: Attached scsi generic sg1 type 0
[24613.602252] scsi 7:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[24613.602343] sd 7:0:0:0: [sdc] 976773168 512-byte hardware sectors 
(500108 MB)
[24613.602360] sd 7:0:0:0: [sdc] Write Protect is off
[24613.602363] sd 7:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[24613.602386] sd 7:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[24613.602457] sd 7:0:0:0: [sdc] 976773168 512-byte hardware sectors 
(500108 MB)
[24613.602470] sd 7:0:0:0: [sdc] Write Protect is off
[24613.602473] sd 7:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[24613.602495] sd 7:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[24613.602498]  sdc: unknown partition table
[24613.617764] sd 7:0:0:0: [sdc] Attached SCSI disk
[24613.617936] sd 7:0:0:0: Attached scsi generic sg2 type 0
[28434.310751] ata6.00: disabled
[28434.311019] sd 5:0:0:0: [sda] Synchronizing SCSI cache
[28434.312760] sd 5:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[28434.312769] sd 5:0:0:0: [sda] Stopping disk
[28434.313018] sd 5:0:0:0: [sda] START_STOP FAILED
[28434.313022] sd 5:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[28434.313242] ata7.00: disabled
[28434.313514] sd 6:0:0:0: [sdb] Synchronizing SCSI cache
[28434.313680] sd 6:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[28434.313684] sd 6:0:0:0: [sdb] Stopping disk
[28434.313806] sd 6:0:0:0: [sdb] START_STOP FAILED
[28434.313809] sd 6:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[28434.313981] ata8.00: disabled
[28434.314179] sd 7:0:0:0: [sdc] Synchronizing SCSI cache
[28434.314315] sd 7:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[28434.314320] sd 7:0:0:0: [sdc] Stopping disk
[28434.314440] sd 7:0:0:0: [sdc] START_STOP FAILED
[28434.314444] sd 7:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[28434.314714] sata_promise 0000:01:08.0: PCI INT A disabled
[28498.823936] sata_promise 0000:01:08.0: version 2.12
[28498.825625] sata_promise 0000:01:08.0: PCI INT A -> Link[APC3] -> GSI 
18 (level, high) -> IRQ 18
[28498.826212] scsi8 : sata_promise
[28498.827942] scsi9 : sata_promise
[28498.828206] scsi10 : sata_promise
[28498.828716] scsi11 : sata_promise
[28498.828838] ata9: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024380 irq 18
[28498.828845] ata10: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024280 irq 18
[28498.828850] ata11: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024200 irq 18
[28498.828854] ata12: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024300 irq 18
[28504.210021] ata9: link is slow to respond, please be patient (ready=-19)
[28508.830010] ata9: COMRESET failed (errno=-16)
[28514.220012] ata9: link is slow to respond, please be patient (ready=-19)
[28518.840009] ata9: COMRESET failed (errno=-16)
[28524.230012] ata9: link is slow to respond, please be patient (ready=-19)
[28553.870009] ata9: COMRESET failed (errno=-16)
[28553.870019] ata9: limiting SATA link speed to 1.5 Gbps
[28558.900010] ata9: COMRESET failed (errno=-16)
[28558.900017] ata9: reset failed, giving up
[28559.250043] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[28564.250027] ata10.00: qc timeout (cmd 0xec)
[28564.250242] ata10.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[28569.640739] ata10: link is slow to respond, please be patient (ready=-19)
[28574.260008] ata10: COMRESET failed (errno=-16)
[28579.650015] ata10: link is slow to respond, please be patient (ready=-19)
[28584.270008] ata10: COMRESET failed (errno=-16)
[28589.660012] ata10: link is slow to respond, please be patient (ready=-19)
[28619.300008] ata10: COMRESET failed (errno=-16)
[28619.300018] ata10: limiting SATA link speed to 1.5 Gbps
[28624.330009] ata10: COMRESET failed (errno=-16)
[28624.330018] ata10: reset failed, giving up
[28624.330037] ata10: hard resetting link
[28629.720011] ata10: link is slow to respond, please be patient (ready=-19)
[28634.340029] ata10: COMRESET failed (errno=-16)
[28634.340044] ata10: hard resetting link
[28639.730011] ata10: link is slow to respond, please be patient (ready=-19)
[28644.350016] ata10: COMRESET failed (errno=-16)
[28644.350032] ata10: hard resetting link
[28649.740018] ata10: link is slow to respond, please be patient (ready=-19)
[28679.380015] ata10: COMRESET failed (errno=-16)
[28679.380032] ata10: hard resetting link
[28684.410011] ata10: COMRESET failed (errno=-16)
[28684.410019] ata10: reset failed, giving up
[28684.410026] ata10: EH complete
[28684.760044] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[28689.760028] ata11.00: qc timeout (cmd 0xec)
[28689.760242] ata11.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[28695.150021] ata11: link is slow to respond, please be patient (ready=-19)
[28699.770010] ata11: COMRESET failed (errno=-16)
[28705.160064] ata11: link is slow to respond, please be patient (ready=-19)
[28709.780011] ata11: COMRESET failed (errno=-16)
[28715.170015] ata11: link is slow to respond, please be patient (ready=-19)
[28744.810010] ata11: COMRESET failed (errno=-16)
[28744.810019] ata11: limiting SATA link speed to 1.5 Gbps
[28749.840009] ata11: COMRESET failed (errno=-16)
[28749.840016] ata11: reset failed, giving up
[28749.840038] ata11: hard resetting link
[28755.230012] ata11: link is slow to respond, please be patient (ready=-19)
[28759.850009] ata11: COMRESET failed (errno=-16)
[28759.850023] ata11: hard resetting link
[28765.240010] ata11: link is slow to respond, please be patient (ready=-19)
[28769.860011] ata11: COMRESET failed (errno=-16)
[28769.860026] ata11: hard resetting link
[28775.250010] ata11: link is slow to respond, please be patient (ready=-19)
[28804.890008] ata11: COMRESET failed (errno=-16)
[28804.890024] ata11: hard resetting link
[28809.920011] ata11: COMRESET failed (errno=-16)
[28809.920019] ata11: reset failed, giving up
[28809.920026] ata11: EH complete
[28810.270043] ata12: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[28815.270028] ata12.00: qc timeout (cmd 0xec)
[28815.270244] ata12.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[28820.660011] ata12: link is slow to respond, please be patient (ready=-19)
[28825.280010] ata12: COMRESET failed (errno=-16)
[28830.670011] ata12: link is slow to respond, please be patient (ready=-19)
[28835.290010] ata12: COMRESET failed (errno=-16)
[28840.680011] ata12: link is slow to respond, please be patient (ready=-19)
[28870.320011] ata12: COMRESET failed (errno=-16)
[28870.320021] ata12: limiting SATA link speed to 1.5 Gbps
[28875.350016] ata12: COMRESET failed (errno=-16)
[28875.350024] ata12: reset failed, giving up
[28875.350046] ata12: hard resetting link
[28880.740018] ata12: link is slow to respond, please be patient (ready=-19)
[28885.360018] ata12: COMRESET failed (errno=-16)
[28885.360034] ata12: hard resetting link
[28890.750011] ata12: link is slow to respond, please be patient (ready=-19)
[28895.370015] ata12: COMRESET failed (errno=-16)
[28895.370031] ata12: hard resetting link
[28900.760011] ata12: link is slow to respond, please be patient (ready=-19)
[28930.400011] ata12: COMRESET failed (errno=-16)
[28930.400028] ata12: hard resetting link
[28935.430011] ata12: COMRESET failed (errno=-16)
[28935.430020] ata12: reset failed, giving up
[28935.430027] ata12: EH complete

6. then I tried modprobe -r and modprobe once again but without success.

[29272.494502] sata_promise 0000:01:08.0: PCI INT A disabled
[29278.383748] sata_promise 0000:01:08.0: version 2.12
[29278.385439] sata_promise 0000:01:08.0: PCI INT A -> Link[APC3] -> GSI 
18 (level, high) -> IRQ 18
[29278.386014] scsi12 : sata_promise
[29278.387767] scsi13 : sata_promise
[29278.388031] scsi14 : sata_promise
[29278.388544] scsi15 : sata_promise
[29278.388665] ata13: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024380 irq 18
[29278.388671] ata14: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024280 irq 18
[29278.388676] ata15: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024200 irq 18
[29278.388680] ata16: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024300 irq 18
[29283.770010] ata13: link is slow to respond, please be patient (ready=-19)
[29288.390023] ata13: COMRESET failed (errno=-16)
[29293.780010] ata13: link is slow to respond, please be patient (ready=-19)
[29298.400011] ata13: COMRESET failed (errno=-16)
[29303.790019] ata13: link is slow to respond, please be patient (ready=-19)
[29333.430019] ata13: COMRESET failed (errno=-16)
[29333.430029] ata13: limiting SATA link speed to 1.5 Gbps
[29338.460010] ata13: COMRESET failed (errno=-16)
[29338.460018] ata13: reset failed, giving up
[29343.850019] ata14: link is slow to respond, please be patient (ready=-19)
[29348.470020] ata14: COMRESET failed (errno=-16)
[29353.860011] ata14: link is slow to respond, please be patient (ready=-19)
[29358.480011] ata14: COMRESET failed (errno=-16)
[29363.870009] ata14: link is slow to respond, please be patient (ready=-19)
[29393.510011] ata14: COMRESET failed (errno=-16)
[29393.510021] ata14: limiting SATA link speed to 1.5 Gbps
[29398.540018] ata14: COMRESET failed (errno=-16)
[29398.540026] ata14: reset failed, giving up
[29403.930010] ata15: link is slow to respond, please be patient (ready=-19)
[29408.550022] ata15: COMRESET failed (errno=-16)
[29413.940023] ata15: link is slow to respond, please be patient (ready=-19)
[29418.560013] ata15: COMRESET failed (errno=-16)
[29423.950015] ata15: link is slow to respond, please be patient (ready=-19)
[29453.590010] ata15: COMRESET failed (errno=-16)
[29453.590019] ata15: limiting SATA link speed to 1.5 Gbps
[29458.620009] ata15: COMRESET failed (errno=-16)
[29458.620017] ata15: reset failed, giving up
[29464.010010] ata16: link is slow to respond, please be patient (ready=-19)
[29468.630018] ata16: COMRESET failed (errno=-16)
[29474.020009] ata16: link is slow to respond, please be patient (ready=-19)
[29478.640743] ata16: COMRESET failed (errno=-16)
[29484.030010] ata16: link is slow to respond, please be patient (ready=-19)
[29513.670012] ata16: COMRESET failed (errno=-16)
[29513.670022] ata16: limiting SATA link speed to 1.5 Gbps
[29518.700010] ata16: COMRESET failed (errno=-16)
[29518.700018] ata16: reset failed, giving up


Best regards,

Peter
