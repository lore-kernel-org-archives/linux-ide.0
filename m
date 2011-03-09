From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 30802] New: exception & eSATA hard link resets
Date: Wed, 9 Mar 2011 13:53:29 GMT
Message-ID: <bug-30802-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter2.kernel.org ([140.211.167.42]:53393 "EHLO
	demeter2.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab1CINxa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Mar 2011 08:53:30 -0500
Received: from demeter2.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter2.kernel.org (8.14.4/8.14.3) with ESMTP id p29DrT4G027864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 9 Mar 2011 13:53:29 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=30802

           Summary: exception & eSATA hard link resets
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.37.2
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Serial ATA
        AssignedTo: jgarzik@pobox.com
        ReportedBy: zrubish@gmail.com
                CC: linux-ide@vger.kernel.org
        Regression: No


Created an attachment (id=50442)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=50442)
kernel log, dmesg and lspci output

Hi,
using eSATA on Thinkpad W510 does not work for me (tested with kernel 2.6.35
on). At the beginning I've suspected VirtualBox problems (usage of
virtualization features of i7), but today hard reset has occurred even before
Virtualbox has been started.

The reset happens very often ("exception Emask 0x10 SAct 0x0 SErr 0x4050000
action 0xe frozen" is caught) - almost for sure in an hour and repeats till
connection drops.
Details from kernel.log are attached (disk has been switched off in this case -
after few resets).

Files system used on all media is XFS.

[4.] Kernel information
[4.1.] Kernel version (from /proc/version):
Linux version 2.6.37.2vbox (root@think) (gcc version 4.4.5 (Ubuntu/Linaro
4.4.4-14ubuntu5) ) #1 SMP Mon Mar 7 21:14:19 CET 2011

[4.2.] Kernel .config file is attached. It was made with "make oldconfig" on
Ubuntu Maverick.

[5.] Most recent kernel version which did not have the bug:
:(

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
no Ooops... :(. Attached is the kernel log, and dmesg output

[7.] A small shell script or example program which triggers the
     problem (if possible):
the easiest to reproduce is by using VirtualBox (haven't managed to try copying
large files - I've planned to do this today, however connection failed before
that).

[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)
---
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux think 2.6.37.2vbox #1 SMP Mon Mar 7 21:14:19 CET 2011 x86_64 GNU/Linux

Gnu C                  4.4.5
Gnu make               3.81
binutils               2.20.51
util-linux             2.17.2
mount                  support
module-init-tools      3.12
e2fsprogs              1.41.12
reiserfsprogs          3.6.21
xfsprogs               3.1.2
pcmciautils            014
Linux C Library        2.12.1
Dynamic linker (ldd)   2.12.1
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15
Sh-utils               8.5
wireless-tools         30
Modules Loaded         btrfs zlib_deflate crc32c libcrc32c ufs qnx4 hfsplus hfs
minix ntfs msdos jfs reiserfs usb_storage sha1_generic ppp_mppe ppp_async
crc_ccitt nls_utf8 udf crc_itu_t nls_iso8859_1 nls_cp437 vfat fat binfmt_misc
vboxnetadp vboxnetflt vboxdrv parport_pc ppdev nfsd nfs lockd fscache nfs_acl
auth_rpcgss sunrpc snd_hda_codec_hdmi arc4 nvidia iwlagn iwlcore
snd_hda_codec_conexant mac80211 snd_hda_intel xhci_hcd thinkpad_acpi
snd_hda_codec tpm_tis tpm tpm_bios i7core_edac psmouse video cfg80211 edac_core
lp nvram snd_hwdep snd_seq_midi snd_pcm snd_rawmidi snd_seq_midi_event shpchp
serio_raw joydev snd_seq snd_timer snd_seq_device uvcvideo videodev v4l1_compat
v4l2_compat_ioctl32 output snd parport soundcore snd_page_alloc xfs exportfs
usbhid hid mmc_block sdhci_pci sdhci ahci e1000e libahci
---

[8.2.] Processor information (from /proc/cpuinfo):
---
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU       Q 820  @ 1.73GHz
stepping    : 5
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm
sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority ept vpid
bogomips    : 3458.09
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU       Q 820  @ 1.73GHz
stepping    : 5
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm
sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority ept vpid
bogomips    : 3457.94
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU       Q 820  @ 1.73GHz
stepping    : 5
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm
sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority ept vpid
bogomips    : 3457.94
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU       Q 820  @ 1.73GHz
stepping    : 5
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 1
cpu cores    : 4
apicid        : 3
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm
sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority ept vpid
bogomips    : 3457.94
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 4
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU       Q 820  @ 1.73GHz
stepping    : 5
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 4
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm
sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority ept vpid
bogomips    : 3457.94
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 5
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU       Q 820  @ 1.73GHz
stepping    : 5
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 2
cpu cores    : 4
apicid        : 5
initial apicid    : 5
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm
sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority ept vpid
bogomips    : 3457.94
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 6
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU       Q 820  @ 1.73GHz
stepping    : 5
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 6
initial apicid    : 6
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm
sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority ept vpid
bogomips    : 3457.94
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 7
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU       Q 820  @ 1.73GHz
stepping    : 5
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 7
initial apicid    : 7
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm
sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority ept vpid
bogomips    : 3457.94
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:
---

[8.3.] Module information (from /proc/modules):
---
btrfs 523995 0 - Live 0xffffffffa1167000
zlib_deflate 21723 1 btrfs, Live 0xffffffffa0f3c000
crc32c 3007 1 - Live 0xffffffffa0f36000
libcrc32c 1236 1 btrfs, Live 0xffffffffa02e5000
ufs 73550 0 - Live 0xffffffffa1153000
qnx4 7456 0 - Live 0xffffffffa0e67000
hfsplus 78184 0 - Live 0xffffffffa0ead000
hfs 47415 0 - Live 0xffffffffa0e4f000
minix 29133 0 - Live 0xffffffffa0e41000
ntfs 96715 0 - Live 0xffffffffa0e27000
msdos 8023 0 - Live 0xffffffffa0d8d000
jfs 181397 0 - Live 0xffffffffa0df0000
reiserfs 240655 0 - Live 0xffffffffa0da8000
usb_storage 50232 1 - Live 0xffffffffa0d99000
sha1_generic 2255 4 - Live 0xffffffffa0d8a000
ppp_mppe 6458 2 - Live 0xffffffffa02ea000
ppp_async 7912 1 - Live 0xffffffffa02e1000
crc_ccitt 1699 1 ppp_async, Live 0xffffffffa020e000
nls_utf8 1453 1 - Live 0xffffffffa0d90000
udf 86294 1 - Live 0xffffffffa0d72000
crc_itu_t 1739 1 udf, Live 0xffffffffa02e7000
nls_iso8859_1 4657 2 - Live 0xffffffffa02a7000
nls_cp437 6375 2 - Live 0xffffffffa0242000
vfat 10797 2 - Live 0xffffffffa01ed000
fat 55449 2 msdos,vfat, Live 0xffffffffa0d62000
binfmt_misc 7749 1 - Live 0xffffffffa0194000
vboxnetadp 5900 0 - Live 0xffffffffa01ca000
vboxnetflt 19935 0 - Live 0xffffffffa02c3000
vboxdrv 1817864 2 vboxnetadp,vboxnetflt, Live 0xffffffffa0f95000
parport_pc 30200 1 - Live 0xffffffffa02b9000
ppdev 6430 0 - Live 0xffffffffa017d000
nfsd 306110 13 - Live 0xffffffffa0f48000
nfs 319250 0 - Live 0xffffffffa0ee6000
lockd 74886 2 nfsd,nfs, Live 0xffffffffa0ed1000
fscache 50214 1 nfs, Live 0xffffffffa0ec2000
nfs_acl 2701 2 nfsd,nfs, Live 0xffffffffa01c3000
auth_rpcgss 44458 2 nfsd,nfs, Live 0xffffffffa029a000
sunrpc 227888 14 nfsd,nfs,lockd,nfs_acl,auth_rpcgss, Live 0xffffffffa0e73000
snd_hda_codec_hdmi 24503 4 - Live 0xffffffffa025e000
arc4 1497 4 - Live 0xffffffffa017a000
nvidia 10221078 42 - Live 0xffffffffa03a0000 (P)
iwlagn 241949 0 - Live 0xffffffffa0362000
iwlcore 107920 1 iwlagn, Live 0xffffffffa0345000
snd_hda_codec_conexant 47341 1 - Live 0xffffffffa02ab000
mac80211 268281 2 iwlagn,iwlcore, Live 0xffffffffa0301000
snd_hda_intel 25257 2 - Live 0xffffffffa0235000
xhci_hcd 65773 0 - Live 0xffffffffa02ee000
thinkpad_acpi 75854 0 - Live 0xffffffffa02cc000
snd_hda_codec 95642 3 snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_intel,
Live 0xffffffffa021b000
tpm_tis 9478 0 - Live 0xffffffffa0204000
tpm 16209 1 tpm_tis, Live 0xffffffffa01fe000
tpm_bios 6451 1 tpm, Live 0xffffffffa01a9000
i7core_edac 17692 0 - Live 0xffffffffa01f7000
psmouse 59542 0 - Live 0xffffffffa01dc000
video 13174 0 - Live 0xffffffffa01f1000
cfg80211 162281 3 iwlagn,iwlcore,mac80211, Live 0xffffffffa0270000
edac_core 46183 3 i7core_edac, Live 0xffffffffa01ce000
lp 10021 0 - Live 0xffffffffa01be000
nvram 7693 1 thinkpad_acpi, Live 0xffffffffa019d000
snd_hwdep 6546 1 snd_hda_codec, Live 0xffffffffa0161000
snd_seq_midi 5964 0 - Live 0xffffffffa004b000
snd_pcm 88491 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0xffffffffa0246000
snd_rawmidi 22012 1 snd_seq_midi, Live 0xffffffffa0268000
snd_seq_midi_event 7323 1 snd_seq_midi, Live 0xffffffffa023e000
shpchp 28850 0 - Live 0xffffffffa0211000
serio_raw 5006 0 - Live 0xffffffffa020a000
joydev 11287 0 - Live 0xffffffffa01c5000
snd_seq 57011 2 snd_seq_midi,snd_seq_midi_event, Live 0xffffffffa01ae000
snd_timer 23276 2 snd_pcm,snd_seq, Live 0xffffffffa01a1000
snd_seq_device 6912 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0xffffffffa0199000
uvcvideo 64071 0 - Live 0xffffffffa0182000
videodev 78073 1 uvcvideo, Live 0xffffffffa0164000
v4l1_compat 15679 2 uvcvideo,videodev, Live 0xffffffffa005b000
v4l2_compat_ioctl32 11518 1 videodev, Live 0xffffffffa0044000
output 2495 1 video, Live 0xffffffffa0083000
snd 63608 15
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_intel,thinkpad_acpi,snd_hda_codec,snd_hwdep,snd_rawmidi,snd_pcm,snd_seq,snd_timer,snd_seq_device,
Live 0xffffffffa014f000
parport 37263 3 parport_pc,ppdev,lp, Live 0xffffffffa0143000
soundcore 1240 1 snd, Live 0xffffffffa0048000
snd_page_alloc 8748 2 snd_hda_intel,snd_pcm, Live 0xffffffffa002b000
xfs 765376 2 - Live 0xffffffffa0086000
exportfs 4162 2 nfsd,xfs, Live 0xffffffffa004f000
usbhid 40063 0 - Live 0xffffffffa0077000
hid 84420 1 usbhid, Live 0xffffffffa0060000
mmc_block 11127 2 - Live 0xffffffffa0026000
sdhci_pci 8166 0 - Live 0xffffffffa0038000
sdhci 18986 1 sdhci_pci, Live 0xffffffffa003d000
ahci 21262 3 - Live 0xffffffffa0053000
e1000e 146076 0 - Live 0xffffffffa0000000
libahci 22574 1 ahci, Live 0xffffffffa0030000
---

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
Note: I've switched external disk on again before collected this information.
ioports:
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0378-037a : parport0
  03c0-03df : vga+
  0800-080f : pnp 00:03
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-107f : pnp 00:03
    1000-1003 : ACPI PM1a_EVT_BLK
    1004-1005 : ACPI PM1a_CNT_BLK
    1008-100b : ACPI PM_TMR
    1010-1015 : ACPI CPU throttle
    1020-102f : ACPI GPE0_BLK
    1050-1050 : ACPI PM2_CNT_BLK
  1180-11ff : pnp 00:03
  15e0-15ef : pnp 00:03
  1600-1641 : pnp 00:03
  164e-164f : pnp 00:03
  1808-180b : 0000:00:1f.2
    1808-180b : ahci
  180c-180f : 0000:00:1f.2
    180c-180f : ahci
  1810-1817 : 0000:00:1f.2
    1810-1817 : ahci
  1818-181f : 0000:00:1f.2
    1818-181f : ahci
  1820-183f : 0000:00:19.0
  1840-185f : 0000:00:1f.2
    1840-185f : ahci
  1860-187f : 0000:00:1f.3
  2000-2fff : PCI Bus 0000:01
    2000-207f : 0000:01:00.0
  3000-3fff : PCI Bus 0000:05
---
iomem:
---
00000000-0000ffff : reserved
00010000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c3fff : pnp 00:00
000c4000-000c7fff : pnp 00:00
000c8000-000cbfff : pnp 00:00
000cc000-000cffff : pnp 00:00
000d2000-000d3fff : reserved
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000fffff : reserved
00100000-bba7bfff : System RAM
  01000000-015a9d35 : Kernel code
  015a9d36-01aa4aef : Kernel data
  01b94000-01cc007f : Kernel bss
  2f000000-36ffffff : Crash kernel
bba7c000-bba81fff : reserved
bba82000-bbb48fff : System RAM
bbb49000-bbb5bfff : reserved
bbb5c000-bbbdcfff : ACPI Non-volatile Storage
bbbdd000-bbc0efff : reserved
bbc0f000-bbc5cfff : System RAM
bbc5d000-bbe67fff : reserved
bbe68000-bbee7fff : ACPI Non-volatile Storage
bbee8000-bbf0efff : reserved
bbf0f000-bbf17fff : System RAM
bbf18000-bbf1efff : reserved
bbf1f000-bbf6dfff : System RAM
bbf6e000-bbf79fff : ACPI Non-volatile Storage
bbf7a000-bbf7cfff : ACPI Tables
bbf7d000-bbf80fff : ACPI Non-volatile Storage
bbf81000-bbf81fff : ACPI Tables
bbf82000-bbf8afff : ACPI Non-volatile Storage
bbf8b000-bbf8bfff : ACPI Tables
bbf8c000-bbf9efff : ACPI Non-volatile Storage
bbf9f000-bbffefff : ACPI Tables
bbfff000-bbffffff : System RAM
bc000000-bdffffff : reserved
bf800000-bfffffff : reserved
c0000000-febfffff : PCI Bus 0000:00
  c0000000-c0000fff : pnp 00:03
  cc000000-cdefffff : PCI Bus 0000:01
    cc000000-ccffffff : 0000:01:00.0
      cc000000-ccffffff : nvidia
    cd000000-cd07ffff : 0000:01:00.0
    cdefc000-cdefffff : 0000:01:00.1
      cdefc000-cdefffff : ICH HD audio
  ce000000-dfffffff : PCI Bus 0000:01
    ce000000-cfffffff : 0000:01:00.0
    d0000000-dfffffff : 0000:01:00.0
  e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
    e0000000-efffffff : reserved
      e0000000-efffffff : pnp 00:03
  f0000000-f1ffffff : PCI Bus 0000:05
  f2000000-f20fffff : PCI Bus 0000:03
    f2000000-f2001fff : 0000:03:00.0
      f2000000-f2001fff : iwlagn
  f2100000-f21fffff : PCI Bus 0000:0d
    f2100000-f21000ff : 0000:0d:00.0
      f2100000-f21000ff : mmc0
    f2100400-f21004ff : 0000:0d:00.1
  f2200000-f22fffff : PCI Bus 0000:0f
    f2200000-f2201fff : 0000:0f:00.0
      f2200000-f2201fff : xhci_hcd
  f2300000-f23fffff : PCI Bus 0000:17
    f2300000-f23000ff : 0000:17:00.0
      f2300000-f23000ff : mmc1
  f2600000-f261ffff : 0000:00:19.0
    f2600000-f261ffff : e1000e
  f2620000-f2623fff : 0000:00:1b.0
    f2620000-f2623fff : ICH HD audio
  f2625000-f2625fff : 0000:00:19.0
    f2625000-f2625fff : e1000e
  f2626000-f2626fff : pnp 00:03
  f2627000-f26277ff : 0000:00:1f.2
    f2627000-f26277ff : ahci
  f2627800-f262780f : 0000:00:16.0
  f2628000-f26283ff : 0000:00:1a.0
    f2628000-f26283ff : ehci_hcd
  f2628400-f26287ff : 0000:00:1d.0
    f2628400-f26287ff : ehci_hcd
  f2628800-f26288ff : 0000:00:1f.3
  f2700000-f27fffff : PCI Bus 0000:05
  feaff000-feafffff : reserved
fec00000-fec0ffff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : reserved
fed10000-fed13fff : pnp 00:03
fed18000-fed18fff : pnp 00:03
fed19000-fed19fff : pnp 00:03
fed1c000-fed8ffff : reserved
  fed1c000-fed1ffff : pnp 00:03
  fed45000-fed4bfff : pnp 00:03
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
100000000-43fffffff : System RAM
---

[8.5.] PCI information ('lspci -vvv' as root) - attached.

[8.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST9500420AS      Rev: 0003
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Optiarc  Model: DVD RW AD-7700H  Rev: 1.FA
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi8 Channel: 00 Id: 00 Lun: 00
  Vendor: HTC      Model: Android Phone    Rev: 0100
  Type:   Direct-Access                    ANSI  SCSI revision: 02
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD1500HLFS-0 Rev: 04.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
I'm willing to assist / reproduce, but I lack the knowledge to decide by
myself.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug.
