From: Brad Campbell <brad@wasp.net.au>
Subject: Still having problems with sata_promise on all late kernels
Date: Tue, 14 Aug 2007 07:04:30 +0400
Message-ID: <46C11BBE.6010802@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:38060 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755720AbXHNDEp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Aug 2007 23:04:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

G'day all,

This has been happening on a lightly loaded box for a while now. I have posted about it before.
The issue is now I've upgraded 3 drives from 250GB Maxtors to 750GB WD's, it's just getting worse, 
particularly when the drives are loaded. I've jumpered the WD's to 1.5GB PHY speed (I had to do that 
or the on-board via sata controller would not recognise one of the drives.
The box is a bit of a mish-mash of controllers. I have 3 Promise SATA150TX4, one SIL3112 (all on PCI 
cards) and the on-board 2 port VIA driver.

I'm at a bit of a loss as to what to do really, short of replacing the Promise cards with something 
else.

brad@srv:~$ dmesg | grep "hard resetting port" | wc -l
990
brad@srv:~$ uptime
  06:55:04 up  8:14,  9 users,  load average: 5.21, 5.27, 4.92
brad@srv:~$ uname -a
Linux srv 2.6.23-rc3 #3 Mon Aug 13 11:20:23 GST 2007 i686 GNU/Linux

brad@srv:~$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
00:0b.0 Mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
00:0c.0 Mass storage controller: Silicon Image, Inc. SiI 3112 [SATALink/SATARaid] Serial ATA 
Controller (rev 02)
00:0d.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 12)
00:0e.0 Mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master 
IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller 
(rev 60)
00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 80)
00:13.0 Mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 315PRO PCI/AGP VGA Display Adapter

brad@srv:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(TM) XP 2600+
stepping        : 0
cpu MHz         : 1916.544
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr 
sse syscall mmxext 3dnowext 3dnow ts
bogomips        : 3835.54
clflush size    : 32

brad@srv:~$ cat /proc/interrupts
            CPU0
   0:      71848   IO-APIC-edge      timer
   1:         17   IO-APIC-edge      i8042
   4:         62   IO-APIC-edge      serial
   8:          3   IO-APIC-edge      rtc
   9:          0   IO-APIC-fasteoi   acpi
  16:    1323517   IO-APIC-fasteoi   sata_sil, sata_promise
  17:     211665   IO-APIC-fasteoi   sata_via
  18:     272230   IO-APIC-fasteoi   sata_promise
  19:    4770431   IO-APIC-fasteoi   sata_promise, eth0
  20:    7353914   IO-APIC-fasteoi   eth1
  21:    4038815   IO-APIC-fasteoi   uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, 
ehci_hcd:usb5
NMI:          0
LOC:    9811571
ERR:          0
MIS:          0

brad@srv:~$ cat /proc/mdstat
Personalities : [raid0] [raid1] [raid6] [raid5] [raid4]
md2 : active raid5 sdo[0] sdb[3] sdn[2]
       1465148928 blocks level 5, 128k chunk, algorithm 2 [3/2] [U_U]
       [===========>.........]  recovery = 55.8% (409462104/732574464) finish=383.5min speed=14041K/sec

md0 : active raid5 sdd1[0] sdm1[9] sdl1[8] sdk1[7] sdj1[6] sdi1[5] sdh1[4] sdg1[3] sdf1[2] sde1[1]
       2206003968 blocks level 5, 128k chunk, algorithm 0 [10/10] [UUUUUUUUUU]

md5 : active raid1 sdc4[0] sda4[1]
       200217984 blocks [2/2] [UU]

md4 : active raid1 sdc3[0] sda3[1]
       4891712 blocks [2/2] [UU]

md3 : active raid1 sdc2[0] sda2[1]
       19542976 blocks [2/2] [UU]

md1 : active raid1 sdc1[0] sda1[1]
       19542976 blocks [2/2] [UU]

unused devices: <none>

[   28.626959] Freeing unused kernel memory: 192k freed
[   28.685039] sata_sil 0000:00:0c.0: version 2.2
[   28.685118] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 19 (level, low) -> IRQ 16
[   28.685361] scsi0 : sata_sil
[   28.685466] scsi1 : sata_sil
[   28.685545] ata1: SATA max UDMA/100 cmd 0xf881e080 ctl 0xf881e08a bmdma 0xf881e000 irq 16
[   28.685596] ata2: SATA max UDMA/100 cmd 0xf881e0c0 ctl 0xf881e0ca bmdma 0xf881e008 irq 16
[   29.165502] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   29.185927] ata1.00: ATA-7: Maxtor 7Y250M0, YAR51HW0, max UDMA/133
[   29.185968] ata1.00: 490234752 sectors, multi 16: LBA48
[   29.225879] ata1.00: configured for UDMA/100
[   29.715175] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   29.742761] ata2.00: ATA-7: WDC WD7500AAKS-00RBA0, 30.04G30, max UDMA/133
[   29.742803] ata2.00: 1465149168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   29.776035] ata2.00: configured for UDMA/100
[   29.776181] scsi 0:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   29.776333] sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
[   29.776387] sd 0:0:0:0: [sda] Write Protect is off
[   29.776427] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   29.776444] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   29.776540] sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
[   29.776589] sd 0:0:0:0: [sda] Write Protect is off
[   29.776629] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   29.776643] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   29.776694]  sda: sda1 sda2 sda3 sda4
[   29.790518] sd 0:0:0:0: [sda] Attached SCSI disk
[   29.790620] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   29.790727] scsi 1:0:0:0: Direct-Access     ATA      WDC WD7500AAKS-0 30.0 PQ: 0 ANSI: 5
[   29.790855] sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[   29.790911] sd 1:0:0:0: [sdb] Write Protect is off
[   29.790950] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   29.790965] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   29.791053] sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[   29.791108] sd 1:0:0:0: [sdb] Write Protect is off
[   29.791147] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   29.791161] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   29.791212]  sdb: unknown partition table
[   29.800633] sd 1:0:0:0: [sdb] Attached SCSI disk
[   29.800732] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   29.806178] sata_via 0000:00:0f.0: version 2.2
[   29.806224] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
[   29.806376] sata_via 0000:00:0f.0: routed to hard irq line 0
[   29.806472] scsi2 : sata_via
[   29.806580] scsi3 : sata_via
[   29.806667] ata3: SATA max UDMA/133 cmd 0x00017400 ctl 0x00017002 bmdma 0x00016000 irq 17
[   29.806718] ata4: SATA max UDMA/133 cmd 0x00016800 ctl 0x00016402 bmdma 0x00016008 irq 17
[   30.014986] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   30.215202] ata3.00: ATA-7: Maxtor 7Y250M0, YAR51HW0, max UDMA/133
[   30.215243] ata3.00: 490234752 sectors, multi 0: LBA48
[   30.255162] ata3.00: configured for UDMA/133
[   30.464719] ata4: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
[   30.475365] scsi 2:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   30.475510] sd 2:0:0:0: [sdc] 490234752 512-byte hardware sectors (251000 MB)
[   30.475563] sd 2:0:0:0: [sdc] Write Protect is off
[   30.475603] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   30.475619] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   30.475715] sd 2:0:0:0: [sdc] 490234752 512-byte hardware sectors (251000 MB)
[   30.475763] sd 2:0:0:0: [sdc] Write Protect is off
[   30.475803] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   30.475816] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   30.475868]  sdc: sdc1 sdc2 sdc3 sdc4
[   30.483558] sd 2:0:0:0: [sdc] Attached SCSI disk
[   30.483662] sd 2:0:0:0: Attached scsi generic sg2 type 0
[   30.488904] sata_promise 0000:00:0b.0: version 2.09
[   30.488930] ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 16
[   30.504787] scsi4 : sata_promise
[   30.504903] scsi5 : sata_promise
[   30.504992] scsi6 : sata_promise
[   30.505081] scsi7 : sata_promise
[   30.505172] ata5: SATA max UDMA/133 cmd 0xf882c200 ctl 0xf882c238 bmdma 0x00000000 irq 16
[   30.505223] ata6: SATA max UDMA/133 cmd 0xf882c280 ctl 0xf882c2b8 bmdma 0x00000000 irq 16
[   30.505274] ata7: SATA max UDMA/133 cmd 0xf882c300 ctl 0xf882c338 bmdma 0x00000000 irq 16
[   30.505324] ata8: SATA max UDMA/133 cmd 0xf882c380 ctl 0xf882c3b8 bmdma 0x00000000 irq 16
[   30.994427] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   31.014865] ata5.00: ATA-7: Maxtor 7Y250M0, YAR51EW0, max UDMA/133
[   31.014906] ata5.00: 490234752 sectors, multi 0: LBA48
[   31.054821] ata5.00: configured for UDMA/133
[   31.544099] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   31.564540] ata6.00: ATA-7: Maxtor 7Y250M0, YAR51EW0, max UDMA/133
[   31.564581] ata6.00: 490234752 sectors, multi 0: LBA48
[   31.604496] ata6.00: configured for UDMA/133
[   32.093775] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   32.114196] ata7.00: ATA-7: Maxtor 7Y250M0, YAR51EW0, max UDMA/133
[   32.114237] ata7.00: 490234752 sectors, multi 0: LBA48
[   32.154173] ata7.00: configured for UDMA/133
[   32.643450] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   32.663870] ata8.00: ATA-7: Maxtor 7Y250M0, YAR51EW0, max UDMA/133
[   32.663911] ata8.00: 490234752 sectors, multi 0: LBA48
[   32.703859] ata8.00: configured for UDMA/133
[   32.704007] scsi 4:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   32.704153] sd 4:0:0:0: [sdd] 490234752 512-byte hardware sectors (251000 MB)
[   32.704207] sd 4:0:0:0: [sdd] Write Protect is off
[   32.704247] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   32.704264] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.704367] sd 4:0:0:0: [sdd] 490234752 512-byte hardware sectors (251000 MB)
[   32.704416] sd 4:0:0:0: [sdd] Write Protect is off
[   32.704456] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   32.704471] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.704522]  sdd: sdd1
[   32.721933] sd 4:0:0:0: [sdd] Attached SCSI disk
[   32.722035] sd 4:0:0:0: Attached scsi generic sg3 type 0
[   32.722135] scsi 5:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   32.722270] sd 5:0:0:0: [sde] 490234752 512-byte hardware sectors (251000 MB)
[   32.722320] sd 5:0:0:0: [sde] Write Protect is off
[   32.722359] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   32.722374] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.722452] sd 5:0:0:0: [sde] 490234752 512-byte hardware sectors (251000 MB)
[   32.722501] sd 5:0:0:0: [sde] Write Protect is off
[   32.722541] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   32.722555] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.722605]  sde: sde1
[   32.741783] sd 5:0:0:0: [sde] Attached SCSI disk
[   32.741880] sd 5:0:0:0: Attached scsi generic sg4 type 0
[   32.741977] scsi 6:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   32.742111] sd 6:0:0:0: [sdf] 490234752 512-byte hardware sectors (251000 MB)
[   32.742160] sd 6:0:0:0: [sdf] Write Protect is off
[   32.742200] sd 6:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   32.742214] sd 6:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.742290] sd 6:0:0:0: [sdf] 490234752 512-byte hardware sectors (251000 MB)
[   32.742339] sd 6:0:0:0: [sdf] Write Protect is off
[   32.742378] sd 6:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   32.742392] sd 6:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.742443]  sdf: sdf1
[   32.787559] sd 6:0:0:0: [sdf] Attached SCSI disk
[   32.787655] sd 6:0:0:0: Attached scsi generic sg5 type 0
[   32.787757] scsi 7:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   32.787879] sd 7:0:0:0: [sdg] 490234752 512-byte hardware sectors (251000 MB)
[   32.787929] sd 7:0:0:0: [sdg] Write Protect is off
[   32.787969] sd 7:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[   32.787983] sd 7:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.788060] sd 7:0:0:0: [sdg] 490234752 512-byte hardware sectors (251000 MB)
[   32.788109] sd 7:0:0:0: [sdg] Write Protect is off
[   32.788148] sd 7:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[   32.788163] sd 7:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.788213]  sdg: sdg1
[   32.812064] sd 7:0:0:0: [sdg] Attached SCSI disk
[   32.812157] sd 7:0:0:0: Attached scsi generic sg6 type 0
[   32.812993] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 18
[   32.823377] scsi8 : sata_promise
[   32.823466] scsi9 : sata_promise
[   32.823549] scsi10 : sata_promise
[   32.823635] scsi11 : sata_promise
[   32.823718] ata9: SATA max UDMA/133 cmd 0xf882e200 ctl 0xf882e238 bmdma 0x00000000 irq 18
[   32.823769] ata10: SATA max UDMA/133 cmd 0xf882e280 ctl 0xf882e2b8 bmdma 0x00000000 irq 18
[   32.823819] ata11: SATA max UDMA/133 cmd 0xf882e300 ctl 0xf882e338 bmdma 0x00000000 irq 18
[   32.823869] ata12: SATA max UDMA/133 cmd 0xf882e380 ctl 0xf882e3b8 bmdma 0x00000000 irq 18
[   33.313055] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   33.333475] ata9.00: ATA-7: Maxtor 7Y250M0, YAR51EW0, max UDMA/133
[   33.333517] ata9.00: 490234752 sectors, multi 0: LBA48
[   33.373459] ata9.00: configured for UDMA/133
[   33.862730] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   33.883156] ata10.00: ATA-7: Maxtor 7Y250M0, YAR51EW0, max UDMA/133
[   33.883197] ata10.00: 490234752 sectors, multi 0: LBA48
[   33.923143] ata10.00: configured for UDMA/133
[   34.412405] ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   34.432835] ata11.00: ATA-7: Maxtor 7Y250M0, YAR51EW0, max UDMA/133
[   34.432876] ata11.00: 490234752 sectors, multi 0: LBA48
[   34.472799] ata11.00: configured for UDMA/133
[   34.962080] ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   34.982499] ata12.00: ATA-7: Maxtor 7Y250M0, YAR51EW0, max UDMA/133
[   34.982540] ata12.00: 490234752 sectors, multi 0: LBA48
[   35.022488] ata12.00: configured for UDMA/133
[   35.022581] scsi 8:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   35.022713] sd 8:0:0:0: [sdh] 490234752 512-byte hardware sectors (251000 MB)
[   35.022763] sd 8:0:0:0: [sdh] Write Protect is off
[   35.022802] sd 8:0:0:0: [sdh] Mode Sense: 00 3a 00 00
[   35.022817] sd 8:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   35.022897] sd 8:0:0:0: [sdh] 490234752 512-byte hardware sectors (251000 MB)
[   35.022946] sd 8:0:0:0: [sdh] Write Protect is off
[   35.022985] sd 8:0:0:0: [sdh] Mode Sense: 00 3a 00 00
[   35.023000] sd 8:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   35.023051]  sdh: sdh1
[   35.042161] sd 8:0:0:0: [sdh] Attached SCSI disk
[   35.042259] sd 8:0:0:0: Attached scsi generic sg7 type 0
[   35.042364] scsi 9:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   35.042494] sd 9:0:0:0: [sdi] 490234752 512-byte hardware sectors (251000 MB)
[   35.042544] sd 9:0:0:0: [sdi] Write Protect is off
[   35.042584] sd 9:0:0:0: [sdi] Mode Sense: 00 3a 00 00
[   35.042598] sd 9:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   35.042676] sd 9:0:0:0: [sdi] 490234752 512-byte hardware sectors (251000 MB)
[   35.042725] sd 9:0:0:0: [sdi] Write Protect is off
[   35.042764] sd 9:0:0:0: [sdi] Mode Sense: 00 3a 00 00
[   35.042778] sd 9:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   35.042829]  sdi: sdi1
[   35.061735] sd 9:0:0:0: [sdi] Attached SCSI disk
[   35.061842] sd 9:0:0:0: Attached scsi generic sg8 type 0
[   35.061937] scsi 10:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   35.062073] sd 10:0:0:0: [sdj] 490234752 512-byte hardware sectors (251000 MB)
[   35.062129] sd 10:0:0:0: [sdj] Write Protect is off
[   35.062169] sd 10:0:0:0: [sdj] Mode Sense: 00 3a 00 00
[   35.062183] sd 10:0:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   35.062271] sd 10:0:0:0: [sdj] 490234752 512-byte hardware sectors (251000 MB)
[   35.062326] sd 10:0:0:0: [sdj] Write Protect is off
[   35.062365] sd 10:0:0:0: [sdj] Mode Sense: 00 3a 00 00
[   35.062379] sd 10:0:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   35.062430]  sdj: sdj1
[   35.083112] sd 10:0:0:0: [sdj] Attached SCSI disk
[   35.083216] sd 10:0:0:0: Attached scsi generic sg9 type 0
[   35.083312] scsi 11:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   35.083437] sd 11:0:0:0: [sdk] 490234752 512-byte hardware sectors (251000 MB)
[   35.083492] sd 11:0:0:0: [sdk] Write Protect is off
[   35.083532] sd 11:0:0:0: [sdk] Mode Sense: 00 3a 00 00
[   35.083546] sd 11:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   35.083623] sd 11:0:0:0: [sdk] 490234752 512-byte hardware sectors (251000 MB)
[   35.083678] sd 11:0:0:0: [sdk] Write Protect is off
[   35.083718] sd 11:0:0:0: [sdk] Mode Sense: 00 3a 00 00
[   35.083732] sd 11:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   35.083783]  sdk: sdk1
[   35.102151] sd 11:0:0:0: [sdk] Attached SCSI disk
[   35.102247] sd 11:0:0:0: Attached scsi generic sg10 type 0
[   35.102328] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 18 (level, low) -> IRQ 19
[   35.122021] scsi12 : sata_promise
[   35.122118] scsi13 : sata_promise
[   35.122202] scsi14 : sata_promise
[   35.122293] scsi15 : sata_promise
[   35.122370] ata13: SATA max UDMA/133 cmd 0xf8830200 ctl 0xf8830238 bmdma 0x00000000 irq 19
[   35.122421] ata14: SATA max UDMA/133 cmd 0xf8830280 ctl 0xf88302b8 bmdma 0x00000000 irq 19
[   35.122472] ata15: SATA max UDMA/133 cmd 0xf8830300 ctl 0xf8830338 bmdma 0x00000000 irq 19
[   35.122522] ata16: SATA max UDMA/133 cmd 0xf8830380 ctl 0xf88303b8 bmdma 0x00000000 irq 19
[   35.611701] ata13: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   35.632191] ata13.00: ATA-7: Maxtor 7Y250M0, YAR51EW0, max UDMA/133
[   35.632233] ata13.00: 490234752 sectors, multi 0: LBA48
[   35.672183] ata13.00: configured for UDMA/133
[   36.161376] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   36.181863] ata14.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[   36.181904] ata14.00: 490234752 sectors, multi 0: LBA48
[   36.221848] ata14.00: configured for UDMA/133
[   36.711051] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   36.731024] Switched to high resolution mode on CPU 0
[   36.740905] ata15.00: ATA-7: WDC WD7500AAKS-00RBA0, 30.04G30, max UDMA/133
[   36.740946] ata15.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   36.771967] ata15.00: configured for UDMA/133
[   37.260977] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   37.291678] ata16.00: ATA-7: WDC WD7500AAKS-00RBA0, 30.04G30, max UDMA/133
[   37.291720] ata16.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   37.331930] ata16.00: configured for UDMA/133
[   37.332018] scsi 12:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   37.332145] sd 12:0:0:0: [sdl] 490234752 512-byte hardware sectors (251000 MB)
[   37.332201] sd 12:0:0:0: [sdl] Write Protect is off
[   37.332240] sd 12:0:0:0: [sdl] Mode Sense: 00 3a 00 00
[   37.332255] sd 12:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   37.332335] sd 12:0:0:0: [sdl] 490234752 512-byte hardware sectors (251000 MB)
[   37.332390] sd 12:0:0:0: [sdl] Write Protect is off
[   37.332430] sd 12:0:0:0: [sdl] Mode Sense: 00 3a 00 00
[   37.332444] sd 12:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   37.332495]  sdl: sdl1
[   37.355681] sd 12:0:0:0: [sdl] Attached SCSI disk
[   37.355776] sd 12:0:0:0: Attached scsi generic sg11 type 0
[   37.355874] scsi 13:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   37.356000] sd 13:0:0:0: [sdm] 490234752 512-byte hardware sectors (251000 MB)
[   37.356056] sd 13:0:0:0: [sdm] Write Protect is off
[   37.356096] sd 13:0:0:0: [sdm] Mode Sense: 00 3a 00 00
[   37.356110] sd 13:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   37.356187] sd 13:0:0:0: [sdm] 490234752 512-byte hardware sectors (251000 MB)
[   37.356242] sd 13:0:0:0: [sdm] Write Protect is off
[   37.356282] sd 13:0:0:0: [sdm] Mode Sense: 00 3a 00 00
[   37.356296] sd 13:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   37.356347]  sdm: sdm1
[   37.366978] sd 13:0:0:0: [sdm] Attached SCSI disk
[   37.367080] sd 13:0:0:0: Attached scsi generic sg12 type 0
[   37.367176] scsi 14:0:0:0: Direct-Access     ATA      WDC WD7500AAKS-0 30.0 PQ: 0 ANSI: 5
[   37.367303] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[   37.367359] sd 14:0:0:0: [sdn] Write Protect is off
[   37.367399] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[   37.367413] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   37.367498] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[   37.368305] sd 14:0:0:0: [sdn] Write Protect is off
[   37.368345] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[   37.368359] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   37.368409]  sdn: unknown partition table
[   37.371026] sd 14:0:0:0: [sdn] Attached SCSI disk
[   37.371129] sd 14:0:0:0: Attached scsi generic sg13 type 0
[   37.371225] scsi 15:0:0:0: Direct-Access     ATA      WDC WD7500AAKS-0 30.0 PQ: 0 ANSI: 5
[   37.371355] sd 15:0:0:0: [sdo] 1465149168 512-byte hardware sectors (750156 MB)
[   37.371411] sd 15:0:0:0: [sdo] Write Protect is off
[   37.371450] sd 15:0:0:0: [sdo] Mode Sense: 00 3a 00 00
[   37.371465] sd 15:0:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   37.371550] sd 15:0:0:0: [sdo] 1465149168 512-byte hardware sectors (750156 MB)
[   37.371606] sd 15:0:0:0: [sdo] Write Protect is off
[   37.371645] sd 15:0:0:0: [sdo] Mode Sense: 00 3a 00 00
[   37.371659] sd 15:0:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   37.371710]  sdo: unknown partition table
[   37.374420] sd 15:0:0:0: [sdo] Attached SCSI disk
[   37.374523] sd 15:0:0:0: Attached scsi generic sg14 type 0

<snip lots and lots of errors>

[28709.825489] ata15: hard resetting port
[28710.327227] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[28710.378398] ata15.00: configured for UDMA/33
[28710.378441] ata15: EH complete
[28710.460556] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[28710.499998] sd 14:0:0:0: [sdn] Write Protect is off
[28710.500028] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[28710.562799] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[28741.832705] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[28741.832733] ata15.00: port_status 0x20200000
[28741.832751] ata15.00: cmd 25/00:00:00:b1:54/00:04:2f:00:00/e0 tag 0 cdb 0x0 data 524288 in
[28741.832753]          res 51/0c:5f:a1:b1:54/0c:03:2f:00:00/e0 Emask 0x10 (ATA bus error)
[28741.832806] ata15: hard resetting port
[28742.358261] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[28742.413120] ata15.00: configured for UDMA/33
[28742.413163] ata15: EH complete
[28742.487607] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[28742.526602] sd 14:0:0:0: [sdn] Write Protect is off
[28742.526631] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[28742.591078] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[28795.033648] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[28795.033675] ata15.00: port_status 0x20200000
[28795.033693] ata15.00: cmd 25/00:00:00:85:6b/00:04:2f:00:00/e0 tag 0 cdb 0x0 data 524288 in
[28795.033695]          res 51/0c:2f:d1:85:6b/0c:03:2f:00:00/e0 Emask 0x10 (ATA bus error)
[28795.033747] ata15: hard resetting port
[28795.536735] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[28795.617197] ata15.00: configured for UDMA/33
[28795.617241] ata15: EH complete
[28795.703828] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[28795.752159] sd 14:0:0:0: [sdn] Write Protect is off
[28795.752190] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[28795.803082] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[28940.313319] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[28940.313347] ata15.00: port_status 0x20200000
[28940.313365] ata15.00: cmd 25/00:00:a0:57:a0/00:04:2f:00:00/e0 tag 0 cdb 0x0 data 524288 in
[28940.313367]          res 51/0c:5f:41:5a:a0/0c:01:2f:00:00/e0 Emask 0x10 (ATA bus error)
[28940.313423] ata15: hard resetting port
[28940.821227] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[28940.881930] ata15.00: configured for UDMA/33
[28940.881973] ata15: EH complete
[28940.960533] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[28940.968408] sd 14:0:0:0: [sdn] Write Protect is off
[28940.968427] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[28940.979329] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29193.654162] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29193.654193] ata15.00: port_status 0x20200000
[29193.654211] ata15.00: cmd 25/00:00:00:db:ec/00:04:2f:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29193.654213]          res 51/0c:2f:d1:db:ec/0c:03:2f:00:00/e0 Emask 0x10 (ATA bus error)
[29193.654271] ata15: hard resetting port
[29194.160468] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29194.241583] ata15.00: configured for UDMA/33
[29194.241627] ata15: EH complete
[29194.410207] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29194.410746] sd 14:0:0:0: [sdn] Write Protect is off
[29194.410763] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29194.495828] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29195.659632] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29195.659659] ata15.00: port_status 0x20200000
[29195.659677] ata15.00: cmd 25/00:00:00:4b:ed/00:04:2f:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29195.659679]          res 51/0c:bf:41:4d:ed/0c:01:2f:00:00/e0 Emask 0x10 (ATA bus error)
[29195.659732] ata15: hard resetting port
[29196.159157] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29196.240367] ata15.00: configured for UDMA/33
[29196.240410] ata15: EH complete
[29196.311812] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29196.312786] sd 14:0:0:0: [sdn] Write Protect is off
[29196.312805] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29196.327517] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29203.938497] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29203.938524] ata15.00: port_status 0x20200000
[29203.938542] ata15.00: cmd 25/00:00:b0:ea:ef/00:04:2f:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29203.938545]          res 51/0c:7f:31:eb:ef/0c:03:2f:00:00/e0 Emask 0x10 (ATA bus error)
[29203.938598] ata15: hard resetting port
[29204.524234] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29204.595683] ata15.00: configured for UDMA/33
[29204.595726] ata15: EH complete
[29204.677730] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29204.718810] sd 14:0:0:0: [sdn] Write Protect is off
[29204.718841] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29204.781863] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29209.243050] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29209.243078] ata15.00: port_status 0x20200000
[29209.243096] ata15.00: cmd 25/00:00:d0:56:f1/00:04:2f:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29209.243098]          res 51/0c:0f:c1:57:f1/0c:03:2f:00:00/e0 Emask 0x10 (ATA bus error)
[29209.243151] ata15: hard resetting port
[29209.801099] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29209.882794] ata15.00: configured for UDMA/33
[29209.882836] ata15: EH complete
[29209.968689] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29209.983562] sd 14:0:0:0: [sdn] Write Protect is off
[29209.983592] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29209.987341] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29264.619705] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29264.619734] ata15.00: port_status 0x20200000
[29264.619752] ata15.00: cmd 25/00:00:00:1b:02/00:04:30:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29264.619754]          res 51/0c:00:ff:1e:02/0c:00:30:00:00/e0 Emask 0x10 (ATA bus error)
[29264.619808] ata15: hard resetting port
[29265.199696] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29265.248788] ata15.00: configured for UDMA/33
[29265.248832] ata15: EH complete
[29265.328952] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29265.369406] sd 14:0:0:0: [sdn] Write Protect is off
[29265.369436] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29265.432610] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29309.946702] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29309.946730] ata15.00: port_status 0x20200000
[29309.946748] ata15.00: cmd 25/00:00:00:6b:15/00:04:30:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29309.946750]          res 51/0c:9f:61:6e:15/0c:00:30:00:00/e0 Emask 0x10 (ATA bus error)
[29309.946811] ata15: hard resetting port
[29310.491333] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29310.572766] ata15.00: configured for UDMA/33
[29310.572808] ata15: EH complete
[29310.655530] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29310.695178] sd 14:0:0:0: [sdn] Write Protect is off
[29310.695208] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29310.763870] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29312.542555] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29312.542582] ata15.00: port_status 0x20200000
[29312.542600] ata15.00: cmd 25/00:00:00:47:16/00:04:30:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29312.542602]          res 51/0c:ff:01:48:16/0c:02:30:00:00/e0 Emask 0x10 (ATA bus error)
[29312.542655] ata15: hard resetting port
[29313.049971] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29313.100785] ata15.00: configured for UDMA/33
[29313.100820] ata15: EH complete
[29313.248726] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29313.319242] sd 14:0:0:0: [sdn] Write Protect is off
[29313.319272] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29313.389715] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29317.568100] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29317.568128] ata15.00: port_status 0x20200000
[29317.568146] ata15.00: cmd 25/00:00:30:4d:18/00:04:30:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29317.568148]          res 51/0c:7f:b1:4e:18/0c:02:30:00:00/e0 Emask 0x10 (ATA bus error)
[29317.568201] ata15: hard resetting port
[29318.077123] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29318.137807] ata15.00: configured for UDMA/33
[29318.137850] ata15: EH complete
[29318.216414] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29318.256434] sd 14:0:0:0: [sdn] Write Protect is off
[29318.256491] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29318.394857] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29470.310985] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29470.311012] ata15.00: port_status 0x20200000
[29470.311030] ata15.00: cmd 25/00:00:00:ea:56/00:04:30:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29470.311032]          res 51/0c:7f:81:ea:56/0c:03:30:00:00/e0 Emask 0x10 (ATA bus error)
[29470.311085] ata15: hard resetting port
[29470.816829] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29470.897960] ata15.00: configured for UDMA/33
[29470.898034] ata15: EH complete
[29470.980584] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29471.022850] sd 14:0:0:0: [sdn] Write Protect is off
[29471.022879] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29471.086914] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29506.727933] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29506.727961] ata15.00: port_status 0x20200000
[29506.727979] ata15.00: cmd 25/00:00:00:71:64/00:04:30:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29506.727981]          res 51/0c:4f:b1:72:64/0c:02:30:00:00/e0 Emask 0x10 (ATA bus error)
[29506.728034] ata15: hard resetting port
[29507.234647] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29507.296034] ata15.00: configured for UDMA/33
[29507.296071] ata15: EH complete
[29507.373399] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29507.545398] sd 14:0:0:0: [sdn] Write Protect is off
[29507.545430] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29507.622395] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29555.709386] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29555.709414] ata15.00: port_status 0x20200000
[29555.709432] ata15.00: cmd 25/00:00:00:bd:75/00:04:30:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29555.709434]          res 51/0c:ef:11:c0:75/0c:00:30:00:00/e0 Emask 0x10 (ATA bus error)
[29555.709488] ata15: hard resetting port
[29556.235991] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29556.306323] ata15.00: configured for UDMA/33
[29556.306360] ata15: EH complete
[29556.378394] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29556.549202] sd 14:0:0:0: [sdn] Write Protect is off
[29556.549232] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29556.609265] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[29559.807528] ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
[29559.807555] ata15.00: port_status 0x20200000
[29559.807573] ata15.00: cmd 25/00:00:00:51:77/00:04:30:00:00/e0 tag 0 cdb 0x0 data 524288 in
[29559.807575]          res 51/0c:9f:61:52:77/0c:02:30:00:00/e0 Emask 0x10 (ATA bus error)
[29559.807654] ata15: hard resetting port
[29560.313376] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29560.394924] ata15.00: configured for UDMA/33
[29560.394961] ata15: EH complete
[29560.543396] sd 14:0:0:0: [sdn] 1465149168 512-byte hardware sectors (750156 MB)
[29560.573796] sd 14:0:0:0: [sdn] Write Protect is off
[29560.573825] sd 14:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[29560.657737] sd 14:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
