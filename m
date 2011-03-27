From: Allen Weiner <alweiner7@hotmail.com>
Subject: PROBLEM: HDD (PATA) 40-wire cable wrong detection
Date: Sun, 27 Mar 2011 21:23:16 +0000
Message-ID: <bay146-w22DC3B44D3DF10B3DECB49F7BB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay0-omc2-s11.bay0.hotmail.com ([65.54.190.86]:19715 "EHLO
	bay0-omc2-s11.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237Ab1C0VXR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Mar 2011 17:23:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


My 133 MB/s PATA HDD is being configured for 33 MB/s due to incorrect d=
etection of a 40-wire cable.=20

=46rom dmesg:

=A01.837668] ata5.00: ATA-7: Maxtor 6Y080L0, YAR41BW0, max UDMA/133
[=A0=A0=A0 1.837907] ata5.00: 156250000 sectors, multi 0: LBA=20
[=A0=A0=A0 1.838158] ata5.00: limited to UDMA/33 due to 40-wire cable
[=A0=A0=A0 1.844689] ata5.00: configured for UDMA/33

My IDE cable is an 80-wire cable (1:blue and black end-connectors and g=
ray center connector, 2: the cable has many more ripples than a 40-wire=
 cable I have.). The IDE cable is connected with the correct orientatio=
n. The blue end-connector is connected to the motherboard. The black en=
d-connector is connected to the HDD. Nothing is connected to the center=
 connector. The HDD is jumpered for cable-select. (Single-mode is not a=
vailable.)

On bootup, the BIOS displays an informational screen showing that the H=
DD is recognized as UDMA mode 6 (which is UDMA/133). At first, I connec=
ted the cable with the backwards orientation and the BIOS informational=
 screen reported the HDD as UDMA mode 2.

The motherboard is a BIOSTAR TA890FXE. The motherboard IDE controller i=
s a VIA VT6330. I also have installed a Promise Ultra133 TX2 PCI IDE co=
ntroller card. A CD-RW drive is attached to IDE connector #1 on that ca=
rd.

Questions:

Q1: Is this problem most likely a faulty cable (I don't currently have =
a second cable to try a substitution), a BIOS bug, or a Linux bug?=20

Q2: What additional steps can I take to debug this problem?

=46ollowing is a bug report, following the format recommended in the LK=
ML FAQ. The details in this report are for Fedora 14. The problem also =
occurs on Ubuntu 10.10.

<KERNEL VERSION:>

Linux version 2.6.35.11-83.fc14.i686.PAE (mockbuild@x86-12.phx2.fedorap=
roject.org) (gcc version 4.5.1 20100924 (Red Hat 4.5.1-4) (GCC) ) #1 SM=
P Mon Feb 7 06:57:55 UTC 2011

<SOFTWARE (from ver_linux script):>

Linux localhost.localdomain 2.6.35.11-83.fc14.i686.PAE #1 SMP Mon Feb 7=
 06:57:55 UTC 2011 i686 i686 i386 GNU/Linux
=A0
Gnu C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4.5.1
Gnu make=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.82
binutils=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.20.51.0.7
util-linux=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.18
mount=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 support
module-init-tools=A0=A0=A0=A0=A0 3.11.1
e2fsprogs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.41.12
xfsprogs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.1.2
pcmciautils=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 017
quota-tools=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.17.
PPP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.4.5
Linux C Library=A0=A0=A0=A0=A0=A0=A0 2.13
Dynamic linker (ldd)=A0=A0 2.13
Procps=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.2.8
Net-tools=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.60
Kbd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.15
Sh-utils=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8.5
wireless-tools=A0=A0=A0=A0=A0=A0=A0=A0 29
Modules Loaded=A0=A0=A0=A0=A0=A0=A0=A0 tcp_lp fuse hwmon_vid sunrpc cpu=
freq_ondemand powernow_k8 mperf ipt_LOG xt_limit iptable_mangle ip6t_RE=
JECT nf_conntrack_ipv6 ip6table_filter ip6_tables ipv6 uinput nvidia sn=
d_hda_codec_nvhdmi snd_hda_codec_realtek snd_hda_intel snd_hda_codec sn=
d_hwdep snd_seq i2c_piix4 snd_seq_device snd_pcm i2c_core r8169 mii k10=
temp snd_timer snd soundcore snd_page_alloc microcode pata_acpi firewir=
e_ohci ata_generic pata_pdc2027x pata_atiixp firewire_core crc_itu_t pa=
ta_via

<PROCESSOR INFO: (from /proc/cpuinfo)>

processor=A0=A0=A0=A0=A0=A0 : 0
vendor_id=A0=A0=A0=A0=A0=A0 : AuthenticAMD
cpu family=A0=A0=A0=A0=A0 : 16
model=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 4
model name=A0=A0=A0=A0=A0 : AMD Phenom(tm) II X2 555 Processor
stepping=A0=A0=A0=A0=A0=A0=A0 : 3
cpu MHz=A0=A0=A0=A0=A0=A0=A0=A0 : 800.000
cache size=A0=A0=A0=A0=A0 : 512 KB
physical id=A0=A0=A0=A0 : 0
siblings=A0=A0=A0=A0=A0=A0=A0 : 2
core id=A0=A0=A0=A0=A0=A0=A0=A0 : 0
cpu cores=A0=A0=A0=A0=A0=A0 : 2
apicid=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 0
initial apicid=A0 : 0
fdiv_bug=A0=A0=A0=A0=A0=A0=A0 : no
hlt_bug=A0=A0=A0=A0=A0=A0=A0=A0 : no
f00f_bug=A0=A0=A0=A0=A0=A0=A0 : no
coma_bug=A0=A0=A0=A0=A0=A0=A0 : no
fpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : yes
fpu_exception=A0=A0 : yes
cpuid level=A0=A0=A0=A0 : 5
wp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : yes
flags=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : fpu vme de pse tsc msr pae mce cx=
8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht sys=
call nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc n=
onstop_tsc extd_apicid pni monitor cx16 popcnt lahf_lm cmp_legacy svm e=
xtapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit w=
dt npt lbrv svm_lock nrip_save
bogomips=A0=A0=A0=A0=A0=A0=A0 : 6400.43
clflush size=A0=A0=A0 : 64
cache_alignment : 64
address sizes=A0=A0 : 48 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate

processor=A0=A0=A0=A0=A0=A0 : 1
vendor_id=A0=A0=A0=A0=A0=A0 : AuthenticAMD
cpu family=A0=A0=A0=A0=A0 : 16
model=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 4
model name=A0=A0=A0=A0=A0 : AMD Phenom(tm) II X2 555 Processor
stepping=A0=A0=A0=A0=A0=A0=A0 : 3
cpu MHz=A0=A0=A0=A0=A0=A0=A0=A0 : 800.000
cache size=A0=A0=A0=A0=A0 : 512 KB
physical id=A0=A0=A0=A0 : 0
siblings=A0=A0=A0=A0=A0=A0=A0 : 2
core id=A0=A0=A0=A0=A0=A0=A0=A0 : 1
cpu cores=A0=A0=A0=A0=A0=A0 : 2
apicid=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 1
initial apicid=A0 : 1
fdiv_bug=A0=A0=A0=A0=A0=A0=A0 : no
hlt_bug=A0=A0=A0=A0=A0=A0=A0=A0 : no
f00f_bug=A0=A0=A0=A0=A0=A0=A0 : no
coma_bug=A0=A0=A0=A0=A0=A0=A0 : no
fpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : yes
fpu_exception=A0=A0 : yes
cpuid level=A0=A0=A0=A0 : 5
wp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : yes
flags=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : fpu vme de pse tsc msr pae mce cx=
8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht sys=
call nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc n=
onstop_tsc extd_apicid pni monitor cx16 popcnt lahf_lm cmp_legacy svm e=
xtapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit w=
dt npt lbrv svm_lock nrip_save
bogomips=A0=A0=A0=A0=A0=A0=A0 : 6400.42
clflush size=A0=A0=A0 : 64
cache_alignment : 64
address sizes=A0=A0 : 48 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate

<MODULE INFORMATION: (from /proc/modules)>

tcp_lp 1779 0 - Live 0xf7aa7000
fuse 51648 3 - Live 0xf7b41000
hwmon_vid 1751 0 - Live 0xfb6b1000
sunrpc 165546 1 - Live 0xfb674000
cpufreq_ondemand 7262 2 - Live 0xfb638000
powernow_k8 14270 0 - Live 0xfb629000
mperf 1141 1 powernow_k8, Live 0xfb61b000
ipt_LOG 4243 8 - Live 0xfb60b000
xt_limit 1254 8 - Live 0xfb601000
iptable_mangle 1235 0 - Live 0xfb5ce000
ip6t_REJECT 3470 2 - Live 0xfb5bf000
nf_conntrack_ipv6 14441 2 - Live 0xfb5b1000
ip6table_filter 1207 1 - Live 0xfb5a0000
ip6_tables 9929 1 ip6table_filter, Live 0xfb594000
ipv6 229581 30 ip6t_REJECT,nf_conntrack_ipv6, Live 0xfb542000
uinput 5228 0 - Live 0xfb4b0000
nvidia 9371270 28 - Live 0xf9a06000 (P)
snd_hda_codec_nvhdmi 11784 4 - Live 0xf9035000
snd_hda_codec_realtek 210808 1 - Live 0xf83df000
snd_hda_intel 20251 2 - Live 0xf8382000
snd_hda_codec 71701 3 snd_hda_codec_nvhdmi,snd_hda_codec_realtek,snd_hd=
a_intel, Live 0xf8344000
snd_hwdep 4795 1 snd_hda_codec, Live 0xf82ed000
snd_seq 43435 0 - Live 0xf82c2000
i2c_piix4 10574 0 - Live 0xf8296000
snd_seq_device 5056 1 snd_seq, Live 0xf8281000
snd_pcm 61877 2 snd_hda_intel,snd_hda_codec, Live 0xf825d000
i2c_core 21445 2 nvidia,i2c_piix4, Live 0xf81fb000
r8169 32005 0 - Live 0xf81d4000
mii 3578 1 r8169, Live 0xf81c0000
k10temp 2503 0 - Live 0xf81b6000
snd_timer 15435 2 snd_seq,snd_pcm, Live 0xf8195000
snd 47365 13 snd_hda_codec_nvhdmi,snd_hda_codec_realtek,snd_hda_intel,s=
nd_hda_codec,snd_hwdep,snd_seq,snd_seq_device,snd_pcm,snd_timer, Live 0=
xf8177000
soundcore 5088 1 snd, Live 0xf8135000
snd_page_alloc 6244 2 snd_hda_intel,snd_pcm, Live 0xf811d000
microcode 11067 0 - Live 0xf8103000
pata_acpi 2331 0 - Live 0xf7ae2000
firewire_ohci 18005 0 - Live 0xf7af1000
ata_generic 2399 0 - Live 0xf7aae000
pata_pdc2027x 4872 0 - Live 0xf7a4f000
pata_atiixp 2976 0 - Live 0xf7aa4000
firewire_core 37917 1 firewire_ohci, Live 0xf7a8e000
crc_itu_t 1235 1 firewire_core, Live 0xf7a79000
pata_via 6642 7 - Live 0xf7a30000


<LOADED DRIVER & HARDWARE INFORMATION: (from /proc/ioports and /proc/io=
mem)>

<IOPORTS:>

0000-ffff : PCI Bus #00
=A0 0000-001f : dma1
=A0 0020-0021 : pic1
=A0 0040-0043 : timer0
=A0 0050-0053 : timer1
=A0 0060-0060 : keyboard
=A0 0064-0064 : keyboard
=A0 0070-0071 : rtc0
=A0 0080-008f : dma page reg
=A0 00a0-00a1 : pic2
=A0 00c0-00df : dma2
=A0 00f0-00ff : fpu
=A0 0170-0177 : 0000:00:14.1
=A0=A0=A0 0170-0177 : pata_atiixp
=A0 01f0-01f7 : 0000:00:14.1
=A0=A0=A0 01f0-01f7 : pata_atiixp
=A0 0376-0376 : 0000:00:14.1
=A0=A0=A0 0376-0376 : pata_atiixp
=A0 03c0-03df : vga+
=A0 03f6-03f6 : 0000:00:14.1
=A0=A0=A0 03f6-03f6 : pata_atiixp
=A0 03f8-03ff : serial
=A0 040b-040b : pnp 00:09
=A0 04d0-04d1 : pnp 00:09
=A0 04d6-04d6 : pnp 00:09
=A0 0800-089f : pnp 00:09
=A0=A0=A0 0800-0803 : ACPI PM1a_EVT_BLK
=A0=A0=A0 0804-0805 : ACPI PM1a_CNT_BLK
=A0=A0=A0 0808-080b : ACPI PM_TMR
=A0=A0=A0 0810-0815 : ACPI CPU throttle
=A0=A0=A0 0820-0827 : ACPI GPE0_BLK
=A0 08ff-08ff : ACPI PM2_CNT_BLK
=A0 0900-090f : pnp 00:09
=A0 0910-091f : pnp 00:09
=A0 0a00-0a0f : pnp 00:0b
=A0 0a10-0a1f : pnp 00:0b
=A0 0a20-0a2f : pnp 00:0b
=A0 0a30-0a3f : pnp 00:0b
=A0 0b00-0b1f : pnp 00:09
=A0=A0=A0 0b00-0b07 : piix4_smbus
=A0 0b20-0b3f : pnp 00:09
=A0 0c00-0c01 : pnp 00:09
=A0 0c14-0c14 : pnp 00:09
=A0 0c50-0c51 : pnp 00:09
=A0 0c52-0c52 : pnp 00:09
=A0 0c6c-0c6c : pnp 00:09
=A0 0c6f-0c6f : pnp 00:09
=A0 0cd0-0cd1 : pnp 00:09
=A0 0cd2-0cd3 : pnp 00:09
=A0 0cd4-0cd5 : pnp 00:09
=A0 0cd6-0cd7 : pnp 00:09
=A0 0cd8-0cdf : pnp 00:09
=A0 0cf8-0cff : PCI conf1
=A0 4000-400f : 0000:00:11.0
=A0=A0=A0 4000-400f : ahci
=A0 5000-5003 : 0000:00:11.0
=A0=A0=A0 5000-5003 : ahci
=A0 6000-6007 : 0000:00:11.0
=A0=A0=A0 6000-6007 : ahci
=A0 7000-7003 : 0000:00:11.0
=A0=A0=A0 7000-7003 : ahci
=A0 8000-8007 : 0000:00:11.0
=A0=A0=A0 8000-8007 : ahci
=A0 9000-9fff : PCI Bus 0000:01
=A0=A0=A0 9800-987f : 0000:01:00.0
=A0 a000-bfff : PCI Bus 0000:02
=A0=A0=A0 a400-a40f : 0000:02:05.0
=A0=A0=A0 a800-a803 : 0000:02:05.0
=A0=A0=A0 b000-b007 : 0000:02:05.0
=A0=A0=A0 b400-b403 : 0000:02:05.0
=A0=A0=A0 b800-b807 : 0000:02:05.0
=A0 c000-cfff : PCI Bus 0000:03
=A0=A0=A0 c800-c8ff : 0000:03:00.0
=A0=A0=A0=A0=A0 c800-c8ff : r8169
=A0 d000-efff : PCI Bus 0000:04
=A0=A0=A0 d000-d0ff : 0000:04:00.0
=A0=A0=A0 d400-d40f : 0000:04:00.1
=A0=A0=A0=A0=A0 d400-d40f : pata_via
=A0=A0=A0 d800-d803 : 0000:04:00.1
=A0=A0=A0=A0=A0 d800-d803 : pata_via
=A0=A0=A0 e000-e007 : 0000:04:00.1
=A0=A0=A0=A0=A0 e000-e007 : pata_via
=A0=A0=A0 e400-e403 : 0000:04:00.1
=A0=A0=A0=A0=A0 e400-e403 : pata_via
=A0=A0=A0 e800-e807 : 0000:04:00.1
=A0=A0=A0=A0=A0 e800-e807 : pata_via
=A0 fe00-fefe : pnp 00:09
=A0 ff00-ff0f : 0000:00:14.1
=A0=A0=A0 ff00-ff0f : pata_atiixp


<IOMEM:>

00000000-0000ffff : reserved
00010000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : PCI Bus #00
=A0 000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ce000-000d1fff : Adapter ROM
000e2000-000fffff : reserved
=A0 000f0000-000fffff : System ROM
00100000-c7faffff : System RAM
=A0 00400000-007bf931 : Kernel code
=A0 007bf932-00a3a91f : Kernel data
=A0 00acb000-00c5e27f : Kernel bss
c7fb0000-c7fbdfff : ACPI Tables
c7fbe000-c7fdffff : ACPI Non-volatile Storage
c7fe0000-c7ffffff : reserved
c8000000-dfffffff : PCI Bus #00
=A0 ce000000-dfffffff : PCI Bus 0000:01
=A0=A0=A0 ce000000-cfffffff : 0000:01:00.0
=A0=A0=A0 d0000000-dfffffff : 0000:01:00.0
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
=A0 e0000000-efffffff : pnp 00:0d
f0000000-ffffffff : PCI Bus #00
=A0 fbf00000-fbffffff : PCI Bus 0000:03
=A0=A0=A0 fbff8000-fbffbfff : 0000:03:00.0
=A0=A0=A0=A0=A0 fbff8000-fbffbfff : r8169
=A0=A0=A0 fbfff000-fbffffff : 0000:03:00.0
=A0=A0=A0=A0=A0 fbfff000-fbffffff : r8169
=A0 fcff7000-fcff7fff : 0000:00:16.0
=A0=A0=A0 fcff7000-fcff7fff : ohci_hcd
=A0 fcff8000-fcffbfff : 0000:00:14.2
=A0=A0=A0 fcff8000-fcffbfff : ICH HD audio
=A0 fcffc000-fcffcfff : 0000:00:14.5
=A0=A0=A0 fcffc000-fcffcfff : ohci_hcd
=A0 fcffd000-fcffdfff : 0000:00:13.0
=A0=A0=A0 fcffd000-fcffdfff : ohci_hcd
=A0 fcffe000-fcffefff : 0000:00:12.0
=A0=A0=A0 fcffe000-fcffefff : ohci_hcd
=A0 fcfff000-fcfff0ff : 0000:00:16.2
=A0=A0=A0 fcfff000-fcfff0ff : ehci_hcd
=A0 fcfff400-fcfff4ff : 0000:00:13.2
=A0=A0=A0 fcfff400-fcfff4ff : ehci_hcd
=A0 fcfff800-fcfff8ff : 0000:00:12.2
=A0=A0=A0 fcfff800-fcfff8ff : ehci_hcd
=A0 fcfffc00-fcffffff : 0000:00:11.0
=A0=A0=A0 fcfffc00-fcffffff : ahci
=A0 fd000000-fe6fffff : PCI Bus 0000:01
=A0=A0=A0 fd000000-fdffffff : 0000:01:00.0
=A0=A0=A0=A0=A0 fd000000-fdffffff : nvidia
=A0=A0=A0 fe600000-fe67ffff : 0000:01:00.0
=A0=A0=A0 fe6fc000-fe6fffff : 0000:01:00.1
=A0=A0=A0=A0=A0 fe6fc000-fe6fffff : ICH HD audio
=A0 fe700000-fe7fffff : PCI Bus 0000:02
=A0=A0=A0 fe7e0000-fe7e3fff : 0000:02:05.0
=A0=A0=A0 fe7fc000-fe7fffff : 0000:02:05.0
=A0=A0=A0=A0=A0 fe7fc000-fe7fffff : pata_pdc2027x
=A0 fe800000-fe8fffff : PCI Bus 0000:03
=A0=A0=A0 fe8e0000-fe8fffff : 0000:03:00.0
=A0 fe900000-fe9fffff : PCI Bus 0000:04
=A0=A0=A0 fe9ef800-fe9effff : 0000:04:00.0
=A0=A0=A0=A0=A0 fe9ef800-fe9effff : firewire_ohci
=A0=A0=A0 fe9f0000-fe9fffff : 0000:04:00.1
=A0 fec00000-fec003ff : IOAPIC 0
=A0 fec10000-fec1001f : pnp 00:09
=A0 fed00000-fed003ff : HPET 2
=A0 fed80000-fed80fff : pnp 00:09
=A0 fee00000-fee00fff : Local APIC
=A0=A0=A0 fee00000-fee00fff : pnp 00:08
=A0 ffb80000-ffbfffff : pnp 00:09
=A0 fff00000-ffffffff : reserved
100000000-237ffffff : System RAM
238000000-fcffffffff : PCI Bus #00


<PCI INFORMATION: (from lspci -vvv)>

00:00.0 Host bridge: ATI Technologies Inc RD890 Northbridge only single=
 slot PCI-e GFX Hydra part (rev 02)
=A0=A0=A0=A0=A0=A0=A0 Subsystem: ATI Technologies Inc RD890 Northbridge=
 only single slot PCI-e GFX Hydra part
=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [f0] HyperTransport: MSI Mapping En=
able+ Fixed+
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [c4] HyperTransport: Slave or Prima=
ry Interface
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Command: BaseUnitID=3D0 U=
nitCnt=3D20 MastHost- DefDir- DUL-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Control 0: CFlE- CST=
- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=3D0 IsocEn- LSEn- ExtCTL- 64b-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Config 0: MLWI=3D16b=
it DwFcIn- MLWO=3D16bit DwFcOut- LWI=3D16bit DwFcInEn- LWO=3D16bit DwFc=
OutEn-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Control 1: CFlE- CST=
- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=3D0 IsocEn- LSEn- ExtCTL- 64b-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Config 1: MLWI=3D8bi=
t DwFcIn- MLWO=3D8bit DwFcOut- LWI=3D8bit DwFcInEn- LWO=3D8bit DwFcOutE=
n-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Revision ID: 3.00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Frequency 0: [b]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Error 0: <Prot- <Ovf=
l- <EOC- CTLTm-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Frequency Capability=
 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4=
GHz- 1.6GHz- Vend-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Feature Capability: IsocF=
C+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Frequency 1: 200MHz
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Error 1: <Prot- <Ovf=
l- <EOC- CTLTm-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Frequency Capability=
 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4=
GHz- 1.6GHz- Vend-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Error Handling: PFlE- OFl=
E- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNF=
E- CRCNFE- SERRNFE-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Prefetchable memory behin=
d bridge Upper: 00-00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bus Number: 00
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [40] HyperTransport: Retry Mode
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [54] HyperTransport: UnitID Clumpin=
g
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [9c] HyperTransport: #1a
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [70] MSI: Enable- Count=3D1/4 Maska=
ble- 64bit-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address: 00000000=A0 Data=
: 0000

00:02.0 PCI bridge: ATI Technologies Inc RD890 PCI to PCI bridge (PCI e=
xpress gpp port B) (prog-if 00 [Normal decode])
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 0, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Bus: primary=3D00, secondary=3D01, subordinate=3D=
01, sec-latency=3D0
=A0=A0=A0=A0=A0=A0=A0 I/O behind bridge: 00009000-00009fff
=A0=A0=A0=A0=A0=A0=A0 Memory behind bridge: fd000000-fe6fffff
=A0=A0=A0=A0=A0=A0=A0 Prefetchable memory behind bridge: 00000000ce0000=
00-00000000dfffffff
=A0=A0=A0=A0=A0=A0=A0 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
=A0=A0=A0=A0=A0=A0=A0 BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Res=
et- FastB2B-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PriDiscTmr- SecDiscTmr- D=
iscTmrStat- DiscTmrSERREn-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [50] Power Management version 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1- D=
2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst- PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [58] Express (v2) Root Port (Slot+)=
, MSI 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap: MaxPayload 128 by=
tes, PhantFunc 0, Latency L0s <64ns, L1 <1us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtTag+ RBE+ FLReset-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl: Report errors: Co=
rrectable- Non-Fatal- Fatal- Unsupported-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 R=
lxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 M=
axPayload 128 bytes, MaxReadReq 128 bytes
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevSta: CorrErr- UncorrEr=
r- FatalErr- UnsuppReq- AuxPwr- TransPend-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCap: Port #0, Speed 5G=
T/s, Width x16, ASPM L0s L1, Latency L0 <1us, L1 <8us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
lockPM- Surprise- LLActRep+ BwNot+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl: ASPM L0s L1 Enabl=
ed; RCB 64 bytes Disabled- Retrain- CommClk+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta: Speed 5GT/s, Widt=
h x16, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SltCap: AttnBtn- PwrCtrl-=
 MRL- AttnInd- PwrInd- HotPlug- Surprise-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 S=
lot #18, PowerLimit 75.000W; Interlock- NoCompl+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SltCtl: Enable: AttnBtn- =
PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
ontrol: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SltSta: Status: AttnBtn- =
PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
hanged: MRL- PresDet+ LinkState+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RootCtl: ErrCorrectable- =
ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RootCap: CRSVisible-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RootSta: PME ReqID 0000, =
PMEStatus- PMEPending-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap2: Completion Timeo=
ut: Range ABCD, TimeoutDis+ ARIFwd+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl2: Completion Timeo=
ut: 65ms to 210ms, TimeoutDis- ARIFwd-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl2: Target Link Spee=
d: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Comp=
lianceSOS-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Compliance De-emphasis: -6dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta2: Current De-empha=
sis Level: -3.5dB
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maska=
ble- 64bit-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address: fee0300c=A0 Data=
: 4149
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [b0] Subsystem: ATI Technologies In=
c Device 5a11
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [b8] HyperTransport: MSI Mapping En=
able+ Fixed+
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [100 v1] Vendor Specific Informatio=
n: ID=3D0001 Rev=3D1 Len=3D010 <?>
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [190 v1] Access Control Services
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ACSCap: SrcValid+ TransBl=
k+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ACSCtl: SrcValid- TransBl=
k- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: pcieport

00:11.0 SATA controller: ATI Technologies Inc SB700/SB800 SATA Controll=
er [IDE mode] (rev 40) (prog-if 01 [AHCI 1.0])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 55=
03
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin A routed to IRQ 43
=A0=A0=A0=A0=A0=A0=A0 Region 0: I/O ports at 8000 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0 Region 1: I/O ports at 7000 [size=3D4]
=A0=A0=A0=A0=A0=A0=A0 Region 2: I/O ports at 6000 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0 Region 3: I/O ports at 5000 [size=3D4]
=A0=A0=A0=A0=A0=A0=A0 Region 4: I/O ports at 4000 [size=3D16]
=A0=A0=A0=A0=A0=A0=A0 Region 5: Memory at fcfffc00 (32-bit, non-prefetc=
hable) [size=3D1K]
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [50] MSI: Enable+ Count=3D1/4 Maska=
ble- 64bit+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address: 00000000fee0300c=
=A0 Data: 4169
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [70] SATA HBA v1.0 InCfgSpace
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [a4] PCI Advanced Features
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AFCap: TP+ FLR+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AFCtrl: FLR-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AFStatus: TP-
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: ahci

00:12.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Cont=
roller (prog-if 10 [OHCI])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 37=
01
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin A routed to IRQ 18
=A0=A0=A0=A0=A0=A0=A0 Region 0: Memory at fcffe000 (32-bit, non-prefetc=
hable) [size=3D4K]
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: ohci_hcd

00:12.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Contr=
oller (prog-if 20 [EHCI])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 37=
01
=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin B routed to IRQ 17
=A0=A0=A0=A0=A0=A0=A0 Region 0: Memory at fcfff800 (32-bit, non-prefetc=
hable) [size=3D256]
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [c0] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1+ D=
2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst- PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bridge: PM- B3+
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [e4] Debug port: BAR=3D1 offset=3D0=
0e0
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: ehci_hcd

00:13.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Cont=
roller (prog-if 10 [OHCI])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 37=
01
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin A routed to IRQ 18
=A0=A0=A0=A0=A0=A0=A0 Region 0: Memory at fcffd000 (32-bit, non-prefetc=
hable) [size=3D4K]
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: ohci_hcd

00:13.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Contr=
oller (prog-if 20 [EHCI])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 37=
01
=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin B routed to IRQ 17
=A0=A0=A0=A0=A0=A0=A0 Region 0: Memory at fcfff400 (32-bit, non-prefetc=
hable) [size=3D256]
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [c0] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1+ D=
2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst- PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bridge: PM- B3+
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [e4] Debug port: BAR=3D1 offset=3D0=
0e0
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: ehci_hcd

00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus Controller (rev 41)
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
=A0=A0=A0=A0=A0=A0=A0 Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: piix4_smbus
=A0=A0=A0=A0=A0=A0=A0 Kernel modules: i2c-piix4

00:14.1 IDE interface: ATI Technologies Inc SB700/SB800 IDE Controller =
(rev 40) (prog-if 8a [Master SecP PriP])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 37=
01
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin B routed to IRQ 17
=A0=A0=A0=A0=A0=A0=A0 Region 0: I/O ports at 01f0 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0 Region 1: I/O ports at 03f4 [size=3D1]
=A0=A0=A0=A0=A0=A0=A0 Region 2: I/O ports at 0170 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0 Region 3: I/O ports at 0374 [size=3D1]
=A0=A0=A0=A0=A0=A0=A0 Region 4: I/O ports at ff00 [size=3D16]
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: pata_atiixp
=A0=A0=A0=A0=A0=A0=A0 Kernel modules: pata_atiixp

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA) (re=
v 40)
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 82=
24
=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin ? routed to IRQ 16
=A0=A0=A0=A0=A0=A0=A0 Region 0: Memory at fcff8000 (64-bit, non-prefetc=
hable) [size=3D16K]
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [50] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1- D=
2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst- PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: HDA Intel
=A0=A0=A0=A0=A0=A0=A0 Kernel modules: snd-hda-intel

00:14.3 ISA bridge: ATI Technologies Inc SB700/SB800 LPC host controlle=
r (rev 40)
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 37=
01
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 0

00:14.4 PCI bridge: ATI Technologies Inc SBx00 PCI to PCI Bridge (rev 4=
0) (prog-if 01 [Subtractive decode])
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64
=A0=A0=A0=A0=A0=A0=A0 Bus: primary=3D00, secondary=3D02, subordinate=3D=
02, sec-latency=3D64
=A0=A0=A0=A0=A0=A0=A0 I/O behind bridge: 0000a000-0000bfff
=A0=A0=A0=A0=A0=A0=A0 Memory behind bridge: fe700000-fe7fffff
=A0=A0=A0=A0=A0=A0=A0 Prefetchable memory behind bridge: fff00000-000ff=
fff
=A0=A0=A0=A0=A0=A0=A0 Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
=A0=A0=A0=A0=A0=A0=A0 BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Res=
et- FastB2B-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PriDiscTmr- SecDiscTmr- D=
iscTmrStat- DiscTmrSERREn-

00:14.5 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI2 Cont=
roller (prog-if 10 [OHCI])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 37=
01
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin C routed to IRQ 18
=A0=A0=A0=A0=A0=A0=A0 Region 0: Memory at fcffc000 (32-bit, non-prefetc=
hable) [size=3D4K]
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: ohci_hcd

00:15.0 PCI bridge: ATI Technologies Inc Device 43a0 (prog-if 00 [Norma=
l decode])
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 0, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Bus: primary=3D00, secondary=3D04, subordinate=3D=
04, sec-latency=3D0
=A0=A0=A0=A0=A0=A0=A0 I/O behind bridge: 0000d000-0000efff
=A0=A0=A0=A0=A0=A0=A0 Memory behind bridge: fe900000-fe9fffff
=A0=A0=A0=A0=A0=A0=A0 Prefetchable memory behind bridge: 00000000fff000=
00-00000000000fffff
=A0=A0=A0=A0=A0=A0=A0 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
=A0=A0=A0=A0=A0=A0=A0 BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Res=
et- FastB2B-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PriDiscTmr- SecDiscTmr- D=
iscTmrStat- DiscTmrSERREn-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [50] Power Management version 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1+ D=
2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst- PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [58] Express (v2) Root Port (Slot+)=
, MSI 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap: MaxPayload 128 by=
tes, PhantFunc 0, Latency L0s <64ns, L1 <1us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtTag+ RBE+ FLReset-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl: Report errors: Co=
rrectable- Non-Fatal- Fatal- Unsupported-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 R=
lxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 M=
axPayload 128 bytes, MaxReadReq 128 bytes
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevSta: CorrErr- UncorrEr=
r- FatalErr- UnsuppReq- AuxPwr- TransPend-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCap: Port #0, Speed 2.=
5GT/s, Width x1, ASPM L0s L1, Latency L0 <64ns, L1 <1us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
lockPM- Surprise- LLActRep+ BwNot+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl: ASPM Disabled; RC=
B 64 bytes Disabled- Retrain- CommClk-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta: Speed 2.5GT/s, Wi=
dth x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SltCap: AttnBtn- PwrCtrl-=
 MRL- AttnInd- PwrInd- HotPlug- Surprise-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 S=
lot #32, PowerLimit 10.000W; Interlock- NoCompl+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SltCtl: Enable: AttnBtn- =
PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
ontrol: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SltSta: Status: AttnBtn- =
PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
hanged: MRL- PresDet+ LinkState+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RootCtl: ErrCorrectable- =
ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RootCap: CRSVisible-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RootSta: PME ReqID 0000, =
PMEStatus- PMEPending-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap2: Completion Timeo=
ut: Range ABCD, TimeoutDis+ ARIFwd-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl2: Completion Timeo=
ut: 65ms to 210ms, TimeoutDis- ARIFwd-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl2: Target Link Spee=
d: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Comp=
lianceSOS-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Compliance De-emphasis: -6dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta2: Current De-empha=
sis Level: -6dB
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maska=
ble- 64bit+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address: 00000000fee0300c=
=A0 Data: 4151
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [b0] Subsystem: ATI Technologies In=
c Device 0000
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [b8] HyperTransport: MSI Mapping En=
able+ Fixed+
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [100 v1] Vendor Specific Informatio=
n: ID=3D0001 Rev=3D1 Len=3D010 <?>
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: pcieport

00:15.1 PCI bridge: ATI Technologies Inc Device 43a1 (prog-if 00 [Norma=
l decode])
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 0, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Bus: primary=3D00, secondary=3D03, subordinate=3D=
03, sec-latency=3D0
=A0=A0=A0=A0=A0=A0=A0 I/O behind bridge: 0000c000-0000cfff
=A0=A0=A0=A0=A0=A0=A0 Memory behind bridge: fe800000-fe8fffff
=A0=A0=A0=A0=A0=A0=A0 Prefetchable memory behind bridge: 00000000fbf000=
00-00000000fbffffff
=A0=A0=A0=A0=A0=A0=A0 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
=A0=A0=A0=A0=A0=A0=A0 BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Res=
et- FastB2B-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PriDiscTmr- SecDiscTmr- D=
iscTmrStat- DiscTmrSERREn-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [50] Power Management version 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1+ D=
2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst- PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [58] Express (v2) Root Port (Slot+)=
, MSI 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap: MaxPayload 128 by=
tes, PhantFunc 0, Latency L0s <64ns, L1 <1us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtTag+ RBE+ FLReset-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl: Report errors: Co=
rrectable- Non-Fatal- Fatal- Unsupported-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 R=
lxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 M=
axPayload 128 bytes, MaxReadReq 128 bytes
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevSta: CorrErr- UncorrEr=
r- FatalErr- UnsuppReq- AuxPwr- TransPend-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCap: Port #1, Speed 2.=
5GT/s, Width x1, ASPM L0s L1, Latency L0 <64ns, L1 <1us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
lockPM- Surprise- LLActRep+ BwNot+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl: ASPM L0s L1 Enabl=
ed; RCB 64 bytes Disabled- Retrain- CommClk+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta: Speed 2.5GT/s, Wi=
dth x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SltCap: AttnBtn- PwrCtrl-=
 MRL- AttnInd- PwrInd- HotPlug- Surprise-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 S=
lot #33, PowerLimit 10.000W; Interlock- NoCompl+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SltCtl: Enable: AttnBtn- =
PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
ontrol: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SltSta: Status: AttnBtn- =
PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
hanged: MRL- PresDet+ LinkState+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RootCtl: ErrCorrectable- =
ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RootCap: CRSVisible-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RootSta: PME ReqID 0000, =
PMEStatus- PMEPending-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap2: Completion Timeo=
ut: Range ABCD, TimeoutDis+ ARIFwd-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl2: Completion Timeo=
ut: 65ms to 210ms, TimeoutDis- ARIFwd-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl2: Target Link Spee=
d: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Comp=
lianceSOS-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Compliance De-emphasis: -6dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta2: Current De-empha=
sis Level: -6dB
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maska=
ble- 64bit+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address: 00000000fee0300c=
=A0 Data: 4159
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [b0] Subsystem: ATI Technologies In=
c Device 0000
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [b8] HyperTransport: MSI Mapping En=
able+ Fixed+
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [100 v1] Vendor Specific Informatio=
n: ID=3D0001 Rev=3D1 Len=3D010 <?>
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: pcieport

00:16.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Cont=
roller (prog-if 10 [OHCI])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 37=
01
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin A routed to IRQ 18
=A0=A0=A0=A0=A0=A0=A0 Region 0: Memory at fcff7000 (32-bit, non-prefetc=
hable) [size=3D4K]
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: ohci_hcd

00:16.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Contr=
oller (prog-if 20 [EHCI])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 37=
01
=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3D=
medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin B routed to IRQ 17
=A0=A0=A0=A0=A0=A0=A0 Region 0: Memory at fcfff000 (32-bit, non-prefetc=
hable) [size=3D256]
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [c0] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1+ D=
2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst- PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bridge: PM- B3+
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [e4] Debug port: BAR=3D1 offset=3D0=
0e0
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: ehci_hcd

00:18.0 Host bridge: Advanced Micro Devices [AMD] Family 10h Processor =
HyperTransport Configuration
=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [80] HyperTransport: Host or Second=
ary Interface
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Command: WarmRst+ DblEnd-=
 DevNum=3D0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Control: CFlE- CST- =
CFE- <LkFail- Init+ EOC- TXO- <CRCErr=3D0 IsocEn- LSEn+ ExtCTL- 64b-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Config: MLWI=3D16bit=
 DwFcIn- MLWO=3D16bit DwFcOut- LWI=3D16bit DwFcInEn- LWO=3D16bit DwFcOu=
tEn-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Revision ID: 3.00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Frequency: [b]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Error: <Prot- <Ovfl-=
 <EOC- CTLTm-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Link Frequency Capability=
: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GH=
z- 1.6GHz- Vend-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Feature Capability: IsocF=
C+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-

00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 10h Processor =
Address Map
=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices [AMD] Family 10h Processor =
DRAM Controller
=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices [AMD] Family 10h Processor =
Miscellaneous Control
=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [f0] Secure device <?>
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: k10temp
=A0=A0=A0=A0=A0=A0=A0 Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices [AMD] Family 10h Processor =
Link Control
=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

01:00.0 VGA compatible controller: nVidia Corporation GT218 [GeForce 21=
0] (rev a2) (prog-if 00 [VGA controller])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: eVga.com. Corp. Device 1212
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 0
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin A routed to IRQ 18
=A0=A0=A0=A0=A0=A0=A0 Region 0: Memory at fd000000 (32-bit, non-prefetc=
hable) [size=3D16M]
=A0=A0=A0=A0=A0=A0=A0 Region 1: Memory at d0000000 (64-bit, prefetchabl=
e) [size=3D256M]
=A0=A0=A0=A0=A0=A0=A0 Region 3: Memory at ce000000 (64-bit, prefetchabl=
e) [size=3D32M]
=A0=A0=A0=A0=A0=A0=A0 Region 5: I/O ports at 9800 [size=3D128]
=A0=A0=A0=A0=A0=A0=A0 [virtual] Expansion ROM at fe600000 [disabled] [s=
ize=3D512K]
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [60] Power Management version 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1- D=
2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst+ PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [68] MSI: Enable- Count=3D1/1 Maska=
ble- 64bit+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address: 0000000000000000=
=A0 Data: 0000
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [78] Express (v2) Endpoint, MSI 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap: MaxPayload 128 by=
tes, PhantFunc 0, Latency L0s unlimited, L1 <64us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl: Report errors: Co=
rrectable- Non-Fatal- Fatal- Unsupported-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 R=
lxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 M=
axPayload 128 bytes, MaxReadReq 512 bytes
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevSta: CorrErr- UncorrEr=
r- FatalErr- UnsuppReq- AuxPwr- TransPend-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCap: Port #0, Speed 5G=
T/s, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <4us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
lockPM+ Surprise- LLActRep- BwNot-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl: ASPM L0s L1 Enabl=
ed; RCB 128 bytes Disabled- Retrain- CommClk+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta: Speed 5GT/s, Widt=
h x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap2: Completion Timeo=
ut: Not Supported, TimeoutDis+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl2: Completion Timeo=
ut: 50us to 50ms, TimeoutDis-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl2: Target Link Spee=
d: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Comp=
lianceSOS-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Compliance De-emphasis: -6dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta2: Current De-empha=
sis Level: -3.5dB
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [b4] Vendor Specific Information: L=
en=3D14 <?>
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [100 v1] Virtual Channel
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Caps:=A0=A0 LPEVC=3D0 Ref=
Clk=3D100ns PATEntryBits=3D1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Arb:=A0=A0=A0 Fixed- WRR3=
2- WRR64- WRR128-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Ctrl:=A0=A0 ArbSelect=3DF=
ixed
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: InProgress-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 VC0:=A0=A0=A0 Caps:=A0=A0=
 PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 A=
rb:=A0=A0=A0 Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
trl:=A0=A0 Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 S=
tatus: NegoPending- InProgress-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [128 v1] Power Budgeting <?>
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [600 v1] Vendor Specific Informatio=
n: ID=3D0001 Rev=3D1 Len=3D024 <?>
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: nvidia
=A0=A0=A0=A0=A0=A0=A0 Kernel modules: nvidia, nouveau, nvidiafb

01:00.1 Audio device: nVidia Corporation High Definition Audio Controll=
er (rev a1)
=A0=A0=A0=A0=A0=A0=A0 Subsystem: eVga.com. Corp. Device 1212
=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 0, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin A routed to IRQ 18
=A0=A0=A0=A0=A0=A0=A0 Region 0: Memory at fe6fc000 (32-bit, non-prefetc=
hable) [size=3D16K]
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [60] Power Management version 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1- D=
2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst+ PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [68] MSI: Enable- Count=3D1/1 Maska=
ble- 64bit+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address: 0000000000000000=
=A0 Data: 0000
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [78] Express (v2) Endpoint, MSI 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap: MaxPayload 128 by=
tes, PhantFunc 0, Latency L0s <4us, L1 <64us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl: Report errors: Co=
rrectable- Non-Fatal- Fatal- Unsupported-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 R=
lxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 M=
axPayload 128 bytes, MaxReadReq 512 bytes
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevSta: CorrErr- UncorrEr=
r- FatalErr- UnsuppReq- AuxPwr- TransPend-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCap: Port #0, Speed 5G=
T/s, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <1us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
lockPM+ Surprise- LLActRep- BwNot-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl: ASPM L0s L1 Enabl=
ed; RCB 128 bytes Disabled- Retrain- CommClk+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta: Speed 5GT/s, Widt=
h x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap2: Completion Timeo=
ut: Not Supported, TimeoutDis+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl2: Completion Timeo=
ut: 50us to 50ms, TimeoutDis-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl2: Target Link Spee=
d: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Comp=
lianceSOS-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Compliance De-emphasis: -6dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta2: Current De-empha=
sis Level: -3.5dB
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: HDA Intel
=A0=A0=A0=A0=A0=A0=A0 Kernel modules: snd-hda-intel

02:05.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02=
) (prog-if 85)
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Promise Technology, Inc. Ultra133TX2
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3D=
slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 64 (1000ns min, 4500ns max), Cache Line =
Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin A routed to IRQ 20
=A0=A0=A0=A0=A0=A0=A0 Region 0: I/O ports at b800 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0 Region 1: I/O ports at b400 [size=3D4]
=A0=A0=A0=A0=A0=A0=A0 Region 2: I/O ports at b000 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0 Region 3: I/O ports at a800 [size=3D4]
=A0=A0=A0=A0=A0=A0=A0 Region 4: I/O ports at a400 [size=3D16]
=A0=A0=A0=A0=A0=A0=A0 Region 5: Memory at fe7fc000 (32-bit, non-prefetc=
hable) [size=3D16K]
=A0=A0=A0=A0=A0=A0=A0 Expansion ROM at fe7e0000 [disabled] [size=3D16K]
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [60] Power Management version 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI+ D1+ D=
2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst- PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: pata_pdc2027x
=A0=A0=A0=A0=A0=A0=A0 Kernel modules: pata_pdc2027x

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/81=
68B PCI Express Gigabit Ethernet controller (rev 03)
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 23=
09
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 0, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin A routed to IRQ 44
=A0=A0=A0=A0=A0=A0=A0 Region 0: I/O ports at c800 [size=3D256]
=A0=A0=A0=A0=A0=A0=A0 Region 2: Memory at fbfff000 (64-bit, prefetchabl=
e) [size=3D4K]
=A0=A0=A0=A0=A0=A0=A0 Region 4: Memory at fbff8000 (64-bit, prefetchabl=
e) [size=3D16K]
=A0=A0=A0=A0=A0=A0=A0 Expansion ROM at fe8e0000 [disabled] [size=3D128K=
]
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [40] Power Management version 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1+ D=
2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst+ PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [50] MSI: Enable+ Count=3D1/1 Maska=
ble- 64bit+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address: 00000000fee0100c=
=A0 Data: 4181
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [70] Express (v2) Endpoint, MSI 01
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap: MaxPayload 256 by=
tes, PhantFunc 0, Latency L0s <512ns, L1 <64us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl: Report errors: Co=
rrectable- Non-Fatal- Fatal- Unsupported-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 R=
lxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 M=
axPayload 128 bytes, MaxReadReq 4096 bytes
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevSta: CorrErr+ UncorrEr=
r- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCap: Port #0, Speed 2.=
5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
lockPM+ Surprise- LLActRep- BwNot-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl: ASPM L0s L1 Enabl=
ed; RCB 64 bytes Disabled- Retrain- CommClk+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta: Speed 2.5GT/s, Wi=
dth x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap2: Completion Timeo=
ut: Not Supported, TimeoutDis+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl2: Completion Timeo=
ut: 50us to 50ms, TimeoutDis-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl2: Target Link Spee=
d: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Comp=
lianceSOS-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Compliance De-emphasis: -6dB
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta2: Current De-empha=
sis Level: -6dB
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [ac] MSI-X: Enable- Count=3D4 Maske=
d-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Vector table: BAR=3D4 off=
set=3D00000000
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PBA: BAR=3D4 offset=3D000=
00800
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [cc] Vital Product Data
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Unknown small resource ty=
pe 00, will not decode more.
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [100 v1] Advanced Error Reporting
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 UESta:=A0 DLP- SDES- TLP-=
 FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSV=
iol-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 UEMsk:=A0 DLP- SDES- TLP-=
 FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSV=
iol-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 UESvrt: DLP+ SDES+ TLP- F=
CP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSVio=
l-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CESta:=A0 RxErr- BadTLP- =
BadDLLP- Rollover- Timeout- NonFatalErr+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CEMsk:=A0 RxErr- BadTLP- =
BadDLLP- Rollover- Timeout- NonFatalErr+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AERCap: First Error Point=
er: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [140 v1] Virtual Channel
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Caps:=A0=A0 LPEVC=3D0 Ref=
Clk=3D100ns PATEntryBits=3D1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Arb:=A0=A0=A0 Fixed- WRR3=
2- WRR64- WRR128-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Ctrl:=A0=A0 ArbSelect=3DF=
ixed
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: InProgress-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 VC0:=A0=A0=A0 Caps:=A0=A0=
 PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 A=
rb:=A0=A0=A0 Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
trl:=A0=A0 Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 S=
tatus: NegoPending- InProgress-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [160 v1] Device Serial Number 55-03=
-00-00-68-4c-e0-00
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: r8169
=A0=A0=A0=A0=A0=A0=A0 Kernel modules: r8169

04:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6315 Series Fire=
wire Controller (prog-if 10 [OHCI])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: Biostar Microtech Int'l Corp Device 42=
02
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 0, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin A routed to IRQ 16
=A0=A0=A0=A0=A0=A0=A0 Region 0: Memory at fe9ef800 (64-bit, non-prefetc=
hable) [size=3D2K]
=A0=A0=A0=A0=A0=A0=A0 Region 2: I/O ports at d000 [size=3D256]
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [50] Power Management version 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1- D=
2+ AuxCurrent=3D0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst- PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [80] MSI: Enable- Count=3D1/1 Maska=
ble+ 64bit+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address: 0000000000000000=
=A0 Data: 0000
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Masking: 00000000=A0 Pend=
ing: 00000000
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [98] Express (v1) Endpoint, MSI 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap: MaxPayload 128 by=
tes, PhantFunc 0, Latency L0s <64ns, L1 <1us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl: Report errors: Co=
rrectable- Non-Fatal- Fatal- Unsupported-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 R=
lxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 M=
axPayload 128 bytes, MaxReadReq 512 bytes
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevSta: CorrErr+ UncorrEr=
r- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCap: Port #0, Speed 2.=
5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <64us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
lockPM+ Surprise- LLActRep- BwNot-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl: ASPM L0s Enabled;=
 RCB 64 bytes Disabled- Retrain- CommClk-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta: Speed 2.5GT/s, Wi=
dth x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [100 v1] Advanced Error Reporting
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 UESta:=A0 DLP- SDES- TLP-=
 FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSV=
iol-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 UEMsk:=A0 DLP- SDES- TLP-=
 FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSV=
iol-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 UESvrt: DLP+ SDES+ TLP- F=
CP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSVio=
l-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CESta:=A0 RxErr- BadTLP- =
BadDLLP- Rollover- Timeout- NonFatalErr+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CEMsk:=A0 RxErr- BadTLP- =
BadDLLP- Rollover- Timeout- NonFatalErr+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AERCap: First Error Point=
er: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [130 v1] Device Serial Number 00-30=
-67-ff-ff-83-f3-23
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: firewire_ohci
=A0=A0=A0=A0=A0=A0=A0 Kernel modules: firewire-ohci

04:00.1 IDE interface: VIA Technologies, Inc. PATA IDE Host Controller =
(rev a0) (prog-if 85 [Master SecO PriO])
=A0=A0=A0=A0=A0=A0=A0 Subsystem: VIA Technologies, Inc. PATA IDE Host C=
ontroller
=A0=A0=A0=A0=A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0 Latency: 0, Cache Line Size: 64 bytes
=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin A routed to IRQ 16
=A0=A0=A0=A0=A0=A0=A0 Region 0: I/O ports at e800 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0 Region 1: I/O ports at e400 [size=3D4]
=A0=A0=A0=A0=A0=A0=A0 Region 2: I/O ports at e000 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0 Region 3: I/O ports at d800 [size=3D4]
=A0=A0=A0=A0=A0=A0=A0 Region 4: I/O ports at d400 [size=3D16]
=A0=A0=A0=A0=A0=A0=A0 Expansion ROM at fe9f0000 [disabled] [size=3D64K]
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [50] Power Management version 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI- D1- D=
2+ AuxCurrent=3D0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 NoSoftRst- PME=
-Enable- DSel=3D0 DScale=3D0 PME-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [70] MSI: Enable- Count=3D1/1 Maska=
ble+ 64bit+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address: 0000000000000000=
=A0 Data: 0000
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Masking: 00000000=A0 Pend=
ing: 00000000
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [90] Express (v1) Legacy Endpoint, =
MSI 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCap: MaxPayload 128 by=
tes, PhantFunc 0, Latency L0s <64ns, L1 <1us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevCtl: Report errors: Co=
rrectable- Non-Fatal- Fatal- Unsupported-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 R=
lxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 M=
axPayload 128 bytes, MaxReadReq 512 bytes
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DevSta: CorrErr+ UncorrEr=
r- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCap: Port #0, Speed 2.=
5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <64us
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
lockPM+ Surprise- LLActRep- BwNot-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkCtl: ASPM L0s Enabled;=
 RCB 64 bytes Disabled- Retrain- CommClk-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E=
xtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LnkSta: Speed 2.5GT/s, Wi=
dth x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [100 v1] Advanced Error Reporting
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 UESta:=A0 DLP- SDES- TLP-=
 FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSV=
iol-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 UEMsk:=A0 DLP- SDES- TLP-=
 FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSV=
iol-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 UESvrt: DLP+ SDES+ TLP- F=
CP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSVio=
l-
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CESta:=A0 RxErr- BadTLP- =
BadDLLP- Rollover- Timeout- NonFatalErr+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CEMsk:=A0 RxErr- BadTLP- =
BadDLLP- Rollover- Timeout- NonFatalErr+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AERCap: First Error Point=
er: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
=A0=A0=A0=A0=A0=A0=A0 Capabilities: [130 v1] Device Serial Number 00-30=
-67-ff-ff-83-f3-23
=A0=A0=A0=A0=A0=A0=A0 Kernel driver in use: pata_via
=A0=A0=A0=A0=A0=A0=A0 Kernel modules: pata_via

<SCSI INFORMATION: (from /proc/scsi/scsi)>

Attached devices:
Host: scsi4 Channel: 00 Id: 00 Lun: 00
=A0 Vendor: ATA=A0=A0=A0=A0=A0 Model: Maxtor 6Y080L0=A0=A0 Rev: YAR4
=A0 Type:=A0=A0 Direct-Access=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 ANSI=A0 SCSI revision: 05
Host: scsi8 Channel: 00 Id: 00 Lun: 00
=A0 Vendor: SONY=A0=A0=A0=A0 Model: CD-RW=A0 CRX216E=A0=A0 Rev: PD01
=A0 Type:=A0=A0 CD-ROM=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 ANSI=A0 SCSI revision: 05

=A0


 		 	   		  