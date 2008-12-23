From: Sami Farin <safari-kernel@safari.iki.fi>
Subject: SATA / DVD-RW: recovering from write errors without rebooting
Date: Tue, 23 Dec 2008 03:26:19 +0200
Message-ID: <20081223012619.dj3ssmpbiff6zcvf@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7fprigsjr7i4n2hz"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:55497 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbYLWB00 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Dec 2008 20:26:26 -0500
Received: from safari.iki.fi (80.223.84.180) by kirsi2.inet.fi (8.5.014)
        id 48FC5B8902E13F61 for linux-ide@vger.kernel.org; Tue, 23 Dec 2008 03:26:23 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux ide Mailing List <linux-ide@vger.kernel.org>


--7fprigsjr7i4n2hz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'd like to know one thing: Is this a hardware bug or a software bug.

When I write a DVD-RW with growisofs and there's some (media) error,
I get some ata errors and DVD's led stays green, and I can't
reset the drive, eject disk with software or by pressing
drive's eject button.  It does not matter if I open the drive
door and put in some other disc.

I have SATA drive HL-DT-ST DVD-RAM GH22NS30 1.01,
one SATA hard disk, one PATA hard disk, Intel motherboard
DQ965GF version CO96510J.86A.6079.2008.0727.2220,
Linux x86_64 2.6.27.10.
I already wrote to LG (manufacturer of DVD drive) a couple
of weeks ago but I have not heard back.

At around 01:57:08.431689628 I opened case and replugged power
cable from the DVD drive.  Kernel detected it, but then after
some seconds I got something like "hda: command timed out"
and then hard freeze (had to power cycle).
No kernel messages were available after 01:57:55.999123925.

2008-12-23 01:44:55.656343805 <3>[17524.249147] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
2008-12-23 01:44:55.656346265 <3>[17524.249158] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
2008-12-23 01:44:55.656347206 <3>[17524.249159]          cdb 54 01 00 00 00 00 00 00  00 00 00 00 00 00 00 00
2008-12-23 01:44:55.656348135 <3>[17524.249161]          res 40/00:03:00:18:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
2008-12-23 01:44:55.656349088 <3>[17524.249164] ata4.00: status: { DRDY }
2008-12-23 01:44:55.656349714 <6>[17524.249171] ata4: hard resetting link
2008-12-23 01:44:55.961280094 <6>[17524.554144] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
2008-12-23 01:44:55.964089698 <6>[17524.556852] ata4.00: configured for UDMA/100
2008-12-23 01:44:55.964091029 <6>[17524.556875] ata4: EH complete
2008-12-23 01:45:55.966348828 <3>[17584.559149] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
2008-12-23 01:45:55.966351426 <3>[17584.559161] ata4.00: cmd a0/01:00:00:00:80/00:00:00:00:00/a0 tag 0 dma 32768 out
2008-12-23 01:45:55.966352479 <3>[17584.559163]          cdb 2a 00 00 00 00 00 00 00  10 00 00 00 00 00 00 00
2008-12-23 01:45:55.966353405 <3>[17584.559164]          res 40/00:03:00:18:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
2008-12-23 01:45:55.966354339 <3>[17584.559167] ata4.00: status: { DRDY }
2008-12-23 01:45:55.966354962 <6>[17584.559174] ata4: hard resetting link
2008-12-23 01:45:56.271288460 <6>[17584.864145] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
2008-12-23 01:45:56.275602728 <6>[17584.866809] ata4.00: configured for UDMA/100
2008-12-23 01:45:56.275606194 <6>[17584.866831] ata4: EH complete

2008-12-23 01:49:58.286330148 <4>[17826.879146] ata4: limiting SATA link speed to 1.5 Gbps
2008-12-23 01:49:58.286366841 <3>[17826.879154] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
2008-12-23 01:49:58.286390100 <3>[17826.879162] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
2008-12-23 01:49:58.286412270 <3>[17826.879163]          cdb 1b 00 00 00 03 00 00 00  00 00 00 00 00 00 00 00
2008-12-23 01:49:58.286434918 <3>[17826.879165]          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
2008-12-23 01:49:58.286456553 <3>[17826.879168] ata4.00: status: { DRDY }
2008-12-23 01:49:58.286477612 <6>[17826.879174] ata4: hard resetting link
2008-12-23 01:49:58.591286039 <6>[17827.184144] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
2008-12-23 01:49:58.593975535 <6>[17827.186848] ata4.00: configured for UDMA/100
2008-12-23 01:49:58.593998258 <6>[17827.186861] ata4: EH complete

2008-12-23 01:50:28.593347236 <3>[17857.186147] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
2008-12-23 01:50:28.593349616 <3>[17857.186159] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
2008-12-23 01:50:28.593350529 <3>[17857.186160]          cdb 1b 00 00 00 03 00 00 00  00 00 00 00 00 00 00 00
2008-12-23 01:50:28.593351407 <3>[17857.186162]          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
2008-12-23 01:50:28.593352291 <3>[17857.186165] ata4.00: status: { DRDY }
2008-12-23 01:50:28.593352886 <6>[17857.186172] ata4: hard resetting link
2008-12-23 01:50:28.898286191 <6>[17857.491144] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
2008-12-23 01:50:28.901031752 <6>[17857.493899] ata4.00: configured for UDMA/100

2008-12-23 01:50:28.901032973 <6>[17857.493913] ata4: EH complete
2008-12-23 01:50:58.900353887 <3>[17887.493149] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
2008-12-23 01:50:58.900356575 <3>[17887.493161] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
2008-12-23 01:50:58.900357474 <3>[17887.493162]          cdb 1b 00 00 00 03 00 00 00  00 00 00 00 00 00 00 00
2008-12-23 01:50:58.900358367 <3>[17887.493163]          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
2008-12-23 01:50:58.900359250 <3>[17887.493167] ata4.00: status: { DRDY }
2008-12-23 01:50:58.900359846 <6>[17887.493173] ata4: hard resetting link

2008-12-23 01:50:59.205287636 <6>[17887.798145] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
2008-12-23 01:50:59.208045366 <6>[17887.800847] ata4.00: configured for UDMA/100
2008-12-23 01:50:59.208046752 <6>[17887.800867] ata4: EH complete
2008-12-23 01:50:59.208047308 <3>[17887.800878] sr0: CDROM (ioctl) error, command: Start/Stop Unit 1b 00 00 00 03 00
2008-12-23 01:50:59.208048206 <6>[17887.800888] sr: Sense Key : Aborted Command [current] [descriptor]
2008-12-23 01:50:59.208049019 <6>[17887.800894] sr: Add. Sense: No additional sense information


2008-12-23 01:57:08.431689628 <4>[18257.024504] ata4.00: limiting speed to UDMA/66:PIO4
2008-12-23 01:57:08.431691932 <3>[18257.024511] ata4: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xe frozen
2008-12-23 01:57:08.431692873 <3>[18257.024514] ata4: irq_stat 0x00400000, PHY RDY changed
2008-12-23 01:57:08.431693654 <3>[18257.024518] ata4: SError: { PHYRdyChg }
2008-12-23 01:57:08.431694295 <6>[18257.024525] ata4: hard resetting link
2008-12-23 01:57:09.154282182 <6>[18257.747142] ata4: SATA link down (SStatus 0 SControl 310)
2008-12-23 01:57:14.154273371 <6>[18262.747136] ata4: hard resetting link
2008-12-23 01:57:14.459278255 <6>[18263.052141] ata4: SATA link down (SStatus 0 SControl 310)
2008-12-23 01:57:19.459276252 <6>[18268.052136] ata4: hard resetting link
2008-12-23 01:57:19.766261425 <6>[18268.357141] ata4: SATA link down (SStatus 0 SControl 310)
2008-12-23 01:57:19.766264578 <4>[18268.357150] ata4.00: disabled
2008-12-23 01:57:19.766265221 <6>[18268.357161] ata4: EH complete
2008-12-23 01:57:19.766265872 <6>[18268.357173] ata4.00: detaching (SCSI 3:0:0:0)

here I gave the stupid drive some power

2008-12-23 01:57:55.266490475 <3>[18303.859302] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xe frozen
2008-12-23 01:57:55.266493160 <3>[18303.859309] ata4: irq_stat 0x00000040, connection status changed
2008-12-23 01:57:55.266494069 <3>[18303.859313] ata4: SError: { RecovComm PHYRdyChg CommWake DevExch }
2008-12-23 01:57:55.266494925 <6>[18303.859322] ata4: hard resetting link
2008-12-23 01:57:55.989291809 <6>[18304.582144] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
2008-12-23 01:57:55.990426641 <6>[18304.583305] ata4.00: ATAPI: HL-DT-STDVD-RAM GH22NS30, 1.01, max UDMA/100
2008-12-23 01:57:55.991877936 <6>[18304.584755] ata4.00: configured for UDMA/100
2008-12-23 01:57:55.991879143 <6>[18304.584765] ata4: EH complete
2008-12-23 01:57:55.993043771 <5>[18304.585931] scsi 3:0:0:0: CD-ROM            HL-DT-ST DVD-RAM GH22NS30 1.01 PQ: 0 ANSI: 5
2008-12-23 01:57:55.998279657 <4>[18304.591138] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
2008-12-23 01:57:55.998469034 <7>[18304.591361] sr 3:0:0:0: Attached scsi CD-ROM sr0
2008-12-23 01:57:55.999123925 <5>[18304.592000] sr 3:0:0:0: Attached scsi generic sg1 type 5



           CPU0       CPU1       
  0:         29          0   IO-APIC-edge      timer
  1:          2          0   IO-APIC-edge      i8042
  4:          2          0   IO-APIC-edge    
  7:          0          0   IO-APIC-edge      parport0
  8:          1          0   IO-APIC-edge      rtc0
  9:          0          0   IO-APIC-fasteoi   acpi
 12:          7          0   IO-APIC-edge      i8042
 14:          0          0   IO-APIC-edge      ide2
 15:          0          0   IO-APIC-edge      ide3
 16:     255281      38243   IO-APIC-fasteoi   uhci_hcd:usb1, i915@pci:0000:00:02.0
 17:        802       3089   IO-APIC-fasteoi   ide0, ide1
 18:          2          0   IO-APIC-fasteoi   ehci_hcd:usb3, uhci_hcd:usb6
 19:      15804      10247   IO-APIC-fasteoi   uhci_hcd:usb5, ohci1394
 21:         48          0   IO-APIC-fasteoi   uhci_hcd:usb2
 23:          3          0   IO-APIC-fasteoi   uhci_hcd:usb4, ehci_hcd:usb7
504:       3109      12186   PCI-MSI-edge      HDA Intel
505:         70       7239   PCI-MSI-edge      eth0
506:      11427      24155   PCI-MSI-edge      ahci
NMI:          0          0   Non-maskable interrupts
LOC:    2097539    2126841   Local timer interrupts
RES:       4740       3811   Rescheduling interrupts
CAL:      31978        737   function call interrupts
TLB:        669        831   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
SPU:          0          0   Spurious interrupts
ERR:          0

-- 
"If it bleeds, we can kill it." - Arnold Schwarzenegger


--7fprigsjr7i4n2hz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.27.10 (safari@safari.finland.fbi) (gcc version 4.3.2 20081105 (Red Hat 4.3.2-7) (GCC) ) #26 SMP Mon Dec 22 03:06:48 EET 2008
Command line: grub_kernel=bzImage-2.6.27.10-012 ro root=/dev/sda6 ide-pci-generic.all-generic-ide vga=6 noisapnp enforcing=0 selinux=0 printk.time=1 log_buf_len=512k
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000008f000 (usable)
 BIOS-e820: 000000000008f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000be584000 (usable)
 BIOS-e820: 00000000be584000 - 00000000be591000 (reserved)
 BIOS-e820: 00000000be591000 - 00000000be620000 (usable)
 BIOS-e820: 00000000be620000 - 00000000be6df000 (ACPI NVS)
 BIOS-e820: 00000000be6df000 - 00000000be6f0000 (usable)
 BIOS-e820: 00000000be6f0000 - 00000000be6f2000 (ACPI NVS)
 BIOS-e820: 00000000be6f2000 - 00000000be6ff000 (ACPI data)
 BIOS-e820: 00000000be6ff000 - 00000000be700000 (usable)
 BIOS-e820: 00000000be700000 - 00000000bf000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f8000000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
DMI 2.4 present.
last_pfn = 0xbe700 max_arch_pfn = 0x3ffffffff
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
init_memory_mapping
 0000000000 - 00be600000 page 2M
 00be600000 - 00be700000 page 4k
kernel direct mapping tables up to be700000 @ 8000-d000
last_map_addr: be700000 end: be700000
ACPI: RSDP 000FE020, 0014 (r0 INTEL )
ACPI: RSDT BE6FD038, 0040 (r1 INTEL  DQ965GF      17BF       1000013)
ACPI: FACP BE6FC000, 0074 (r1 INTEL  DQ965GF      17BF MSFT  1000013)
ACPI: DSDT BE6F7000, 4304 (r1 INTEL  DQ965GF      17BF MSFT  1000013)
ACPI: FACS BE687000, 0040
ACPI: APIC BE6F6000, 0078 (r1 INTEL  DQ965GF      17BF MSFT  1000013)
ACPI: WDDT BE6F5000, 0040 (r1 INTEL  DQ965GF      17BF MSFT  1000013)
ACPI: MCFG BE6F4000, 003C (r1 INTEL  DQ965GF      17BF MSFT  1000013)
ACPI: ASF! BE6F3000, 00A6 (r32 INTEL  DQ965GF      17BF MSFT  1000013)
ACPI: HPET BE6F2000, 0038 (r1 INTEL  DQ965GF      17BF MSFT  1000013)
ACPI: TCPA BE620000, 0032 (r2 INTEL  TIANO           2 MSFT  1000013)
(5 early reservations) ==> bootmem [0000000000 - 00be700000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
  #2 [0000200000 - 0000980fa8]    TEXT DATA BSS ==> [0000200000 - 0000980fa8]
  #3 [000009e000 - 0000100000]    BIOS reserved ==> [000009e000 - 0000100000]
  #4 [0000008000 - 000000b000]          PGTABLE ==> [0000008000 - 000000b000]
found SMP MP-table at [ffff8800000fe200] 000fe200
 [ffffe20000000000-ffffe200029fffff] PMD -> [ffff880001200000-ffff880003bfffff] on node 0
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00100000
Movable zone start PFN for each node
early_node_map[5] active PFN ranges
    0: 0x00000000 -> 0x0000008f
    0: 0x00000100 -> 0x000be584
    0: 0x000be591 -> 0x000be620
    0: 0x000be6df -> 0x000be6f0
    0: 0x000be6ff -> 0x000be700
On node 0 totalpages: 779700
  DMA zone: 1901 pages, LIFO batch:0
  DMA32 zone: 765108 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
SMP: Allowing 4 CPUs, 2 hotplug CPUs
Allocating PCI resources starting at c0000000 (gap: bf000000:31000000)
PERCPU: Allocating 43424 bytes of per cpu data
NR_CPUS: 8, nr_cpu_ids: 4, nr_node_ids 1
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 767009
Kernel command line: grub_kernel=bzImage-2.6.27.10-012 ro root=/dev/sda6 ide-pci-generic.all-generic-ide vga=6 noisapnp enforcing=0 selinux=0 printk.time=1 log_buf_len=512k
[    0.000000] log_buf_len: 524288
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] TSC: PIT calibration confirmed by PMTIMER.
[    0.000000] TSC: using PMTIMER calibration value
[    0.000000] Detected 2797.147 MHz processor.
[    0.000999] Console: colour VGA+ 80x60
[    0.000999] console [tty0] enabled
[    0.000999] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000999] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000999] Checking aperture...
[    0.000999] No AGP bridge found
[    0.000999] Memory: 3060364k/3120128k available (4866k kernel code, 57732k reserved, 1889k data, 352k init)
[    0.000999] CPA: page pool initialized 1 of 1 pages preallocated
[    0.000999] hpet clockevent registered
[    0.000999] Calibrating delay loop (skipped), value calculated using timer frequency.. 5594.29 BogoMIPS (lpj=2797147)
[    0.000999] Security Framework initialized
[    0.000999] SELinux:  Disabled at boot.
[    0.000999] Mount-cache hash table entries: 256
[    0.000999] CPU: Trace cache: 12K uops, L1 D cache: 16K
[    0.000999] CPU: L2 cache: 1024K
[    0.000999] CPU: Physical Processor ID: 0
[    0.000999] CPU: Processor Core ID: 0
[    0.000999] CPU0: Thermal monitoring enabled (TM1)
[    0.000999] using mwait in idle threads.
[    0.000999] ACPI: Core revision 20080609
[    0.010386] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.020966] CPU0:               Intel(R) Pentium(R) D CPU 2.80GHz stepping 07
[    0.021045] Using local APIC timer interrupts.
[    0.022002] APIC timer calibration result 12487291
[    0.022004] Detected 12.487 MHz APIC timer.
[    0.022204] Booting processor 1/1 ip 6000
[    0.000999] Initializing CPU#1
[    0.000999] Calibrating delay using timer specific routine.. 5594.30 BogoMIPS (lpj=2797151)
[    0.000999] CPU: Trace cache: 12K uops, L1 D cache: 16K
[    0.000999] CPU: L2 cache: 1024K
[    0.000999] CPU: Physical Processor ID: 0
[    0.000999] CPU: Processor Core ID: 1
[    0.000999] CPU1: Thermal monitoring enabled (TM1)
[    0.000999] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.093768] CPU1:               Intel(R) Pentium(R) D CPU 2.80GHz stepping 07
[    0.094107] checking TSC synchronization [CPU#0 -> CPU#1]:
[    0.094999] Measured 3990 cycles TSC warp between CPUs, turning off TSC clock.
[    0.094999] Marking TSC unstable due to check_tsc_sync_source failed
[    0.095013] Brought up 2 CPUs
[    0.095067] Total of 2 processors activated (11188.59 BogoMIPS).
[    0.096046] net_namespace: 1456 bytes
[    0.096181] NET: Registered protocol family 16
[    0.096548] No dock devices found.
[    0.096731] ACPI: bus type pci registered
[    0.096916] PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 127
[    0.096979] PCI: MCFG area at f0000000 reserved in E820
[    0.099887] PCI: Using MMCONFIG at f0000000 - f7ffffff
[    0.099943] PCI: Using configuration type 1 for base access
[    0.103432] ACPI: EC: Look up EC in DSDT
[    0.107885] ACPI: Interpreter enabled
[    0.107941] ACPI: (supports S0 S3 S5)
[    0.108070] ACPI: Using IOAPIC for interrupt routing
[    0.115226] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.115422] PCI: 0000:00:02.0 reg 10 32bit mmio: [d0200000, d02fffff]
[    0.115433] PCI: 0000:00:02.0 reg 18 64bit mmio: [c0000000, cfffffff]
[    0.115438] PCI: 0000:00:02.0 reg 20 io port: [2410, 2417]
[    0.115483] PCI: 0000:00:03.0 reg 10 64bit mmio: [d0326100, d032610f]
[    0.115513] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.115573] pci 0000:00:03.0: PME# disabled
[    0.115685] PCI: 0000:00:19.0 reg 10 32bit mmio: [d0300000, d031ffff]
[    0.115692] PCI: 0000:00:19.0 reg 14 32bit mmio: [d0324000, d0324fff]
[    0.115699] PCI: 0000:00:19.0 reg 18 io port: [20e0, 20ff]
[    0.115731] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.115791] pci 0000:00:19.0: PME# disabled
[    0.115886] PCI: 0000:00:1a.0 reg 20 io port: [20c0, 20df]
[    0.115936] PCI: 0000:00:1a.1 reg 20 io port: [20a0, 20bf]
[    0.115993] PCI: 0000:00:1a.7 reg 10 32bit mmio: [d0325c00, d0325fff]
[    0.116045] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.116105] pci 0000:00:1a.7: PME# disabled
[    0.116190] PCI: 0000:00:1b.0 reg 10 64bit mmio: [d0320000, d0323fff]
[    0.116229] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.116288] pci 0000:00:1b.0: PME# disabled
[    0.116390] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.116450] pci 0000:00:1c.0: PME# disabled
[    0.116549] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.116609] pci 0000:00:1c.1: PME# disabled
[    0.116710] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.116770] pci 0000:00:1c.2: PME# disabled
[    0.116869] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.116929] pci 0000:00:1c.3: PME# disabled
[    0.117035] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.117095] pci 0000:00:1c.4: PME# disabled
[    0.117184] PCI: 0000:00:1d.0 reg 20 io port: [2080, 209f]
[    0.117236] PCI: 0000:00:1d.1 reg 20 io port: [2060, 207f]
[    0.117285] PCI: 0000:00:1d.2 reg 20 io port: [2040, 205f]
[    0.117343] PCI: 0000:00:1d.7 reg 10 32bit mmio: [d0325800, d0325bff]
[    0.117391] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.117451] pci 0000:00:1d.7: PME# disabled
[    0.117620] pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
[    0.117703] pci 0000:00:1f.0: quirk: region 0500-053f claimed by ICH6 GPIO
[    0.117805] PCI: 0000:00:1f.2 reg 10 io port: [2408, 240f]
[    0.117811] PCI: 0000:00:1f.2 reg 14 io port: [241c, 241f]
[    0.117817] PCI: 0000:00:1f.2 reg 18 io port: [2400, 2407]
[    0.117823] PCI: 0000:00:1f.2 reg 1c io port: [2418, 241b]
[    0.117829] PCI: 0000:00:1f.2 reg 20 io port: [2020, 203f]
[    0.117835] PCI: 0000:00:1f.2 reg 24 32bit mmio: [d0325000, d03257ff]
[    0.117858] pci 0000:00:1f.2: PME# supported from D3hot
[    0.117915] pci 0000:00:1f.2: PME# disabled
[    0.117982] PCI: 0000:00:1f.3 reg 10 32bit mmio: [d0326000, d03260ff]
[    0.118005] PCI: 0000:00:1f.3 reg 20 io port: [2000, 201f]
[    0.118119] PCI: 0000:02:00.0 reg 10 io port: [1018, 101f]
[    0.118128] PCI: 0000:02:00.0 reg 14 io port: [1024, 1027]
[    0.118138] PCI: 0000:02:00.0 reg 18 io port: [1010, 1017]
[    0.118147] PCI: 0000:02:00.0 reg 1c io port: [1020, 1023]
[    0.118155] PCI: 0000:02:00.0 reg 20 io port: [1000, 100f]
[    0.118163] PCI: 0000:02:00.0 reg 24 32bit mmio: [d0100000, d01001ff]
[    0.118196] pci 0000:02:00.0: supports D1
[    0.118198] pci 0000:02:00.0: PME# supported from D0 D1 D3hot
[    0.118258] pci 0000:02:00.0: PME# disabled
[    0.118342] PCI: bridge 0000:00:1c.1 io port: [1000, 1fff]
[    0.118346] PCI: bridge 0000:00:1c.1 32bit mmio: [d0100000, d01fffff]
[    0.118528] PCI: 0000:06:03.0 reg 10 32bit mmio: [d0004000, d00047ff]
[    0.118535] PCI: 0000:06:03.0 reg 14 32bit mmio: [d0000000, d0003fff]
[    0.118577] pci 0000:06:03.0: supports D1
[    0.118579] pci 0000:06:03.0: supports D2
[    0.118581] pci 0000:06:03.0: PME# supported from D0 D1 D2 D3hot
[    0.118641] pci 0000:06:03.0: PME# disabled
[    0.118729] pci 0000:00:1e.0: transparent bridge
[    0.118786] PCI: bridge 0000:00:1e.0 32bit mmio: [d0000000, d00fffff]
[    0.118819] bus 00 -> node 0
[    0.118827] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.119411] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[    0.119837] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[    0.120010] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
[    0.120182] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
[    0.120350] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
[    0.120520] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
[    0.128442] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
[    0.128871] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
[    0.129300] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
[    0.129736] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
[    0.130147] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 12)
[    0.130573] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
[    0.131019] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
[    0.131447] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11 12)
[    0.132038] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.132141] pnp: PnP ACPI init
[    0.132201] ACPI: bus type pnp registered
[    0.136720] pnp: PnP ACPI: found 13 devices
[    0.136774] ACPI: ACPI bus type pnp unregistered
[    0.137119] SCSI subsystem initialized
[    0.137249] libata version 3.00 loaded.
[    0.137498] usbcore: registered new interface driver usbfs
[    0.137664] usbcore: registered new interface driver hub
[    0.137782] usbcore: registered new device driver usb
[    0.138073] PCI: Using ACPI for IRQ routing
[    0.145035] PCI-GART: No AMD northbridge found.
[    0.145093] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.145236] hpet0: 3 64-bit timers, 14318180 Hz
[    0.146051] ACPI: RTC can wake from S4
[    0.147015] Switched to high resolution mode on CPU 0
[    0.147584] Switched to high resolution mode on CPU 1
[    0.149028] system 00:01: iomem range 0xf0000000-0xf7ffffff could not be reserved
[    0.150693] system 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
[    0.150755] system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
[    0.150817] system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
[    0.150878] system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
[    0.150940] system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.151007] system 00:01: iomem range 0xfed20000-0xfed3ffff has been reserved
[    0.151070] system 00:01: iomem range 0xfed45000-0xfed99fff has been reserved
[    0.151134] system 00:01: iomem range 0xc0000-0xdffff has been reserved
[    0.151194] system 00:01: iomem range 0xe0000-0xfffff could not be reserved
[    0.151265] system 00:06: ioport range 0x500-0x53f has been reserved
[    0.151325] system 00:06: ioport range 0x400-0x47f has been reserved
[    0.151384] system 00:06: ioport range 0x360-0x361 has been reserved
[    0.151443] system 00:06: ioport range 0x680-0x6ff has been reserved
[    0.151508] system 00:07: iomem range 0xfed40000-0xfed44fff has been reserved
[    0.156731] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:01
[    0.156790] pci 0000:00:1c.0:   IO window: disabled
[    0.156847] pci 0000:00:1c.0:   MEM window: disabled
[    0.156904] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.156964] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:02
[    0.157029] pci 0000:00:1c.1:   IO window: 0x1000-0x1fff
[    0.157088] pci 0000:00:1c.1:   MEM window: 0xd0100000-0xd01fffff
[    0.157150] pci 0000:00:1c.1:   PREFETCH window: disabled
[    0.157210] pci 0000:00:1c.2: PCI bridge, secondary bus 0000:03
[    0.157267] pci 0000:00:1c.2:   IO window: disabled
[    0.157324] pci 0000:00:1c.2:   MEM window: disabled
[    0.157380] pci 0000:00:1c.2:   PREFETCH window: disabled
[    0.157440] pci 0000:00:1c.3: PCI bridge, secondary bus 0000:04
[    0.157497] pci 0000:00:1c.3:   IO window: disabled
[    0.157554] pci 0000:00:1c.3:   MEM window: disabled
[    0.157610] pci 0000:00:1c.3:   PREFETCH window: disabled
[    0.157669] pci 0000:00:1c.4: PCI bridge, secondary bus 0000:05
[    0.157726] pci 0000:00:1c.4:   IO window: disabled
[    0.157783] pci 0000:00:1c.4:   MEM window: disabled
[    0.157839] pci 0000:00:1c.4:   PREFETCH window: disabled
[    0.157900] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:06
[    0.157956] pci 0000:00:1e.0:   IO window: disabled
[    0.158020] pci 0000:00:1e.0:   MEM window: 0xd0000000-0xd00fffff
[    0.158081] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.158154] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.158217] pci 0000:00:1c.0: setting latency timer to 64
[    0.158226] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.158288] pci 0000:00:1c.1: setting latency timer to 64
[    0.158297] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.158358] pci 0000:00:1c.2: setting latency timer to 64
[    0.158367] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    0.158428] pci 0000:00:1c.3: setting latency timer to 64
[    0.158436] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.158497] pci 0000:00:1c.4: setting latency timer to 64
[    0.158504] pci 0000:00:1e.0: setting latency timer to 64
[    0.158508] bus: 00 index 0 io port: [0, ffff]
[    0.158561] bus: 00 index 1 mmio: [0, ffffffffffffffff]
[    0.158617] bus: 01 index 0 mmio: [0, 0]
[    0.158668] bus: 01 index 1 mmio: [0, 0]
[    0.158719] bus: 01 index 2 mmio: [0, 0]
[    0.158770] bus: 01 index 3 mmio: [0, 0]
[    0.158822] bus: 02 index 0 io port: [1000, 1fff]
[    0.158876] bus: 02 index 1 mmio: [d0100000, d01fffff]
[    0.158931] bus: 02 index 2 mmio: [0, 0]
[    0.158982] bus: 02 index 3 mmio: [0, 0]
[    0.159042] bus: 03 index 0 mmio: [0, 0]
[    0.159094] bus: 03 index 1 mmio: [0, 0]
[    0.159148] bus: 03 index 2 mmio: [0, 0]
[    0.159199] bus: 03 index 3 mmio: [0, 0]
[    0.159250] bus: 04 index 0 mmio: [0, 0]
[    0.159301] bus: 04 index 1 mmio: [0, 0]
[    0.159353] bus: 04 index 2 mmio: [0, 0]
[    0.159404] bus: 04 index 3 mmio: [0, 0]
[    0.159455] bus: 05 index 0 mmio: [0, 0]
[    0.159506] bus: 05 index 1 mmio: [0, 0]
[    0.159557] bus: 05 index 2 mmio: [0, 0]
[    0.159608] bus: 05 index 3 mmio: [0, 0]
[    0.159660] bus: 06 index 0 mmio: [0, 0]
[    0.159711] bus: 06 index 1 mmio: [d0000000, d00fffff]
[    0.159766] bus: 06 index 2 mmio: [0, 0]
[    0.159817] bus: 06 index 3 io port: [0, ffff]
[    0.159870] bus: 06 index 4 mmio: [0, ffffffffffffffff]
[    0.159964] NET: Registered protocol family 2
[    0.171021] random: early call rand_initialize
[    0.171075] random: rand_initialize starting
[    0.171128] random: rand_initialize OK (random_debug=0/debug_max=31 POOLBITS=8192)
[    0.171165] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.171781] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.174108] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.174735] TCP: Hash tables configured (established 262144 bind 65536)
[    0.174799] TCP reno registered
[    0.177134] NET: Registered protocol family 1
[    0.178331] IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
[    0.178922] audit: initializing netlink socket (disabled)
[    0.178995] type=2000 audit(1229993307.178:1): initialized
[    0.179399] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.179612] VFS: Disk quotas dquot_6.5.1
[    0.179683] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.179882] SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
[    0.180227] SGI XFS Quota Management subsystem
[    0.180289] msgmni has been set to 5978
[    0.180450] io scheduler noop registered
[    0.180503] io scheduler anticipatory registered (default)
[    0.180559] io scheduler deadline registered
[    0.180634] io scheduler cfq registered
[    0.180697] pci 0000:00:02.0: Boot video device
[    0.181173] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    0.181208] pcieport-driver 0000:00:1c.0: found MSI capability
[    0.181302] pci_express 0000:00:1c.0:pcie00: allocate port service
[    0.181356] pci_express 0000:00:1c.0:pcie02: allocate port service
[    0.181405] pci_express 0000:00:1c.0:pcie03: allocate port service
[    0.181508] pcieport-driver 0000:00:1c.1: setting latency timer to 64
[    0.181542] pcieport-driver 0000:00:1c.1: found MSI capability
[    0.181631] pci_express 0000:00:1c.1:pcie00: allocate port service
[    0.181679] pci_express 0000:00:1c.1:pcie02: allocate port service
[    0.181726] pci_express 0000:00:1c.1:pcie03: allocate port service
[    0.181826] pcieport-driver 0000:00:1c.2: setting latency timer to 64
[    0.181860] pcieport-driver 0000:00:1c.2: found MSI capability
[    0.181949] pci_express 0000:00:1c.2:pcie00: allocate port service
[    0.181999] pci_express 0000:00:1c.2:pcie02: allocate port service
[    0.182051] pci_express 0000:00:1c.2:pcie03: allocate port service
[    0.182162] pcieport-driver 0000:00:1c.3: setting latency timer to 64
[    0.182196] pcieport-driver 0000:00:1c.3: found MSI capability
[    0.182286] pci_express 0000:00:1c.3:pcie00: allocate port service
[    0.182333] pci_express 0000:00:1c.3:pcie02: allocate port service
[    0.182383] pci_express 0000:00:1c.3:pcie03: allocate port service
[    0.182483] pcieport-driver 0000:00:1c.4: setting latency timer to 64
[    0.182517] pcieport-driver 0000:00:1c.4: found MSI capability
[    0.182606] pci_express 0000:00:1c.4:pcie00: allocate port service
[    0.182655] pci_express 0000:00:1c.4:pcie02: allocate port service
[    0.182706] pci_express 0000:00:1c.4:pcie03: allocate port service
[    0.182901] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.182959] cpcihp_zt5550: ZT5550 CompactPCI Hot Plug Driver version: 0.2
[    0.183085] cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
[    0.183172] cpcihp_generic: not configured, disabling.
[    0.183450] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.183574] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.184120] processor ACPI0007:00: registered as cooling_device0
[    0.184186] ACPI: Processor [CPU0] (supports 8 throttling states)
[    0.184407] processor ACPI0007:01: registered as cooling_device1
[    0.184470] ACPI: Processor [CPU1] (supports 8 throttling states)
[    0.190025] random: skipping rand_initialize: already initialized
[    0.190233] hpet_resources: 0xfed00000 is busy
[    0.190423] Linux agpgart interface v0.103
[    0.190495] agpgart-intel 0000:00:00.0: Intel 965Q Chipset
[    0.190948] agpgart-intel 0000:00:00.0: detected 7676K stolen memory
[    0.206738] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xc0000000
[    0.207051] [drm] Initialized drm 1.1.0 20060810
[    0.207108] Serial: 8250/16550 driver4 ports, IRQ sharing enabled
[    0.451293] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.451905] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.454042] brd: module loaded
[    0.454177] Uniform Multi-Platform E-IDE driver
[    0.455430] ide_pci_generic 0000:02:00.0: IDE controller (0x11ab:0x6101 rev 0xb1)
[    0.455523] PCI_IDE 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.455599] ide_pci_generic 0000:02:00.0: 100% native mode on irq 17
[    0.455663]     ide0: BM-DMA at 0x1000-0x1007
[    0.455721]     ide1: BM-DMA at 0x1008-0x100f
[    0.455775] Probing IDE interface ide0...
[    0.719432] hda: ST3160023A, ATA DISK drive
[    1.331205] Probing IDE interface ide1...
[    3.074211] ide0 at 0x1018-0x101f,0x1026 on irq 17
[    3.074314] isa bounce pool size: 16 pages
[    3.074379] ide1 at 0x1010-0x1017,0x1022 on irq 17
[    3.074587] ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
[    3.074683] Probing IDE interface ide2...
[    3.587191] Probing IDE interface ide3...
[    4.100204] ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
[    4.100297] ide3 at 0x170-0x177,0x376 on irq 15
[    4.100506] hda: max request size: 512KiB
[    4.101076] hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
[    4.101354] hda: cache flushes supported
[    4.101474]  hda: hda1 hda2 < hda5 hda6 >
[    4.126369] ide-floppy driver 1.00
[    4.127151] aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 loaded
[    4.127301] stex: Promise SuperTrak EX Driver version: 3.6.0000.1
[    4.127416] st: Version 20080504, fixed bufsize 32768, s/g segs 256
[    4.129096] Driver 'st' needs updating - please use bus_type methods
[    4.129204] osst :I: Tape driver with OnStream support version 0.99.4
[    4.129205] osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
[    4.129362] Driver 'osst' needs updating - please use bus_type methods
[    4.129508] Driver 'sd' needs updating - please use bus_type methods
[    4.129608] Driver 'sr' needs updating - please use bus_type methods
[    4.129790] ahci 0000:00:1f.2: version 3.0
[    4.129806] ahci 0000:00:1f.2: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    4.129987] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    4.130079] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part ems 
[    4.130166] ahci 0000:00:1f.2: setting latency timer to 64
[    4.130522] scsi0 : ahci
[    4.130778] scsi1 : ahci
[    4.130966] scsi2 : ahci
[    4.131164] scsi3 : ahci
[    4.131364] scsi4 : ahci
[    4.131550] scsi5 : ahci
[    4.131835] ata1: SATA max UDMA/133 abar m2048@0xd0325000 port 0xd0325100 irq 506
[    4.131917] ata2: SATA max UDMA/133 abar m2048@0xd0325000 port 0xd0325180 irq 506
[    4.131997] ata3: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 506
[    4.132087] ata4: SATA max UDMA/133 irq_stat 0x00000040, connection status changed irq 506
[    4.132171] ata5: SATA max UDMA/133 abar m2048@0xd0325000 port 0xd0325300 irq 506
[    4.132251] ata6: SATA max UDMA/133 abar m2048@0xd0325000 port 0xd0325380 irq 506
[    4.437142] ata1: SATA link down (SStatus 0 SControl 300)
[    4.742139] ata2: SATA link down (SStatus 0 SControl 300)
[    5.465141] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.506396] ata3.00: ATA-7: ST3320620AS, 3.AAE, max UDMA/133
[    5.506455] ata3.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    5.564704] ata3.00: configured for UDMA/133
[    6.287018] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    6.288219] ata4.00: ATAPI: HL-DT-STDVD-RAM GH22NS30, 1.01, max UDMA/100
[    6.289677] ata4.00: configured for UDMA/100
[    6.594016] ata5: SATA link down (SStatus 0 SControl 300)
[    6.899016] ata6: SATA link down (SStatus 0 SControl 300)
[    6.899178] scsi 2:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
[    6.899523] sd 2:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
[    6.899601] sd 2:0:0:0: [sda] Write Protect is off
[    6.899656] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.899687] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.899850] sd 2:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
[    6.899925] sd 2:0:0:0: [sda] Write Protect is off
[    6.899981] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.900019] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.900104]  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 >
[    6.964811] sd 2:0:0:0: [sda] Attached SCSI disk
[    6.965017] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    6.966178] scsi 3:0:0:0: CD-ROM            HL-DT-ST DVD-RAM GH22NS30 1.01 PQ: 0 ANSI: 5
[    6.969584] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    6.969666] Uniform CD-ROM driver Revision: 3.20
[    6.969881] sr 3:0:0:0: Attached scsi CD-ROM sr0
[    6.970018] sr 3:0:0:0: Attached scsi generic sg1 type 5
[    6.972031] PNP: No PS/2 controller found. Probing ports directly.
[    6.974979] serio: i8042 KBD port at 0x60,0x64 irq 1
[    6.975045] serio: i8042 AUX port at 0x60,0x64 irq 12
[    6.975172] mice: PS/2 mouse device common for all mice
[    6.975423] EDAC MC: Ver: 2.1.0 Dec 18 2008
[    6.976054] usbcore: registered new interface driver hiddev
[    6.976164] usbcore: registered new interface driver usbhid
[    6.976223] usbhid: v2.6:USB HID core driver
[    6.976358] TCP bic registered
[    6.976408] Initializing XFRM netlink socket
[    6.976528] NET: Registered protocol family 10
[    6.976761] lo: Disabled Privacy Extensions
[    6.976850] IPv6 over IPv4 tunneling driver
[    6.977104] sit0: Disabled Privacy Extensions
[    6.977175] NET: Registered protocol family 17
[    6.977576] drivers/rtc/hctosys.c: unable to open rtc device (rtc)
[    7.684230] md: Autodetecting RAID arrays.
[    7.684284] md: Scanned 0 and added 0 devices.
[    7.684336] md: autorun ...
[    7.684384] md: ... autorun DONE.
[    7.729403] XFS mounting filesystem sda6
[    7.779501] Ending clean XFS mount for filesystem: sda6
[    7.779543] VFS: Mounted root (xfs filesystem) readonly.
[    7.779616] Freeing unused kernel memory: 352k freed
[    7.779831] Write protecting the kernel read-only data: 6384k
[   10.137155] USB Universal Host Controller Interface driver v3.0
[   10.137238] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   10.137248] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[   10.137252] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   10.137315] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[   10.137353] uhci_hcd 0000:00:1a.0: irq 16, io base 0x000020c0
[   10.137487] usb usb1: configuration #1 chosen from 1 choice
[   10.137526] hub 1-0:1.0: USB hub found
[   10.137535] hub 1-0:1.0: 2 ports detected
[   10.208233] input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   10.221197] ACPI: Power Button (FF) [PWRF]
[   10.221278] input: Sleep Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input1
[   10.232084] ACPI: Sleep Button (CM) [SLPB]
[   10.238269] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[   10.238273] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.238276] usb usb1: Product: UHCI Host Controller
[   10.238278] usb usb1: Manufacturer: Linux 2.6.27.10 uhci_hcd
[   10.238280] usb usb1: SerialNumber: 0000:00:1a.0
[   10.238320] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[   10.238332] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[   10.238336] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   10.238372] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
[   10.238411] uhci_hcd 0000:00:1a.1: irq 21, io base 0x000020a0
[   10.238523] usb usb2: configuration #1 chosen from 1 choice
[   10.238562] hub 2-0:1.0: USB hub found
[   10.238570] hub 2-0:1.0: 2 ports detected
[   10.252393] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k6
[   10.252397] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[   10.324060] parport_pc 00:09: reported by Plug and Play ACPI
[   10.324172] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
[   10.382955] Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
[   10.440188] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[   10.440193] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.440196] usb usb2: Product: UHCI Host Controller
[   10.440199] usb usb2: Manufacturer: Linux 2.6.27.10 uhci_hcd
[   10.440201] usb usb2: SerialNumber: 0000:00:1a.1
[   10.440339] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[   10.440349] e1000e 0000:00:19.0: setting latency timer to 64
[   10.542029] usb 2-1: new low speed USB device using uhci_hcd and address 2
[   10.568144] iTCO_vendor_support: vendor-support=0
[   10.590461] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.03 (30-Apr-2008)
[   10.590570] iTCO_wdt: Found a ICH8DO TCO device (Version=2, TCOBASE=0x0460)
[   10.590633] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   10.624403] 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:19:d1:00:5f:01
[   10.624407] 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[   10.624433] 0000:00:19.0: eth0: MAC: 5, PHY: 6, PBA No: ffffff-0ff
[   10.624536] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[   10.624556] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[   10.624560] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[   10.624604] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 3
[   10.628505] ehci_hcd 0000:00:1a.7: debug port 1
[   10.628512] ehci_hcd 0000:00:1a.7: cache line size of 128 is not supported
[   10.628531] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xd0325c00
[   10.656017] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   10.656158] usb usb3: configuration #1 chosen from 1 choice
[   10.656198] hub 3-0:1.0: USB hub found
[   10.656209] hub 3-0:1.0: 4 ports detected
[   10.858185] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[   10.858189] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.858192] usb usb3: Product: EHCI Host Controller
[   10.858195] usb usb3: Manufacturer: Linux 2.6.27.10 ehci_hcd
[   10.858198] usb usb3: SerialNumber: 0000:00:1a.7
[   10.858281] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[   10.858293] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[   10.858297] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   10.858335] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[   10.858375] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00002080
[   10.858517] usb usb4: configuration #1 chosen from 1 choice
[   10.858557] hub 4-0:1.0: USB hub found
[   10.858567] hub 4-0:1.0: 2 ports detected
[   10.867863] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[   10.867891] rtc0: alarms up to one month, hpet irqs
[   10.894540] input: PC Speaker as /devices/platform/pcspkr/input/input2
[   10.959234] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[   10.959238] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.959242] usb usb4: Product: UHCI Host Controller
[   10.959245] usb usb4: Manufacturer: Linux 2.6.27.10 uhci_hcd
[   10.959247] usb usb4: SerialNumber: 0000:00:1d.0
[   10.959312] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[   10.959324] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[   10.959328] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   10.959365] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 5
[   10.959404] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00002060
[   10.959519] usb usb5: configuration #1 chosen from 1 choice
[   10.959558] hub 5-0:1.0: USB hub found
[   10.959566] hub 5-0:1.0: 2 ports detected
[   11.058023] usb 2-1: device not accepting address 2, error -71
[   11.109097] hub 2-0:1.0: unable to enumerate USB device on port 1
[   11.161180] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[   11.161184] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.161187] usb usb5: Product: UHCI Host Controller
[   11.161189] usb usb5: Manufacturer: Linux 2.6.27.10 uhci_hcd
[   11.161191] usb usb5: SerialNumber: 0000:00:1d.1
[   11.161871] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[   11.161882] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[   11.161886] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   11.161930] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 6
[   11.161957] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00002040
[   11.162090] usb usb6: configuration #1 chosen from 1 choice
[   11.162129] hub 6-0:1.0: USB hub found
[   11.162138] hub 6-0:1.0: 2 ports detected
[   11.260240] ppdev: user-space parallel port driver
[   11.263192] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[   11.263196] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.263199] usb usb6: Product: UHCI Host Controller
[   11.263202] usb usb6: Manufacturer: Linux 2.6.27.10 uhci_hcd
[   11.263204] usb usb6: SerialNumber: 0000:00:1d.2
[   11.264073] usb 5-1: new low speed USB device using uhci_hcd and address 2
[   11.264125] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[   11.264160] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[   11.264166] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   11.264232] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
[   11.268153] ehci_hcd 0000:00:1d.7: debug port 1
[   11.268161] ehci_hcd 0000:00:1d.7: cache line size of 128 is not supported
[   11.268314] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd0325800
[   11.278147] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   11.278320] usb usb7: configuration #1 chosen from 1 choice
[   11.278365] hub 7-0:1.0: USB hub found
[   11.278376] hub 7-0:1.0: 6 ports detected
[   11.329055] hub 5-0:1.0: unable to enumerate USB device on port 1
[   11.480329] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002
[   11.480334] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.480337] usb usb7: Product: EHCI Host Controller
[   11.480339] usb usb7: Manufacturer: Linux 2.6.27.10 ehci_hcd
[   11.480341] usb usb7: SerialNumber: 0000:00:1d.7
[   11.481409] ohci1394 0000:06:03.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   11.530969] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[   11.532278] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[d0004000-d00047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   11.684028] usb 2-1: new low speed USB device using uhci_hcd and address 4
[   11.843587] usb 2-1: configuration #1 chosen from 1 choice
[   11.859570] hiddev96: USB HID v1.11 Device [OMRON 87XXUPS] on usb-0000:00:1a.1-1
[   11.859711] usb 2-1: New USB device found, idVendor=06da, idProduct=0003
[   11.859715] usb 2-1: New USB device strings: Mfr=3, Product=1, SerialNumber=0
[   11.859717] usb 2-1: Product: 87XXUPS
[   11.859719] usb 2-1: Manufacturer: OMRON
[   12.067425] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   12.067501] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   12.220019] usb 5-1: new low speed USB device using uhci_hcd and address 3
[   12.293507] TCP cubic registered
[   12.431112] md: Autodetecting RAID arrays.
[   12.431117] md: Scanned 0 and added 0 devices.
[   12.431119] md: autorun ...
[   12.431121] md: ... autorun DONE.
[   12.477788] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[   12.493594] usb 5-1: configuration #1 chosen from 1 choice
[   12.548033] input: Chicony Saitek Eclipse II Keyboard as /devices/pci0000:00/0000:00:1d.1/usb5/5-1/5-1:1.0/input/input3
[   12.557084] input: USB HID v1.11 Keyboard [Chicony Saitek Eclipse II Keyboard] on usb-0000:00:1d.1-1
[   12.703154] input: Chicony Saitek Eclipse II Keyboard as /devices/pci0000:00/0000:00:1d.1/usb5/5-1/5-1:1.1/input/input4
[   12.716252] input,hiddev97: USB HID v1.11 Device [Chicony Saitek Eclipse II Keyboard] on usb-0000:00:1d.1-1
[   12.716397] usb 5-1: New USB device found, idVendor=06a3, idProduct=8021
[   12.716400] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   12.716403] usb 5-1: Product: Saitek Eclipse II Keyboard
[   12.716406] usb 5-1: Manufacturer: Chicony
[   12.788736] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0090270001b66bbe]
[   12.850899] loop: loaded (max 8 devices)
[   12.923146] usb 5-2: new full speed USB device using uhci_hcd and address 4
[   13.081593] usb 5-2: configuration #1 chosen from 1 choice
[   13.089745] input: Tempest Habu Mouse as /devices/pci0000:00/0000:00:1d.1/usb5/5-2/5-2:1.0/input/input5
[   13.104211] input: USB HID v10.01 Mouse [Tempest Habu Mouse] on usb-0000:00:1d.1-2
[   13.109023] input: Tempest Habu Mouse as /devices/pci0000:00/0000:00:1d.1/usb5/5-2/5-2:1.1/input/input6
[   13.121780] input: USB HID v10.01 Keyboard [Tempest Habu Mouse] on usb-0000:00:1d.1-2
[   13.122744] usb 5-2: New USB device found, idVendor=1532, idProduct=0009
[   13.122749] usb 5-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   13.122752] usb 5-2: Product: Habu Mouse
[   13.122755] usb 5-2: Manufacturer: Tempest
[   13.436105] XFS mounting filesystem sda1
[   13.478935] Ending clean XFS mount for filesystem: sda1
[   13.538792] XFS mounting filesystem sda7
[   13.697341] Ending clean XFS mount for filesystem: sda7
[   13.756435] XFS mounting filesystem sda8
[   13.822554] Ending clean XFS mount for filesystem: sda8
[   13.924133] XFS mounting filesystem sda10
[   14.028436] Ending clean XFS mount for filesystem: sda10
[   20.937478] Adding 3911784k swap on /dev/loop6.  Priority:10 extents:1 across:3911784k

--7fprigsjr7i4n2hz--
