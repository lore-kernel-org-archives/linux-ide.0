From: Adko Branil <adkobranil@yahoo.com>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Sat, 25 Aug 2012 06:36:11 -0700 (PDT)
Message-ID: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com>
Reply-To: Adko Branil <adkobranil@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm29-vm2.bullet.mail.ne1.yahoo.com ([98.138.91.129]:24529 "HELO
	nm29-vm2.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751282Ab2HYNgN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Aug 2012 09:36:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Here i post few more panics, the last 3-4 or 5 of them are with boot op=
tion "nosmp".=A0I will take a look at the motherboard to see is there a=
ny visual sign for this plague after 2 days probably, as i am no near t=
o that machine now.

Thanks for the answers Felix and Boris !


[36291.085760] Pid: 0, comm: swapper/1 Not tainted 3.5.2 #2 To Be Fille=
d By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[36291.240016] RIP: 0010:[<ffffffff810759c9>]=A0 [<ffffffff810759c9>] s=
elect_task_rq_idle+0x9/0x20
[36291.240016] RSP: 0018:ffff88007fd03f10=A0 EFLAGS: 00010046
[36291.240016] RAX: 0000000000000004 RBX: ffff88007fd0d780 RCX: 0000000=
000000000
[36291.240016] RDX: 00002101ad3ae230 RSI: ffff88007fd0d780 RDI: 0000000=
000000000
[36291.240016] RBP: 000000007fd03f10 R08: 0000000000000000 R09: 0000000=
000000000
[36291.240016] R10: ffffffff81049091 R11: 0000000000000001 R12: ffff880=
07fd0d780
[36291.240016] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
[36291.240016] FS:=A0 00007f1857041740(0000) GS:ffff88007fd00000(0000) =
knlGS:00000000f6fb6700
[36291.240016] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[36291.240016] CR2: 0000000000000008 CR3: 000000007436c000 CR4: 0000000=
0000007e0
[36291.240016] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[36291.240016] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[36291.240016] Process swapper/1 (pid: 0, threadinfo ffff88007c516000, =
task ffff88007d0528e0)
[36291.240016] Stack:
[36291.240016]=A0 ffffffff81091237 ffff88007fd03f68 00002101ad3ae230 ff=
ff88007fd03f68
[36291.240016]=A0 0000000000000001 0000000000000000 0000000000000000 ff=
ff88007fd03f88
[36291.240016] Call Trace:
[36291.240016]=A0 <IRQ>=A0 [<ffffffff81090d4e>] ? tick_nohz_stop_idle+0=
x3e/0x50
[36291.240016]=A0 [<ffffffff81091237>] ? tick_check_idle+0xb7/0xd0
[36291.240016]=A0 [<ffffffff81049091>] ? irq_enter+0x71/0x80
[36291.240016]=A0 [<ffffffff81b18ffe>] ? smp_apic_timer_interrupt+0x3e/=
0x99
[36291.240016]=A0 [<ffffffff81b18147>] ? apic_timer_interrupt+0x67/0x70
[36291.240016]=A0 <EOI>=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1=
b0
[36291.240016]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[36291.240016]=A0 [<ffffffff81afcd19>] ? start_secondary+0x1d8/0x1df
[36291.240016] Code: 00 00 8b 3d 9a e6 07 01 85 ff 74 06 f3 c3 0f 1f 40=
 00 55 48 89 e5 e8 57 ff ff ff 5d c3 0f 1f 44 00 00 55 48 89 e5 66 66 6=
6 66 90 <48> 8b 47 08 5d 8b 40 18 c3 66 66 66 66 66 2e 0f 1f 84 00 00 0=
0=20
[36291.240016] RIP=A0 [<ffffffff810759c9>] select_task_rq_idle+0x9/0x20
[36291.240016]=A0 RSP <ffff88007fd03f10>
[36291.240016] CR2: 0000000000000008
[36291.240016] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga e=
ncoder (output 0)
[36291.240016]=A0 ffffffff81090d4e 000000000000d780 ffff88007fd0d780 ff=
ff88007fd03f68
[36291.287884] ---[ end trace 617ca3727df8933f ]---
[36291.287884] Kernel panic - not syncing: Fatal exception in interrupt
[36291.287884] panic occurred, switching back to text console
[36291.287884] Rebooting in 10 seconds..[=A0 934.880051] [drm] nouveau =
0000:01:00.0: Setting dpms mode 1 on vga encoder (output 0)
[ 2721.605648] REISERFS warning (device sda1): clm-6006 reiserfs_dirty_=
inode: writing inode 347717 on readonly FS
[ 2721.983935] REISERFS warning (device sda1): clm-6006 reiserfs_dirty_=
inode: writing inode 347740 on readonly FS
[ 2722.505205] REISERFS warning (device sda1): clm-6006 reiserfs_dirty_=
inode: writing inode 426162 on readonly FS
[=A0 168.840543] kernel tried to execute NX-protected page - exploit at=
tempt? (uid: 0)
[=A0 168.841525] BUG: unable to handle kernel paging request at ffff880=
07fc03e98
[=A0 168.841525] IP: [<ffff88007fc03e98>] 0xffff88007fc03e97
[=A0 168.841525] PGD 200c063 PUD 1fbfd067 PMD 800000007fc001e3=20
[=A0 168.841525] Oops: 0011 [#1] SMP=20
[=A0 168.841525] CPU 0=20
[=A0 168.841525] Modules linked in:[=A0 168.841525]=A0 netconsole snd_s=
eq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_o=
ss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat n=
f_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x=
_tables lp fuse nouveau mxm_wmi wmi mperf video processor ttm drm_kms_h=
elper drm freq_table thermal_sys i2c_viapro i2c_algo_bit snd_via82xx sn=
d_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm snd_pag=
e_alloc i2c_core k8temp amd64_agp agpgart shpchp hwmon ppdev snd_timer =
snd soundcore ac97_bus gameport skge evdev button parport_pc parport lo=
op

[=A0 168.841525] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[=A0 168.841525] RIP: 0010:[<ffff88007fc03e98>]=A0 [<ffff88007fc03e98>]=
 0xffff88007fc03e97
[=A0 168.841525] RSP: 0018:ffff88007fc03e80=A0 EFLAGS: 00010006
[=A0 168.841525] RAX: 000000007fc03e78 RBX: 000000000000001b RCX: 00000=
00000000008
[=A0 168.841525] RDX: 000000007fc03e78 RSI: 000000005038995a RDI: ffff8=
8007fc03e78
[=A0 168.841525] RBP: ffffffff81088daa R08: 00000000172f91a8 R09: 00172=
f91a9000000
[=A0 168.841525] R10: 000000000080ffad R11: 0000000000000001 R12: 00000=
00013c00700
[=A0 168.841525] R13: 000000000013c007 R14: 0000000000000360 R15: 00000=
0000000001b
[=A0 168.841525] FS:=A0 00007f91bbfd7740(0000) GS:ffff88007fc00000(0000=
) knlGS:00000000f6f76700
[=A0 168.841525] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[=A0 168.841525] CR2: ffff88007fc03e98 CR3: 000000007b557000 CR4: 00000=
000000007f0
[=A0 168.841525] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
[=A0 168.841525] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
[=A0 168.841525] Process swapper/0 (pid: 0, threadinfo ffffffff82000000=
, task ffffffff82013440)
[=A0 168.841525] Stack:
[=A0 168.841525]=A0 ffffffff8108a3c0 ffff88007fc03e98 ffffffff81088e62 =
ffff88007fc03ef8
[=A0 168.841525]=A0 ffffffff81089dce ffff88007fc12b80 ffff88007fc12b80 =
00000000cc022746
[=A0 168.841525]=A0 0000000000000012 ffff88007fc03ee8 0000000001a40288 =
0000000000000000
[=A0 168.841525] Call Trace:
[=A0 168.841525]=A0 <IRQ>=20
[=A0 168.841525]=A0 [<ffffffff8108a3c0>] ? ntp_tick_length+0x30/0x40
[=A0 168.841525]=A0 [<ffffffff81088e62>] ? timekeeping_update+0x22/0x50
[=A0 168.841525]=A0 [<ffffffff81089dce>] ? do_timer+0x2de/0x550
[=A0 168.841525]=A0 [<ffffffff810906c7>] ? tick_do_update_jiffies64+0x7=
7/0xc0
[=A0 168.841525]=A0 [<ffffffff81091214>] ? tick_check_idle+0x94/0xd0
[=A0 168.841525]=A0 [<ffffffff81049091>] ? irq_enter+0x71/0x80
[=A0 168.841525]=A0 [<ffffffff81b18f1e>] ? do_IRQ+0x3e/0xe0
[=A0 168.841525]=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x67
[=A0 168.841525]=A0 <EOI>=20
[=A0 168.841525]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[=A0 168.841525]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[=A0 168.841525]=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
[=A0 168.841525]=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
[=A0 168.841525]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[=A0 168.841525]=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations+0x=
131/0x135
[=A0 168.841525]=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/0xd=
c
[=A0 168.841525] Code: 00 00 00 80 3e c0 7f 00 88 ff ff 18 00 00 00 00 =
00 00 00 c0 a3 08 81 ff ff ff ff 98 3e c0 7f 00 88 ff ff 62 8e 08 81 ff=
 ff ff ff <f8> 3e c0 7f 00 88 ff ff ce 9d 08 81 ff ff ff ff 80 2b c1 7f=
 00=20
[=A0 168.841525] RIP=A0 [<ffff88007fc03e98>] 0xffff88007fc03e97
[=A0 168.841525]=A0 RSP <ffff88007fc03e80>
[=A0 168.841525] CR2: ffff88007fc03e98
[=A0 168.841525] ---[ end trace 197aa6de17869ba9 ]---
[=A0 168.841525] Kernel panic - not syncing: Fatal exception in interru=
pt
[=A0 168.841525] panic occurred, switching back to text console
[=A0 168.841525] Rebooting in 10 seconds..[=A0 170.456024] BUG: unable =
to handle kernel paging request at ffffffff2bbc4800
[=A0 170.457007] IP: [<ffffffff81047810>] mktime+0xc0/0xc0
[=A0 170.457007] PGD 200d067 PUD 0=20
[=A0 170.457007] Oops: 0002 [#1] SMP=20
[=A0 170.457007] CPU 0=20
[=A0 170.457007] Modules linked in:[=A0 170.457007]=A0 netconsole snd_s=
eq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_o=
ss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat n=
f_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x=
_tables lp fuse nouveau mxm_wmi mperf wmi processor video snd_via82xx t=
tm drm_kms_helper drm i2c_algo_bit snd_ac97_codec snd_mpu401_uart snd_r=
awmidi snd_seq_device snd_pcm snd_page_alloc snd_timer snd soundcore sh=
pchp evdev i2c_viapro amd64_agp ac97_bus agpgart ppdev freq_table therm=
al_sys skge parport_pc parport button gameport i2c_core k8temp hwmon lo=
op

[=A0 170.457007] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[=A0 170.457007] RIP: 0010:[<ffffffff81047810>]=A0 [<ffffffff81047810>]=
 mktime+0xc0/0xc0
[=A0 170.457007] RSP: 0018:ffff88007fc03e70=A0 EFLAGS: 00010013
[=A0 170.457007] RAX: ffffffff2bbc4800 RBX: 0000000000000020 RCX: 00000=
00000000008
[=A0 170.457007] RDX: ffffffffca1b2166 RSI: 0000000050389a37 RDI: ffff8=
8007fc03e78
[=A0 170.457007] RBP: ffff88007fc03e88 R08: 0000000020d77f47 R09: 0020d=
77f48000000
[=A0 170.457007] R10: 000000000080ffad R11: 0000000000000001 R12: 00000=
0000374ffa0
[=A0 170.457007] R13: 00000000001ba7fd R14: 00000000be97e000 R15: 00000=
00000000008
[=A0 170.457007] FS:=A0 00007fe879ee9740(0000) GS:ffff88007fc00000(0000=
) knlGS:00000000f6fcb700
[=A0 170.457007] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[=A0 170.457007] CR2: ffffffff2bbc4800 CR3: 000000007b53c000 CR4: 00000=
000000007f0
[=A0 170.457007] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
[=A0 170.457007] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
[=A0 170.457007] Process swapper/0 (pid: 0, threadinfo ffffffff82000000=
, task ffffffff82013440)
[=A0 170.457007] Stack:
[=A0 170.457007]=A0 ffffffff81088daa ffff88007fc03e98 ffffffff8108a3c0 =
ffff88007fc03e98
[=A0 170.457007]=A0 ffffffff81088e62 ffff88007fc03ef8 ffffffff81089dce =
ffff88007fc12b80
[=A0 170.457007]=A0 ffff88007fc12b80 00000000214310aa 0000000000000002 =
ffff88007fc03ee8
[=A0 170.457007] Call Trace:
[=A0 170.457007]=A0 <IRQ>=20
[=A0 170.457007]=A0 [<ffffffff81088daa>] ? update_rt_offset+0x2a/0x60
[=A0 170.457007]=A0 [<ffffffff8108a3c0>] ? ntp_tick_length+0x30/0x40
[=A0 170.457007]=A0 [<ffffffff81088e62>] timekeeping_update+0x22/0x50
[=A0 170.457007]=A0 [<ffffffff81089dce>] do_timer+0x2de/0x550
[=A0 170.457007]=A0 [<ffffffff810906c7>] tick_do_update_jiffies64+0x77/=
0xc0
[=A0 170.457007]=A0 [<ffffffff81091214>] tick_check_idle+0x94/0xd0
[=A0 170.457007]=A0 [<ffffffff81049091>] irq_enter+0x71/0x80
[=A0 170.457007]=A0 [<ffffffff81b18f1e>] do_IRQ+0x3e/0xe0
[=A0 170.457007]=A0 [<ffffffff81b16ea7>] common_interrupt+0x67/0x67
[=A0 170.457007]=A0 <EOI>=20
[=A0 170.457007]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[=A0 170.457007]=A0 [<ffffffff8100b4f6>] cpu_idle+0x106/0x120
[=A0 170.457007]=A0 [<ffffffff81ace029>] rest_init+0x6d/0x74
[=A0 170.457007]=A0 [<ffffffff8210db9a>] start_kernel+0x38c/0x399
[=A0 170.457007]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[=A0 170.457007]=A0 [<ffffffff8210d32d>] x86_64_start_reservations+0x13=
1/0x135
[=A0 170.457007]=A0 [<ffffffff8210d409>] x86_64_start_kernel+0xd8/0xdc
[=A0 170.457007] Code: 48 29 c2 4c 01 c2 48 8d 04 95 00 00 00 00 49 89 =
d0 49 c1 e0 06 49 29 c0 4b 8d 04 03 c3 66 66 66 66 66 2e 0f 1f 84 00 00=
 00 00 00 <55> 48 89 e5 66 66 66 66 90 48 81 fa ff c9 9a 3b 7e 19 66 0f=
 1f=20
[=A0 170.457007] RIP=A0 [<ffffffff81047810>] mktime+0xc0/0xc0
[=A0 170.457007]=A0 RSP <ffff88007fc03e70>
[=A0 170.457007] CR2: ffffffff2bbc4800
[=A0 170.457007] ---[ end trace fb5b43f93a914e0c ]---
[=A0 170.457007] Kernel panic - not syncing: Fatal exception in interru=
pt
[=A0 170.457007] panic occurred, switching back to text console
[=A0 170.457007] Rebooting in 10 seconds..[=A0 914.400054] [drm] nouvea=
u 0000:01:00.0: Setting dpms mode 1 on vga encoder (output 0)
[ 1740.272749] kernel tried to execute NX-protected page - exploit atte=
mpt? (uid: 0)
[ 1740.273732] BUG: unable to handle kernel paging request at ffff88007=
fc03f58
[ 1740.273732] IP: [<ffff88007fc03f58>] 0xffff88007fc03f57
[ 1740.273732] PGD 200c063 PUD 1fbfd067 PMD 800000007fc001e3=20
[ 1740.273732] Oops: 0011 [#1] SMP=20
[ 1740.273732] CPU 0=20
[ 1740.273732] Modules linked in:[ 1740.273732]=A0 netconsole snd_seq_d=
ummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss i=
pt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat nf_co=
nntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x_tab=
les lp fuse nouveau mxm_wmi snd_via82xx wmi video ttm drm_kms_helper sn=
d_ac97_codec drm i2c_viapro i2c_algo_bit mperf processor amd64_agp freq=
_table snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm snd_page_allo=
c snd_timer snd soundcore thermal_sys k8temp hwmon agpgart ppdev shpchp=
 ac97_bus skge i2c_core gameport evdev button parport_pc parport loop

[ 1740.273732] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fille=
d By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[ 1740.273732] RIP: 0010:[<ffff88007fc03f58>]=A0 [<ffff88007fc03f58>] 0=
xffff88007fc03f57
[ 1740.273732] RSP: 0018:ffff88007fc03f50=A0 EFLAGS: 00010046
[ 1740.273732] RAX: 0000000000005454 RBX: ffff88007f807000 RCX: ffff880=
07d000018
[ 1740.273732] RDX: 0000000000000054 RSI: ffff88007f807000 RDI: ffff880=
07f807084
[ 1740.273732] RBP: ffffffff810b99ed R08: 0000000000000000 R09: ffff880=
07d000000
[ 1740.273732] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000=
000000030
[ 1740.273732] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
[ 1740.273732] FS:=A0 00007f81a4a93740(0000) GS:ffff88007fc00000(0000) =
knlGS:00000000f6f37700
[ 1740.273732] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1740.273732] CR2: ffff88007fc03f58 CR3: 000000007b545000 CR4: 0000000=
0000007f0
[ 1740.273732] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[ 1740.273732] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[ 1740.273732] Process swapper/0 (pid: 0, threadinfo ffffffff82000000, =
task ffffffff82013440)
[ 1740.273732] Stack:
[ 1740.273732]=A0 0000000000000000 ffff88007fc03f78 ffffffff81003be2 ff=
ff88007fc03f78
[ 1740.273732]=A0 ffffffff82001e58 ffff88007fc03fa8 ffffffff81b18f3a ff=
ffffff82001fd8
[ 1740.273732]=A0 0000000000000000 ffffffff821572c0 ffff88007ff7d8c0 ff=
ffffff82001f18
[ 1740.273732] Call Trace:
[ 1740.273732]=A0 <IRQ>=20
[ 1740.273732]=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
[ 1740.273732]=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
[ 1740.273732]=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x67
[ 1740.273732]=A0 <EOI>=20
[ 1740.273732]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[ 1740.273732]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[ 1740.273732]=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
[ 1740.273732]=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
[ 1740.273732]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[ 1740.273732]=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations+0x13=
1/0x135
[ 1740.273732]=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/0xdc
[ 1740.273732] Code: 88 ff ff 10 00 00 00 00 00 00 00 46 00 01 00 00 00=
 00 00 50 3f c0 7f 00 88 ff ff 18 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 <78> 3f c0 7f 00 88 ff ff e2 3b 00 81 ff ff ff ff 78 3f c0 7f 0=
0=20
[ 1740.273732] RIP=A0 [<ffff88007fc03f58>] 0xffff88007fc03f57
[ 1740.273732]=A0 RSP <ffff88007fc03f50>
[ 1740.273732] CR2: ffff88007fc03f58
[ 1740.273732] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga e=
ncoder (output 0)
[ 1740.273732] ---[ end trace 66512b2a64d236e7 ]---
[ 1740.273732] Kernel panic - not syncing: Fatal exception in interrupt
[ 1740.273732] panic occurred, switching back to text console
[ 1740.273732] Rebooting in 10 seconds..[=A0 732.876020] kernel tried t=
o execute NX-protected page - exploit attempt? (uid: 0)
[=A0 732.877002] BUG: unable to handle kernel paging request at ffff880=
07fc03f58
[=A0 732.877002] IP: [<ffff88007fc03f58>] 0xffff88007fc03f57
[=A0 732.877002] PGD 200c063 PUD 1fbfd067 PMD 800000007fc001e3=20
[=A0 732.877002] Oops: 0011 [#1] SMP=20
[=A0 732.877002] CPU 0=20
[=A0 732.877002] Modules linked in:[=A0 732.877002]=A0 netconsole snd_s=
eq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_o=
ss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat n=
f_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x=
_tables lp fuse snd_via82xx snd_ac97_codec snd_mpu401_uart snd_rawmidi =
snd_seq_device snd_pcm snd_page_alloc snd_timer snd soundcore ac97_bus =
gameport nouveau mxm_wmi wmi video ttm drm_kms_helper drm mperf i2c_alg=
o_bit amd64_agp processor freq_table shpchp thermal_sys i2c_viapro agpg=
art evdev i2c_core k8temp hwmon ppdev button skge parport_pc parport lo=
op

[=A0 732.877002] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[=A0 732.877002] RIP: 0010:[<ffff88007fc03f58>]=A0 [<ffff88007fc03f58>]=
 0xffff88007fc03f57
[=A0 732.877002] RSP: 0018:ffff88007fc03f50=A0 EFLAGS: 00010046
[=A0 732.877002] RAX: 000000000000a2a2 RBX: ffff88007f807000 RCX: ffff8=
8007d000018
[=A0 732.877002] RDX: 00000000000000a2 RSI: ffff88007f807000 RDI: ffff8=
8007f807084
[=A0 732.877002] RBP: ffffffff810b99ed R08: 0000000000000000 R09: ffff8=
8007d000000
[=A0 732.877002] R10: 0000000000000002 R11: 0000000000000001 R12: 00000=
00000000030
[=A0 732.877002] R13: 0000000000000000 R14: 0000000000000000 R15: 00000=
00000000000
[=A0 732.877002] FS:=A0 00007f0e22699740(0000) GS:ffff88007fc00000(0000=
) knlGS:00000000f6f51700
[=A0 732.877002] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[=A0 732.877002] CR2: ffff88007fc03f58 CR3: 000000007b74b000 CR4: 00000=
000000007f0
[=A0 732.877002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
[=A0 732.877002] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
[=A0 732.877002] Process swapper/0 (pid: 0, threadinfo ffffffff82000000=
, task ffffffff82013440)
[=A0 732.877002] Stack:
[=A0 732.877002]=A0 0000000000000000 ffff88007fc03f78 ffffffff81003be2 =
ffff88007fc03f78
[=A0 732.877002]=A0 ffffffff82001e58 ffff88007fc03fa8 ffffffff81b18f3a =
ffffffff82001fd8
[=A0 732.877002]=A0 0000000000000000 ffffffff821572c0 ffff88007ff7d8c0 =
ffffffff82001f18
[=A0 732.877002] Call Trace:
[=A0 732.877002]=A0 <IRQ>=20
[=A0 732.877002]=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
[=A0 732.877002]=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
[=A0 732.877002]=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x67
[=A0 732.877002]=A0 <EOI>=20
[=A0 732.877002]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[=A0 732.877002]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[=A0 732.877002]=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
[=A0 732.877002]=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
[=A0 732.877002]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[=A0 732.877002]=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations+0x=
131/0x135
[=A0 732.877002]=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/0xd=
c
[=A0 732.877002] Code: 88 ff ff 10 00 00 00 00 00 00 00 46 00 01 00 00 =
00 00 00 50 3f c0 7f 00 88 ff ff 18 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 <78> 3f c0 7f 00 88 ff ff e2 3b 00 81 ff ff ff ff 78 3f c0 7f=
 00=20
[=A0 732.877002] RIP=A0 [<ffff88007fc03f58>] 0xffff88007fc03f57
[=A0 732.877002]=A0 RSP <ffff88007fc03f50>
[=A0 732.877002] CR2: ffff88007fc03f58
[=A0 732.877002] ---[ end trace 4f43a25a3497d19e ]---
[=A0 732.877002] Kernel panic - not syncing: Fatal exception in interru=
pt
[=A0 732.877002] panic occurred, switching back to text console
[=A0 732.877002] Rebooting in 10 seconds..[=A0=A0 85.609447] kernel tri=
ed to execute NX-protected page - exploit attempt? (uid: 0)
[=A0=A0 85.610428] BUG: unable to handle kernel paging request at ffff8=
8007fc03f58
[=A0=A0 85.610428] IP: [<ffff88007fc03f58>] 0xffff88007fc03f57
[=A0=A0 85.610428] PGD 200c063 PUD 1fbfd067 PMD 800000007fc001e3=20
[=A0=A0 85.610428] Oops: 0011 [#1] SMP=20
[=A0=A0 85.610428] CPU 0=20
[=A0=A0 85.610428] Modules linked in:[=A0=A0 85.610428]=A0 netconsole s=
nd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mix=
er_oss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_n=
at nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tabl=
es x_tables lp fuse nouveau mxm_wmi snd_via82xx snd_ac97_codec snd_mpu4=
01_uart snd_rawmidi wmi video ttm drm_kms_helper drm i2c_algo_bit snd_s=
eq_device snd_pcm snd_page_alloc shpchp amd64_agp ppdev snd_timer snd s=
oundcore ac97_bus gameport i2c_viapro agpgart parport_pc skge i2c_core =
evdev parport k8temp button mperf freq_table processor thermal_sys hwmo=
n loop

[=A0=A0 85.610428] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be F=
illed By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[=A0=A0 85.610428] RIP: 0010:[<ffff88007fc03f58>]=A0 [<ffff88007fc03f58=
>] 0xffff88007fc03f57
[=A0=A0 85.610428] RSP: 0018:ffff88007fc03f50=A0 EFLAGS: 00010046
[=A0=A0 85.610428] RAX: 000000000000f6f6 RBX: ffff88007f807000 RCX: fff=
f88007d000018
[=A0=A0 85.610428] RDX: 00000000000000f6 RSI: ffff88007f807000 RDI: fff=
f88007f807084
[=A0=A0 85.610428] RBP: ffffffff810b99ed R08: 0000000000000000 R09: fff=
f88007d000000
[=A0=A0 85.610428] R10: 0000000000000002 R11: 0000000000000001 R12: 000=
0000000000030
[=A0=A0 85.610428] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
[=A0=A0 85.610428] FS:=A0 00007f5f133f9740(0000) GS:ffff88007fc00000(00=
00) knlGS:00000000f6f7b700
[=A0=A0 85.610428] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[=A0=A0 85.610428] CR2: ffff88007fc03f58 CR3: 000000007b24e000 CR4: 000=
00000000007f0
[=A0=A0 85.610428] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[=A0=A0 85.610428] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 000=
0000000000400
[=A0=A0 85.610428] Process swapper/0 (pid: 0, threadinfo ffffffff820000=
00, task ffffffff82013440)
[=A0=A0 85.610428] Stack:
[=A0=A0 85.610428]=A0 0000000000000000 ffff88007fc03f78 ffffffff81003be=
2 ffff88007fc03f78
[=A0=A0 85.610428]=A0 ffffffff82001e58 ffff88007fc03fa8 ffffffff81b18f3=
a ffffffff82001fd8
[=A0=A0 85.610428]=A0 0000000000000000 ffffffff821572c0 ffff88007ff7d8c=
0 ffffffff82001f18
[=A0=A0 85.610428] Call Trace:
[=A0=A0 85.610428]=A0 <IRQ>=20
[=A0=A0 85.610428]=A0 [<ffffffff81003be2>] ? handle_irq+0x22/0x40
[=A0=A0 85.610428]=A0 [<ffffffff81b18f3a>] ? do_IRQ+0x5a/0xe0
[=A0=A0 85.610428]=A0 [<ffffffff81b16ea7>] ? common_interrupt+0x67/0x67
[=A0=A0 85.610428]=A0 <EOI>=20
[=A0=A0 85.610428]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[=A0=A0 85.610428]=A0 [<ffffffff8100b4f6>] ? cpu_idle+0x106/0x120
[=A0=A0 85.610428]=A0 [<ffffffff81ace029>] ? rest_init+0x6d/0x74
[=A0=A0 85.610428]=A0 [<ffffffff8210db9a>] ? start_kernel+0x38c/0x399
[=A0=A0 85.610428]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5=
e
[=A0=A0 85.610428]=A0 [<ffffffff8210d32d>] ? x86_64_start_reservations+=
0x131/0x135
[=A0=A0 85.610428]=A0 [<ffffffff8210d409>] ? x86_64_start_kernel+0xd8/0=
xdc
[=A0=A0 85.610428] Code: 88 ff ff 10 00 00 00 00 00 00 00 46 00 01 00 0=
0 00 00 00 50 3f c0 7f 00 88 ff ff 18 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 <78> 3f c0 7f 00 88 ff ff e2 3b 00 81 ff ff ff ff 78 3f c0 =
7f 00=20
[=A0=A0 85.610428] RIP=A0 [<ffff88007fc03f58>] 0xffff88007fc03f57
[=A0=A0 85.610428]=A0 RSP <ffff88007fc03f50>
[=A0=A0 85.610428] CR2: ffff88007fc03f58
[=A0=A0 85.610428] ---[ end trace efa90d0be322bd86 ]---
[=A0=A0 85.610428] Kernel panic - not syncing: Fatal exception in inter=
rupt
[=A0=A0 85.610428] panic occurred, switching back to text console
[=A0=A0 85.610428] Rebooting in 10 seconds..[=A0=A0 40.402985] REISERFS=
 warning (device sda1): clm-6006 reiserfs_dirty_inode: writing inode 34=
7717 on readonly FS
[=A0=A0 40.806320] REISERFS warning (device sda1): clm-6006 reiserfs_di=
rty_inode: writing inode 347740 on readonly FS
[=A0=A0 41.285850] REISERFS warning (device sda1): clm-6006 reiserfs_di=
rty_inode: writing inode 426162 on readonly FS
[=A0 914.400057] [drm] nouveau 0000:01:00.0: Setting dpms mode 1 on vga=
 encoder (output 0)
[ 2005.919969] BUG: unable to handle kernel paging request at ffffffff8=
1006020
[ 2005.920951] IP: [<ffffffff81b16c80>] _raw_spin_trylock_bh+0x50/0x50
[ 2005.920951] PGD 200d067 PUD 2011063 PMD 10001e1=20
[ 2005.920951] Oops: 0003 [#1] SMP=20
[ 2005.920951] CPU 0=20
[ 2005.920951] Modules linked in:[ 2005.920951]=A0 netconsole snd_seq_d=
ummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss i=
pt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat nf_co=
nntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x_tab=
les lp fuse nouveau mxm_wmi wmi video ttm drm_kms_helper drm mperf freq=
_table snd_via82xx snd_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_d=
evice snd_pcm snd_page_alloc snd_timer snd soundcore ac97_bus gameport =
amd64_agp agpgart i2c_algo_bit ppdev processor thermal_sys skge shpchp =
parport_pc parport i2c_viapro i2c_core k8temp hwmon evdev button loop

[ 2005.920951] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #2 To Be Fille=
d By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[ 2005.920951] RIP: 0010:[<ffffffff81b16c80>]=A0 [<ffffffff81b16c80>] _=
raw_spin_trylock_bh+0x50/0x50
[ 2005.920951] RSP: 0018:ffff88007fc03f10=A0 EFLAGS: 00010086
[ 2005.920951] RAX: ffffffff81006020 RBX: 0000000000000001 RCX: 0000000=
000000000
[ 2005.920951] RDX: ffffffff82014da0 RSI: ffff88007f807000 RDI: fffffff=
f821db4d0
[ 2005.920951] RBP: ffff88007fc03f38 R08: 0000000000000000 R09: ffff880=
07d000000
[ 2005.920951] R10: 0000000000000002 R11: 0000000000000001 R12: 0000000=
000000000
[ 2005.920951] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
[ 2005.920951] FS:=A0 00007feddb139740(0000) GS:ffff88007fc00000(0000) =
knlGS:00000000f6fde700
[ 2005.920951] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 2005.920951] CR2: ffffffff81006020 CR3: 000000007b556000 CR4: 0000000=
0000007f0
[ 2005.920951] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[ 2005.920951] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[ 2005.920951] Process swapper/0 (pid: 0, threadinfo ffffffff82000000, =
task ffffffff82013440)
[ 2005.920951] Stack:
[ 2005.920951]=A0 ffffffff81006052 ffff88007fc03f58 ffff88007f807000 00=
00000000000030
[ 2005.920951]=A0 0000000000000000 ffff88007fc03f58 ffffffff810b99ff ff=
ff88007fc03f58
[ 2005.920951]=A0 0000000000000000 ffff88007fc03f78 ffffffff81003be2 ff=
ff88007fc03f78
[ 2005.920951] Call Trace:
[ 2005.920951]=A0 <IRQ>=20
[ 2005.920951]=A0 [<ffffffff81006052>] ? mask_and_ack_8259A+0x32/0x110
[ 2005.920951]=A0 [<ffffffff810b99ff>] handle_level_irq+0x2f/0xc0
[ 2005.920951]=A0 [<ffffffff81003be2>] handle_irq+0x22/0x40
[ 2005.920951]=A0 [<ffffffff81b18f3a>] do_IRQ+0x5a/0xe0
[ 2005.920951]=A0 [<ffffffff81b16ea7>] common_interrupt+0x67/0x67
[ 2005.920951]=A0 <EOI>=20
[ 2005.920951]=A0 [<ffffffff8100a6fa>] ? default_idle+0x5a/0x1b0
[ 2005.920951]=A0 [<ffffffff8100b4f6>] cpu_idle+0x106/0x120
[ 2005.920951]=A0 [<ffffffff81ace029>] rest_init+0x6d/0x74
[ 2005.920951]=A0 [<ffffffff8210db9a>] start_kernel+0x38c/0x399
[ 2005.920951]=A0 [<ffffffff8210d60d>] ? repair_env_string+0x5e/0x5e
[ 2005.920951]=A0 [<ffffffff8210d32d>] x86_64_start_reservations+0x131/=
0x135
[ 2005.920951]=A0 [<ffffffff8210d409>] x86_64_start_kernel+0xd8/0xdc
[ 2005.920951] Code: ff 48 83 c4 08 31 c0 5b 5d c3 90 8d 8a 00 01 00 00=
 89 d0 3e 66 0f b1 0b 66 39 d0 75 db 48 83 c4 08 b8 01 00 00 00 5b 5d c=
3 66 90 <55> 48 89 e5 66 66 66 66 90 9c 58 fa ba 00 01 00 00 3e 66 0f c=
1=20
[ 2005.920951] RIP=A0 [<ffffffff81b16c80>] _raw_spin_trylock_bh+0x50/0x=
50
[ 2005.920951]=A0 RSP <ffff88007fc03f10>
[ 2005.920951] CR2: ffffffff81006020
[ 2005.920951] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga e=
ncoder (output 0)
[ 2005.920951] ---[ end trace df411da47382bb20 ]---
[ 2005.920951] Kernel panic - not syncing: Fatal exception in interrupt
[ 2005.920951] panic occurred, switching back to text console
[ 2005.920951] Rebooting in 10 seconds..

