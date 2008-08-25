From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11426] New: reproducable panic when reading cdrom (atapi dma)
Date: Mon, 25 Aug 2008 12:24:47 -0700 (PDT)
Message-ID: <bug-11426-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43796 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754569AbYHYTYu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 15:24:50 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7PJOlNA009576
	for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 12:24:48 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11426

           Summary: reproducable panic when reading cdrom (atapi dma)
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.26.3
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: mathis.ahrens@gmx.de


Latest working kernel version: 2.6.22
Earliest failing kernel version: 2.6.24
Distribution: Ubuntu 8.04 with vanilla kernel
Hardware Environment: Fujitsu/Siemens Amilo Laptop
Problem Description: 
When reading a few hundred MB from cdrom using DMA, kernel panics eventually.

There are two setups WITHOUT this bug:
 - older kernels (where the cdrom gets mounted as hdc)
 - current kernels with libata.dma=1 (PIO4 mode ATAPI)

Steps to reproduce:
$ cp /media/cdromName/1-gb-file /home/onDisk 

After a few hundred MB, hard lockup: no LEDs, no SysRq, no logs.

netconsole gave me the following output:

[  525.388025] divide error: 0000 [#1] SMP
[  525.388025] Modules linked in: netconsole configfs isofs binfmt_misc radeon
drm rfcomm l2cap bluetooth ppdev powernow_k7 cpufreq_userspace cpufreq_stats
cpufreq_powersave cpufreq_ondemand freq_table cpufreq_conservative video output
sbs sbshc container iptable_filter ip_tables x_tables sbp2 lp ipv6 joydev tulip
pcmcia serio_raw psmouse parport_pc parport pcspkr pwc videodev v4l1_compat
i2c_viapro i2c_core via_ircc battery irda ac crc_ccitt yenta_socket button
via_agp agpgart rsrc_nonstatic pcmcia_core shpchp pci_hotplug evdev ext3 jbd
mbcache sg sr_mod cdrom sd_mod pata_via pata_acpi ata_generic libata via_rhine
mii ehci_hcd uhci_hcd scsi_mod dock ohci1394 usbcore ieee1394 thermal processor
fan thermal_sys fuse
[  525.388025]
[  525.388025] Pid: 6084, comm: trackerd Not tainted (2.6.26.3 #2)
[  525.388025] EIP: 0060:[<c0103d3c>] EFLAGS: 00200202 CPU: 0
[  525.388025] EIP is at sysenter_past_esp+0x39/0xb1
[  525.388025] EAX: 0000008c EBX: 0000001e ECX: 00000000 EDX: 000000d8
[  525.388025] ESI: b7959bb0 EDI: 00000000 EBP: b7959b90 ESP: d9391fb8
[  525.388025]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[  525.388025] Process trackerd (pid: 6084, ti=d9390000 task=d9fba3f0
task.ti=d9390000)
[  525.388025] Stack: 0000001e 00000000 000f0000 b7959bb0 00000000 b7959b90
0000008c 0000007b
[  525.388025]        0000007b 00000000 0000008c b7f1b424 00000073 00200292
b7959b90 0000007b
[  525.388025]        00008067 00007067
[  525.388025] Call Trace:
[  525.388025]  =======================
[  525.388025] Code: b4 24 34 e0 ff ff 50 fc 0f a0 06 1e 50 55 57 56 52 51 53
ba 7b 00 00 00 8e da 8e c2 ba d8 00 00 00 8e e2 fb 8d 04 05 00 00 00 00 <90> 8d
80 00 00 00 00 81 fd fd ff ff bf 0f 83 fa 01 00 00 8b 6d
[  525.388025] EIP: [<c0103d3c>] sysenter_past_esp+0x39/0xb1 SS:ESP
0068:d9391fb8
[  525.388025] ---[ end trace 5028e900103372a1 ]---
[  525.399790] divide error: 0000 [#2] SMP
[  525.399790] Modules linked in: netconsole configfs isofs binfmt_misc radeon
drm rfcomm l2cap bluetooth ppdev powernow_k7 cpufreq_userspace cpufreq_stats
cpufreq_powersave cpufreq_ondemand freq_table cpufreq_conservative video output
sbs sbshc container iptable_filter ip_tables x_tables sbp2 lp ipv6 joydev tulip
pcmcia serio_raw psmouse parport_pc parport pcspkr pwc videodev v4l1_compat
i2c_viapro i2c_core via_ircc battery irda ac crc_ccitt yenta_socket button
via_agp agpgart rsrc_nonstatic pcmcia_core shpchp pci_hotplug evdev ext3 jbd
mbcache sg sr_mod cdrom sd_mod pata_via pata_acpi ata_generic libata via_rhine
mii ehci_hcd uhci_hcd scsi_mod dock ohci1394 usbcore ieee1394 thermal processor
fan thermal_sys fuse
[  525.399790] 
[  525.399790] Pid: 0, comm: swapper Tainted: G      D   (2.6.26.3 #2)
[  525.399790] EIP: 0060:[<e081d2ae>] EFLAGS: 00000292 CPU: 0
[  525.399790] EIP is at acpi_idle_enter_simple+0x16f/0x1dd [processor]
[  525.399790] EAX: c0479170 EBX: d5650000 ECX: 00006767 EDX: 00f8f000
[  525.399790] ESI: d5650450 EDI: 001c3383 EBP: 001b8f17 ESP: c041ffac
[  525.399790]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[  525.399790] Process swapper (pid: 0, ti=c041e000 task=c03f0340
task.ti=c041e000)
[  525.399790] Stack: 0000a46c 00000000 d56500cc d56500dc d565001c 00922007
c0288c9a c0288c10
[  525.399790]        00000000 c047c480 c0102753 00000000 00099800 c040f000
c04239ef 00000035
[  525.399790]        c0423130 00000000 c044e900 00000000 00000000
[  525.399790] Call Trace:
[  525.399790]  [<c0288c9a>] cpuidle_idle_call+0x8a/0xd0
[  525.399790]  [<c0288c10>] cpuidle_idle_call+0x0/0xd0
[  525.399790]  [<c0102753>] cpu_idle+0x63/0xe0
[  525.399790]  =======================
[  525.399790] Code: 8d 04 07 99 89 04 24 b8 17 01 00 00 89 54 24 04 f7 24 24
69 4c 24 04 17 01 00 00 8d 14 11 e8 7a 15 92 df fb 8d 04 05 00 00 00 00 <90> 90
89 e0 31 c9 25 00 e0 ff ff 89 f2 83 48 0c 02 89 d8 ff 46
[  525.399790] EIP: [<e081d2ae>] acpi_idle_enter_simple+0x16f/0x1dd [processor]
SS:ESP 0068:c041ffac
[  525.399790] ---[ end trace 5028e900103372a1 ]---
[  525.399790] Kernel panic - not syncing: Attempted to kill the idle task!


$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host
Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller
(rev 80)
00:0b.0 CardBus bridge: O2 Micro, Inc. OZ601/6912/711E0 CardBus/SmartCardBus
Controller (rev 20)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237
AC97 Audio Controller (rev 50)
00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller
(rev 80)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 [Mobility
FireGL 9000] (rev 01)
02:00.0 Ethernet controller: ADMtek 21x4x DEC-Tulip compatible 10/100 Ethernet
(rev 11)


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
