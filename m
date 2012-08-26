From: Borislav Petkov <bp@alien8.de>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Sun, 26 Aug 2012 15:01:52 +0200
Message-ID: <20120826130152.GA20021@liondog.tnic>
References: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:50133 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab2HZNB6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Aug 2012 09:01:58 -0400
Content-Disposition: inline
In-Reply-To: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adko Branil <adkobranil@yahoo.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

Adding linux-kernel to CC.

On Sat, Aug 25, 2012 at 06:36:11AM -0700, Adko Branil wrote:
> Here i post few more panics, the last 3-4 or 5 of them are with boot
> option "nosmp".=C2=A0I will take a look at the motherboard to see is =
there
> any visual sign for this plague after 2 days probably, as i am no nea=
r
> to that machine now.
>
> Thanks for the answers Felix and Boris!

Sure, but when you reply to them, please use the "Reply-to-all" feature
in your mail client so that you send email to everybody on the thread
and they can read your reply.The yahoo web interface should have a
button like that.

So, looking at your RIPs:

[36291.240016] RIP: 0010:[<ffffffff810759c9>]=C2=A0 [<ffffffff810759c9>=
] select_task_rq_idle+0x9/0x20
[=C2=A0 168.841525] RIP: 0010:[<ffff88007fc03e98>]=C2=A0 [<ffff88007fc0=
3e98>] 0xffff88007fc03e97
[=C2=A0 170.457007] RIP: 0010:[<ffffffff81047810>]=C2=A0 [<ffffffff8104=
7810>] mktime+0xc0/0xc0
[ 1740.273732] RIP: 0010:[<ffff88007fc03f58>]=C2=A0 [<ffff88007fc03f58>=
] 0xffff88007fc03f57
[=C2=A0 732.877002] RIP: 0010:[<ffff88007fc03f58>]=C2=A0 [<ffff88007fc0=
3f58>] 0xffff88007fc03f57
[=C2=A0=C2=A0 85.610428] RIP: 0010:[<ffff88007fc03f58>]=C2=A0 [<ffff880=
07fc03f58>] 0xffff88007fc03f57
[ 2005.920951] RIP: 0010:[<ffffffff81b16c80>]=C2=A0 [<ffffffff81b16c80>=
] _raw_spin_trylock_bh+0x50/0x50

it looks like a random error with a pattern repeating three times at ff=
ff88007fc03f58

appearing with

[ 1740.272749] kernel tried to execute NX-protected page - exploit atte=
mpt? (uid: 0)

before the page fault in kernel space.

Stupid question: have you tried replacing your DIMMs to see whether thi=
s
can be caused by a faulty DRAM?

Leaving the rest in for reference.

> [36291.085760] Pid: 0, comm: swapper/1 Not tainted 3.5.2 #2 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
> [36291.240016] RIP: 0010:[<ffffffff810759c9>]=C2=A0 [<ffffffff810759c=
9>] select_task_rq_idle+0x9/0x20
> [36291.240016] RSP: 0018:ffff88007fd03f10=C2=A0 EFLAGS: 00010046
> [36291.240016] RAX: 0000000000000004 RBX: ffff88007fd0d780 RCX: 00000=
00000000000
> [36291.240016] RDX: 00002101ad3ae230 RSI: ffff88007fd0d780 RDI: 00000=
00000000000
> [36291.240016] RBP: 000000007fd03f10 R08: 0000000000000000 R09: 00000=
00000000000
> [36291.240016] R10: ffffffff81049091 R11: 0000000000000001 R12: ffff8=
8007fd0d780
> [36291.240016] R13: 0000000000000000 R14: 0000000000000000 R15: 00000=
00000000000
> [36291.240016] FS:=C2=A0 00007f1857041740(0000) GS:ffff88007fd00000(0=
000) knlGS:00000000f6fb6700
> [36291.240016] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [36291.240016] CR2: 0000000000000008 CR3: 000000007436c000 CR4: 00000=
000000007e0
> [36291.240016] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> [36291.240016] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
> [36291.240016] Process swapper/1 (pid: 0, threadinfo ffff88007c516000=
, task ffff88007d0528e0)
> [36291.240016] Stack:
> [36291.240016]=C2=A0 ffffffff81091237 ffff88007fd03f68 00002101ad3ae2=
30 ffff88007fd03f68
> [36291.240016]=C2=A0 0000000000000001 0000000000000000 00000000000000=
00 ffff88007fd03f88
> [36291.240016] Call Trace:
> [36291.240016]=C2=A0 <IRQ>=C2=A0 [<ffffffff81090d4e>] ? tick_nohz_sto=
p_idle+0x3e/0x50
> [36291.240016]=C2=A0 [<ffffffff81091237>] ? tick_check_idle+0xb7/0xd0
> [36291.240016]=C2=A0 [<ffffffff81049091>] ? irq_enter+0x71/0x80
> [36291.240016]=C2=A0 [<ffffffff81b18ffe>] ? smp_apic_timer_interrupt+=
0x3e/0x99
> [36291.240016]=C2=A0 [<ffffffff81b18147>] ? apic_timer_interrupt+0x67=
/0x70
> [36291.240016]=C2=A0 <EOI>=C2=A0 [<ffffffff8100a6fa>] ? default_idle+=
0x5a/0x1b0
> [36291.240016]=C2=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
> [36291.240016]=C2=A0 [<ffffffff81afcd19>] ? start_secondary+0x1d8/0x1=
df
> [36291.240016] Code: 00 00 8b 3d 9a e6 07 01 85 ff 74 06 f3 c3 0f 1f =
40 00 55 48 89 e5 e8 57 ff ff ff 5d c3 0f 1f 44 00 00 55 48 89 e5 66 66=
 66 66 90 <48> 8b 47 08 5d 8b 40 18 c3 66 66 66 66 66 2e 0f 1f 84 00 00=
 00=20
> [36291.240016] RIP=C2=A0 [<ffffffff810759c9>] select_task_rq_idle+0x9=
/0x20
> [36291.240016]=C2=A0 RSP <ffff88007fd03f10>
> [36291.240016] CR2: 0000000000000008
> [36291.240016] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga=
 encoder (output 0)
> [36291.240016]=C2=A0 ffffffff81090d4e 000000000000d780 ffff88007fd0d7=
80 ffff88007fd03f68
> [36291.287884] ---[ end trace 617ca3727df8933f ]---
> [36291.287884] Kernel panic - not syncing: Fatal exception in interru=
pt
> [36291.287884] panic occurred, switching back to text console
> [36291.287884] Rebooting in 10 seconds..[=C2=A0 934.880051] [drm] nou=
veau 0000:01:00.0: Setting dpms mode 1 on vga encoder (output 0)
> [ 2721.605648] REISERFS warning (device sda1): clm-6006 reiserfs_dirt=
y_inode: writing inode 347717 on readonly FS
> [ 2721.983935] REISERFS warning (device sda1): clm-6006 reiserfs_dirt=
y_inode: writing inode 347740 on readonly FS
> [ 2722.505205] REISERFS warning (device sda1): clm-6006 reiserfs_dirt=
y_inode: writing inode 426162 on readonly FS
> [=C2=A0 168.840543] kernel tried to execute NX-protected page - explo=
it attempt? (uid: 0)
> [=C2=A0 168.841525] BUG: unable to handle kernel paging request at ff=
ff88007fc03e98
> [=C2=A0 168.841525] IP: [<ffff88007fc03e98>] 0xffff88007fc03e97
> [=C2=A0 168.841525] PGD 200c063 PUD 1fbfd067 PMD 800000007fc001e3=20
> [=C2=A0 168.841525] Oops: 0011 [#1] SMP=20
> [=C2=A0 168.841525] CPU 0=20
> [=C2=A0 168.841525] Modules linked in:[=C2=A0 168.841525]=C2=A0 netco=
nsole snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss =
snd_mixer_oss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_n=
at nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter =
ip_tables x_tables lp fuse nouveau mxm_wmi wmi mperf video processor tt=
m drm_kms_helper drm freq_table thermal_sys i2c_viapro i2c_algo_bit snd=
_via82xx snd_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_device snd_=
pcm snd_page_alloc i2c_core k8temp amd64_agp agpgart shpchp hwmon ppdev=
 snd_timer snd soundcore ac97_bus gameport skge evdev button parport_pc=
 parport loop
>=20
> [=C2=A0 168.841525] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To B=
e Filled By O.E.M. To Be Filled By O.E.M./A8V Deluxe
> [=C2=A0 168.841525] RIP: 0010:[<ffff88007fc03e98>]=C2=A0 [<ffff88007f=
c03e98>] 0xffff88007fc03e97
> [=C2=A0 168.841525] RSP: 0018:ffff88007fc03e80=C2=A0 EFLAGS: 00010006
> [=C2=A0 168.841525] RAX: 000000007fc03e78 RBX: 000000000000001b RCX: =
0000000000000008
> [=C2=A0 168.841525] RDX: 000000007fc03e78 RSI: 000000005038995a RDI: =
ffff88007fc03e78
> [=C2=A0 168.841525] RBP: ffffffff81088daa R08: 00000000172f91a8 R09: =
00172f91a9000000
> [=C2=A0 168.841525] R10: 000000000080ffad R11: 0000000000000001 R12: =
0000000013c00700
> [=C2=A0 168.841525] R13: 000000000013c007 R14: 0000000000000360 R15: =
000000000000001b
> [=C2=A0 168.841525] FS:=C2=A0 00007f91bbfd7740(0000) GS:ffff88007fc00=
000(0000) knlGS:00000000f6f76700
> [=C2=A0 168.841525] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800=
5003b
> [=C2=A0 168.841525] CR2: ffff88007fc03e98 CR3: 000000007b557000 CR4: =
00000000000007f0
> [=C2=A0 168.841525] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [=C2=A0 168.841525] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: =
0000000000000400
> [=C2=A0 168.841525] Process swapper/0 (pid: 0, threadinfo ffffffff820=
00000, task ffffffff82013440)
> [=C2=A0 168.841525] Stack:
> [=C2=A0 168.841525]=C2=A0 ffffffff8108a3c0 ffff88007fc03e98 ffffffff8=
1088e62 ffff88007fc03ef8
> [=C2=A0 168.841525]=C2=A0 ffffffff81089dce ffff88007fc12b80 ffff88007=
fc12b80 00000000cc022746
> [=C2=A0 168.841525]=C2=A0 0000000000000012 ffff88007fc03ee8 000000000=
1a40288 0000000000000000
> [=C2=A0 168.841525] Call Trace:
> [=C2=A0 168.841525]=C2=A0 <IRQ>=20
> [=C2=A0 168.841525]=C2=A0 [<ffffffff8108a3c0>] ? ntp_tick_length+0x30=
/0x40
> [=C2=A0 168.841525]=C2=A0 [<ffffffff81088e62>] ? timekeeping_update+0=
x22/0x50
> [=C2=A0 168.841525]=C2=A0 [<ffffffff81089dce>] ? do_timer+0x2de/0x550
> [=C2=A0 168.841525]=C2=A0 [<ffffffff810906c7>] ? tick_do_update_jiffi=
es64+0x77/0xc0
> [=C2=A0 168.841525]=C2=A0 [<ffffffff81091214>] ? tick_check_idle+0x94=
/0xd0
> [=C2=A0 168.841525]=C2=A0 [<ffffffff81049091>] ? irq_enter+0x71/0x80
> [=C2=A0 168.841525]=C2=A0 [<ffffffff81b18f1e>] ? do_IRQ+0x3e/0xe0
> [=C2=A0 168.841525]=C2=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x6=
7/0x67
> [=C2=A0 168.841525]=C2=A0 <EOI>=20
> [=C2=A0 168.841525]=C2=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x=
1b0
> [=C2=A0 168.841525]=C2=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
> [=C2=A0 168.841525]=C2=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
> [=C2=A0 168.841525]=C2=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0=
x399
> [=C2=A0 168.841525]=C2=A0 [<ffffffff8210d60d>] ? repair_env_string+0x=
5e/0x5e
> [=C2=A0 168.841525]=C2=A0 [<ffffffff8210d32d>] ? x86_64_start_reserva=
tions+0x131/0x135
> [=C2=A0 168.841525]=C2=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+=
0xd8/0xdc
> [=C2=A0 168.841525] Code: 00 00 00 80 3e c0 7f 00 88 ff ff 18 00 00 0=
0 00 00 00 00 c0 a3 08 81 ff ff ff ff 98 3e c0 7f 00 88 ff ff 62 8e 08 =
81 ff ff ff ff <f8> 3e c0 7f 00 88 ff ff ce 9d 08 81 ff ff ff ff 80 2b =
c1 7f 00=20
> [=C2=A0 168.841525] RIP=C2=A0 [<ffff88007fc03e98>] 0xffff88007fc03e97
> [=C2=A0 168.841525]=C2=A0 RSP <ffff88007fc03e80>
> [=C2=A0 168.841525] CR2: ffff88007fc03e98
> [=C2=A0 168.841525] ---[ end trace 197aa6de17869ba9 ]---
> [=C2=A0 168.841525] Kernel panic - not syncing: Fatal exception in in=
terrupt
> [=C2=A0 168.841525] panic occurred, switching back to text console
> [=C2=A0 168.841525] Rebooting in 10 seconds..[=C2=A0 170.456024] BUG:=
 unable to handle kernel paging request at ffffffff2bbc4800
> [=C2=A0 170.457007] IP: [<ffffffff81047810>] mktime+0xc0/0xc0
> [=C2=A0 170.457007] PGD 200d067 PUD 0=20
> [=C2=A0 170.457007] Oops: 0002 [#1] SMP=20
> [=C2=A0 170.457007] CPU 0=20
> [=C2=A0 170.457007] Modules linked in:[=C2=A0 170.457007]=C2=A0 netco=
nsole snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss =
snd_mixer_oss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_n=
at nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter =
ip_tables x_tables lp fuse nouveau mxm_wmi mperf wmi processor video sn=
d_via82xx ttm drm_kms_helper drm i2c_algo_bit snd_ac97_codec snd_mpu401=
_uart snd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer snd s=
oundcore shpchp evdev i2c_viapro amd64_agp ac97_bus agpgart ppdev freq_=
table thermal_sys skge parport_pc parport button gameport i2c_core k8te=
mp hwmon loop
>=20
> [=C2=A0 170.457007] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To B=
e Filled By O.E.M. To Be Filled By O.E.M./A8V Deluxe
> [=C2=A0 170.457007] RIP: 0010:[<ffffffff81047810>]=C2=A0 [<ffffffff81=
047810>] mktime+0xc0/0xc0
> [=C2=A0 170.457007] RSP: 0018:ffff88007fc03e70=C2=A0 EFLAGS: 00010013
> [=C2=A0 170.457007] RAX: ffffffff2bbc4800 RBX: 0000000000000020 RCX: =
0000000000000008
> [=C2=A0 170.457007] RDX: ffffffffca1b2166 RSI: 0000000050389a37 RDI: =
ffff88007fc03e78
> [=C2=A0 170.457007] RBP: ffff88007fc03e88 R08: 0000000020d77f47 R09: =
0020d77f48000000
> [=C2=A0 170.457007] R10: 000000000080ffad R11: 0000000000000001 R12: =
000000000374ffa0
> [=C2=A0 170.457007] R13: 00000000001ba7fd R14: 00000000be97e000 R15: =
0000000000000008
> [=C2=A0 170.457007] FS:=C2=A0 00007fe879ee9740(0000) GS:ffff88007fc00=
000(0000) knlGS:00000000f6fcb700
> [=C2=A0 170.457007] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800=
5003b
> [=C2=A0 170.457007] CR2: ffffffff2bbc4800 CR3: 000000007b53c000 CR4: =
00000000000007f0
> [=C2=A0 170.457007] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [=C2=A0 170.457007] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: =
0000000000000400
> [=C2=A0 170.457007] Process swapper/0 (pid: 0, threadinfo ffffffff820=
00000, task ffffffff82013440)
> [=C2=A0 170.457007] Stack:
> [=C2=A0 170.457007]=C2=A0 ffffffff81088daa ffff88007fc03e98 ffffffff8=
108a3c0 ffff88007fc03e98
> [=C2=A0 170.457007]=C2=A0 ffffffff81088e62 ffff88007fc03ef8 ffffffff8=
1089dce ffff88007fc12b80
> [=C2=A0 170.457007]=C2=A0 ffff88007fc12b80 00000000214310aa 000000000=
0000002 ffff88007fc03ee8
> [=C2=A0 170.457007] Call Trace:
> [=C2=A0 170.457007]=C2=A0 <IRQ>=20
> [=C2=A0 170.457007]=C2=A0 [<ffffffff81088daa>] ? update_rt_offset+0x2=
a/0x60
> [=C2=A0 170.457007]=C2=A0 [<ffffffff8108a3c0>] ? ntp_tick_length+0x30=
/0x40
> [=C2=A0 170.457007]=C2=A0 [<ffffffff81088e62>] timekeeping_update+0x2=
2/0x50
> [=C2=A0 170.457007]=C2=A0 [<ffffffff81089dce>] do_timer+0x2de/0x550
> [=C2=A0 170.457007]=C2=A0 [<ffffffff810906c7>] tick_do_update_jiffies=
64+0x77/0xc0
> [=C2=A0 170.457007]=C2=A0 [<ffffffff81091214>] tick_check_idle+0x94/0=
xd0
> [=C2=A0 170.457007]=C2=A0 [<ffffffff81049091>] irq_enter+0x71/0x80
> [=C2=A0 170.457007]=C2=A0 [<ffffffff81b18f1e>] do_IRQ+0x3e/0xe0
> [=C2=A0 170.457007]=C2=A0 [<ffffffff81b16ea7>] common_interrupt+0x67/=
0x67
> [=C2=A0 170.457007]=C2=A0 <EOI>=20
> [=C2=A0 170.457007]=C2=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x=
1b0
> [=C2=A0 170.457007]=C2=A0 [<ffffffff8100b4f6>] cpu_idle+0x106/0x120
> [=C2=A0 170.457007]=C2=A0 [<ffffffff81ace029>] rest_init+0x6d/0x74
> [=C2=A0 170.457007]=C2=A0 [<ffffffff8210db9a>] start_kernel+0x38c/0x3=
99
> [=C2=A0 170.457007]=C2=A0 [<ffffffff8210d60d>] ? repair_env_string+0x=
5e/0x5e
> [=C2=A0 170.457007]=C2=A0 [<ffffffff8210d32d>] x86_64_start_reservati=
ons+0x131/0x135
> [=C2=A0 170.457007]=C2=A0 [<ffffffff8210d409>] x86_64_start_kernel+0x=
d8/0xdc
> [=C2=A0 170.457007] Code: 48 29 c2 4c 01 c2 48 8d 04 95 00 00 00 00 4=
9 89 d0 49 c1 e0 06 49 29 c0 4b 8d 04 03 c3 66 66 66 66 66 2e 0f 1f 84 =
00 00 00 00 00 <55> 48 89 e5 66 66 66 66 90 48 81 fa ff c9 9a 3b 7e 19 =
66 0f 1f=20
> [=C2=A0 170.457007] RIP=C2=A0 [<ffffffff81047810>] mktime+0xc0/0xc0
> [=C2=A0 170.457007]=C2=A0 RSP <ffff88007fc03e70>
> [=C2=A0 170.457007] CR2: ffffffff2bbc4800
> [=C2=A0 170.457007] ---[ end trace fb5b43f93a914e0c ]---
> [=C2=A0 170.457007] Kernel panic - not syncing: Fatal exception in in=
terrupt
> [=C2=A0 170.457007] panic occurred, switching back to text console
> [=C2=A0 170.457007] Rebooting in 10 seconds..[=C2=A0 914.400054] [drm=
] nouveau 0000:01:00.0: Setting dpms mode 1 on vga encoder (output 0)
> [ 1740.272749] kernel tried to execute NX-protected page - exploit at=
tempt? (uid: 0)
> [ 1740.273732] BUG: unable to handle kernel paging request at ffff880=
07fc03f58
> [ 1740.273732] IP: [<ffff88007fc03f58>] 0xffff88007fc03f57
> [ 1740.273732] PGD 200c063 PUD 1fbfd067 PMD 800000007fc001e3=20
> [ 1740.273732] Oops: 0011 [#1] SMP=20
> [ 1740.273732] CPU 0=20
> [ 1740.273732] Modules linked in:[ 1740.273732]=C2=A0 netconsole snd_=
seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_=
oss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat =
nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables =
x_tables lp fuse nouveau mxm_wmi snd_via82xx wmi video ttm drm_kms_help=
er snd_ac97_codec drm i2c_viapro i2c_algo_bit mperf processor amd64_agp=
 freq_table snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm snd_page=
_alloc snd_timer snd soundcore thermal_sys k8temp hwmon agpgart ppdev s=
hpchp ac97_bus skge i2c_core gameport evdev button parport_pc parport l=
oop
>=20
> [ 1740.273732] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
> [ 1740.273732] RIP: 0010:[<ffff88007fc03f58>]=C2=A0 [<ffff88007fc03f5=
8>] 0xffff88007fc03f57
> [ 1740.273732] RSP: 0018:ffff88007fc03f50=C2=A0 EFLAGS: 00010046
> [ 1740.273732] RAX: 0000000000005454 RBX: ffff88007f807000 RCX: ffff8=
8007d000018
> [ 1740.273732] RDX: 0000000000000054 RSI: ffff88007f807000 RDI: ffff8=
8007f807084
> [ 1740.273732] RBP: ffffffff810b99ed R08: 0000000000000000 R09: ffff8=
8007d000000
> [ 1740.273732] R10: 0000000000000002 R11: 0000000000000001 R12: 00000=
00000000030
> [ 1740.273732] R13: 0000000000000000 R14: 0000000000000000 R15: 00000=
00000000000
> [ 1740.273732] FS:=C2=A0 00007f81a4a93740(0000) GS:ffff88007fc00000(0=
000) knlGS:00000000f6f37700
> [ 1740.273732] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [ 1740.273732] CR2: ffff88007fc03f58 CR3: 000000007b545000 CR4: 00000=
000000007f0
> [ 1740.273732] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> [ 1740.273732] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
> [ 1740.273732] Process swapper/0 (pid: 0, threadinfo ffffffff82000000=
, task ffffffff82013440)
> [ 1740.273732] Stack:
> [ 1740.273732]=C2=A0 0000000000000000 ffff88007fc03f78 ffffffff81003b=
e2 ffff88007fc03f78
> [ 1740.273732]=C2=A0 ffffffff82001e58 ffff88007fc03fa8 ffffffff81b18f=
3a ffffffff82001fd8
> [ 1740.273732]=C2=A0 0000000000000000 ffffffff821572c0 ffff88007ff7d8=
c0 ffffffff82001f18
> [ 1740.273732] Call Trace:
> [ 1740.273732]=C2=A0 <IRQ>=20
> [ 1740.273732]=C2=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
> [ 1740.273732]=C2=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
> [ 1740.273732]=C2=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x6=
7
> [ 1740.273732]=C2=A0 <EOI>=20
> [ 1740.273732]=C2=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
> [ 1740.273732]=C2=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
> [ 1740.273732]=C2=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
> [ 1740.273732]=C2=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
> [ 1740.273732]=C2=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x=
5e
> [ 1740.273732]=C2=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations=
+0x131/0x135
> [ 1740.273732]=C2=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/=
0xdc
> [ 1740.273732] Code: 88 ff ff 10 00 00 00 00 00 00 00 46 00 01 00 00 =
00 00 00 50 3f c0 7f 00 88 ff ff 18 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 <78> 3f c0 7f 00 88 ff ff e2 3b 00 81 ff ff ff ff 78 3f c0 7f=
 00=20
> [ 1740.273732] RIP=C2=A0 [<ffff88007fc03f58>] 0xffff88007fc03f57
> [ 1740.273732]=C2=A0 RSP <ffff88007fc03f50>
> [ 1740.273732] CR2: ffff88007fc03f58
> [ 1740.273732] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga=
 encoder (output 0)
> [ 1740.273732] ---[ end trace 66512b2a64d236e7 ]---
> [ 1740.273732] Kernel panic - not syncing: Fatal exception in interru=
pt
> [ 1740.273732] panic occurred, switching back to text console
> [ 1740.273732] Rebooting in 10 seconds..[=C2=A0 732.876020] kernel tr=
ied to execute NX-protected page - exploit attempt? (uid: 0)
> [=C2=A0 732.877002] BUG: unable to handle kernel paging request at ff=
ff88007fc03f58
> [=C2=A0 732.877002] IP: [<ffff88007fc03f58>] 0xffff88007fc03f57
> [=C2=A0 732.877002] PGD 200c063 PUD 1fbfd067 PMD 800000007fc001e3=20
> [=C2=A0 732.877002] Oops: 0011 [#1] SMP=20
> [=C2=A0 732.877002] CPU 0=20
> [=C2=A0 732.877002] Modules linked in:[=C2=A0 732.877002]=C2=A0 netco=
nsole snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss =
snd_mixer_oss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_n=
at nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter =
ip_tables x_tables lp fuse snd_via82xx snd_ac97_codec snd_mpu401_uart s=
nd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer snd soundcor=
e ac97_bus gameport nouveau mxm_wmi wmi video ttm drm_kms_helper drm mp=
erf i2c_algo_bit amd64_agp processor freq_table shpchp thermal_sys i2c_=
viapro agpgart evdev i2c_core k8temp hwmon ppdev button skge parport_pc=
 parport loop
>=20
> [=C2=A0 732.877002] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To B=
e Filled By O.E.M. To Be Filled By O.E.M./A8V Deluxe
> [=C2=A0 732.877002] RIP: 0010:[<ffff88007fc03f58>]=C2=A0 [<ffff88007f=
c03f58>] 0xffff88007fc03f57
> [=C2=A0 732.877002] RSP: 0018:ffff88007fc03f50=C2=A0 EFLAGS: 00010046
> [=C2=A0 732.877002] RAX: 000000000000a2a2 RBX: ffff88007f807000 RCX: =
ffff88007d000018
> [=C2=A0 732.877002] RDX: 00000000000000a2 RSI: ffff88007f807000 RDI: =
ffff88007f807084
> [=C2=A0 732.877002] RBP: ffffffff810b99ed R08: 0000000000000000 R09: =
ffff88007d000000
> [=C2=A0 732.877002] R10: 0000000000000002 R11: 0000000000000001 R12: =
0000000000000030
> [=C2=A0 732.877002] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
> [=C2=A0 732.877002] FS:=C2=A0 00007f0e22699740(0000) GS:ffff88007fc00=
000(0000) knlGS:00000000f6f51700
> [=C2=A0 732.877002] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800=
5003b
> [=C2=A0 732.877002] CR2: ffff88007fc03f58 CR3: 000000007b74b000 CR4: =
00000000000007f0
> [=C2=A0 732.877002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [=C2=A0 732.877002] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: =
0000000000000400
> [=C2=A0 732.877002] Process swapper/0 (pid: 0, threadinfo ffffffff820=
00000, task ffffffff82013440)
> [=C2=A0 732.877002] Stack:
> [=C2=A0 732.877002]=C2=A0 0000000000000000 ffff88007fc03f78 ffffffff8=
1003be2 ffff88007fc03f78
> [=C2=A0 732.877002]=C2=A0 ffffffff82001e58 ffff88007fc03fa8 ffffffff8=
1b18f3a ffffffff82001fd8
> [=C2=A0 732.877002]=C2=A0 0000000000000000 ffffffff821572c0 ffff88007=
ff7d8c0 ffffffff82001f18
> [=C2=A0 732.877002] Call Trace:
> [=C2=A0 732.877002]=C2=A0 <IRQ>=20
> [=C2=A0 732.877002]=C2=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
> [=C2=A0 732.877002]=C2=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
> [=C2=A0 732.877002]=C2=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x6=
7/0x67
> [=C2=A0 732.877002]=C2=A0 <EOI>=20
> [=C2=A0 732.877002]=C2=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x=
1b0
> [=C2=A0 732.877002]=C2=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
> [=C2=A0 732.877002]=C2=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
> [=C2=A0 732.877002]=C2=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0=
x399
> [=C2=A0 732.877002]=C2=A0 [<ffffffff8210d60d>] ? repair_env_string+0x=
5e/0x5e
> [=C2=A0 732.877002]=C2=A0 [<ffffffff8210d32d>] ? x86_64_start_reserva=
tions+0x131/0x135
> [=C2=A0 732.877002]=C2=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+=
0xd8/0xdc
> [=C2=A0 732.877002] Code: 88 ff ff 10 00 00 00 00 00 00 00 46 00 01 0=
0 00 00 00 00 50 3f c0 7f 00 88 ff ff 18 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 <78> 3f c0 7f 00 88 ff ff e2 3b 00 81 ff ff ff ff 78 3f =
c0 7f 00=20
> [=C2=A0 732.877002] RIP=C2=A0 [<ffff88007fc03f58>] 0xffff88007fc03f57
> [=C2=A0 732.877002]=C2=A0 RSP <ffff88007fc03f50>
> [=C2=A0 732.877002] CR2: ffff88007fc03f58
> [=C2=A0 732.877002] ---[ end trace 4f43a25a3497d19e ]---
> [=C2=A0 732.877002] Kernel panic - not syncing: Fatal exception in in=
terrupt
> [=C2=A0 732.877002] panic occurred, switching back to text console
> [=C2=A0 732.877002] Rebooting in 10 seconds..[=C2=A0=C2=A0 85.609447]=
 kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> [=C2=A0=C2=A0 85.610428] BUG: unable to handle kernel paging request =
at ffff88007fc03f58
> [=C2=A0=C2=A0 85.610428] IP: [<ffff88007fc03f58>] 0xffff88007fc03f57
> [=C2=A0=C2=A0 85.610428] PGD 200c063 PUD 1fbfd067 PMD 800000007fc001e=
3=20
> [=C2=A0=C2=A0 85.610428] Oops: 0011 [#1] SMP=20
> [=C2=A0=C2=A0 85.610428] CPU 0=20
> [=C2=A0=C2=A0 85.610428] Modules linked in:[=C2=A0=C2=A0 85.610428]=C2=
=A0 netconsole snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd=
_pcm_oss snd_mixer_oss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle =
iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptabl=
e_filter ip_tables x_tables lp fuse nouveau mxm_wmi snd_via82xx snd_ac9=
7_codec snd_mpu401_uart snd_rawmidi wmi video ttm drm_kms_helper drm i2=
c_algo_bit snd_seq_device snd_pcm snd_page_alloc shpchp amd64_agp ppdev=
 snd_timer snd soundcore ac97_bus gameport i2c_viapro agpgart parport_p=
c skge i2c_core evdev parport k8temp button mperf freq_table processor =
thermal_sys hwmon loop
>=20
> [=C2=A0=C2=A0 85.610428] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2=
 To Be Filled By O.E.M. To Be Filled By O.E.M./A8V Deluxe
> [=C2=A0=C2=A0 85.610428] RIP: 0010:[<ffff88007fc03f58>]=C2=A0 [<ffff8=
8007fc03f58>] 0xffff88007fc03f57
> [=C2=A0=C2=A0 85.610428] RSP: 0018:ffff88007fc03f50=C2=A0 EFLAGS: 000=
10046
> [=C2=A0=C2=A0 85.610428] RAX: 000000000000f6f6 RBX: ffff88007f807000 =
RCX: ffff88007d000018
> [=C2=A0=C2=A0 85.610428] RDX: 00000000000000f6 RSI: ffff88007f807000 =
RDI: ffff88007f807084
> [=C2=A0=C2=A0 85.610428] RBP: ffffffff810b99ed R08: 0000000000000000 =
R09: ffff88007d000000
> [=C2=A0=C2=A0 85.610428] R10: 0000000000000002 R11: 0000000000000001 =
R12: 0000000000000030
> [=C2=A0=C2=A0 85.610428] R13: 0000000000000000 R14: 0000000000000000 =
R15: 0000000000000000
> [=C2=A0=C2=A0 85.610428] FS:=C2=A0 00007f5f133f9740(0000) GS:ffff8800=
7fc00000(0000) knlGS:00000000f6f7b700
> [=C2=A0=C2=A0 85.610428] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000=
008005003b
> [=C2=A0=C2=A0 85.610428] CR2: ffff88007fc03f58 CR3: 000000007b24e000 =
CR4: 00000000000007f0
> [=C2=A0=C2=A0 85.610428] DR0: 0000000000000000 DR1: 0000000000000000 =
DR2: 0000000000000000
> [=C2=A0=C2=A0 85.610428] DR3: 0000000000000000 DR6: 00000000ffff0ff0 =
DR7: 0000000000000400
> [=C2=A0=C2=A0 85.610428] Process swapper/0 (pid: 0, threadinfo ffffff=
ff82000000, task ffffffff82013440)
> [=C2=A0=C2=A0 85.610428] Stack:
> [=C2=A0=C2=A0 85.610428]=C2=A0 0000000000000000 ffff88007fc03f78 ffff=
ffff81003be2 ffff88007fc03f78
> [=C2=A0=C2=A0 85.610428]=C2=A0 ffffffff82001e58 ffff88007fc03fa8 ffff=
ffff81b18f3a ffffffff82001fd8
> [=C2=A0=C2=A0 85.610428]=C2=A0 0000000000000000 ffffffff821572c0 ffff=
88007ff7d8c0 ffffffff82001f18
> [=C2=A0=C2=A0 85.610428] Call Trace:
> [=C2=A0=C2=A0 85.610428]=C2=A0 <IRQ>=20
> [=C2=A0=C2=A0 85.610428]=C2=A0 [<ffffffff81003be2>] ? handle_irq+0x22=
/0x40
> [=C2=A0=C2=A0 85.610428]=C2=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe=
0
> [=C2=A0=C2=A0 85.610428]=C2=A0 [<ffffffff81b16ea7>] ? common_interrup=
t+0x67/0x67
> [=C2=A0=C2=A0 85.610428]=C2=A0 <EOI>=20
> [=C2=A0=C2=A0 85.610428]=C2=A0 [<ffffffff8100a6fa>] ? default_idle+0x=
5a/0x1b0
> [=C2=A0=C2=A0 85.610428]=C2=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/=
0x120
> [=C2=A0=C2=A0 85.610428]=C2=A0 [<ffffffff81ace029>] ? rest_init+0x6d/=
0x74
> [=C2=A0=C2=A0 85.610428]=C2=A0 [<ffffffff8210db9a>] ? start_kernel+0x=
38c/0x399
> [=C2=A0=C2=A0 85.610428]=C2=A0 [<ffffffff8210d60d>] ? repair_env_stri=
ng+0x5e/0x5e
> [=C2=A0=C2=A0 85.610428]=C2=A0 [<ffffffff8210d32d>] ? x86_64_start_re=
servations+0x131/0x135
> [=C2=A0=C2=A0 85.610428]=C2=A0 [<ffffffff8210d409>] ? x86_64_start_ke=
rnel+0xd8/0xdc
> [=C2=A0=C2=A0 85.610428] Code: 88 ff ff 10 00 00 00 00 00 00 00 46 00=
 01 00 00 00 00 00 50 3f c0 7f 00 88 ff ff 18 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 <78> 3f c0 7f 00 88 ff ff e2 3b 00 81 ff ff ff ff 7=
8 3f c0 7f 00=20
> [=C2=A0=C2=A0 85.610428] RIP=C2=A0 [<ffff88007fc03f58>] 0xffff88007fc=
03f57
> [=C2=A0=C2=A0 85.610428]=C2=A0 RSP <ffff88007fc03f50>
> [=C2=A0=C2=A0 85.610428] CR2: ffff88007fc03f58
> [=C2=A0=C2=A0 85.610428] ---[ end trace efa90d0be322bd86 ]---
> [=C2=A0=C2=A0 85.610428] Kernel panic - not syncing: Fatal exception =
in interrupt
> [=C2=A0=C2=A0 85.610428] panic occurred, switching back to text conso=
le
> [=C2=A0=C2=A0 85.610428] Rebooting in 10 seconds..[=C2=A0=C2=A0 40.40=
2985] REISERFS warning (device sda1): clm-6006 reiserfs_dirty_inode: wr=
iting inode 347717 on readonly FS
> [=C2=A0=C2=A0 40.806320] REISERFS warning (device sda1): clm-6006 rei=
serfs_dirty_inode: writing inode 347740 on readonly FS
> [=C2=A0=C2=A0 41.285850] REISERFS warning (device sda1): clm-6006 rei=
serfs_dirty_inode: writing inode 426162 on readonly FS
> [=C2=A0 914.400057] [drm] nouveau 0000:01:00.0: Setting dpms mode 1 o=
n vga encoder (output 0)
> [ 2005.919969] BUG: unable to handle kernel paging request at fffffff=
f81006020
> [ 2005.920951] IP: [<ffffffff81b16c80>] _raw_spin_trylock_bh+0x50/0x5=
0
> [ 2005.920951] PGD 200d067 PUD 2011063 PMD 10001e1=20
> [ 2005.920951] Oops: 0003 [#1] SMP=20
> [ 2005.920951] CPU 0=20
> [ 2005.920951] Modules linked in:[ 2005.920951]=C2=A0 netconsole snd_=
seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_=
oss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat =
nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables =
x_tables lp fuse nouveau mxm_wmi wmi video ttm drm_kms_helper drm mperf=
 freq_table snd_via82xx snd_ac97_codec snd_mpu401_uart snd_rawmidi snd_=
seq_device snd_pcm snd_page_alloc snd_timer snd soundcore ac97_bus game=
port amd64_agp agpgart i2c_algo_bit ppdev processor thermal_sys skge sh=
pchp parport_pc parport i2c_viapro i2c_core k8temp hwmon evdev button l=
oop
>=20
> [ 2005.920951] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
> [ 2005.920951] RIP: 0010:[<ffffffff81b16c80>]=C2=A0 [<ffffffff81b16c8=
0>] _raw_spin_trylock_bh+0x50/0x50
> [ 2005.920951] RSP: 0018:ffff88007fc03f10=C2=A0 EFLAGS: 00010086
> [ 2005.920951] RAX: ffffffff81006020 RBX: 0000000000000001 RCX: 00000=
00000000000
> [ 2005.920951] RDX: ffffffff82014da0 RSI: ffff88007f807000 RDI: fffff=
fff821db4d0
> [ 2005.920951] RBP: ffff88007fc03f38 R08: 0000000000000000 R09: ffff8=
8007d000000
> [ 2005.920951] R10: 0000000000000002 R11: 0000000000000001 R12: 00000=
00000000000
> [ 2005.920951] R13: 0000000000000000 R14: 0000000000000000 R15: 00000=
00000000000
> [ 2005.920951] FS:=C2=A0 00007feddb139740(0000) GS:ffff88007fc00000(0=
000) knlGS:00000000f6fde700
> [ 2005.920951] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [ 2005.920951] CR2: ffffffff81006020 CR3: 000000007b556000 CR4: 00000=
000000007f0
> [ 2005.920951] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> [ 2005.920951] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
> [ 2005.920951] Process swapper/0 (pid: 0, threadinfo ffffffff82000000=
, task ffffffff82013440)
> [ 2005.920951] Stack:
> [ 2005.920951]=C2=A0 ffffffff81006052 ffff88007fc03f58 ffff88007f8070=
00 0000000000000030
> [ 2005.920951]=C2=A0 0000000000000000 ffff88007fc03f58 ffffffff810b99=
ff ffff88007fc03f58
> [ 2005.920951]=C2=A0 0000000000000000 ffff88007fc03f78 ffffffff81003b=
e2 ffff88007fc03f78
> [ 2005.920951] Call Trace:
> [ 2005.920951]=C2=A0 <IRQ>=20
> [ 2005.920951]=C2=A0 [<ffffffff81006052>] ? mask_and_ack_8259A+0x32/0=
x110
> [ 2005.920951]=C2=A0 [<ffffffff810b99ff>] handle_level_irq+0x2f/0xc0
> [ 2005.920951]=C2=A0 [<ffffffff81003be2>] handle_irq+0x22/0x40
> [ 2005.920951]=C2=A0 [<ffffffff81b18f3a>] do_IRQ+0x5a/0xe0
> [ 2005.920951]=C2=A0 [<ffffffff81b16ea7>] common_interrupt+0x67/0x67
> [ 2005.920951]=C2=A0 <EOI>=20
> [ 2005.920951]=C2=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
> [ 2005.920951]=C2=A0 [<ffffffff8100b4f6>] cpu_idle+0x106/0x120
> [ 2005.920951]=C2=A0 [<ffffffff81ace029>] rest_init+0x6d/0x74
> [ 2005.920951]=C2=A0 [<ffffffff8210db9a>] start_kernel+0x38c/0x399
> [ 2005.920951]=C2=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x=
5e
> [ 2005.920951]=C2=A0 [<ffffffff8210d32d>] x86_64_start_reservations+0=
x131/0x135
> [ 2005.920951]=C2=A0 [<ffffffff8210d409>] x86_64_start_kernel+0xd8/0x=
dc
> [ 2005.920951] Code: ff 48 83 c4 08 31 c0 5b 5d c3 90 8d 8a 00 01 00 =
00 89 d0 3e 66 0f b1 0b 66 39 d0 75 db 48 83 c4 08 b8 01 00 00 00 5b 5d=
 c3 66 90 <55> 48 89 e5 66 66 66 66 90 9c 58 fa ba 00 01 00 00 3e 66 0f=
 c1=20
> [ 2005.920951] RIP=C2=A0 [<ffffffff81b16c80>] _raw_spin_trylock_bh+0x=
50/0x50
> [ 2005.920951]=C2=A0 RSP <ffff88007fc03f10>
> [ 2005.920951] CR2: ffffffff81006020
> [ 2005.920951] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga=
 encoder (output 0)
> [ 2005.920951] ---[ end trace df411da47382bb20 ]---
> [ 2005.920951] Kernel panic - not syncing: Fatal exception in interru=
pt
> [ 2005.920951] panic occurred, switching back to text console
> [ 2005.920951] Rebooting in 10 seconds..
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Regards/Gruss,
    Boris.
