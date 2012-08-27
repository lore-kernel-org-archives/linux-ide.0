From: Adko Branil <adkobranil@yahoo.com>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Mon, 27 Aug 2012 10:01:12 -0700 (PDT)
Message-ID: <1346086872.65665.YahooMailNeo@web124704.mail.ne1.yahoo.com>
References: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20120826130152.GA20021@liondog.tnic>
Reply-To: Adko Branil <adkobranil@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web124704.mail.ne1.yahoo.com ([98.138.206.67]:46525 "EHLO
	web124704.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753650Ab2H0RIe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Aug 2012 13:08:34 -0400
In-Reply-To: <20120826130152.GA20021@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

>Stupid question: have you tried replacing your DIMMs to see whether th=
is
>can be caused by a faulty DRAM?

I just tried it - i have 2 banks memory each of 1 Mb - i replaced the f=
irst , then the second, then replaced both and put memory from another =
computer, tried another slots as well - the same picture - crashes cont=
inuing. There is no visual sign of broken capacitors on motherboard - a=
ll looks good. When i pass "nosmp" option to kernel at boot time, it cr=
ashes much faster - may be 100 times faster, and the pannic messages ar=
e almost the same each-other. Is it for sure broken hardware, and which=
 part of hardware it should be in ? Is there possibility that it is bad=
 bios, or even virus in bios, should upgrading bios help in this cases =
?

I have found 2 interesting lines in syslog:

could not find module by name=3D'rtc_cmos'
microcode: AMD CPU family 0xf not supported

The kernel is 3.5.2 on slackware_current with config http://pastebin.co=
m/aGqH3tTR , it crashes with older kernels as well.


cat /proc/cpuinfo , when "nosmp" is passed:

/proc/cpuinfo=20
processor=A0=A0=A0=A0=A0=A0 : 0
vendor_id=A0=A0=A0=A0=A0=A0 : AuthenticAMD
cpu family=A0=A0=A0=A0=A0 : 15
model=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 43
model name=A0=A0=A0=A0=A0 : AMD Athlon(tm) 64 X2 Dual Core Processor 42=
00+
stepping=A0=A0=A0=A0=A0=A0=A0 : 1
microcode=A0=A0=A0=A0=A0=A0 : 0x4d
cpu MHz=A0=A0=A0=A0=A0=A0=A0=A0 : 2200.000
cache size=A0=A0=A0=A0=A0 : 512 KB
physical id=A0=A0=A0=A0 : 0
siblings=A0=A0=A0=A0=A0=A0=A0 : 1
core id=A0=A0=A0=A0=A0=A0=A0=A0 : 0
cpu cores=A0=A0=A0=A0=A0=A0 : 1
apicid=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 0
initial apicid=A0 : 0
fpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : yes
fpu_exception=A0=A0 : yes
cpuid level=A0=A0=A0=A0 : 1
wp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : yes
flags=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : fpu vme de pse tsc msr pae mce cx=
8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht sys=
call nx mmxext fxsr_opt lm 3dnowext 3dnow up rep_good nopl pni lahf_lm =
cmp_legacy
bogomips=A0=A0=A0=A0=A0=A0=A0 : 4405.67
TLB size=A0=A0=A0=A0=A0=A0=A0 : 1024 4K pages
clflush size=A0=A0=A0 : 64
cache_alignment : 64
address sizes=A0=A0 : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


And here i put 10 new panic messages:
**********************************************************
1



[88737.878016] BUG: unable to handle kernel NULL pointer dereference at=
 0000000000000008
[88737.878026] IP: [<ffffffff810759c9>] select_task_rq_idle+0x9/0x20
[88737.878026] PGD 58696067 PUD 586db067 PMD 0=20
[88737.878026] Oops: 0000 [#1] SMP=20
[88737.878026] CPU 1=20
[88737.878026] Modules linked in:[88737.878026]=A0 ipv6 netconsole snd_=
seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_=
oss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat =
nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables =
x_tables lp fuse mperf nouveau snd_via82xx snd_ac97_codec snd_mpu401_ua=
rt snd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer snd proc=
essor mxm_wmi soundcore amd64_agp wmi video ttm drm_kms_helper drm freq=
_table thermal_sys evdev agpgart i2c_algo_bit ppdev k8temp ac97_bus skg=
e shpchp parport_pc parport i2c_viapro i2c_core hwmon gameport button l=
oop

[88737.878026] Pid: 0, comm: swapper/1 Not tainted 3.5.2 #2 To Be Fille=
d By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[88737.878026] RIP: 0010:[<ffffffff810759c9>]=A0 [<ffffffff810759c9>] s=
elect_task_rq_idle+0x9/0x20
[88737.878026] RSP: 0018:ffff88007fd03f10=A0 EFLAGS: 00010046
[88737.878026] RAX: 0000000000000004 RBX: ffff88007fd0d780 RCX: 0000000=
000000000
[88737.878026] RDX: 000050b4e5b246dc RSI: ffff88007fd0d780 RDI: 0000000=
000000000
[88737.878026] RBP: 000000007fd03f10 R08: 0000000000000000 R09: 0000000=
000000000
[88737.878026] R10: ffffffff81049091 R11: 0000000000000001 R12: ffff880=
07fd0d780
[88737.878026] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
[88737.878026] FS:=A0 00007fdcb5f6d740(0000) GS:ffff88007fd00000(0000) =
knlGS:00000000f75686c0
[88737.878026] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[88737.878026] CR2: 0000000000000008 CR3: 000000006f467000 CR4: 0000000=
0000007e0
[88737.878026] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[88737.878026] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[88737.878026] Process swapper/1 (pid: 0, threadinfo ffff88007c516000, =
task ffff88007d0528e0)
[88737.878026] Stack:
[88737.878026]=A0 ffffffff81090d4e 000000000000d780 ffff88007fd0d780 ff=
ff88007fd03f68
[88737.878026]=A0 ffffffff81091237 ffff88007fd03f68 000050b4e5b246dc 00=
00000000000082
[88737.878026]=A0 0000000000000001 0000000000000000 0000000000000000 ff=
ff88007fd03f88
[88737.878026] Call Trace:
[88737.878026]=A0 <IRQ>=20
[88737.878026]=A0 [<ffffffff81090d4e>] ? tick_nohz_stop_idle+0x3e/0x50
[88737.878026]=A0 [<ffffffff81091237>] ? tick_check_idle+0xb7/0xd0
[88737.878026]=A0 [<ffffffff81049091>] ? irq_enter+0x71/0x80
[88737.878026]=A0 [<ffffffff81b18ffe>] ? smp_apic_timer_interrupt+0x3e/=
0x99
[88737.878026]=A0 [<ffffffff81b18147>] ? apic_timer_interrupt+0x67/0x70
[88737.878026]=A0 <EOI>=20
[88737.878026]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[88737.878026]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[88737.878026]=A0 [<ffffffff81afcd19>] ? start_secondary+0x1d8/0x1df
[88737.878026] Code: 00 00 8b 3d 9a e6 07 01 85 ff 74 06 f3 c3 0f 1f 40=
 00 55 48 89 e5 e8 57 ff ff ff 5d c3 0f 1f 44 00 00 55 48 89 e5 66 66 6=
6 66 90 <48> 8b 47 08 5d 8b 40 18 c3 66 66 66 66 66 2e 0f 1f 84 00 00 0=
0=20
[88737.878026] RIP=A0 [<ffffffff810759c9>] select_task_rq_idle+0x9/0x20
[88737.878026]=A0 RSP <ffff88007fd03f10>
[88737.878026] CR2: 0000000000000008
[88737.878026] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga e=
ncoder (output 0)
[88737.878026] ---[ end trace 2b802f6ce20c0ad7 ]---
[88737.878026] Kernel panic - not syncing: Fatal exception in interrupt
[88737.878026] panic occurred, switching back to text console





***********************************************************************=
*******************
2




[=A0=A0 67.718020] BUG: unable to handle kernel NULL pointer dereferenc=
e at 00000000000000ac
[=A0=A0 67.719001] IP: [<00000000000000ac>] 0xab
[=A0=A0 67.719001] PGD 3b191067 PUD 3b192067 PMD 0=20
[=A0=A0 67.719001] Oops: 0010 [#1] SMP=20
[=A0=A0 67.719001] CPU 0=20
[=A0=A0 67.719001] Modules linked in:[=A0=A0 67.719001]=A0 netconsole s=
nd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mix=
er_oss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_n=
at nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tabl=
es x_tables lp fuse nouveau mxm_wmi wmi video ttm drm_kms_helper drm mp=
erf processor freq_table thermal_sys amd64_agp snd_via82xx snd_ac97_cod=
ec i2c_algo_bit snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm snd_=
page_alloc snd_timer snd agpgart ppdev shpchp k8temp i2c_viapro i2c_cor=
e evdev hwmon soundcore ac97_bus parport_pc parport skge gameport butto=
n loop

[=A0=A0 67.719001] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be F=
illed By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[=A0=A0 67.719001] RIP: 0010:[<00000000000000ac>]=A0 [<00000000000000ac=
>] 0xab
[=A0=A0 67.719001] RSP: 0018:ffff88003fc03f50=A0 EFLAGS: 00010046
[=A0=A0 67.719001] RAX: 000000000000acac RBX: ffff88003f807000 RCX: fff=
f88003e000018
[=A0=A0 67.719001] RDX: 00000000000000ac RSI: ffff88003f807000 RDI: fff=
f88003f807084
[=A0=A0 67.719001] RBP: ffffffff810b99ed R08: 0000000000000000 R09: fff=
f88003e000000
[=A0=A0 67.719001] R10: 0000000000000002 R11: 0000000000000001 R12: 000=
0000000000030
[=A0=A0 67.719001] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
[=A0=A0 67.719001] FS:=A0 00007f5738fd9740(0000) GS:ffff88003fc00000(00=
00) knlGS:00000000f6f38700
[=A0=A0 67.719001] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[=A0=A0 67.719001] CR2: 00000000000000ac CR3: 000000003c2ae000 CR4: 000=
00000000007f0
[=A0=A0 67.719001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[=A0=A0 67.719001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 000=
0000000000400
[=A0=A0 67.719001] Process swapper/0 (pid: 0, threadinfo ffffffff820000=
00, task ffffffff82013440)
[=A0=A0 67.719001] Stack:
[=A0=A0 67.719001]=A0 0000000000000000 ffff88003fc03f78 ffffffff81003be=
2 ffff88003fc03f78
[=A0=A0 67.719001]=A0 ffffffff82001e58 ffff88003fc03fa8 ffffffff81b18f3=
a ffffffff82001fd8
[=A0=A0 67.719001]=A0 0000000000000000 ffffffff821572c0 ffff88003ff7d8c=
0 ffffffff82001f18
[=A0=A0 67.719001] Call Trace:
[=A0=A0 67.719001]=A0 <IRQ>=20
[=A0=A0 67.719001]=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
[=A0=A0 67.719001]=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
[=A0=A0 67.719001]=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x67
[=A0=A0 67.719001]=A0 <EOI>=20
[=A0=A0 67.719001]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[=A0=A0 67.719001]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[=A0=A0 67.719001]=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
[=A0=A0 67.719001]=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
[=A0=A0 67.719001]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5=
e
[=A0=A0 67.719001]=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations+=
0x131/0x135
[=A0=A0 67.719001]=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/0=
xdc
[=A0=A0 67.719001] Code:=A0 Bad RIP value.
[=A0=A0 67.719001] RIP=A0 [<00000000000000ac>] 0xab
[=A0=A0 67.719001]=A0 RSP <ffff88003fc03f50>
[=A0=A0 67.719001] CR2: 00000000000000ac
[=A0=A0 67.719001] ---[ end trace dda71181e8426f41 ]---
[=A0=A0 67.719001] Kernel panic - not syncing: Fatal exception in inter=
rupt
[=A0=A0 67.719001] panic occurred, switching back to text console





***********************************************************************=
*******************
2




[ 1085.409036] BUG: unable to handle kernel NULL pointer dereference at=
 000000000000009e
[ 1085.410016] IP: [<000000000000009e>] 0x9d
[ 1085.410016] PGD 3c89f067 PUD 3c121067 PMD 0=20
[ 1085.410016] Oops: 0010 [#1] SMP=20
[ 1085.410016] CPU 0=20
[ 1085.410016] Modules linked in:[ 1085.410016]=A0 netconsole snd_seq_d=
ummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss i=
pt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat nf_co=
nntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x_tab=
les lp fuse nouveau mxm_wmi wmi video ttm drm_kms_helper snd_via82xx sn=
d_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm snd_pag=
e_alloc snd_timer snd drm soundcore ac97_bus mperf gameport i2c_algo_bi=
t amd64_agp freq_table i2c_viapro skge processor evdev i2c_core thermal=
_sys agpgart ppdev k8temp button hwmon shpchp parport_pc parport loop

[ 1085.410016] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fille=
d By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[ 1085.410016] RIP: 0010:[<000000000000009e>]=A0 [<000000000000009e>] 0=
x9d
[ 1085.410016] RSP: 0018:ffff88003fc03f50=A0 EFLAGS: 00010046
[ 1085.410016] RAX: 0000000000009e9e RBX: ffff88003f807000 RCX: ffff880=
03e000018
[ 1085.410016] RDX: 000000000000009e RSI: ffff88003f807000 RDI: ffff880=
03f807084
[ 1085.410016] RBP: ffffffff810b99ed R08: 0000000000000000 R09: ffff880=
03e000000
[ 1085.410016] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000=
000000030
[ 1085.410016] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
[ 1085.410016] FS:=A0 00007f386ab3a740(0000) GS:ffff88003fc00000(0000) =
knlGS:00000000f6fa1700
[ 1085.410016] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1085.410016] CR2: 000000000000009e CR3: 000000003cad0000 CR4: 0000000=
0000007f0
[ 1085.410016] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[ 1085.410016] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[ 1085.410016] Process swapper/0 (pid: 0, threadinfo ffffffff82000000, =
task ffffffff82013440)
[ 1085.410016] Stack:
[ 1085.410016]=A0 0000000000000000 ffff88003fc03f78 ffffffff81003be2 ff=
ff88003fc03f78
[ 1085.410016]=A0 ffffffff82001e58 ffff88003fc03fa8 ffffffff81b18f3a ff=
ffffff82001fd8
[ 1085.410016]=A0 0000000000000000 ffffffff821572c0 ffff88003ff7d8c0 ff=
ffffff82001f18
[ 1085.410016] Call Trace:
[ 1085.410016]=A0 <IRQ>=20
[ 1085.410016]=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
[ 1085.410016]=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
[ 1085.410016]=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x67
[ 1085.410016]=A0 <EOI>=20
[ 1085.410016]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[ 1085.410016]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[ 1085.410016]=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
[ 1085.410016]=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
[ 1085.410016]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[ 1085.410016]=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations+0x13=
1/0x135
[ 1085.410016]=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/0xdc
[ 1085.410016] Code:=A0 Bad RIP value.
[ 1085.410016] RIP=A0 [<000000000000009e>] 0x9d
[ 1085.410016]=A0 RSP <ffff88003fc03f50>
[ 1085.410016] CR2: 000000000000009e
[ 1085.410016] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga e=
ncoder (output 0)
[ 1085.410016] ---[ end trace 90cc13f8af30d858 ]---
[ 1085.410016] Kernel panic - not syncing: Fatal exception in interrupt
[ 1085.410016] panic occurred, switching back to text console





***********************************************************************=
*******************
4




[=A0 480.508000] BUG: unable to handle kernel NULL pointer dereference =
at 0000000000000008
[=A0 480.508981] IP: [<0000000000000008>] 0x7
[=A0 480.508981] PGD 3c3ca067 PUD 3c3cb067 PMD 0=20
[=A0 480.508981] Oops: 0010 [#1] SMP=20
[=A0 480.508981] CPU 0=20
[=A0 480.508981] Modules linked in:[=A0 480.508981]=A0 netconsole snd_s=
eq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_o=
ss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat n=
f_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x=
_tables lp fuse snd_via82xx snd_ac97_codec nouveau snd_mpu401_uart snd_=
rawmidi snd_seq_device snd_pcm snd_page_alloc mxm_wmi snd_timer wmi vid=
eo ttm drm_kms_helper snd drm i2c_algo_bit shpchp amd64_agp agpgart ppd=
ev skge soundcore ac97_bus gameport parport_pc i2c_viapro i2c_core evde=
v k8temp parport button mperf freq_table processor thermal_sys hwmon lo=
op

[=A0 480.508981] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[=A0 480.508981] RIP: 0010:[<0000000000000008>]=A0 [<0000000000000008>]=
 0x7
[=A0 480.508981] RSP: 0018:ffff88003fc03f50=A0 EFLAGS: 00010046
[=A0 480.508981] RAX: 0000000000000808 RBX: ffff88003f807000 RCX: ffff8=
8003e000018
[=A0 480.508981] RDX: 0000000000000008 RSI: ffff88003f807000 RDI: ffff8=
8003f807084
[=A0 480.508981] RBP: ffffffff810b99ed R08: 0000000000000000 R09: ffff8=
8003e000000
[=A0 480.508981] R10: 0000000000000002 R11: 0000000000000001 R12: 00000=
00000000030
[=A0 480.508981] R13: 0000000000000000 R14: 0000000000000000 R15: 00000=
00000000000
[=A0 480.508981] FS:=A0 00007f00f6c01740(0000) GS:ffff88003fc00000(0000=
) knlGS:00000000f6f8a700
[=A0 480.508981] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[=A0 480.508981] CR2: 0000000000000008 CR3: 000000003c3f5000 CR4: 00000=
000000007f0
[=A0 480.508981] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
[=A0 480.508981] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
[=A0 480.508981] Process swapper/0 (pid: 0, threadinfo ffffffff82000000=
, task ffffffff82013440)
[=A0 480.508981] Stack:
[=A0 480.508981]=A0 0000000000000000 ffff88003fc03f78 ffffffff81003be2 =
ffff88003fc03f78
[=A0 480.508981]=A0 ffffffff82001e58 ffff88003fc03fa8 ffffffff81b18f3a =
ffffffff82001fd8
[=A0 480.508981]=A0 0000000000000000 ffffffff821572c0 ffff88003ff7d8c0 =
ffffffff82001f18
[=A0 480.508981] Call Trace:
[=A0 480.508981]=A0 <IRQ>=20
[=A0 480.508981]=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
[=A0 480.508981]=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
[=A0 480.508981]=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x67
[=A0 480.508981]=A0 <EOI>=20
[=A0 480.508981]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[=A0 480.508981]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[=A0 480.508981]=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
[=A0 480.508981]=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
[=A0 480.508981]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[=A0 480.508981]=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations+0x=
131/0x135
[=A0 480.508981]=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/0xd=
c
[=A0 480.508981] Code:=A0 Bad RIP value.
[=A0 480.508981] RIP=A0 [<0000000000000008>] 0x7
[=A0 480.508981]=A0 RSP <ffff88003fc03f50>
[=A0 480.508981] CR2: 0000000000000008
[=A0 480.508981] ---[ end trace 8b165df2324216e5 ]---
[=A0 480.508981] Kernel panic - not syncing: Fatal exception in interru=
pt
[=A0 480.508981] panic occurred, switching back to text console





***********************************************************************=
*******************
5




[=A0 578.242542] BUG: unable to handle kernel paging request at fffffff=
f81006020
[=A0 578.243522] IP: [<ffffffff81b16c80>] _raw_spin_trylock_bh+0x50/0x5=
0
[=A0 578.243522] PGD 200d067 PUD 2011063 PMD 10001e1=20
[=A0 578.243522] Oops: 0003 [#1] SMP=20
[=A0 578.243522] CPU 0=20
[=A0 578.243522] Modules linked in:[=A0 578.243522]=A0 netconsole snd_s=
eq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_o=
ss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat n=
f_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x=
_tables lp fuse nouveau mxm_wmi wmi video ttm drm_kms_helper drm i2c_al=
go_bit mperf processor amd64_agp freq_table shpchp snd_via82xx snd_ac97=
_codec snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm snd_page_allo=
c snd_timer snd soundcore ac97_bus gameport thermal_sys k8temp hwmon i2=
c_viapro i2c_core agpgart ppdev button evdev skge parport_pc parport lo=
op

[=A0 578.243522] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[=A0 578.243522] RIP: 0010:[<ffffffff81b16c80>]=A0 [<ffffffff81b16c80>]=
 _raw_spin_trylock_bh+0x50/0x50
[=A0 578.243522] RSP: 0018:ffff88003fc03f10=A0 EFLAGS: 00010086
[=A0 578.243522] RAX: ffffffff81006020 RBX: 0000000000000001 RCX: 00000=
00000000000
[=A0 578.243522] RDX: ffffffff82014da0 RSI: ffff88003f807000 RDI: fffff=
fff821db4d0
[=A0 578.243522] RBP: ffff88003fc03f38 R08: 0000000000000000 R09: ffff8=
8003e000000
[=A0 578.243522] R10: 0000000000000002 R11: 0000000000000001 R12: 00000=
00000000000
[=A0 578.243522] R13: 0000000000000000 R14: 0000000000000000 R15: 00000=
00000000000
[=A0 578.243522] FS:=A0 00007f43a6aa8740(0000) GS:ffff88003fc00000(0000=
) knlGS:00000000f6fd6700
[=A0 578.243522] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[=A0 578.243522] CR2: ffffffff81006020 CR3: 0000000039874000 CR4: 00000=
000000007f0
[=A0 578.243522] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
[=A0 578.243522] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
[=A0 578.243522] Process swapper/0 (pid: 0, threadinfo ffffffff82000000=
, task ffffffff82013440)
[=A0 578.243522] Stack:
[=A0 578.243522]=A0 ffffffff81006052 ffff88003fc03f58 ffff88003f807000 =
0000000000000030
[=A0 578.243522]=A0 0000000000000000 ffff88003fc03f58 ffffffff810b99ff =
ffff88003fc03f58
[=A0 578.243522]=A0 0000000000000000 ffff88003fc03f78 ffffffff81003be2 =
ffff88003fc03f78
[=A0 578.243522] Call Trace:
[=A0 578.243522]=A0 <IRQ>=20
[=A0 578.243522]=A0 [<ffffffff81006052>] ? mask_and_ack_8259A+0x32/0x11=
0
[=A0 578.243522]=A0 [<ffffffff810b99ff>] handle_level_irq+0x2f/0xc0
[=A0 578.243522]=A0 [<ffffffff81003be2>] handle_irq+0x22/0x40
[=A0 578.243522]=A0 [<ffffffff81b18f3a>] do_IRQ+0x5a/0xe0
[=A0 578.243522]=A0 [<ffffffff81b16ea7>] common_interrupt+0x67/0x67
[=A0 578.243522]=A0 <EOI>=20
[=A0 578.243522]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[=A0 578.243522]=A0 [<ffffffff8100b4f6>] cpu_idle+0x106/0x120
[=A0 578.243522]=A0 [<ffffffff81ace029>] rest_init+0x6d/0x74
[=A0 578.243522]=A0 [<ffffffff8210db9a>] start_kernel+0x38c/0x399
[=A0 578.243522]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[=A0 578.243522]=A0 [<ffffffff8210d32d>] x86_64_start_reservations+0x13=
1/0x135
[=A0 578.243522]=A0 [<ffffffff8210d409>] x86_64_start_kernel+0xd8/0xdc
[=A0 578.243522] Code: ff 48 83 c4 08 31 c0 5b 5d c3 90 8d 8a 00 01 00 =
00 89 d0 3e 66 0f b1 0b 66 39 d0 75 db 48 83 c4 08 b8 01 00 00 00 5b 5d=
 c3 66 90 <55> 48 89 e5 66 66 66 66 90 9c 58 fa ba 00 01 00 00 3e 66 0f=
 c1=20
[=A0 578.243522] RIP=A0 [<ffffffff81b16c80>] _raw_spin_trylock_bh+0x50/=
0x50
[=A0 578.243522]=A0 RSP <ffff88003fc03f10>
[=A0 578.243522] CR2: ffffffff81006020
[=A0 578.243522] ---[ end trace ac1d8aa849f50149 ]---
[=A0 578.243522] Kernel panic - not syncing: Fatal exception in interru=
pt
[=A0 578.243522] panic occurred, switching back to text console
[=A0 578.243522] Rebooting in 10 seconds..[=A0 914.400053] [drm] nouvea=
u 0000:01:00.0: Setting dpms mode 1 on vga encoder (output 0)





***********************************************************************=
*******************
6




[ 1929.879022] BUG: unable to handle kernel NULL pointer dereference at=
 000000000000002e
[ 1929.880005] IP: [<000000000000002e>] 0x2d
[ 1929.880005] PGD 3b7dc067 PUD 3cb54067 PMD 0=20
[ 1929.880005] Oops: 0010 [#1] SMP=20
[ 1929.880005] CPU 0=20
[ 1929.880005] Modules linked in:[ 1929.880005]=A0 netconsole snd_seq_d=
ummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss i=
pt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat nf_co=
nntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x_tab=
les lp fuse nouveau mxm_wmi wmi video ttm drm_kms_helper drm mperf proc=
essor freq_table thermal_sys snd_via82xx i2c_algo_bit i2c_viapro i2c_co=
re shpchp snd_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_device snd=
_pcm snd_page_alloc snd_timer amd64_agp k8temp agpgart hwmon ppdev snd =
soundcore ac97_bus gameport evdev button skge parport_pc parport loop

[ 1929.880005] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fille=
d By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[ 1929.880005] RIP: 0010:[<000000000000002e>]=A0 [<000000000000002e>] 0=
x2d
[ 1929.880005] RSP: 0018:ffff88003fc03f50=A0 EFLAGS: 00010046
[ 1929.880005] RAX: 0000000000002e2e RBX: ffff88003f807000 RCX: ffff880=
03e000018
[ 1929.880005] RDX: 000000000000002e RSI: ffff88003f807000 RDI: ffff880=
03f807084
[ 1929.880005] RBP: ffffffff810b99ed R08: 0000000000000000 R09: ffff880=
03e000000
[ 1929.880005] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000=
000000030
[ 1929.880005] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
[ 1929.880005] FS:=A0 00007f0fe8bc9740(0000) GS:ffff88003fc00000(0000) =
knlGS:00000000f6f64700
[ 1929.880005] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1929.880005] CR2: 000000000000002e CR3: 000000003cb4e000 CR4: 0000000=
0000007f0
[ 1929.880005] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[ 1929.880005] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[ 1929.880005] Process swapper/0 (pid: 0, threadinfo ffffffff82000000, =
task ffffffff82013440)
[ 1929.880005] Stack:
[ 1929.880005]=A0 0000000000000000 ffff88003fc03f78 ffffffff81003be2 ff=
ff88003fc03f78
[ 1929.880005]=A0 ffffffff82001e58 ffff88003fc03fa8 ffffffff81b18f3a ff=
ffffff82001fd8
[ 1929.880005]=A0 0000000000000000 ffffffff821572c0 ffff88003ff7d8c0 ff=
ffffff82001f18
[ 1929.880005] Call Trace:
[ 1929.880005]=A0 <IRQ>=20
[ 1929.880005]=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
[ 1929.880005]=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
[ 1929.880005]=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x67
[ 1929.880005]=A0 <EOI>=20
[ 1929.880005]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[ 1929.880005]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[ 1929.880005]=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
[ 1929.880005]=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
[ 1929.880005]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[ 1929.880005]=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations+0x13=
1/0x135
[ 1929.880005]=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/0xdc
[ 1929.880005] Code:=A0 Bad RIP value.
[ 1929.880005] RIP=A0 [<000000000000002e>] 0x2d
[ 1929.880005]=A0 RSP <ffff88003fc03f50>
[ 1929.880005] CR2: 000000000000002e
[ 1929.880005] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga e=
ncoder (output 0)
[ 1929.880005] ---[ end trace 6a8b984dcbc1c2e2 ]---
[ 1929.880005] Kernel panic - not syncing: Fatal exception in interrupt
[ 1929.880005] panic occurred, switching back to text console
[ 1929.880005] Rebooting in 10 seconds..





***********************************************************************=
*******************
7




[=A0 109.770017] BUG: unable to handle kernel NULL pointer dereference =
at 00000000000000c6
[=A0 109.771001] IP: [<00000000000000c6>] 0xc5
[=A0 109.771001] PGD 3a347067 PUD 3a345067 PMD 0=20
[=A0 109.771001] Oops: 0010 [#1] SMP=20
[=A0 109.771001] CPU 0=20
[=A0 109.771001] Modules linked in:[=A0 109.771001]=A0 netconsole snd_s=
eq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_o=
ss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat n=
f_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x=
_tables lp fuse nouveau mxm_wmi wmi video ttm drm_kms_helper drm mperf =
amd64_agp processor agpgart snd_via82xx snd_ac97_codec freq_table snd_m=
pu401_uart thermal_sys i2c_algo_bit ppdev snd_rawmidi snd_seq_device sn=
d_pcm snd_page_alloc snd_timer snd soundcore ac97_bus gameport button s=
hpchp skge i2c_viapro k8temp evdev hwmon i2c_core parport_pc parport lo=
op

[=A0 109.771001] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[=A0 109.771001] RIP: 0010:[<00000000000000c6>]=A0 [<00000000000000c6>]=
 0xc5
[=A0 109.771001] RSP: 0018:ffff88003fc03f50=A0 EFLAGS: 00010046
[=A0 109.771001] RAX: 000000000000c6c6 RBX: ffff88003f807000 RCX: ffff8=
8003e000018
[=A0 109.771001] RDX: 00000000000000c6 RSI: ffff88003f807000 RDI: ffff8=
8003f807084
[=A0 109.771001] RBP: ffffffff810b99ed R08: 0000000000000000 R09: ffff8=
8003e000000
[=A0 109.771001] R10: 0000000000000002 R11: 0000000000000001 R12: 00000=
00000000030
[=A0 109.771001] R13: 0000000000000000 R14: 0000000000000000 R15: 00000=
00000000000
[=A0 109.771001] FS:=A0 00007f5fcd527740(0000) GS:ffff88003fc00000(0000=
) knlGS:00000000f6f51700
[=A0 109.771001] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[=A0 109.771001] CR2: 00000000000000c6 CR3: 000000003b069000 CR4: 00000=
000000007f0
[=A0 109.771001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
[=A0 109.771001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
[=A0 109.771001] Process swapper/0 (pid: 0, threadinfo ffffffff82000000=
, task ffffffff82013440)
[=A0 109.771001] Stack:
[=A0 109.771001]=A0 0000000000000000 ffff88003fc03f78 ffffffff81003be2 =
ffff88003fc03f78
[=A0 109.771001]=A0 ffffffff82001e58 ffff88003fc03fa8 ffffffff81b18f3a =
ffffffff82001fd8
[=A0 109.771001]=A0 0000000000000000 ffffffff821572c0 ffff88003ff7d8c0 =
ffffffff82001f18
[=A0 109.771001] Call Trace:
[=A0 109.771001]=A0 <IRQ>=20
[=A0 109.771001]=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
[=A0 109.771001]=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
[=A0 109.771001]=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x67
[=A0 109.771001]=A0 <EOI>=20
[=A0 109.771001]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[=A0 109.771001]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[=A0 109.771001]=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
[=A0 109.771001]=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
[=A0 109.771001]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[=A0 109.771001]=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations+0x=
131/0x135
[=A0 109.771001]=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/0xd=
c
[=A0 109.771001] Code:=A0 Bad RIP value.
[=A0 109.771001] RIP=A0 [<00000000000000c6>] 0xc5
[=A0 109.771001]=A0 RSP <ffff88003fc03f50>
[=A0 109.771001] CR2: 00000000000000c6
[=A0 109.771001] ---[ end trace eb4ceefac75ebaf7 ]---
[=A0 109.771001] Kernel panic - not syncing: Fatal exception in interru=
pt
[=A0 109.771001] panic occurred, switching back to text console
[=A0 109.771001] Rebooting in 10 seconds..[=A0 918.496056] [drm] nouvea=
u 0000:01:00.0: Setting dpms mode 1 on vga encoder (output 0)





***********************************************************************=
*******************
8




[ 1754.015971] BUG: unable to handle kernel paging request at ffffffff8=
1006020
[ 1754.016954] IP: [<ffffffff81b16c80>] _raw_spin_trylock_bh+0x50/0x50
[ 1754.016954] PGD 200d067 PUD 2011063 PMD 10001e1=20
[ 1754.016954] Oops: 0003 [#1] SMP=20
[ 1754.016954] CPU 0=20
[ 1754.016954] Modules linked in:[ 1754.016954]=A0 netconsole snd_seq_d=
ummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss i=
pt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat nf_co=
nntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x_tab=
les lp fuse nouveau mxm_wmi wmi video ttm drm_kms_helper snd_via82xx mp=
erf snd_ac97_codec freq_table amd64_agp drm snd_mpu401_uart snd_rawmidi=
 snd_seq_device snd_pcm snd_page_alloc snd_timer snd i2c_algo_bit ppdev=
 shpchp i2c_viapro skge parport_pc parport soundcore ac97_bus processor=
 agpgart button thermal_sys gameport i2c_core k8temp hwmon evdev loop

[ 1754.016954] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fille=
d By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[ 1754.016954] RIP: 0010:[<ffffffff81b16c80>]=A0 [<ffffffff81b16c80>] _=
raw_spin_trylock_bh+0x50/0x50
[ 1754.016954] RSP: 0018:ffff88003fc03f10=A0 EFLAGS: 00010086
[ 1754.016954] RAX: ffffffff81006020 RBX: 0000000000000001 RCX: 0000000=
000000000
[ 1754.016954] RDX: ffffffff82014da0 RSI: ffff88003f807000 RDI: fffffff=
f821db4d0
[ 1754.016954] RBP: ffff88003fc03f38 R08: 0000000000000000 R09: ffff880=
03e000000
[ 1754.016954] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000=
000000000
[ 1754.016954] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
[ 1754.016954] FS:=A0 00007fa74d8bf740(0000) GS:ffff88003fc00000(0000) =
knlGS:00000000f6ff9700
[ 1754.016954] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1754.016954] CR2: ffffffff81006020 CR3: 000000003ceb6000 CR4: 0000000=
0000007f0
[ 1754.016954] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[ 1754.016954] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[ 1754.016954] Process swapper/0 (pid: 0, threadinfo ffffffff82000000, =
task ffffffff82013440)
[ 1754.016954] Stack:
[ 1754.016954]=A0 ffffffff81006052 ffff88003fc03f58 ffff88003f807000 00=
00000000000030
[ 1754.016954]=A0 0000000000000000 ffff88003fc03f58 ffffffff810b99ff ff=
ff88003fc03f58
[ 1754.016954]=A0 0000000000000000 ffff88003fc03f78 ffffffff81003be2 ff=
ff88003fc03f78
[ 1754.016954] Call Trace:
[ 1754.016954]=A0 <IRQ>=20
[ 1754.016954]=A0 [<ffffffff81006052>] ? mask_and_ack_8259A+0x32/0x110
[ 1754.016954]=A0 [<ffffffff810b99ff>] handle_level_irq+0x2f/0xc0
[ 1754.016954]=A0 [<ffffffff81003be2>] handle_irq+0x22/0x40
[ 1754.016954]=A0 [<ffffffff81b18f3a>] do_IRQ+0x5a/0xe0
[ 1754.016954]=A0 [<ffffffff81b16ea7>] common_interrupt+0x67/0x67
[ 1754.016954]=A0 <EOI>=20
[ 1754.016954]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[ 1754.016954]=A0 [<ffffffff8100b4f6>] cpu_idle+0x106/0x120
[ 1754.016954]=A0 [<ffffffff81ace029>] rest_init+0x6d/0x74
[ 1754.016954]=A0 [<ffffffff8210db9a>] start_kernel+0x38c/0x399
[ 1754.016954]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[ 1754.016954]=A0 [<ffffffff8210d32d>] x86_64_start_reservations+0x131/=
0x135
[ 1754.016954]=A0 [<ffffffff8210d409>] x86_64_start_kernel+0xd8/0xdc
[ 1754.016954] Code: ff 48 83 c4 08 31 c0 5b 5d c3 90 8d 8a 00 01 00 00=
 89 d0 3e 66 0f b1 0b 66 39 d0 75 db 48 83 c4 08 b8 01 00 00 00 5b 5d c=
3 66 90 <55> 48 89 e5 66 66 66 66 90 9c 58 fa ba 00 01 00 00 3e 66 0f c=
1=20
[ 1754.016954] RIP=A0 [<ffffffff81b16c80>] _raw_spin_trylock_bh+0x50/0x=
50
[ 1754.016954]=A0 RSP <ffff88003fc03f10>
[ 1754.016954] CR2: ffffffff81006020
[ 1754.016954] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga e=
ncoder (output 0)
[ 1754.016954] ---[ end trace 61ca47b57f1bbabe ]---
[ 1754.016954] Kernel panic - not syncing: Fatal exception in interrupt
[ 1754.016954] panic occurred, switching back to text console
[ 1754.016954] Rebooting in 10 seconds..





***********************************************************************=
*******************
9




[=A0 553.949022] BUG: unable to handle kernel NULL pointer dereference =
at 00000000000000ac
[=A0 553.950004] IP: [<00000000000000ac>] 0xab
[=A0 553.950004] PGD 3ceb0067 PUD 3ceb4067 PMD 0=20
[=A0 553.950004] Oops: 0010 [#1] SMP=20
[=A0 553.950004] CPU 0=20
[=A0 553.950004] Modules linked in:[=A0 553.950004]=A0 netconsole snd_s=
eq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_o=
ss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat n=
f_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x=
_tables lp fuse nouveau snd_via82xx mxm_wmi wmi video ttm drm_kms_helpe=
r snd_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm snd=
_page_alloc snd_timer snd soundcore drm ac97_bus powernow_k8 mperf i2c_=
viapro i2c_algo_bit i2c_core amd64_agp processor agpgart freq_table ppd=
ev gameport shpchp thermal_sys k8temp hwmon evdev skge button parport_p=
c parport loop

[=A0 553.950004] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[=A0 553.950004] RIP: 0010:[<00000000000000ac>]=A0 [<00000000000000ac>]=
 0xab
[=A0 553.950004] RSP: 0018:ffff88003fc03f50=A0 EFLAGS: 00010046
[=A0 553.950004] RAX: 000000000000acac RBX: ffff88003f807000 RCX: ffff8=
8003e000018
[=A0 553.950004] RDX: 00000000000000ac RSI: ffff88003f807000 RDI: ffff8=
8003f807084
[=A0 553.950004] RBP: ffffffff810b99ed R08: 0000000000000000 R09: ffff8=
8003e000000
[=A0 553.950004] R10: 0000000000000002 R11: 0000000000000001 R12: 00000=
00000000030
[=A0 553.950004] R13: ffffffff82013440 R14: 0000000000000000 R15: 00000=
00000000000
[=A0 553.950004] FS:=A0 00007ff1d87bf740(0000) GS:ffff88003fc00000(0000=
) knlGS:00000000f6f46700
[=A0 553.950004] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[=A0 553.950004] CR2: 00000000000000ac CR3: 000000003ceb8000 CR4: 00000=
000000007f0
[=A0 553.950004] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
[=A0 553.950004] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
[=A0 553.950004] Process swapper/0 (pid: 0, threadinfo ffffffff82000000=
, task ffffffff82013440)
[=A0 553.950004] Stack:
[=A0 553.950004]=A0 0000000000000000 ffff88003fc03f78 ffffffff81003be2 =
ffff88003fc03f78
[=A0 553.950004]=A0 ffffffff82001e58 ffff88003fc03fa8 ffffffff81b18f3a =
ffffffff82001fd8
[=A0 553.950004]=A0 0000000000000000 ffffffff821572c0 ffff88003ff7d8c0 =
ffffffff82001f18
[=A0 553.950004] Call Trace:
[=A0 553.950004]=A0 <IRQ>=20
[=A0 553.950004]=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
[=A0 553.950004]=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
[=A0 553.950004]=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x67
[=A0 553.950004]=A0 <EOI>=20
[=A0 553.950004]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[=A0 553.950004]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[=A0 553.950004]=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
[=A0 553.950004]=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
[=A0 553.950004]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[=A0 553.950004]=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations+0x=
131/0x135
[=A0 553.950004]=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/0xd=
c
[=A0 553.950004] Code:=A0 Bad RIP value.
[=A0 553.950004] RIP=A0 [<00000000000000ac>] 0xab
[=A0 553.950004]=A0 RSP <ffff88003fc03f50>
[=A0 553.950004] CR2: 00000000000000ac
[=A0 553.950004] ---[ end trace bbaf991e0e6264f6 ]---
[=A0 553.950004] Kernel panic - not syncing: Fatal exception in interru=
pt
[=A0 553.950004] panic occurred, switching back to text console
[=A0 553.950004] Rebooting in 10 seconds..





***********************************************************************=
*******************
10




[=A0 431.817000] BUG: unable to handle kernel NULL pointer dereference =
at 00000000000000a2
[=A0 431.817982] IP: [<00000000000000a2>] 0xa1
[=A0 431.817982] PGD 3b27b067 PUD 3b228067 PMD 0=20
[=A0 431.817982] Oops: 0010 [#1] SMP=20
[=A0 431.817982] CPU 0=20
[=A0 431.817982] Modules linked in:[=A0 431.817982]=A0 netconsole snd_s=
eq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_o=
ss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat n=
f_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x=
_tables lp fuse nouveau mxm_wmi wmi video ttm drm_kms_helper drm i2c_al=
go_bit snd_via82xx shpchp amd64_agp ppdev snd_ac97_codec snd_mpu401_uar=
t snd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer snd sound=
core ac97_bus gameport parport_pc agpgart powernow_k8 skge i2c_viapro i=
2c_core evdev parport k8temp button mperf freq_table processor thermal_=
sys hwmon loop

[=A0 431.817982] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[=A0 431.817982] RIP: 0010:[<00000000000000a2>]=A0 [<00000000000000a2>]=
 0xa1
[=A0 431.817982] RSP: 0018:ffff88003fc03f50=A0 EFLAGS: 00010046
[=A0 431.817982] RAX: 000000000000a2a2 RBX: ffff88003f807000 RCX: ffff8=
8003e000018
[=A0 431.817982] RDX: 00000000000000a2 RSI: ffff88003f807000 RDI: ffff8=
8003f807084
[=A0 431.817982] RBP: ffffffff810b99ed R08: 0000000000000000 R09: ffff8=
8003e000000
[=A0 431.817982] R10: 0000000000000002 R11: 0000000000000001 R12: 00000=
00000000030
[=A0 431.817982] R13: ffffffff82013440 R14: 0000000000000000 R15: 00000=
00000000000
[=A0 431.817982] FS:=A0 00007fcf47b6e740(0000) GS:ffff88003fc00000(0000=
) knlGS:00000000f6fb7700
[=A0 431.817982] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[=A0 431.817982] CR2: 00000000000000a2 CR3: 000000003a5d9000 CR4: 00000=
000000007f0
[=A0 431.817982] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
[=A0 431.817982] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
[=A0 431.817982] Process swapper/0 (pid: 0, threadinfo ffffffff82000000=
, task ffffffff82013440)
[=A0 431.817982] Stack:
[=A0 431.817982]=A0 0000000000000000 ffff88003fc03f78 ffffffff81003be2 =
ffff88003fc03f78
[=A0 431.817982]=A0 ffffffff82001e58 ffff88003fc03fa8 ffffffff81b18f3a =
ffffffff82001fd8
[=A0 431.817982]=A0 0000000000000000 ffffffff821572c0 ffff88003ff7d8c0 =
ffffffff82001f18
[=A0 431.817982] Call Trace:
[=A0 431.817982]=A0 <IRQ>=20
[=A0 431.817982]=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
[=A0 431.817982]=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
[=A0 431.817982]=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x67
[=A0 431.817982]=A0 <EOI>=20
[=A0 431.817982]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[=A0 431.817982]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[=A0 431.817982]=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
[=A0 431.817982]=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
[=A0 431.817982]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[=A0 431.817982]=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations+0x=
131/0x135
[=A0 431.817982]=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/0xd=
c
[=A0 431.817982] Code:=A0 Bad RIP value.
[=A0 431.817982] RIP=A0 [<00000000000000a2>] 0xa1
[=A0 431.817982]=A0 RSP <ffff88003fc03f50>
[=A0 431.817982] CR2: 00000000000000a2
[=A0 431.817982] ---[ end trace c8f219db95e8434c ]---
[=A0 431.817982] Kernel panic - not syncing: Fatal exception in interru=
pt
[=A0 431.817982] panic occurred, switching back to text console
[=A0 431.817982] Rebooting in 10 seconds..


Thanks for the help !

Best Regards !
Adko.
