From: David Shaw <dshaw@jabberwocky.com>
Subject: Re: Suppressing ATA errors on boot
Date: Thu, 30 Jun 2011 11:22:47 -0400
Message-ID: <438EE45C-A01E-4F77-8314-5DF9E8332E21@jabberwocky.com>
References: <F2FB3B32-A380-40EB-B6DF-02AB30592E3D@jabberwocky.com> <20110630094937.GO3386@htj.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from walrus.jabberwocky.com ([173.9.29.57]:46592 "EHLO
	walrus.jabberwocky.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab1F3P3S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jun 2011 11:29:18 -0400
In-Reply-To: <20110630094937.GO3386@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Jun 30, 2011, at 5:49 AM, Tejun Heo wrote:

> Hello,
> 
> On Wed, Jun 29, 2011 at 11:07:11AM -0400, David Shaw wrote:
>> Is there some way to tell libata that those ports shouldn't even be
>> probed?  Alternately, is there a way to selectively prevent those
>> messages from being logged (without affecting the logging for the
>> rest of the boot)?  Or perhaps a third solution?
> 
> Can you attach the output of "lspci -nn" and full boot log?

Sure.

# lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation 5500 I/O Hub to ESI Port [8086:3403] (rev 13)
00:01.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1 [8086:3408] (rev 13)
00:03.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 3 [8086:340a] (rev 13)
00:07.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 7 [8086:340e] (rev 13)
00:14.0 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub System Management Registers [8086:342e] (rev 13)
00:14.1 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub GPIO and Scratch Pad Registers [8086:3422] (rev 13)
00:14.2 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub Control Status and RAS Registers [8086:3423] (rev 13)
00:1a.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #4 [8086:3a37]
00:1a.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #5 [8086:3a38]
00:1a.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #2 [8086:3a3c]
00:1d.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #1 [8086:3a34]
00:1d.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #2 [8086:3a35]
00:1d.2 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #3 [8086:3a36]
00:1d.3 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #6 [8086:3a39]
00:1d.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #1 [8086:3a3a]
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e] (rev 90)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801JIR (ICH10R) LPC Interface Controller [8086:3a16]
00:1f.2 IDE interface [0101]: Intel Corporation 82801JI (ICH10 Family) 4 port SATA IDE Controller #1 [8086:3a20]
00:1f.5 IDE interface [0101]: Intel Corporation 82801JI (ICH10 Family) 2 port SATA IDE Controller #2 [8086:3a26]
01:00.0 Ethernet controller [0200]: Broadcom Corporation NetXtreme II BCM5716 Gigabit Ethernet [14e4:163b] (rev 20)
01:00.1 Ethernet controller [0200]: Broadcom Corporation NetXtreme II BCM5716 Gigabit Ethernet [14e4:163b] (rev 20)
03:00.0 RAID bus controller [0104]: LSI Logic / Symbios Logic LSI MegaSAS 9260 [1000:0079] (rev 05)
04:03.0 VGA compatible controller [0300]: Matrox Graphics, Inc. MGA G200eW WPCM450 [102b:0532] (rev 0a)
fe:00.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series QuickPath Architecture Generic Non-core Registers [8086:2c70] (rev 02)
fe:00.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series QuickPath Architecture System Address Decoder [8086:2d81] (rev 02)
fe:02.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Link 0 [8086:2d90] (rev 02)
fe:02.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Physical 0 [8086:2d91] (rev 02)
fe:02.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Mirror Port Link 0 [8086:2d92] (rev 02)
fe:02.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Mirror Port Link 1 [8086:2d93] (rev 02)
fe:02.4 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Link 1 [8086:2d94] (rev 02)
fe:02.5 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Physical 1 [8086:2d95] (rev 02)
fe:03.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Registers [8086:2d98] (rev 02)
fe:03.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Target Address Decoder [8086:2d99] (rev 02)
fe:03.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller RAS Registers [8086:2d9a] (rev 02)
fe:03.4 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Test Registers [8086:2d9c] (rev 02)
fe:04.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Control [8086:2da0] (rev 02)
fe:04.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Address [8086:2da1] (rev 02)
fe:04.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Rank [8086:2da2] (rev 02)
fe:04.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Thermal Control [8086:2da3] (rev 02)
fe:05.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Control [8086:2da8] (rev 02)
fe:05.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Address [8086:2da9] (rev 02)
fe:05.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Rank [8086:2daa] (rev 02)
fe:05.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Thermal Control [8086:2dab] (rev 02)
fe:06.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Control [8086:2db0] (rev 02)
fe:06.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Address [8086:2db1] (rev 02)
fe:06.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Rank [8086:2db2] (rev 02)
fe:06.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Thermal Control [8086:2db3] (rev 02)

Boot log:

Jun 27 13:47:39 localhost kernel: imklog 4.6.3, log source = /proc/kmsg started.
Jun 27 13:47:39 localhost rsyslogd: [origin software="rsyslogd" swVersion="4.6.3" x-pid="1316" x-info="http://www.rsyslog.com"] (re)start
Jun 27 13:47:39 localhost kernel: [    0.000000] Initializing cgroup subsys cpuset
Jun 27 13:47:39 localhost kernel: [    0.000000] Initializing cgroup subsys cpu
Jun 27 13:47:39 localhost kernel: [    0.000000] Linux version 2.6.35.13-91.fc14.i686.PAE (mockbuild@x86-16.phx2.fedoraproject.org) (gcc version 4.5.1 20100924 (Red Hat 4.5.1-4) (GCC) ) #1 SMP Tue May 3 13:29:55 UTC 2011
Jun 27 13:47:39 localhost kernel: [    0.000000] BIOS-provided physical RAM map:
Jun 27 13:47:39 localhost kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Jun 27 13:47:39 localhost kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 00000000cf379000 (usable)
Jun 27 13:47:39 localhost kernel: [    0.000000]  BIOS-e820: 00000000cf379000 - 00000000cf38f000 (reserved)
Jun 27 13:47:39 localhost kernel: [    0.000000]  BIOS-e820: 00000000cf38f000 - 00000000cf3ce000 (ACPI data)
Jun 27 13:47:39 localhost kernel: [    0.000000]  BIOS-e820: 00000000cf3ce000 - 00000000d0000000 (reserved)
Jun 27 13:47:39 localhost kernel: [    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jun 27 13:47:39 localhost kernel: [    0.000000]  BIOS-e820: 00000000fe000000 - 0000000100000000 (reserved)
Jun 27 13:47:39 localhost kernel: [    0.000000]  BIOS-e820: 0000000100000000 - 0000000330000000 (usable)
Jun 27 13:47:39 localhost kernel: [    0.000000] NX (Execute Disable) protection: active
Jun 27 13:47:39 localhost kernel: [    0.000000] DMI 2.6 present.
Jun 27 13:47:39 localhost kernel: [    0.000000] last_pfn = 0x330000 max_arch_pfn = 0x1000000
Jun 27 13:47:39 localhost kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Jun 27 13:47:39 localhost kernel: [    0.000000] found SMP MP-table at [c00fe710] fe710
Jun 27 13:47:39 localhost kernel: [    0.000000] init_memory_mapping: 0000000000000000-00000000371fe000
Jun 27 13:47:39 localhost kernel: [    0.000000] RAMDISK: 37465000 - 37ff0000
Jun 27 13:47:39 localhost kernel: [    0.000000] Allocated new RAMDISK: 00c6a000 - 017f4441
Jun 27 13:47:39 localhost kernel: [    0.000000] Move RAMDISK from 0000000037465000 - 0000000037fef440 to 00c6a000 - 017f4440
Jun 27 13:47:39 localhost kernel: [    0.000000] Reserving 64MB of memory at 32MB for crashkernel (System RAM: 13056MB)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: RSDP 000f10c0 00024 (v02 DELL  )
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: XSDT 000f11c4 0009C (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: FACP cf3b3f9c 000F4 (v03 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: DSDT cf38f000 03B51 (v01 DELL   PE_SC3   00000001 INTL 20050624)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: FACS cf3b6000 00040
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: APIC cf3b3478 0015E (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: SPCR cf3b35d8 00050 (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: HPET cf3b362c 00038 (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: DM__ cf3b3668 001C0 (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: MCFG cf3b38c4 0003C (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: WD__ cf3b3904 00134 (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: SLIC cf3b3a3c 00024 (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: ERST cf392cd4 00270 (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: HEST cf392f44 003A8 (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: BERT cf392b54 00030 (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: EINJ cf392b84 00150 (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: SRAT cf3b3bc0 00370 (v01 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: TCPA cf3b3f34 00064 (v02 DELL   PE_SC3   00000001 DELL 00000001)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: SSDT cf3b7000 0220C (v01  INTEL PPM RCM  80000001 INTL 20061109)
Jun 27 13:47:39 localhost kernel: [    0.000000] 12174MB HIGHMEM available.
Jun 27 13:47:39 localhost kernel: [    0.000000] 881MB LOWMEM available.
Jun 27 13:47:39 localhost kernel: [    0.000000]   mapped low ram: 0 - 371fe000
Jun 27 13:47:39 localhost kernel: [    0.000000]   low ram: 0 - 371fe000
Jun 27 13:47:39 localhost kernel: [    0.000000]   node 0 low ram: 00000000 - 371fe000
Jun 27 13:47:39 localhost kernel: [    0.000000]   node 0 bootmap 0000e000 - 00014e40
Jun 27 13:47:39 localhost kernel: [    0.000000] (14/32 early reservations) ==> bootmem [0000000000 - 00371fe000]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #0 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #1 [0000400000 - 0000c602c0]    TEXT DATA BSS ==> [0000400000 - 0000c602c0]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #2 [0000c61000 - 0000c69275]              BRK ==> [0000c61000 - 0000c69275]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #3 [00000fe720 - 0000100000]    BIOS reserved ==> [00000fe720 - 0000100000]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #4 [00000fe710 - 00000fe720]     MP-table mpf ==> [00000fe710 - 00000fe720]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #5 [000009e800 - 00000f0000]    BIOS reserved ==> [000009e800 - 00000f0000]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #6 [00000f02b4 - 00000fe710]    BIOS reserved ==> [00000f02b4 - 00000fe710]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #7 [00000f0000 - 00000f02b4]     MP-table mpc ==> [00000f0000 - 00000f02b4]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #8 [0000002000 - 0000003000]       TRAMPOLINE ==> [0000002000 - 0000003000]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #9 [0000003000 - 0000007000]      ACPI WAKEUP ==> [0000003000 - 0000007000]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #10 [0000007000 - 000000e000]          PGTABLE ==> [0000007000 - 000000e000]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #11 [0000c6a000 - 00017f5000]      NEW RAMDISK ==> [0000c6a000 - 00017f5000]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #12 [0002000000 - 0006000000]     CRASH KERNEL ==> [0002000000 - 0006000000]
Jun 27 13:47:39 localhost kernel: [    0.000000]   #13 [000000e000 - 0000015000]          BOOTMAP ==> [000000e000 - 0000015000]
Jun 27 13:47:39 localhost kernel: [    0.000000] Zone PFN ranges:
Jun 27 13:47:39 localhost kernel: [    0.000000]   DMA      0x00000001 -> 0x00001000
Jun 27 13:47:39 localhost kernel: [    0.000000]   Normal   0x00001000 -> 0x000371fe
Jun 27 13:47:39 localhost kernel: [    0.000000]   HighMem  0x000371fe -> 0x00330000
Jun 27 13:47:39 localhost kernel: [    0.000000] Movable zone start PFN for each node
Jun 27 13:47:39 localhost kernel: [    0.000000] early_node_map[3] active PFN ranges
Jun 27 13:47:39 localhost kernel: [    0.000000]     0: 0x00000001 -> 0x000000a0
Jun 27 13:47:39 localhost kernel: [    0.000000]     0: 0x00000100 -> 0x000cf379
Jun 27 13:47:39 localhost kernel: [    0.000000]     0: 0x00100000 -> 0x00330000
Jun 27 13:47:39 localhost kernel: [    0.000000] Using APIC driver default
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x808
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x20] enabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x22] enabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x32] enabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x34] enabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x21] enabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x23] enabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x33] enabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x35] enabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x11] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x12] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x13] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x14] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x15] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x16] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x17] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x18] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x19] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x1a] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x1b] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x1c] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x1d] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x1e] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x1f] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x20] lapic_id[0xff] disabled)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
Jun 27 13:47:39 localhost kernel: [    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec80000] gsi_base[32])
Jun 27 13:47:39 localhost kernel: [    0.000000] IOAPIC[1]: apic_id 1, version 32, address 0xfec80000, GSI 32-55
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jun 27 13:47:39 localhost kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Jun 27 13:47:39 localhost kernel: [    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
Jun 27 13:47:39 localhost kernel: [    0.000000] SMP: Allowing 32 CPUs, 24 hotplug CPUs
Jun 27 13:47:39 localhost kernel: [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 0000000000100000
Jun 27 13:47:39 localhost kernel: [    0.000000] Allocating PCI resources starting at d0000000 (gap: d0000000:10000000)
Jun 27 13:47:39 localhost kernel: [    0.000000] Booting paravirtualized kernel on bare hardware
Jun 27 13:47:39 localhost kernel: [    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:32 nr_node_ids:1
Jun 27 13:47:39 localhost kernel: [    0.000000] PERCPU: Embedded 15 pages/cpu @cc800000 s38464 r0 d22976 u65536
Jun 27 13:47:39 localhost kernel: [    0.000000] pcpu-alloc: s38464 r0 d22976 u65536 alloc=1*2097152
Jun 27 13:47:39 localhost kernel: [    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Jun 27 13:47:39 localhost kernel: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 3116311
Jun 27 13:47:39 localhost kernel: [    0.000000] Kernel command line: ro root=/dev/files/root rhgb quiet vga=0x314 crashkernel=64M selinux=0 erst_disable
Jun 27 13:47:39 localhost kernel: [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
Jun 27 13:47:39 localhost kernel: [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Jun 27 13:47:39 localhost kernel: [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Jun 27 13:47:39 localhost kernel: [    0.000000] Enabling fast FPU save and restore... done.
Jun 27 13:47:39 localhost kernel: [    0.000000] Enabling unmasked SIMD FPU exception support... done.
Jun 27 13:47:39 localhost kernel: [    0.000000] Initializing CPU#0
Jun 27 13:47:39 localhost kernel: [    0.000000] allocated 66846700 bytes of page_cgroup
Jun 27 13:47:39 localhost kernel: [    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
Jun 27 13:47:39 localhost kernel: [    0.000000] Initializing HighMem for node 0 (000371fe:00330000)
Jun 27 13:47:39 localhost kernel: [    0.000000] Memory: 12311128k/13369344k available (3841k kernel code, 258568k reserved, 2544k data, 564k init, 11666924k highmem)
Jun 27 13:47:39 localhost kernel: [    0.000000] virtual kernel memory layout:
Jun 27 13:47:39 localhost kernel: [    0.000000]     fixmap  : 0xff575000 - 0xfffff000   (10792 kB)
Jun 27 13:47:39 localhost kernel: [    0.000000]     pkmap   : 0xff200000 - 0xff400000   (2048 kB)
Jun 27 13:47:39 localhost kernel: [    0.000000]     vmalloc : 0xf79fe000 - 0xff1fe000   ( 120 MB)
Jun 27 13:47:39 localhost kernel: [    0.000000]     lowmem  : 0xc0000000 - 0xf71fe000   ( 881 MB)
Jun 27 13:47:39 localhost kernel: [    0.000000]       .init : 0xc0a3d000 - 0xc0aca000   ( 564 kB)
Jun 27 13:47:39 localhost kernel: [    0.000000]       .data : 0xc07c05aa - 0xc0a3c920   (2544 kB)
Jun 27 13:47:39 localhost kernel: [    0.000000]       .text : 0xc0400000 - 0xc07c05aa   (3841 kB)
Jun 27 13:47:39 localhost kernel: [    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
Jun 27 13:47:39 localhost kernel: [    0.000000] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
Jun 27 13:47:39 localhost kernel: [    0.000000] Hierarchical RCU implementation.
Jun 27 13:47:39 localhost kernel: [    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
Jun 27 13:47:39 localhost kernel: [    0.000000] 	RCU-based detection of stalled CPUs is disabled.
Jun 27 13:47:39 localhost kernel: [    0.000000] 	Verbose stalled-CPUs detection is disabled.
Jun 27 13:47:39 localhost kernel: [    0.000000] NR_IRQS:2304
Jun 27 13:47:39 localhost kernel: [    0.000000] Extended CMOS year: 2000
Jun 27 13:47:39 localhost kernel: [    0.000000] Console: colour dummy device 80x25
Jun 27 13:47:39 localhost kernel: [    0.000000] console [tty0] enabled
Jun 27 13:47:39 localhost kernel: [    0.000000] Fast TSC calibration using PIT
Jun 27 13:47:39 localhost kernel: [    0.001000] Detected 2394.285 MHz processor.
Jun 27 13:47:39 localhost kernel: [    0.000006] Calibrating delay loop (skipped), value calculated using timer frequency.. 4788.57 BogoMIPS (lpj=2394285)
Jun 27 13:47:39 localhost kernel: [    0.000010] pid_max: default: 32768 minimum: 301
Jun 27 13:47:39 localhost kernel: [    0.000033] Security Framework initialized
Jun 27 13:47:39 localhost kernel: [    0.000038] SELinux:  Disabled at boot.
Jun 27 13:47:39 localhost kernel: [    0.000086] Mount-cache hash table entries: 512
Jun 27 13:47:39 localhost kernel: [    0.000222] Initializing cgroup subsys ns
Jun 27 13:47:39 localhost kernel: [    0.000226] Initializing cgroup subsys cpuacct
Jun 27 13:47:39 localhost kernel: [    0.000234] Initializing cgroup subsys memory
Jun 27 13:47:39 localhost kernel: [    0.000243] Initializing cgroup subsys devices
Jun 27 13:47:39 localhost kernel: [    0.000245] Initializing cgroup subsys freezer
Jun 27 13:47:39 localhost kernel: [    0.000247] Initializing cgroup subsys net_cls
Jun 27 13:47:39 localhost kernel: [    0.000249] Initializing cgroup subsys blkio
Jun 27 13:47:39 localhost kernel: [    0.000276] CPU: Physical Processor ID: 1
Jun 27 13:47:39 localhost kernel: [    0.000277] CPU: Processor Core ID: 0
Jun 27 13:47:39 localhost kernel: [    0.000281] mce: CPU supports 9 MCE banks
Jun 27 13:47:39 localhost kernel: [    0.000290] CPU0: Thermal monitoring enabled (TM1)
Jun 27 13:47:39 localhost kernel: [    0.000296] using mwait in idle threads.
Jun 27 13:47:39 localhost kernel: [    0.000300] Performance Events: PEBS fmt1+, Westmere events, Intel PMU driver.
Jun 27 13:47:39 localhost kernel: [    0.000305] ... version:                3
Jun 27 13:47:39 localhost kernel: [    0.000307] ... bit width:              48
Jun 27 13:47:39 localhost kernel: [    0.000308] ... generic registers:      4
Jun 27 13:47:39 localhost kernel: [    0.000309] ... value mask:             0000ffffffffffff
Jun 27 13:47:39 localhost kernel: [    0.000311] ... max period:             000000007fffffff
Jun 27 13:47:39 localhost kernel: [    0.000312] ... fixed-purpose events:   3
Jun 27 13:47:39 localhost kernel: [    0.000314] ... event mask:             000000070000000f
Jun 27 13:47:39 localhost kernel: [    0.000719] ACPI: Core revision 20100428
Jun 27 13:47:39 localhost kernel: [    0.004718] ftrace: converting mcount calls to 0f 1f 44 00 00
Jun 27 13:47:39 localhost kernel: [    0.004721] ftrace: allocating 23603 entries in 47 pages
Jun 27 13:47:39 localhost kernel: [    0.010909] Overriding APIC driver with bigsmp
Jun 27 13:47:39 localhost kernel: [    0.010911] Enabling APIC mode:  Physflat.  Using 2 I/O APICs
Jun 27 13:47:39 localhost kernel: [    0.011179] Leaving ESR disabled.
Jun 27 13:47:39 localhost kernel: [    0.011366] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Jun 27 13:47:39 localhost kernel: [    0.021353] CPU0: Intel(R) Xeon(R) CPU           E5620  @ 2.40GHz stepping 02
Jun 27 13:47:39 localhost kernel: [    0.122746] Booting Node   0, Processors  #1
Jun 27 13:47:39 localhost kernel: [    0.133366] Initializing CPU#1
Jun 27 13:47:39 localhost kernel: [    0.133839] Leaving ESR disabled.
Jun 27 13:47:39 localhost kernel: [    0.213637]  #2
Jun 27 13:47:39 localhost kernel: [    0.224133] Initializing CPU#2
Jun 27 13:47:39 localhost kernel: [    0.224727] Leaving ESR disabled.
Jun 27 13:47:39 localhost kernel: [    0.304422]  #3
Jun 27 13:47:39 localhost kernel: [    0.314915] Initializing CPU#3
Jun 27 13:47:39 localhost kernel: [    0.315512] Leaving ESR disabled.
Jun 27 13:47:39 localhost kernel: [    0.395309]  #4
Jun 27 13:47:39 localhost kernel: [    0.405814] Initializing CPU#4
Jun 27 13:47:39 localhost kernel: [    0.406509] Leaving ESR disabled.
Jun 27 13:47:39 localhost kernel: [    0.486106]  #5
Jun 27 13:47:39 localhost kernel: [    0.496600] Initializing CPU#5
Jun 27 13:47:39 localhost kernel: [    0.497196] Leaving ESR disabled.
Jun 27 13:47:39 localhost kernel: [    0.576901]  #6
Jun 27 13:47:39 localhost kernel: [    0.587394] Initializing CPU#6
Jun 27 13:47:39 localhost kernel: [    0.587991] Leaving ESR disabled.
Jun 27 13:47:39 localhost kernel: [    0.667794]  #7
Jun 27 13:47:39 localhost kernel: [    0.678288] Initializing CPU#7
Jun 27 13:47:39 localhost kernel: [    0.678884] Leaving ESR disabled.
Jun 27 13:47:39 localhost kernel: [    0.758535] Brought up 8 CPUs
Jun 27 13:47:39 localhost kernel: [    0.758538] Total of 8 processors activated (38302.80 BogoMIPS).
Jun 27 13:47:39 localhost kernel: [    0.764738] devtmpfs: initialized
Jun 27 13:47:39 localhost kernel: [    0.765690] atomic64 test passed for i586+ platform with CX8 and with SSE
Jun 27 13:47:39 localhost kernel: [    0.765717] Time: 17:47:15  Date: 06/27/11
Jun 27 13:47:39 localhost kernel: [    0.765757] NET: Registered protocol family 16
Jun 27 13:47:39 localhost kernel: [    0.765830] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
Jun 27 13:47:39 localhost kernel: [    0.765832] ACPI: bus type pci registered
Jun 27 13:47:39 localhost kernel: [    0.765899] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Jun 27 13:47:39 localhost kernel: [    0.765902] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
Jun 27 13:47:39 localhost kernel: [    0.765904] PCI: Using MMCONFIG for extended config space
Jun 27 13:47:39 localhost kernel: [    0.765905] PCI: Using configuration type 1 for base access
Jun 27 13:47:39 localhost kernel: [    0.766946] bio: create slab <bio-0> at 0
Jun 27 13:47:39 localhost kernel: [    0.768698] ACPI: BIOS _OSI(Linux) query ignored
Jun 27 13:47:39 localhost kernel: [    0.770707] ACPI: Interpreter enabled
Jun 27 13:47:39 localhost kernel: [    0.770710] ACPI: (supports S0 S4 S5)
Jun 27 13:47:39 localhost kernel: [    0.770723] ACPI: Using IOAPIC for interrupt routing
Jun 27 13:47:39 localhost kernel: [    0.774980] ACPI: No dock devices found.
Jun 27 13:47:39 localhost kernel: [    0.774983] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
Jun 27 13:47:39 localhost kernel: [    0.775332] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Jun 27 13:47:39 localhost kernel: [    0.776648] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0c00 (mask 007f)
Jun 27 13:47:39 localhost kernel: [    0.776652] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0ca0 (mask 000f)
Jun 27 13:47:39 localhost kernel: [    0.776655] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 00e0 (mask 000f)
Jun 27 13:47:39 localhost kernel: [    0.777034] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jun 27 13:47:39 localhost kernel: [    0.777079] pci 0000:00:03.0: PCI bridge to [bus 02-02]
Jun 27 13:47:39 localhost kernel: [    0.777186] pci 0000:00:07.0: PCI bridge to [bus 03-03]
Jun 27 13:47:39 localhost kernel: [    0.777324] pci 0000:00:1e.0: PCI bridge to [bus 04-04] (subtractive decode)
Jun 27 13:47:39 localhost kernel: [    0.780664] ACPI: PCI Interrupt Link [LK00] (IRQs 3 4 5 6 7 10 11 14 *15)
Jun 27 13:47:39 localhost kernel: [    0.780765] ACPI: PCI Interrupt Link [LK01] (IRQs 3 4 5 6 7 10 11 *14 15)
Jun 27 13:47:39 localhost kernel: [    0.780863] ACPI: PCI Interrupt Link [LK02] (IRQs 3 4 5 6 7 10 *11 14 15)
Jun 27 13:47:39 localhost kernel: [    0.780962] ACPI: PCI Interrupt Link [LK03] (IRQs 3 4 5 6 7 *10 11 14 15)
Jun 27 13:47:39 localhost kernel: [    0.781060] ACPI: PCI Interrupt Link [LK04] (IRQs 3 4 *5 6 7 10 11 14 15)
Jun 27 13:47:39 localhost kernel: [    0.781158] ACPI: PCI Interrupt Link [LK05] (IRQs 3 4 5 *6 7 10 11 14 15)
Jun 27 13:47:39 localhost kernel: [    0.781256] ACPI: PCI Interrupt Link [LK06] (IRQs 3 4 5 6 7 10 *11 14 15)
Jun 27 13:47:39 localhost kernel: [    0.781353] ACPI: PCI Interrupt Link [LK07] (IRQs 3 4 5 6 7 10 11 *14 15)
Jun 27 13:47:39 localhost kernel: [    0.781472] HEST: HEST table parsing is initialized.
Jun 27 13:47:39 localhost kernel: [    0.781523] vgaarb: device added: PCI:0000:04:03.0,decodes=io+mem,owns=io+mem,locks=none
Jun 27 13:47:39 localhost kernel: [    0.781525] vgaarb: loaded
Jun 27 13:47:39 localhost kernel: [    0.781597] SCSI subsystem initialized
Jun 27 13:47:39 localhost kernel: [    0.781762] usbcore: registered new interface driver usbfs
Jun 27 13:47:39 localhost kernel: [    0.781773] usbcore: registered new interface driver hub
Jun 27 13:47:39 localhost kernel: [    0.781794] usbcore: registered new device driver usb
Jun 27 13:47:39 localhost kernel: [    0.781844] PCI: Using ACPI for IRQ routing
Jun 27 13:47:39 localhost kernel: [    0.781986] NetLabel: Initializing
Jun 27 13:47:39 localhost kernel: [    0.781988] NetLabel:  domain hash size = 128
Jun 27 13:47:39 localhost kernel: [    0.781989] NetLabel:  protocols = UNLABELED CIPSOv4
Jun 27 13:47:39 localhost kernel: [    0.781998] NetLabel:  unlabeled traffic allowed by default
Jun 27 13:47:39 localhost kernel: [    0.782036] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
Jun 27 13:47:39 localhost kernel: [    0.782040] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
Jun 27 13:47:39 localhost kernel: [    0.784057] Switching to clocksource tsc
Jun 27 13:47:39 localhost kernel: [    0.791877] pnp: PnP ACPI init
Jun 27 13:47:39 localhost kernel: [    0.791887] ACPI: bus type pnp registered
Jun 27 13:47:39 localhost kernel: [    0.795310] pnp: PnP ACPI: found 12 devices
Jun 27 13:47:39 localhost kernel: [    0.795312] ACPI: ACPI bus type pnp unregistered
Jun 27 13:47:39 localhost kernel: [    0.795323] system 00:07: [io  0x0800-0x087f] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795326] system 00:07: [io  0x0880-0x08ff] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795328] system 00:07: [io  0x0900-0x091f] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795330] system 00:07: [io  0x0920-0x0923] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795332] system 00:07: [io  0x0924] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795335] system 00:07: [io  0x0c00-0x0c7f] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795337] system 00:07: [io  0x0ca0-0x0ca7] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795339] system 00:07: [io  0x0ca9-0x0cab] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795341] system 00:07: [io  0x0cad-0x0caf] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795346] system 00:08: [io  0x0ca8] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795348] system 00:08: [io  0x0cac] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795352] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.795358] system 00:0b: [mem 0xfed90000-0xfed91fff] has been reserved
Jun 27 13:47:39 localhost kernel: [    0.831070] pci 0000:00:01.0: PCI bridge to [bus 01-01]
Jun 27 13:47:39 localhost kernel: [    0.831072] pci 0000:00:01.0:   bridge window [io  disabled]
Jun 27 13:47:39 localhost kernel: [    0.831076] pci 0000:00:01.0:   bridge window [mem 0xda000000-0xddffffff]
Jun 27 13:47:39 localhost kernel: [    0.831079] pci 0000:00:01.0:   bridge window [mem pref disabled]
Jun 27 13:47:39 localhost kernel: [    0.831083] pci 0000:00:03.0: PCI bridge to [bus 02-02]
Jun 27 13:47:39 localhost kernel: [    0.831084] pci 0000:00:03.0:   bridge window [io  disabled]
Jun 27 13:47:39 localhost kernel: [    0.831088] pci 0000:00:03.0:   bridge window [mem disabled]
Jun 27 13:47:39 localhost kernel: [    0.831091] pci 0000:00:03.0:   bridge window [mem pref disabled]
Jun 27 13:47:39 localhost kernel: [    0.831095] pci 0000:00:07.0: PCI bridge to [bus 03-03]
Jun 27 13:47:39 localhost kernel: [    0.831097] pci 0000:00:07.0:   bridge window [io  0xf000-0xffff]
Jun 27 13:47:39 localhost kernel: [    0.831101] pci 0000:00:07.0:   bridge window [mem 0xdf100000-0xdf1fffff]
Jun 27 13:47:39 localhost kernel: [    0.831104] pci 0000:00:07.0:   bridge window [mem pref disabled]
Jun 27 13:47:39 localhost kernel: [    0.831110] pci 0000:04:03.0: BAR 6: assigned [mem 0xde000000-0xde00ffff pref]
Jun 27 13:47:39 localhost kernel: [    0.831112] pci 0000:00:1e.0: PCI bridge to [bus 04-04]
Jun 27 13:47:39 localhost kernel: [    0.831114] pci 0000:00:1e.0:   bridge window [io  disabled]
Jun 27 13:47:39 localhost kernel: [    0.831118] pci 0000:00:1e.0:   bridge window [mem 0xde000000-0xdeffffff]
Jun 27 13:47:39 localhost kernel: [    0.831121] pci 0000:00:1e.0:   bridge window [mem 0xd9800000-0xd9ffffff 64bit pref]
Jun 27 13:47:39 localhost kernel: [    0.831135] pci 0000:00:01.0: PCI INT A -> GSI 53 (level, low) -> IRQ 53
Jun 27 13:47:39 localhost kernel: [    0.831144] pci 0000:00:03.0: PCI INT A -> GSI 53 (level, low) -> IRQ 53
Jun 27 13:47:39 localhost kernel: [    0.831153] pci 0000:00:07.0: PCI INT A -> GSI 53 (level, low) -> IRQ 53
Jun 27 13:47:39 localhost kernel: [    0.831200] NET: Registered protocol family 2
Jun 27 13:47:39 localhost kernel: [    0.831233] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Jun 27 13:47:39 localhost kernel: [    0.831311] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
Jun 27 13:47:39 localhost kernel: [    0.831537] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
Jun 27 13:47:39 localhost kernel: [    0.831633] TCP: Hash tables configured (established 131072 bind 65536)
Jun 27 13:47:39 localhost kernel: [    0.831635] TCP reno registered
Jun 27 13:47:39 localhost kernel: [    0.831637] UDP hash table entries: 512 (order: 2, 16384 bytes)
Jun 27 13:47:39 localhost kernel: [    0.831642] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
Jun 27 13:47:39 localhost kernel: [    0.831760] NET: Registered protocol family 1
Jun 27 13:47:39 localhost kernel: [    0.842464] Trying to unpack rootfs image as initramfs...
Jun 27 13:47:39 localhost kernel: [    1.094202] Freeing initrd memory: 11820k freed
Jun 27 13:47:39 localhost kernel: [    1.096759] apm: BIOS not found.
Jun 27 13:47:39 localhost kernel: [    1.096874] audit: initializing netlink socket (disabled)
Jun 27 13:47:39 localhost kernel: [    1.096883] type=2000 audit(1309196834.853:1): initialized
Jun 27 13:47:39 localhost kernel: [    1.107600] highmem bounce pool size: 64 pages
Jun 27 13:47:39 localhost kernel: [    1.107604] HugeTLB registered 2 MB page size, pre-allocated 0 pages
Jun 27 13:47:39 localhost kernel: [    1.108815] VFS: Disk quotas dquot_6.5.2
Jun 27 13:47:39 localhost kernel: [    1.108871] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Jun 27 13:47:39 localhost kernel: [    1.109267] msgmni has been set to 1281
Jun 27 13:47:39 localhost kernel: [    1.109552] alg: No test for stdrng (krng)
Jun 27 13:47:39 localhost kernel: [    1.109593] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
Jun 27 13:47:39 localhost kernel: [    1.109596] io scheduler noop registered
Jun 27 13:47:39 localhost kernel: [    1.109597] io scheduler deadline registered
Jun 27 13:47:39 localhost kernel: [    1.109607] io scheduler cfq registered (default)
Jun 27 13:47:39 localhost kernel: [    1.110039] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jun 27 13:47:39 localhost kernel: [    1.110055] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
Jun 27 13:47:39 localhost kernel: [    1.110057] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Jun 27 13:47:39 localhost kernel: [    1.110382] vesafb: framebuffer at 0xd9800000, mapped to 0xf7a80000, using 1875k, total 8192k
Jun 27 13:47:39 localhost kernel: [    1.110384] vesafb: mode is 800x600x16, linelength=1600, pages=7
Jun 27 13:47:39 localhost kernel: [    1.110386] vesafb: protected mode interface info at c000:7d80
Jun 27 13:47:39 localhost kernel: [    1.110388] vesafb: pmi: set display start = c00c7e12, set palette = c00c7e7e
Jun 27 13:47:39 localhost kernel: [    1.110389] vesafb: pmi: ports = 3de 3df 
Jun 27 13:47:39 localhost kernel: [    1.110391] vesafb: scrolling: redraw
Jun 27 13:47:39 localhost kernel: [    1.110394] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Jun 27 13:47:39 localhost kernel: [    1.110451] Console: switching to colour frame buffer device 100x37
Jun 27 13:47:39 localhost kernel: [    1.146727] fb0: VESA VGA frame buffer device
Jun 27 13:47:39 localhost kernel: [    1.146858] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
Jun 27 13:47:39 localhost kernel: [    1.146862] ACPI: Power Button [PWRF]
Jun 27 13:47:39 localhost kernel: [    1.149397] ERST: Error Record Serialization Table (ERST) support is disabled.
Jun 27 13:47:39 localhost kernel: [    1.149409] isapnp: Scanning for PnP cards...
Jun 27 13:47:39 localhost kernel: [    1.461104] isapnp: No Plug & Play device found
Jun 27 13:47:39 localhost kernel: [    1.461301] Non-volatile memory driver v1.3
Jun 27 13:47:39 localhost kernel: [    1.461303] Linux agpgart interface v0.103
Jun 27 13:47:39 localhost kernel: [    1.461400] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Jun 27 13:47:39 localhost kernel: [    1.704864] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 27 13:47:39 localhost kernel: [    1.948472] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jun 27 13:47:39 localhost kernel: [    1.948704] 00:05: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 27 13:47:39 localhost kernel: [    1.948827] 00:06: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jun 27 13:47:39 localhost kernel: [    1.949903] brd: module loaded
Jun 27 13:47:39 localhost kernel: [    1.950422] loop: module loaded
Jun 27 13:47:39 localhost kernel: [    1.950500] ata_piix 0000:00:1f.2: PCI INT C -> GSI 23 (level, low) -> IRQ 23
Jun 27 13:47:39 localhost kernel: [    1.950504] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
Jun 27 13:47:39 localhost kernel: [    2.101059] scsi0 : ata_piix
Jun 27 13:47:39 localhost kernel: [    2.101158] scsi1 : ata_piix
Jun 27 13:47:39 localhost kernel: [    2.101207] ata1: SATA max UDMA/133 cmd 0xe8e0 ctl 0xe8d0 bmdma 0xec00 irq 23
Jun 27 13:47:39 localhost kernel: [    2.101213] ata2: SATA max UDMA/133 cmd 0xe8e8 ctl 0xe8d4 bmdma 0xec08 irq 23
Jun 27 13:47:39 localhost kernel: [    2.101239] ata_piix 0000:00:1f.5: PCI INT D -> GSI 22 (level, low) -> IRQ 22
Jun 27 13:47:39 localhost kernel: [    2.101247] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
Jun 27 13:47:39 localhost kernel: [    2.251821] scsi2 : ata_piix
Jun 27 13:47:39 localhost kernel: [    2.251903] scsi3 : ata_piix
Jun 27 13:47:39 localhost kernel: [    2.251951] ata3: SATA max UDMA/133 cmd 0xe8f0 ctl 0xe8d8 bmdma 0xec20 irq 22
Jun 27 13:47:39 localhost kernel: [    2.251955] ata4: SATA max UDMA/133 cmd 0xe8f8 ctl 0xe8dc bmdma 0xec28 irq 22
Jun 27 13:47:39 localhost kernel: [    2.252027] Fixed MDIO Bus: probed
Jun 27 13:47:39 localhost kernel: [    2.252083] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jun 27 13:47:39 localhost kernel: [    2.252104] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 19 (level, low) -> IRQ 19
Jun 27 13:47:39 localhost kernel: [    2.252122] ehci_hcd 0000:00:1a.7: EHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.252179] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
Jun 27 13:47:39 localhost kernel: [    2.252209] ehci_hcd 0000:00:1a.7: debug port 1
Jun 27 13:47:39 localhost kernel: [    2.256108] ehci_hcd 0000:00:1a.7: irq 19, io mem 0xdf0fe000
Jun 27 13:47:39 localhost kernel: [    2.265711] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
Jun 27 13:47:39 localhost kernel: [    2.265746] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Jun 27 13:47:39 localhost kernel: [    2.265750] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jun 27 13:47:39 localhost kernel: [    2.265752] usb usb1: Product: EHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.265755] usb usb1: Manufacturer: Linux 2.6.35.13-91.fc14.i686.PAE ehci_hcd
Jun 27 13:47:39 localhost kernel: [    2.265758] usb usb1: SerialNumber: 0000:00:1a.7
Jun 27 13:47:39 localhost kernel: [    2.265876] hub 1-0:1.0: USB hub found
Jun 27 13:47:39 localhost kernel: [    2.265881] hub 1-0:1.0: 4 ports detected
Jun 27 13:47:39 localhost kernel: [    2.265960] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 21 (level, low) -> IRQ 21
Jun 27 13:47:39 localhost kernel: [    2.265977] ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.266020] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
Jun 27 13:47:39 localhost kernel: [    2.266048] ehci_hcd 0000:00:1d.7: debug port 1
Jun 27 13:47:39 localhost kernel: [    2.269941] ehci_hcd 0000:00:1d.7: irq 21, io mem 0xdf0ff000
Jun 27 13:47:39 localhost kernel: [    2.279686] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
Jun 27 13:47:39 localhost kernel: [    2.279706] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
Jun 27 13:47:39 localhost kernel: [    2.279709] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jun 27 13:47:39 localhost kernel: [    2.279712] usb usb2: Product: EHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.279714] usb usb2: Manufacturer: Linux 2.6.35.13-91.fc14.i686.PAE ehci_hcd
Jun 27 13:47:39 localhost kernel: [    2.279717] usb usb2: SerialNumber: 0000:00:1d.7
Jun 27 13:47:39 localhost kernel: [    2.279828] hub 2-0:1.0: USB hub found
Jun 27 13:47:39 localhost kernel: [    2.279833] hub 2-0:1.0: 4 ports detected
Jun 27 13:47:39 localhost kernel: [    2.279914] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jun 27 13:47:39 localhost kernel: [    2.279930] uhci_hcd: USB Universal Host Controller Interface driver
Jun 27 13:47:39 localhost kernel: [    2.279954] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jun 27 13:47:39 localhost kernel: [    2.279965] uhci_hcd 0000:00:1a.0: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.280009] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
Jun 27 13:47:39 localhost kernel: [    2.280044] uhci_hcd 0000:00:1a.0: irq 17, io base 0x0000ec40
Jun 27 13:47:39 localhost kernel: [    2.280077] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
Jun 27 13:47:39 localhost kernel: [    2.280080] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jun 27 13:47:39 localhost kernel: [    2.280083] usb usb3: Product: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.280086] usb usb3: Manufacturer: Linux 2.6.35.13-91.fc14.i686.PAE uhci_hcd
Jun 27 13:47:39 localhost kernel: [    2.280088] usb usb3: SerialNumber: 0000:00:1a.0
Jun 27 13:47:39 localhost kernel: [    2.280195] hub 3-0:1.0: USB hub found
Jun 27 13:47:39 localhost kernel: [    2.280200] hub 3-0:1.0: 2 ports detected
Jun 27 13:47:39 localhost kernel: [    2.280271] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 18 (level, low) -> IRQ 18
Jun 27 13:47:39 localhost kernel: [    2.280282] uhci_hcd 0000:00:1a.1: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.280324] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
Jun 27 13:47:39 localhost kernel: [    2.280357] uhci_hcd 0000:00:1a.1: irq 18, io base 0x0000ec60
Jun 27 13:47:39 localhost kernel: [    2.280390] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
Jun 27 13:47:39 localhost kernel: [    2.280393] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jun 27 13:47:39 localhost kernel: [    2.280396] usb usb4: Product: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.280399] usb usb4: Manufacturer: Linux 2.6.35.13-91.fc14.i686.PAE uhci_hcd
Jun 27 13:47:39 localhost kernel: [    2.280401] usb usb4: SerialNumber: 0000:00:1a.1
Jun 27 13:47:39 localhost kernel: [    2.280510] hub 4-0:1.0: USB hub found
Jun 27 13:47:39 localhost kernel: [    2.280514] hub 4-0:1.0: 2 ports detected
Jun 27 13:47:39 localhost kernel: [    2.280585] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
Jun 27 13:47:39 localhost kernel: [    2.280596] uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.280637] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
Jun 27 13:47:39 localhost kernel: [    2.280662] uhci_hcd 0000:00:1d.0: irq 21, io base 0x0000ec80
Jun 27 13:47:39 localhost kernel: [    2.280710] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
Jun 27 13:47:39 localhost kernel: [    2.280714] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jun 27 13:47:39 localhost kernel: [    2.280716] usb usb5: Product: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.280719] usb usb5: Manufacturer: Linux 2.6.35.13-91.fc14.i686.PAE uhci_hcd
Jun 27 13:47:39 localhost kernel: [    2.280722] usb usb5: SerialNumber: 0000:00:1d.0
Jun 27 13:47:39 localhost kernel: [    2.280831] hub 5-0:1.0: USB hub found
Jun 27 13:47:39 localhost kernel: [    2.280835] hub 5-0:1.0: 2 ports detected
Jun 27 13:47:39 localhost kernel: [    2.280910] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 20 (level, low) -> IRQ 20
Jun 27 13:47:39 localhost kernel: [    2.280921] uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.280963] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
Jun 27 13:47:39 localhost kernel: [    2.280997] uhci_hcd 0000:00:1d.1: irq 20, io base 0x0000eca0
Jun 27 13:47:39 localhost kernel: [    2.281033] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
Jun 27 13:47:39 localhost kernel: [    2.281036] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jun 27 13:47:39 localhost kernel: [    2.281039] usb usb6: Product: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.281041] usb usb6: Manufacturer: Linux 2.6.35.13-91.fc14.i686.PAE uhci_hcd
Jun 27 13:47:39 localhost kernel: [    2.281044] usb usb6: SerialNumber: 0000:00:1d.1
Jun 27 13:47:39 localhost kernel: [    2.281157] hub 6-0:1.0: USB hub found
Jun 27 13:47:39 localhost kernel: [    2.281162] hub 6-0:1.0: 2 ports detected
Jun 27 13:47:39 localhost kernel: [    2.281232] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 21 (level, low) -> IRQ 21
Jun 27 13:47:39 localhost kernel: [    2.281243] uhci_hcd 0000:00:1d.2: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.281284] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
Jun 27 13:47:39 localhost kernel: [    2.281309] uhci_hcd 0000:00:1d.2: irq 21, io base 0x0000ecc0
Jun 27 13:47:39 localhost kernel: [    2.281341] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
Jun 27 13:47:39 localhost kernel: [    2.281345] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jun 27 13:47:39 localhost kernel: [    2.281347] usb usb7: Product: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.281350] usb usb7: Manufacturer: Linux 2.6.35.13-91.fc14.i686.PAE uhci_hcd
Jun 27 13:47:39 localhost kernel: [    2.281352] usb usb7: SerialNumber: 0000:00:1d.2
Jun 27 13:47:39 localhost kernel: [    2.281457] hub 7-0:1.0: USB hub found
Jun 27 13:47:39 localhost kernel: [    2.281462] hub 7-0:1.0: 2 ports detected
Jun 27 13:47:39 localhost kernel: [    2.281530] uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 20 (level, low) -> IRQ 20
Jun 27 13:47:39 localhost kernel: [    2.281541] uhci_hcd 0000:00:1d.3: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.281592] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 8
Jun 27 13:47:39 localhost kernel: [    2.281619] uhci_hcd 0000:00:1d.3: irq 20, io base 0x0000ece0
Jun 27 13:47:39 localhost kernel: [    2.281653] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
Jun 27 13:47:39 localhost kernel: [    2.281656] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jun 27 13:47:39 localhost kernel: [    2.281659] usb usb8: Product: UHCI Host Controller
Jun 27 13:47:39 localhost kernel: [    2.281661] usb usb8: Manufacturer: Linux 2.6.35.13-91.fc14.i686.PAE uhci_hcd
Jun 27 13:47:39 localhost kernel: [    2.281664] usb usb8: SerialNumber: 0000:00:1d.3
Jun 27 13:47:39 localhost kernel: [    2.281779] hub 8-0:1.0: USB hub found
Jun 27 13:47:39 localhost kernel: [    2.281784] hub 8-0:1.0: 2 ports detected
Jun 27 13:47:39 localhost kernel: [    2.281924] PNP: No PS/2 controller found. Probing ports directly.
Jun 27 13:47:39 localhost kernel: [    2.284704] serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 27 13:47:39 localhost kernel: [    2.284711] serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 27 13:47:39 localhost kernel: [    2.284761] mice: PS/2 mouse device common for all mice
Jun 27 13:47:39 localhost kernel: [    2.284895] rtc_cmos 00:04: RTC can wake from S4
Jun 27 13:47:39 localhost kernel: [    2.284941] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
Jun 27 13:47:39 localhost kernel: [    2.284968] rtc0: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
Jun 27 13:47:39 localhost kernel: [    2.285090] device-mapper: uevent: version 1.0.3
Jun 27 13:47:39 localhost kernel: [    2.285227] device-mapper: ioctl: 4.19.1-ioctl (2010-10-12) initialised: dm-devel@redhat.com
Jun 27 13:47:39 localhost kernel: [    2.285627] cpuidle: using governor ladder
Jun 27 13:47:39 localhost kernel: [    2.286108] cpuidle: using governor menu
Jun 27 13:47:39 localhost kernel: [    2.286364] usbcore: registered new interface driver hiddev
Jun 27 13:47:39 localhost kernel: [    2.286383] usbcore: registered new interface driver usbhid
Jun 27 13:47:39 localhost kernel: [    2.286385] usbhid: USB HID core driver
Jun 27 13:47:39 localhost kernel: [    2.286435] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
Jun 27 13:47:39 localhost kernel: [    2.286576] CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
Jun 27 13:47:39 localhost kernel: [    2.286579] nf_conntrack.acct=1 kernel parameter, acct=1 nf_conntrack module option or
Jun 27 13:47:39 localhost kernel: [    2.286581] sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
Jun 27 13:47:39 localhost kernel: [    2.286679] ip_tables: (C) 2000-2006 Netfilter Core Team
Jun 27 13:47:39 localhost kernel: [    2.286712] TCP cubic registered
Jun 27 13:47:39 localhost kernel: [    2.286714] Initializing XFRM netlink socket
Jun 27 13:47:39 localhost kernel: [    2.286729] NET: Registered protocol family 17
Jun 27 13:47:39 localhost kernel: [    2.286755] Using IPI No-Shortcut mode
Jun 27 13:47:39 localhost kernel: [    2.286860] registered taskstats version 1
Jun 27 13:47:39 localhost kernel: [    2.287372]   Magic number: 15:69:796
Jun 27 13:47:39 localhost kernel: [    2.287432] rtc_cmos 00:04: setting system clock to 2011-06-27 17:47:17 UTC (1309196837)
Jun 27 13:47:39 localhost kernel: [    2.287473] Initalizing network drop monitor service
Jun 27 13:47:39 localhost kernel: [    2.618221] usb 1-3: new high speed USB device using ehci_hcd and address 3
Jun 27 13:47:39 localhost kernel: [    2.707108] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jun 27 13:47:39 localhost kernel: [    2.726193] ata3.00: ATAPI: TEAC DVD-ROM DV-28SW, R.2A, max UDMA/100
Jun 27 13:47:39 localhost kernel: [    2.732400] usb 1-3: New USB device found, idVendor=0424, idProduct=2514
Jun 27 13:47:39 localhost kernel: [    2.732404] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Jun 27 13:47:39 localhost kernel: [    2.732689] hub 1-3:1.0: USB hub found
Jun 27 13:47:39 localhost kernel: [    2.732895] hub 1-3:1.0: 4 ports detected
Jun 27 13:47:39 localhost kernel: [    2.748177] ata3.00: configured for UDMA/100
Jun 27 13:47:39 localhost kernel: [    2.938672] usb 3-1: new low speed USB device using uhci_hcd and address 2
Jun 27 13:47:39 localhost kernel: [    3.106444] ata2.00: failed to resume link (SControl 0)
Jun 27 13:47:39 localhost kernel: [    3.110725] usb 3-1: New USB device found, idVendor=413c, idProduct=2103
Jun 27 13:47:39 localhost kernel: [    3.110730] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Jun 27 13:47:39 localhost kernel: [    3.110733] usb 3-1: Product: Dell USB/PS2 Combo Rackmount Keyboard
Jun 27 13:47:39 localhost kernel: [    3.110735] usb 3-1: Manufacturer: LITE-ON Technology
Jun 27 13:47:39 localhost kernel: [    3.128884] input: LITE-ON Technology Dell USB/PS2 Combo Rackmount Keyboard as /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1:1.0/input/input1
Jun 27 13:47:39 localhost kernel: [    3.128960] generic-usb 0003:413C:2103.0001: input,hidraw0: USB HID v1.00 Keyboard [LITE-ON Technology Dell USB/PS2 Combo Rackmount Keyboard] on usb-0000:00:1a.0-1/input0
Jun 27 13:47:39 localhost kernel: [    3.144800] input: LITE-ON Technology Dell USB/PS2 Combo Rackmount Keyboard as /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1:1.1/input/input2
Jun 27 13:47:39 localhost kernel: [    3.144903] generic-usb 0003:413C:2103.0002: input,hidraw1: USB HID v1.10 Mouse [LITE-ON Technology Dell USB/PS2 Combo Rackmount Keyboard] on usb-0000:00:1a.0-1/input1
Jun 27 13:47:39 localhost kernel: [    3.257201] ata4: failed to resume link (SControl 0)
Jun 27 13:47:39 localhost kernel: [    3.268543] ata4: SATA link down (SStatus 4 SControl 0)
Jun 27 13:47:39 localhost kernel: [    3.410956] ata1.01: failed to resume link (SControl 0)
Jun 27 13:47:39 localhost kernel: [    3.422360] ata1.00: SATA link down (SStatus 0 SControl 300)
Jun 27 13:47:39 localhost kernel: [    3.422375] ata1.01: SATA link down (SStatus 0 SControl 0)
Jun 27 13:47:39 localhost kernel: [    4.111811] ata2.01: failed to resume link (SControl 0)
Jun 27 13:47:39 localhost kernel: [    4.123190] ata2.00: SATA link down (SStatus 0 SControl 0)
Jun 27 13:47:39 localhost kernel: [    4.123205] ata2.01: SATA link down (SStatus 0 SControl 0)
Jun 27 13:47:39 localhost kernel: [    4.132591] scsi 2:0:0:0: CD-ROM            TEAC     DVD-ROM DV-28SW  R.2A PQ: 0 ANSI: 5
Jun 27 13:47:39 localhost kernel: [    4.167883] sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
Jun 27 13:47:39 localhost kernel: [    4.167887] Uniform CD-ROM driver Revision: 3.20
Jun 27 13:47:39 localhost kernel: [    4.168070] sr 2:0:0:0: Attached scsi generic sg0 type 5
Jun 27 13:47:39 localhost kernel: [    4.168492] Freeing unused kernel memory: 564k freed
Jun 27 13:47:39 localhost kernel: [    4.169313] Write protecting the kernel text: 3844k
Jun 27 13:47:39 localhost kernel: [    4.169951] Write protecting the kernel read-only data: 1864k
Jun 27 13:47:39 localhost kernel: [    4.184672] dracut: dracut-006-6.fc14
Jun 27 13:47:39 localhost kernel: [    4.197493] udev[133]: starting version 161
Jun 27 13:47:39 localhost kernel: [    4.265794] dracut: Starting plymouth daemon
Jun 27 13:47:39 localhost kernel: [    4.480013] megasas: 00.00.04.17.1-rc1 Thu. Oct. 29, 11:41:51 PST 2009
Jun 27 13:47:39 localhost kernel: [    4.480043] megasas: 0x1000:0x0079:0x1028:0x1f16: bus 3:slot 0:func 0
Jun 27 13:47:39 localhost kernel: [    4.480067] megaraid_sas 0000:03:00.0: PCI INT A -> GSI 38 (level, low) -> IRQ 38
Jun 27 13:47:39 localhost kernel: [    4.481095] megasas: FW now in Ready state
Jun 27 13:47:39 localhost kernel: [    4.492295] scsi4 : LSI SAS based MegaRAID driver
Jun 27 13:47:39 localhost kernel: [    4.495853] scsi 4:0:0:0: Direct-Access     ATA      WDC WD1003FBYX-1 1V02 PQ: 0 ANSI: 5
Jun 27 13:47:39 localhost kernel: [    4.499402] scsi 4:0:1:0: Direct-Access     ATA      WDC WD1003FBYX-1 1V02 PQ: 0 ANSI: 5
Jun 27 13:47:39 localhost kernel: [    4.502597] scsi 4:0:2:0: Direct-Access     ATA      WDC WD1003FBYX-1 1V02 PQ: 0 ANSI: 5
Jun 27 13:47:39 localhost kernel: [    4.505874] scsi 4:0:3:0: Direct-Access     ATA      WDC WD1003FBYX-1 1V02 PQ: 0 ANSI: 5
Jun 27 13:47:39 localhost kernel: [    4.582341] scsi 4:0:32:0: Enclosure         DP       BACKPLANE        1.07 PQ: 0 ANSI: 5
Jun 27 13:47:39 localhost kernel: [    4.596190] scsi 4:2:0:0: Direct-Access     DELL     PERC H700        2.10 PQ: 0 ANSI: 5
Jun 27 13:47:39 localhost kernel: [    4.596311] scsi 4:2:1:0: Direct-Access     DELL     PERC H700        2.10 PQ: 0 ANSI: 5
Jun 27 13:47:39 localhost kernel: [    4.609419] scsi 4:0:32:0: Attached scsi generic sg1 type 13
Jun 27 13:47:39 localhost kernel: [    4.609632] sd 4:2:0:0: [sda] 16779264 512-byte logical blocks: (8.59 GB/8.00 GiB)
Jun 27 13:47:39 localhost kernel: [    4.609658] sd 4:2:0:0: Attached scsi generic sg2 type 0
Jun 27 13:47:39 localhost kernel: [    4.609703] sd 4:2:0:0: [sda] Write Protect is off
Jun 27 13:47:39 localhost kernel: [    4.609753] sd 4:2:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jun 27 13:47:39 localhost kernel: [    4.610031] sd 4:2:1:0: [sdb] 5840566272 512-byte logical blocks: (2.99 TB/2.71 TiB)
Jun 27 13:47:39 localhost kernel: [    4.610089]  sda:
Jun 27 13:47:39 localhost kernel: [    4.610111] sd 4:2:1:0: [sdb] Write Protect is off
Jun 27 13:47:39 localhost kernel: [    4.610142] sd 4:2:1:0: Attached scsi generic sg3 type 0
Jun 27 13:47:39 localhost kernel: [    4.610178] sd 4:2:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jun 27 13:47:39 localhost kernel: [    4.610422]  sda1 sda2
Jun 27 13:47:39 localhost kernel: [    4.610474]  sdb:
Jun 27 13:47:39 localhost kernel: [    4.610950] sd 4:2:0:0: [sda] Attached SCSI disk
Jun 27 13:47:39 localhost kernel: [    4.619228]  unknown partition table
Jun 27 13:47:39 localhost kernel: [    4.619662] sd 4:2:1:0: [sdb] Attached SCSI disk
Jun 27 13:47:39 localhost kernel: [    4.994761] dracut: Scanning devices sda2 sdb  for LVM volume groups 
Jun 27 13:47:39 localhost kernel: [    5.026833] dracut: Reading all physical volumes. This may take a while...
Jun 27 13:47:39 localhost kernel: [    5.026899] dracut: Found volume group "cache" using metadata type lvm2
Jun 27 13:47:39 localhost kernel: [    5.026959] dracut: Found volume group "files" using metadata type lvm2
Jun 27 13:47:39 localhost kernel: [    6.005919] dracut: 2 logical volume(s) in volume group "cache" now active
Jun 27 13:47:39 localhost kernel: [    6.005987] dracut: 3 logical volume(s) in volume group "files" now active
Jun 27 13:47:39 localhost kernel: [    6.032443] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
Jun 27 13:47:39 localhost kernel: [    6.045736] dracut: Remounting /dev/files/root with -o noatime,ro
Jun 27 13:47:39 localhost kernel: [    6.048145] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
Jun 27 13:47:39 localhost kernel: [    6.049461] dracut: Mounted root filesystem /dev/mapper/files-root
Jun 27 13:47:39 localhost kernel: [    6.120713] dracut: Switching root
Jun 27 13:47:39 localhost kernel: [    7.164816] udev[426]: starting version 161
Jun 27 13:47:39 localhost kernel: [    7.450184] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
Jun 27 13:47:39 localhost kernel: [    7.524451] EDAC MC: Ver: 2.1.0 May  3 2011
Jun 27 13:47:39 localhost kernel: [    7.528580] PCI: Discovered peer bus fe
Jun 27 13:47:39 localhost kernel: [    7.531107] EDAC MC0: Giving out device to 'i7core_edac.c' 'i7 core #0': DEV 0000:fe:03.0
Jun 27 13:47:39 localhost kernel: [    7.531143] EDAC PCI0: Giving out device to module 'i7core_edac' controller 'EDAC PCI controller': DEV '0000:fe:03.0' (POLLED)
Jun 27 13:47:39 localhost kernel: [    7.531150] EDAC i7core: Driver loaded.
Jun 27 13:47:39 localhost kernel: [    7.632715] iTCO_vendor_support: vendor-support=0
Jun 27 13:47:39 localhost kernel: [    7.634481] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
Jun 27 13:47:39 localhost kernel: [    7.634595] iTCO_wdt: Found a ICH10R TCO device (Version=2, TCOBASE=0x0860)
Jun 27 13:47:39 localhost kernel: [    7.634673] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
Jun 27 13:47:39 localhost kernel: [    7.639822] ses 4:0:32:0: Attached Enclosure device
Jun 27 13:47:39 localhost kernel: [    7.646532] ACPI Error: No handler for Region [IPMI] (f6c1a0a0) [IPMI] (20100428/evregion-369)
Jun 27 13:47:39 localhost kernel: [    7.646540] ACPI Error: Region IPMI(0x7) has no handler (20100428/exfldio-293)
Jun 27 13:47:39 localhost kernel: [    7.646580] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PMI0._GHL] (Node f6c196a8), AE_NOT_EXIST
Jun 27 13:47:39 localhost kernel: [    7.646609] ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PMI0._PMC] (Node f6c19648), AE_NOT_EXIST
Jun 27 13:47:39 localhost kernel: [    7.646637] ACPI Exception: AE_NOT_EXIST, Evaluating _PMC (20100428/power_meter-773)
Jun 27 13:47:39 localhost kernel: [    7.802371] bnx2: Broadcom NetXtreme II Gigabit Ethernet Driver bnx2 v2.0.15 (May 4, 2010)
Jun 27 13:47:39 localhost kernel: [    7.802397] bnx2 0000:01:00.0: PCI INT A -> GSI 36 (level, low) -> IRQ 36
Jun 27 13:47:39 localhost kernel: [    7.840021] bnx2 0000:01:00.0: eth0: Broadcom NetXtreme II BCM5716 1000Base-T (C0) PCI Express found at mem da000000, IRQ 36, node addr 78:2b:cb:36:5c:b6
Jun 27 13:47:39 localhost kernel: [    7.840054] bnx2 0000:01:00.1: PCI INT B -> GSI 48 (level, low) -> IRQ 48
Jun 27 13:47:39 localhost kernel: [    7.843904] bnx2 0000:01:00.1: eth1: Broadcom NetXtreme II BCM5716 1000Base-T (C0) PCI Express found at mem dc000000, IRQ 48, node addr 78:2b:cb:36:5c:b7
Jun 27 13:47:39 localhost kernel: [    9.791756] EXT4-fs (dm-2): re-mounted. Opts: (null)
Jun 27 13:47:39 localhost kernel: [    9.838989] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
Jun 27 13:47:39 localhost kernel: [    9.841131] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: (null)
Jun 27 13:47:39 localhost kernel: [    9.851946] EXT4-fs (dm-4): mounted filesystem with ordered data mode. Opts: (null)
Jun 27 13:47:39 localhost kernel: [   12.165396] ipmi message handler version 39.2
Jun 27 13:47:39 localhost kernel: [   12.168802] ipmi device interface
Jun 27 13:47:39 localhost kernel: [   12.173556] IPMI System Interface driver.
Jun 27 13:47:39 localhost kernel: [   12.173598] ipmi_si: probing via SMBIOS
Jun 27 13:47:39 localhost kernel: [   12.173600] ipmi_si: Adding SMBIOS-specified kcs state machine
Jun 27 13:47:39 localhost kernel: [   12.173605] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca8, slave address 0x20, irq 0
Jun 27 13:47:39 localhost kernel: [   12.220652] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0002a2, prod_id: 0x0100, dev_id: 0x20)
Jun 27 13:47:39 localhost kernel: [   12.220724] ipmi_si ipmi_si.0: IPMI kcs interface initialized
Jun 27 13:47:39 localhost kernel: [   13.441536] EXT4-fs (dm-1): barriers disabled
Jun 27 13:47:39 localhost kernel: [   13.475753] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: acl,user_xattr,barrier=0
Jun 27 13:47:39 localhost kernel: [   13.883811] NET: Registered protocol family 10
Jun 27 13:47:39 localhost kernel: [   13.884245] lo: Disabled Privacy Extensions
Jun 27 13:47:39 localhost kernel: [   14.166241] bnx2 0000:01:00.0: eth0: using MSIX
Jun 27 13:47:39 localhost kernel: [   14.166523] ADDRCONF(NETDEV_UP): eth0: link is not ready
Jun 27 13:47:39 localhost kernel: [   15.758714] bnx2 0000:01:00.0: eth0: NIC Copper Link is Up, 100 Mbps full duplex
Jun 27 13:47:39 localhost kernel: [   15.759058] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

David

