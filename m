From: Tejun Heo <tj@kernel.org>
Subject: Re: sata EH on boot
Date: Wed, 11 Mar 2009 16:32:19 +0900
Message-ID: <49B76903.5030205@kernel.org>
References: <Pine.SOC.4.64.0903041006210.6557@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51566 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872AbZCKHb6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 03:31:58 -0400
In-Reply-To: <Pine.SOC.4.64.0903041006210.6557@math.ut.ee>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

cc'ing Robert and quoting whole body.

Meelis Roos wrote:
> Hello,
> 
> About during previous -rc period I started getting SATA error hangling 
> mesages about one disk on mostly(?) every boot. The messages disapeared 
> around 2.6.28 release so I put it to the rest.
> 
> However, now the messages are back. They happen to one specific disk - a 
> SATA-1 160G Seagate. They happen on every boot after root is mounted, do 
> their recovery and complete the EH and later the system works fine - 
> survives lots of disk activity.
> 
> Sometimes there are less lines in logs, sometimes more, the dmesg below 
> is the longest yet (from todays 2.6.29-rc7 boot).
> 
> smartctl -a /dev/sda tells nothing suspicious.
> 
> Any ideas?
> 
> forcedeth: Reverse Engineered nForce ethernet driver. Version 0.62.
> ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
> forcedeth 0000:00:08.0: PCI INT A -> Link[APCH] -> GSI 23 (level, low) -> IRQ 23
> forcedeth 0000:00:08.0: setting latency timer to 64
> nv_probe: set workaround bit for reversed mac addr
> forcedeth 0000:00:08.0: ifname eth0, PHY OUI 0x5043 @ 0, addr 00:50:8d:91:d9:f0
> forcedeth 0000:00:08.0: highdma csum vlan pwrctl mgmt timirq gbit lnktim msi desc-v3
> ACPI: PCI Interrupt Link [AMC1] enabled at IRQ 22
> forcedeth 0000:00:09.0: PCI INT A -> Link[AMC1] -> GSI 22 (level, low) -> IRQ 22
> forcedeth 0000:00:09.0: setting latency timer to 64
> nv_probe: set workaround bit for reversed mac addr
> forcedeth 0000:00:09.0: ifname eth1, PHY OUI 0x5043 @ 1, addr 00:50:8d:91:d9:f1
> forcedeth 0000:00:09.0: highdma csum vlan pwrctl mgmt timirq gbit lnktim msi desc-v3
> console [netcon0] enabled
> netconsole: network logging started
> Driver 'sd' needs updating - please use bus_type methods
> sata_nv 0000:00:05.0: version 3.5
> ACPI: PCI Interrupt Link [APSI] enabled at IRQ 21
> sata_nv 0000:00:05.0: PCI INT A -> Link[APSI] -> GSI 21 (level, low) -> IRQ 21
> sata_nv 0000:00:05.0: Using SWNCQ mode
> sata_nv 0000:00:05.0: setting latency timer to 64
> scsi0 : sata_nv
> scsi1 : sata_nv
> ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xdc00 irq 21
> ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xdc08 irq 21
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ATA-7: ST3160811AS, 3.AAE, max UDMA/133
> ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata1.00: configured for UDMA/133
> isa bounce pool size: 16 pages
> scsi 0:0:0:0: Direct-Access     ATA      ST3160811AS      3.AA PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 GB/149 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 GB/149 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1 sda2 sda3
> sd 0:0:0:0: [sda] Attached SCSI disk
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: ATA-7: WDC WD7500AAKS-00RBA0, 30.04G30, max UDMA/133
> ata2.00: 1465149168 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata2.00: configured for UDMA/133
> scsi 1:0:0:0: Direct-Access     ATA      WDC WD7500AAKS-0 30.0 PQ: 0 ANSI: 5
> sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors: (750 GB/698 GiB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors: (750 GB/698 GiB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sdb: sdb1
> sd 1:0:0:0: [sdb] Attached SCSI disk
> ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 20
> sata_nv 0000:00:05.1: PCI INT B -> Link[APSJ] -> GSI 20 (level, low) -> IRQ 20
> sata_nv 0000:00:05.1: Using SWNCQ mode
> sata_nv 0000:00:05.1: setting latency timer to 64
> scsi2 : sata_nv
> scsi3 : sata_nv
> ata3: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc800 irq 20
> ata4: SATA max UDMA/133 cmd 0x960 ctl 0xb60 bmdma 0xc808 irq 20
> ata3: SATA link down (SStatus 0 SControl 300)
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.00: ATA-7: ST3320620AS, 3.AAC, max UDMA/133
> ata4.00: 625134827 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata4.00: configured for UDMA/133
> scsi 3:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
> sd 3:0:0:0: [sdc] 625134827 512-byte hardware sectors: (320 GB/298 GiB)
> sd 3:0:0:0: [sdc] Write Protect is off
> sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 3:0:0:0: [sdc] 625134827 512-byte hardware sectors: (320 GB/298 GiB)
> sd 3:0:0:0: [sdc] Write Protect is off
> sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sdc: sdc1
> sd 3:0:0:0: [sdc] Attached SCSI disk
> ACPI: PCI Interrupt Link [ASA2] enabled at IRQ 23
> sata_nv 0000:00:05.2: PCI INT C -> Link[ASA2] -> GSI 23 (level, low) -> IRQ 23
> sata_nv 0000:00:05.2: Using SWNCQ mode
> sata_nv 0000:00:05.2: setting latency timer to 64
> scsi4 : sata_nv
> scsi5 : sata_nv
> ata5: SATA max UDMA/133 cmd 0xc400 ctl 0xc000 bmdma 0xb400 irq 23
> ata6: SATA max UDMA/133 cmd 0xbc00 ctl 0xb800 bmdma 0xb408 irq 23
> ata5: SATA link down (SStatus 0 SControl 300)
> ata6: SATA link down (SStatus 0 SControl 300)
> 
> [...]
> 
> pata_amd 0000:00:04.0: version 0.4.1
> pata_amd 0000:00:04.0: setting latency timer to 64
> scsi6 : pata_amd
> scsi7 : pata_amd
> ata7: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
> ata8: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
> ata7.00: ATAPI: _NEC DVD_RW ND-4571A, 1-01, max UDMA/33
> ata7: nv_mode_filter: 0x739f&0x701f->0x701f, BIOS=0x7000 (0xc0000000) ACPI=0x701f (60:600:0x13)
> ata7.00: configured for UDMA/33
> scsi 6:0:0:0: CD-ROM            _NEC     DVD_RW ND-4571A  1-01 PQ: 0 ANSI: 5
> ata8: port disabled. ignoring.
> 
> [...]
> 
> Driver 'sr' needs updating - please use bus_type methods
> sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> sr 6:0:0:0: Attached scsi CD-ROM sr0
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> sd 1:0:0:0: Attached scsi generic sg1 type 0
> sd 3:0:0:0: Attached scsi generic sg2 type 0
> sr 6:0:0:0: Attached scsi generic sg3 type 5
> 
> [...]
> 
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> firewire_core: created device fw0: GUID 00508d0000908bd3, S400
> ata1: EH in SWNCQ mode,QC:qc_active 0x7FFFFFCF sactive 0x7FFFFFCF
> ata1: SWNCQ:qc_active 0x7FFFFFCF defer_bits 0x0 last_issue_tag 0x3
>   dhfis 0x7FFFFFC7 dmafis 0x0 sdbfis 0x0
> ata1: ATA_REG 0xC0 ERR_REG 0x0
> ata1: tag : dhfis dmafis sdbfis sacitve
> ata1: tag 0x0: 1 0 0 1  
> ata1: tag 0x1: 1 0 0 1  
> ata1: tag 0x2: 1 0 0 1  
> ata1: tag 0x3: 0 0 0 1  
> ata1: tag 0x6: 1 0 0 1  
> ata1: tag 0x7: 1 0 0 1  
> ata1: tag 0x8: 1 0 0 1  
> ata1: tag 0x9: 1 0 0 1  
> ata1: tag 0xa: 1 0 0 1  
> ata1: tag 0xb: 1 0 0 1  
> ata1: tag 0xc: 1 0 0 1  
> ata1: tag 0xd: 1 0 0 1  
> ata1: tag 0xe: 1 0 0 1  
> ata1: tag 0xf: 1 0 0 1  
> ata1: tag 0x10: 1 0 0 1  
> ata1: tag 0x11: 1 0 0 1  
> ata1: tag 0x12: 1 0 0 1  
> ata1: tag 0x13: 1 0 0 1  
> ata1: tag 0x14: 1 0 0 1  
> ata1: tag 0x15: 1 0 0 1  
> ata1: tag 0x16: 1 0 0 1  
> ata1: tag 0x17: 1 0 0 1  
> ata1: tag 0x18: 1 0 0 1  
> ata1: tag 0x19: 1 0 0 1  
> ata1: tag 0x1a: 1 0 0 1  
> ata1: tag 0x1b: 1 0 0 1  
> ata1: tag 0x1c: 1 0 0 1  
> ata1: tag 0x1d: 1 0 0 1  
> ata1: tag 0x1e: 1 0 0 1  
> ata1.00: exception Emask 0x0 SAct 0x7fffffcf SErr 0x1800000 action 0x6 frozen
> ata1: SError: { LinkSeq TrStaTrns }
> ata1.00: cmd 60/08:00:b7:9b:b5/00:00:01:00:00/40 tag 0 ncq 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/50:08:3f:ac:b4/00:00:01:00:00/40 tag 1 ncq 40960 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/08:10:2f:b8:b4/00:00:01:00:00/40 tag 2 ncq 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/08:18:67:bb:b5/00:00:01:00:00/40 tag 3 ncq 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/08:30:c7:40:cd/00:00:01:00:00/40 tag 6 ncq 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/30:38:1f:b0:cd/00:00:01:00:00/40 tag 7 ncq 24576 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/10:40:17:cb:cd/00:00:01:00:00/40 tag 8 ncq 8192 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/58:48:8f:d2:cd/00:00:01:00:00/40 tag 9 ncq 45056 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/a8:50:a7:d3:cd/00:00:01:00:00/40 tag 10 ncq 86016 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/50:58:67:41:ce/00:00:01:00:00/40 tag 11 ncq 40960 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/28:60:3f:c4:ce/00:00:01:00:00/40 tag 12 ncq 20480 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/28:68:f7:39:cf/00:00:01:00:00/40 tag 13 ncq 20480 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/90:70:bf:3b:cf/00:00:01:00:00/40 tag 14 ncq 73728 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/e8:78:5f:3c:cf/00:00:01:00:00/40 tag 15 ncq 118784 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/28:80:9f:4d:cf/01:00:01:00:00/40 tag 16 ncq 151552 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/08:88:f7:ee:cf/00:00:01:00:00/40 tag 17 ncq 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/28:90:d7:f4:cf/00:00:01:00:00/40 tag 18 ncq 20480 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/b0:98:17:1f:d0/01:00:01:00:00/40 tag 19 ncq 221184 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/20:a0:1f:23:d0/00:00:01:00:00/40 tag 20 ncq 16384 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/70:a8:3f:37:d0/02:00:01:00:00/40 tag 21 ncq 319488 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/68:b0:ef:ae:d0/00:00:01:00:00/40 tag 22 ncq 53248 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/18:b8:6f:af:d0/01:00:01:00:00/40 tag 23 ncq 143360 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/70:c0:bf:b0:d0/01:00:01:00:00/40 tag 24 ncq 188416 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/68:c8:3f:b2:d0/00:00:01:00:00/40 tag 25 ncq 53248 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/e0:d0:a7:f4:d1/00:00:01:00:00/40 tag 26 ncq 114688 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/d8:d8:97:f5:d1/00:00:01:00:00/40 tag 27 ncq 110592 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/38:e0:bf:f6:d1/03:00:01:00:00/40 tag 28 ncq 421888 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/08:e8:8f:94:b3/00:00:01:00:00/40 tag 29 ncq 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1.00: cmd 60/08:f0:ff:a0:b3/00:00:01:00:00/40 tag 30 ncq 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: hard resetting link
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> 


-- 
tejun
