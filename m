From: Jim Paris <jim@jtan.com>
Subject: Re: [PATCHSET 4/4] implement PMP support, take 4
Date: Tue, 3 Jul 2007 03:39:53 -0400
Message-ID: <20070703073953.GA5343@jim.sh>
References: <1183287253677-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:53765 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862AbXGCHkD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 03:40:03 -0400
Content-Disposition: inline
In-Reply-To: <1183287253677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Hello, all.
> 
> his is the fourth take of libata-pmp patchset.  This patchset contains
> 15 patches and implements PMP support.

Hi Tejun,

Thanks once again.  2.6.22-rc6 + libata-tj-2.6.22-rc6-20070702 seems
to be working fine on my system (SiI3124 PCI-X + two SiI4726, plus
other non-PMP stuff).  The libata portions of the boot logs are
attached below.

There are errors with ata1.05 and ata2.05.  I guess those are the
SiI4726 management ports that were just ignored in the last take of
PMP.  The EH on those causes a boot delay, but it's pretty short.

> * Sil4726 is a bit too quirky.  Without the first fan-out port
>   occupied, the thing acts really weirdly.  As long as the first port
>   is occupied, it works okay.  This is reportedly fixed by new
>   firmware.  I tried to update the firmware but installing 3124 driver
>   on Windows was just too difficult for me and I gave up after thirty
>   painful minutes.  Anyone up for testing?

I'll test the 4726 behavior with pulling disks etc including the first
port.  I'll also search to see if I can find a Windows machine to
update the firmware and let you know how things change.

There's a 4726 firmware update utility for Linux available:
  http://www.siliconimage.com/support/downloadresults.aspx?pid=74
It's closed source, but I wonder how it is supposed to work.  It seems
to just probe /dev/sd* and read the first sector.  Maybe it wants that
management port to be exposed as a SCSI device?

-jim

[   50.891895] libata version 3.00 loaded.
[   50.984511] sata_sil24 0000:01:00.0: version 1.0
[   50.985526] scsi0 : sata_sil24
[   50.985631] scsi1 : sata_sil24
[   50.985722] ata1: SATA max UDMA/100 cmd 0xffffc20000328000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
[   50.985786] ata2: SATA max UDMA/100 cmd 0xffffc2000032a000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
[   53.187373] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   53.331253] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r0, 6 ports, feat 0x9/0xb
[   53.443184] ata1.00: hard resetting link
[   54.006777] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   54.022765] ata1.01: hard resetting link
[   54.666304] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   54.682292] ata1.02: hard resetting link
[   55.293855] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   55.309843] ata1.03: hard resetting link
[   55.937393] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   55.953381] ata1.04: hard resetting link
[   56.580932] ata1.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   56.580980] ata1.05: hard resetting link
[   57.144528] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   57.180320] ata1.00: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[   57.180371] ata1.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   57.238586] ata1.00: configured for UDMA/100
[   57.323623] ata1.01: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[   57.323670] ata1.01: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   57.381887] ata1.01: configured for UDMA/100
[   57.411186] ata1.02: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[   57.411232] ata1.02: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   57.469450] ata1.02: configured for UDMA/100
[   57.499841] ata1.03: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[   57.499888] ata1.03: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   57.558108] ata1.03: configured for UDMA/100
[   57.589327] ata1.04: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[   57.589374] ata1.04: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   57.647596] ata1.04: configured for UDMA/100
[   57.647758] ata1.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[   57.647805] ata1: failed to recover some devices, retrying in 5 secs
[   62.649282] ata1.05: hard resetting link
[   63.212886] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   63.314995] ata1.00: configured for UDMA/100
[   63.433306] ata1.01: configured for UDMA/100
[   63.537472] ata1.02: configured for UDMA/100
[   63.642810] ata1.03: configured for UDMA/100
[   63.748971] ata1.04: configured for UDMA/100
[   63.749131] ata1.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[   63.764490] ata1.05: limiting SATA link speed to 1.5 Gbps
[   63.764537] ata1.05: limiting speed to UDMA7:PIO5
[   63.764582] ata1: failed to recover some devices, retrying in 5 secs
[   68.764898] ata1.05: hard resetting link
[   69.392458] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   69.392621] ata1.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[   69.392668] ata1: failed to recover some devices, retrying in 5 secs
[   74.392865] ata1.05: hard resetting link
[   74.956471] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   74.972460] ata1: EH pending after completion, repeating EH (cnt=4)
[   75.100368] ata1: EH complete
[   77.298095] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   77.441977] ata2.15: Port Multiplier 1.1, 0x1095:0x4726 r0, 6 ports, feat 0x9/0xb
[   77.553906] ata2.00: hard resetting link
[   78.117501] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   78.133489] ata2.01: hard resetting link
[   78.761040] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   78.785022] ata2.02: hard resetting link
[   79.412573] ata2.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   79.428561] ata2.03: hard resetting link
[   80.040123] ata2.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   80.056111] ata2.04: hard resetting link
[   80.667674] ata2.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   80.667721] ata2.05: hard resetting link
[   81.231270] ata2.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   81.262866] ata2.00: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[   81.262913] ata2.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   81.321132] ata2.00: configured for UDMA/100
[   81.354521] ata2.01: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[   81.354568] ata2.01: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   81.412788] ata2.01: configured for UDMA/100
[   81.445410] ata2.02: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[   81.445457] ata2.02: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   81.503678] ata2.02: configured for UDMA/100
[   81.536857] ata2.03: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[   81.536903] ata2.03: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   81.595123] ata2.03: configured for UDMA/100
[   81.627705] ata2.04: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[   81.627751] ata2.04: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   81.685971] ata2.04: configured for UDMA/100
[   81.686132] ata2.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[   81.686178] ata2: failed to recover some devices, retrying in 5 secs
[   86.688055] ata2.05: hard resetting link
[   87.251661] ata2.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   87.364235] ata2.00: configured for UDMA/100
[   87.472510] ata2.01: configured for UDMA/100
[   87.580225] ata2.02: configured for UDMA/100
[   87.688046] ata2.03: configured for UDMA/100
[   87.795499] ata2.04: configured for UDMA/100
[   87.795657] ata2.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[   87.811260] ata2.05: limiting SATA link speed to 1.5 Gbps
[   87.811306] ata2.05: limiting speed to UDMA7:PIO5
[   87.811351] ata2: failed to recover some devices, retrying in 5 secs
[   92.811668] ata2.05: hard resetting link
[   93.439228] ata2.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   93.439391] ata2.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[   93.439438] ata2: failed to recover some devices, retrying in 5 secs
[   98.439635] ata2.05: hard resetting link
[   99.003241] ata2.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   99.019230] ata2: EH pending after completion, repeating EH (cnt=4)
[   99.147138] ata2: EH complete
[   99.146576] scsi 0:0:0:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[   99.146715] scsi 0:0:1:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[   99.146840] scsi 0:0:2:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[   99.146967] scsi 0:0:3:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[   99.147091] scsi 0:0:4:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[   99.147216] scsi 1:0:0:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[   99.147343] scsi 1:0:1:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[   99.147469] scsi 1:0:2:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[   99.147596] scsi 1:0:3:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[   99.147719] scsi 1:0:4:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[   99.148681] sata_sil24 0000:04:01.0: Applying completion IRQ loss on PCI-X errata fix
[   99.148986] scsi2 : sata_sil24
[   99.149081] scsi3 : sata_sil24
[   99.149153] scsi4 : sata_sil24
[   99.149226] scsi5 : sata_sil24
[   99.149288] ata3: SATA max UDMA/100 cmd 0xffffc20000330000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
[   99.149352] ata4: SATA max UDMA/100 cmd 0xffffc20000332000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
[   99.149415] ata5: SATA max UDMA/100 cmd 0xffffc20000334000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
[   99.149479] ata6: SATA max UDMA/100 cmd 0xffffc20000336000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
[  101.228942] ata3: SATA link down (SStatus 0 SControl 0)
[  103.307449] ata4: SATA link down (SStatus 0 SControl 0)
[  105.537856] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  105.574723] ata5.00: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  105.574772] ata5.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32)
[  105.632988] ata5.00: configured for UDMA/100
[  107.844203] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  107.909555] ata6.00: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  107.909602] ata6.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32)
[  108.109323] ata6.00: configured for UDMA/100
[  108.108757] scsi 4:0:0:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  108.108899] scsi 5:0:0:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  108.109516] scsi6 : sata_sil24
[  108.109614] scsi7 : sata_sil24
[  108.109679] ata7: SATA max UDMA/100 cmd 0xffffc20000348000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
[  108.109745] ata8: SATA max UDMA/100 cmd 0xffffc2000034a000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
[  110.186524] ata7: SATA link down (SStatus 0 SControl 0)
[  112.265034] ata8: SATA link down (SStatus 0 SControl 0)
[  112.316560] sata_nv 0000:00:0d.0: version 3.4
[  112.317788] scsi8 : sata_nv
[  112.324167] scsi9 : sata_nv
[  112.324252] ata9: SATA max UDMA/133 cmd 0x00000000000109f0 ctl 0x0000000000010bf2 bmdma 0x000000000001dc00 irq 0
[  112.324316] ata10: SATA max UDMA/133 cmd 0x0000000000010970 ctl 0x0000000000010b72 bmdma 0x000000000001dc08 irq 0
[  112.365391] sd 0:0:0:0: [sda] 586072368 512-byte hardware sectors (300069 MB)
[  112.365668] sd 0:0:0:0: [sda] Write Protect is off
[  112.365716] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  112.368722] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.372744] sd 0:0:0:0: [sda] 586072368 512-byte hardware sectors (300069 MB)
[  112.373000] sd 0:0:0:0: [sda] Write Protect is off
[  112.373047] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  112.374422] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.374490]  sda: sda1
[  112.390609] sd 0:0:0:0: [sda] Attached SCSI disk
[  112.391411] sd 0:0:1:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  112.391467] sd 0:0:1:0: [sdb] Write Protect is off
[  112.391512] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[  112.391525] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.391621] sd 0:0:1:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  112.391675] sd 0:0:1:0: [sdb] Write Protect is off
[  112.391720] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[  112.391731] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.391792]  sdb: sdb1
[  112.433805] sd 0:0:1:0: [sdb] Attached SCSI disk
[  112.434589] sd 0:0:2:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  112.434643] sd 0:0:2:0: [sdc] Write Protect is off
[  112.434688] sd 0:0:2:0: [sdc] Mode Sense: 00 3a 00 00
[  112.434700] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.434793] sd 0:0:2:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  112.434846] sd 0:0:2:0: [sdc] Write Protect is off
[  112.434892] sd 0:0:2:0: [sdc] Mode Sense: 00 3a 00 00
[  112.434903] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.434963]  sdc: sdc1
[  112.454363] sd 0:0:2:0: [sdc] Attached SCSI disk
[  112.455143] sd 0:0:3:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  112.455197] sd 0:0:3:0: [sdd] Write Protect is off
[  112.455242] sd 0:0:3:0: [sdd] Mode Sense: 00 3a 00 00
[  112.455253] sd 0:0:3:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.455343] sd 0:0:3:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  112.455396] sd 0:0:3:0: [sdd] Write Protect is off
[  112.455441] sd 0:0:3:0: [sdd] Mode Sense: 00 3a 00 00
[  112.455452] sd 0:0:3:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.455512]  sdd: sdd1
[  112.476720] sd 0:0:3:0: [sdd] Attached SCSI disk
[  112.477519] sd 0:0:4:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  112.483764] sd 0:0:4:0: [sde] Write Protect is off
[  112.483810] sd 0:0:4:0: [sde] Mode Sense: 00 3a 00 00
[  112.483822] sd 0:0:4:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.483910] sd 0:0:4:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  112.483964] sd 0:0:4:0: [sde] Write Protect is off
[  112.484009] sd 0:0:4:0: [sde] Mode Sense: 00 3a 00 00
[  112.484020] sd 0:0:4:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.484080]  sde: sde1
[  112.499838] sd 0:0:4:0: [sde] Attached SCSI disk
[  112.500659] sd 1:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
[  112.500714] sd 1:0:0:0: [sdf] Write Protect is off
[  112.500759] sd 1:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[  112.500771] sd 1:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.500858] sd 1:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
[  112.500911] sd 1:0:0:0: [sdf] Write Protect is off
[  112.500956] sd 1:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[  112.500968] sd 1:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.501028]  sdf: sdf1
[  112.517003] sd 1:0:0:0: [sdf] Attached SCSI disk
[  112.517849] sd 1:0:1:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
[  112.517905] sd 1:0:1:0: [sdg] Write Protect is off
[  112.517950] sd 1:0:1:0: [sdg] Mode Sense: 00 3a 00 00
[  112.517962] sd 1:0:1:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.518050] sd 1:0:1:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
[  112.518103] sd 1:0:1:0: [sdg] Write Protect is off
[  112.518149] sd 1:0:1:0: [sdg] Mode Sense: 00 3a 00 00
[  112.518160] sd 1:0:1:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.518221]  sdg: sdg1
[  112.533592] sd 1:0:1:0: [sdg] Attached SCSI disk
[  112.534453] sd 1:0:2:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
[  112.534508] sd 1:0:2:0: [sdh] Write Protect is off
[  112.534553] sd 1:0:2:0: [sdh] Mode Sense: 00 3a 00 00
[  112.534565] sd 1:0:2:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.534654] sd 1:0:2:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
[  112.534708] sd 1:0:2:0: [sdh] Write Protect is off
[  112.534753] sd 1:0:2:0: [sdh] Mode Sense: 00 3a 00 00
[  112.534765] sd 1:0:2:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.534825]  sdh: sdh1
[  112.550479] sd 1:0:2:0: [sdh] Attached SCSI disk
[  112.551366] sd 1:0:3:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
[  112.551420] sd 1:0:3:0: [sdi] Write Protect is off
[  112.551466] sd 1:0:3:0: [sdi] Mode Sense: 00 3a 00 00
[  112.551478] sd 1:0:3:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.551570] sd 1:0:3:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
[  112.551623] sd 1:0:3:0: [sdi] Write Protect is off
[  112.551669] sd 1:0:3:0: [sdi] Mode Sense: 00 3a 00 00
[  112.551681] sd 1:0:3:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.551741]  sdi: sdi1
[  112.565642] sd 1:0:3:0: [sdi] Attached SCSI disk
[  112.566561] sd 1:0:4:0: [sdj] 586072368 512-byte hardware sectors (300069 MB)
[  112.566616] sd 1:0:4:0: [sdj] Write Protect is off
[  112.566661] sd 1:0:4:0: [sdj] Mode Sense: 00 3a 00 00
[  112.566673] sd 1:0:4:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.566766] sd 1:0:4:0: [sdj] 586072368 512-byte hardware sectors (300069 MB)
[  112.566820] sd 1:0:4:0: [sdj] Write Protect is off
[  112.566865] sd 1:0:4:0: [sdj] Mode Sense: 00 3a 00 00
[  112.566876] sd 1:0:4:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.566936]  sdj: sdj1
[  112.581407] sd 1:0:4:0: [sdj] Attached SCSI disk
[  112.582355] sd 4:0:0:0: [sdk] 586072368 512-byte hardware sectors (300069 MB)
[  112.582411] sd 4:0:0:0: [sdk] Write Protect is off
[  112.582456] sd 4:0:0:0: [sdk] Mode Sense: 00 3a 00 00
[  112.582467] sd 4:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.582562] sd 4:0:0:0: [sdk] 586072368 512-byte hardware sectors (300069 MB)
[  112.582615] sd 4:0:0:0: [sdk] Write Protect is off
[  112.582660] sd 4:0:0:0: [sdk] Mode Sense: 00 3a 00 00
[  112.582671] sd 4:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.582731]  sdk: sdk1
[  112.598081] sd 4:0:0:0: [sdk] Attached SCSI disk
[  112.599062] sd 5:0:0:0: [sdl] 586072368 512-byte hardware sectors (300069 MB)
[  112.599116] sd 5:0:0:0: [sdl] Write Protect is off
[  112.599161] sd 5:0:0:0: [sdl] Mode Sense: 00 3a 00 00
[  112.599173] sd 5:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.599261] sd 5:0:0:0: [sdl] 586072368 512-byte hardware sectors (300069 MB)
[  112.599313] sd 5:0:0:0: [sdl] Write Protect is off
[  112.599359] sd 5:0:0:0: [sdl] Mode Sense: 00 3a 00 00
[  112.599370] sd 5:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.599430]  sdl: sdl1
[  112.613091] sd 5:0:0:0: [sdl] Attached SCSI disk
[  112.792671] ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  112.844442] ata9.00: ATA-7: ST3500641AS, 3.AAJ, max UDMA/133
[  112.844493] ata9.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[  112.927659] ata9.00: configured for UDMA/133
[  113.396227] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  113.446869] ata10.00: ATA-7: ST3500641AS, 3.AAJ, max UDMA/133
[  113.446921] ata10.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[  113.530082] ata10.00: configured for UDMA/133
[  113.529519] scsi 8:0:0:0: Direct-Access     ATA      ST3500641AS      3.AA PQ: 0 ANSI: 5
[  113.530079] sd 8:0:0:0: [sdm] 976773168 512-byte hardware sectors (500108 MB)
[  113.530135] sd 8:0:0:0: [sdm] Write Protect is off
[  113.530180] sd 8:0:0:0: [sdm] Mode Sense: 00 3a 00 00
[  113.530193] sd 8:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  113.530291] sd 8:0:0:0: [sdm] 976773168 512-byte hardware sectors (500108 MB)
[  113.530344] sd 8:0:0:0: [sdm] Write Protect is off
[  113.530389] sd 8:0:0:0: [sdm] Mode Sense: 00 3a 00 00
[  113.530401] sd 8:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  113.530463]  sdm: sdm1 sdm2 sdm3
[  113.551040] sd 8:0:0:0: [sdm] Attached SCSI disk
[  113.551184] scsi 9:0:0:0: Direct-Access     ATA      ST3500641AS      3.AA PQ: 0 ANSI: 5
[  113.551298] sd 9:0:0:0: [sdn] 976773168 512-byte hardware sectors (500108 MB)
[  113.551353] sd 9:0:0:0: [sdn] Write Protect is off
[  113.551399] sd 9:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[  113.551411] sd 9:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  113.551513] sd 9:0:0:0: [sdn] 976773168 512-byte hardware sectors (500108 MB)
[  113.551566] sd 9:0:0:0: [sdn] Write Protect is off
[  113.551612] sd 9:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[  113.551623] sd 9:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  113.551685]  sdn: sdn1 sdn2 sdn3
[  113.586789] sd 9:0:0:0: [sdn] Attached SCSI disk
[  113.587689] scsi10 : sata_nv
[  113.587929] scsi11 : sata_nv
[  113.587998] ata11: SATA max UDMA/133 cmd 0x00000000000109e0 ctl 0x0000000000010be2 bmdma 0x000000000001c800 irq 0
[  113.588062] ata12: SATA max UDMA/133 cmd 0x0000000000010960 ctl 0x0000000000010b62 bmdma 0x000000000001c808 irq 0
[  114.055754] ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  114.108809] ata11.00: ATA-7: ST3500641AS, 3.AAJ, max UDMA/133
[  114.108858] ata11.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[  114.192025] ata11.00: configured for UDMA/133
[  114.659320] ata12: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  114.711689] ata12.00: ATA-7: ST3500641AS, 3.AAJ, max UDMA/133
[  114.711737] ata12.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[  114.794908] ata12.00: configured for UDMA/133
[  114.795020] scsi 10:0:0:0: Direct-Access     ATA      ST3500641AS      3.AA PQ: 0 ANSI: 5
[  114.795139] sd 10:0:0:0: [sdo] 976773168 512-byte hardware sectors (500108 MB)
[  114.795204] sd 10:0:0:0: [sdo] Write Protect is off
[  114.795250] sd 10:0:0:0: [sdo] Mode Sense: 00 3a 00 00
[  114.795262] sd 10:0:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  114.795361] sd 10:0:0:0: [sdo] 976773168 512-byte hardware sectors (500108 MB)
[  114.795424] sd 10:0:0:0: [sdo] Write Protect is off
[  114.795469] sd 10:0:0:0: [sdo] Mode Sense: 00 3a 00 00
[  114.795481] sd 10:0:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  114.795541]  sdo: sdo1 sdo2 sdo3
[  114.814713] sd 10:0:0:0: [sdo] Attached SCSI disk
[  114.814823] scsi 11:0:0:0: Direct-Access     ATA      ST3500641AS      3.AA PQ: 0 ANSI: 5
[  114.814928] sd 11:0:0:0: [sdp] 976773168 512-byte hardware sectors (500108 MB)
[  114.814991] sd 11:0:0:0: [sdp] Write Protect is off
[  114.815037] sd 11:0:0:0: [sdp] Mode Sense: 00 3a 00 00
[  114.815049] sd 11:0:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  114.815142] sd 11:0:0:0: [sdp] 976773168 512-byte hardware sectors (500108 MB)
[  114.815205] sd 11:0:0:0: [sdp] Write Protect is off
[  114.815250] sd 11:0:0:0: [sdp] Mode Sense: 00 3a 00 00
[  114.815262] sd 11:0:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  114.815322]  sdp: sdp1 sdp2 sdp3
[  114.843296] sd 11:0:0:0: [sdp] Attached SCSI disk
[  114.844174] scsi12 : sata_nv
[  114.844309] scsi13 : sata_nv
[  114.844375] ata13: SATA max UDMA/133 cmd 0x000000000001c400 ctl 0x000000000001c002 bmdma 0x000000000001b400 irq 0
[  114.844438] ata14: SATA max UDMA/133 cmd 0x000000000001bc00 ctl 0x000000000001b802 bmdma 0x000000000001b408 irq 0
[  115.310854] ata13: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  115.361243] ata13.00: ATA-7: ST3500641AS, 3.AAJ, max UDMA/133
[  115.361291] ata13.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[  115.444459] ata13.00: configured for UDMA/133
[  115.910423] ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  115.964155] ata14.00: ATA-7: ST3500641AS, 3.AAJ, max UDMA/133
[  115.964203] ata14.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[  116.047375] ata14.00: configured for UDMA/133
[  116.047487] scsi 12:0:0:0: Direct-Access     ATA      ST3500641AS      3.AA PQ: 0 ANSI: 5
[  116.047604] sd 12:0:0:0: [sdq] 976773168 512-byte hardware sectors (500108 MB)
[  116.047669] sd 12:0:0:0: [sdq] Write Protect is off
[  116.047714] sd 12:0:0:0: [sdq] Mode Sense: 00 3a 00 00
[  116.047727] sd 12:0:0:0: [sdq] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  116.054016] sd 12:0:0:0: [sdq] 976773168 512-byte hardware sectors (500108 MB)
[  116.054079] sd 12:0:0:0: [sdq] Write Protect is off
[  116.054124] sd 12:0:0:0: [sdq] Mode Sense: 00 3a 00 00
[  116.054136] sd 12:0:0:0: [sdq] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  116.054197]  sdq: sdq1 sdq2 sdq3
[  116.075464] sd 12:0:0:0: [sdq] Attached SCSI disk
[  116.075573] scsi 13:0:0:0: Direct-Access     ATA      ST3500641AS      3.AA PQ: 0 ANSI: 5
[  116.075672] sd 13:0:0:0: [sdr] 976773168 512-byte hardware sectors (500108 MB)
[  116.075736] sd 13:0:0:0: [sdr] Write Protect is off
[  116.075781] sd 13:0:0:0: [sdr] Mode Sense: 00 3a 00 00
[  116.075793] sd 13:0:0:0: [sdr] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  116.075878] sd 13:0:0:0: [sdr] 976773168 512-byte hardware sectors (500108 MB)
[  116.075941] sd 13:0:0:0: [sdr] Write Protect is off
[  116.075986] sd 13:0:0:0: [sdr] Mode Sense: 00 3a 00 00
[  116.075998] sd 13:0:0:0: [sdr] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  116.076058]  sdr: sdr1 sdr2 sdr3
[  116.095768] sd 13:0:0:0: [sdr] Attached SCSI disk
