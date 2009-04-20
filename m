From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13138] New: CPU Stalls When Probing IDE Interfaces
Date: Mon, 20 Apr 2009 01:10:43 GMT
Message-ID: <bug-13138-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:60041 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbZDTBKo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Apr 2009 21:10:44 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n3K1Ahp9030200
	for <linux-ide@vger.kernel.org>; Mon, 20 Apr 2009 01:10:43 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13138

           Summary: CPU Stalls When Probing IDE Interfaces
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.29.1
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: maclover201@me.com
        Regression: No


Created an attachment (id=21047)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=21047)
Dmesg output from kernel 2.6.29.1 with CPU stall

Latest working kernel version: 2.6.29 eventually boots, but the CPU stalls for
35 seconds while booting.

Earliest failing kernel version: 2.6.29, although I've had timeout issues as
early as 2.6.26.

Distribution: Ubuntu 8.10

Hardware Environment

CPU
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 7
cpu MHz         : 2393.989
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe up pebs bts cid
bogomips        : 4787.97
clflush size    : 64

Memory
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf7ff : Video ROM
000d0000-000d27ff : Adapter ROM
000f0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-003f0489 : Kernel code
  003f048a-0054378f : Kernel data
  005bd000-0066f473 : Kernel bss
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
e3000000-e3000fff : 0000:00:13.0
  e3000000-e3000fff : firewire_ohci
e3800000-e38000ff : 0000:00:12.0
  e3800000-e38000ff : 8139too
e4000000-e400ffff : 0000:00:0f.0
e4800000-e4807fff : 0000:00:0e.0
  e4800000-e4807fff : 0000:00:0e.0
e5000000-e5000fff : 0000:00:03.3
  e5000000-e5000fff : ehci_hcd
e5800000-e5800fff : 0000:00:03.2
  e5800000-e5800fff : ohci_hcd
e6000000-e6000fff : 0000:00:03.1
  e6000000-e6000fff : ohci_hcd
e6800000-e6800fff : 0000:00:03.0
  e6800000-e6800fff : ohci_hcd
e7000000-e7ffffff : PCI Bus 0000:01
  e7000000-e7ffffff : 0000:01:00.0
    e7000000-e7ffffff : nvidia
e8000000-ebffffff : 0000:00:00.0
ef700000-febfffff : PCI Bus 0000:01
  ef7e0000-ef7fffff : 0000:01:00.0
  ef800000-ef87ffff : 0000:01:00.0
  f0000000-f7ffffff : 0000:01:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ffee0000-ffefffff : pnp 00:02
ffff0000-ffffffff : reserved

Software Environment
Linux server 2.6.29.1 #3 SMP Tue Apr 7 22:01:24 MDT 2009 i686 GNU/Linux

Gnu C                  4.3.2
Gnu make               3.81
binutils               2.18.93.20081009
util-linux             2.14
mount                  support
module-init-tools      3.3-pre11
e2fsprogs              1.41.3
reiserfsprogs          3.6.19
pcmciautils            014
PPP                    2.4.4
Linux C Library        2.8.90
Dynamic linker (ldd)   2.8.90
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.14.1
Sh-utils               6.10
udev                   124
wireless-tools         29
Modules Loaded         nls_iso8859_1 vfat fat rfcomm bnep sco l2cap bluetooth
ppdev bridge stp tun speedstep_lib cpufreq_powersave cpufreq_stats
cpufreq_conservative cpufreq_ondemand freq_table cpufreq_userspace video output
container sbs sbshc pci_slot battery ipv6 iptable_filter ip_tables x_tables ac
sbp2 lp sg sd_mod snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm_oss
snd_mixer_oss psmouse snd_pcm serio_raw pcspkr rt61pci rt2x00pci rt2x00lib
rfkill led_class eeprom_93cx6 snd_seq_dummy nvidia parport_pc parport
snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer
snd_seq_device snd soundcore button i2c_sis96x snd_page_alloc shpchp sis_agp
pci_hotplug agpgart evdev ext3 jbd mbcache usb_storage libusual ide_cd_mod
cdrom ide_gd_mod pata_sis pata_acpi 8139cp ata_generic ohci1394 ehci_hcd
ohci_hcd ieee1394 8139too mii usbcore sis5513 ide_pci_generic ide_core thermal
processor fan fuse

Other pertinent information...
Hard Drive: Seagate ST380023A 80GB (scsi0)
IDE Interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80
[Master])
 --- Subsystem: Sony Corporation Device 8133

Problem Description: There is a weird CPU stall when probing IDE interfaces on
boot. The stall lasts for about 35 seconds. The call trace sometimes is printed
on the screen. In this case it was.

Steps to reproduce: Install 2.6.29 on a computer with the same
hardware as me and reboot.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
