From: Borislav Petkov <bp@alien8.de>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Thu, 30 Aug 2012 11:58:08 +0200
Message-ID: <20120830095808.GB24680@liondog.tnic>
References: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com>
 <20120826130152.GA20021@liondog.tnic>
 <1346086872.65665.YahooMailNeo@web124704.mail.ne1.yahoo.com>
 <20120827215952.GA18719@liondog.tnic>
 <1346259574.81504.YahooMailNeo@web124706.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:49946 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265Ab2H3J6P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Aug 2012 05:58:15 -0400
Content-Disposition: inline
In-Reply-To: <1346259574.81504.YahooMailNeo@web124706.mail.ne1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>
Cc: Adko Branil <adkobranil@yahoo.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

Ok,

one thing at a time.

Adding Jeff and Mikael.

Guys, I'm leaving in the whole mail thread with all the info.

Right near the end there's a lockdep warning about a deadlock
between sata_promise's hardreset thing and the machine getting a
ata_bmdma_interrupt.

But since I don't know this code, it would be nice if you could take a
look at it.

Kernel is 3.5.2, 32-bit.

Thanks.

On Wed, Aug 29, 2012 at 09:59:34AM -0700, Adko Branil wrote:
> Sorry for the delay, but i have met some difficulties, compiling kern=
el with this options.
>=20
> >You mean 1 Gb each, right?
>=20
> Right, now both banks are installed.
>=20
>=20
> >Ok, judging by the oopses this time, most of them are in handle_irq
> >and "nosmp" disables IO APIC so things start to point at something i=
rq
> >handling related, if I would have to guess.
>=20
> >Hm, ok, can you rebuild that 3.5.2 kernel with the following options
> >enabled:
>=20
> >CONFIG_DEBUG_KERNEL
> >CONFIG_DEBUG_SHIRQ
> >CONFIG_DEBUG_OBJECTS
> >CONFIG_DEBUG_PREEMPT
> >CONFIG_PROVE_LOCKING
> >CONFIG_DEBUG_BUGVERBOSE
> >CONFIG_DEBUG_INFO
> >CONFIG_DEBUG_VM
> >CONFIG_DEBUG_MEMORY_INIT
> >CONFIG_DEBUG_LIST
> >CONFIG_DEBUG_RODATA
>=20
> >Those are all under "Kernel Hacking". Then boot this new kernel and
> >catch the whole dmesg up and including a couple of oopses and send t=
hem
> >to me.
>=20
> >But do not boot with "nosmp" - we want to see whether default SMP ke=
rnel
> >still triggers.
>=20
>=20
> First to say that from time to time appears in the system messages li=
nes like this:
>=20
> =C2=A0[=C2=A0 918.496046] [drm] nouveau 0000:01:00.0: Setting dpms mo=
de 1 on vga encoder (output 0)
> =C2=A0[ 3308.960038] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 =
on vga encoder (output 0)
> =C2=A0[ 4211.680033] [drm] nouveau 0000:01:00.0: Setting dpms mode 1 =
on vga encoder (output 0)
>=20
> even in the time when nobody touches the computer, so i removed this =
nvidia GPU, but the hangs continued, then i put it back.
>=20
> Now about the debug kernel:
> There was no such option CONFIG_DEBUG_PREEMPT at first, as my model w=
as "Voluntary Kernel Preemption (Desktop)"(hangs were on such compiled =
kernels), then i switched to "Preemptible Kernel (Low-Latency Desktop)"=
 , enabled all this options, and compiled the kernel, but it refused to=
 work - blank screen from the beginning, even not "Decompressing Linux =
=2E..". I succeed to run this kernel on a virtual machine, but it refus=
es to run on the "buggy machine" - "this kernel"=3D"the same binary". T=
hen switched this option back,to try if this kernel run. If it is vital=
 to be "Preemptible Kernel (Low-Latency Desktop)" , i will try to do it=
 again, but now i switched to "Voluntary Kernel Preemption (Desktop)" e=
nabled the option you require, compilled kernel, and then interesting t=
hing happened - every time when i do "make modules_install" - the machi=
ne hangs at some arbitrary point, during the process of modules install=
ation, with "kernel pannic" - i saved few such
>  messages, and will put it below. Then i thought it could be some bad=
 blocks (recently i have checked this HDD with badblocks - it is fine).=
 But it is not the case - i can read all the directory with "find /usr/=
src/linux -type f | xargs md5sum), and can make big file as "dd if=3D/d=
ev/zero of=3Dfile bs=3D512M cound=3D2"(the size of /lib/modules/3.5.2 a=
fter hang vary from few kb, to ~400Mb). Then i passed "nosmp" at boot t=
ime - the same picture, but when i enabled swap, it managed to install =
the modules ! So the kernel debug is running for 1.5 hour, without hang=
,=C2=A0 with all option you require, except CONFIG_DEBUG_PREEMPT. And w=
hen i did again "make modules_install" twice, it crashed during the sec=
ond. I log on this machine trough internet, and it disappeared after th=
e last crash, probably before "make modules_install" manage to install =
LAN driver, i suppose, and will be able to continue this tests just tom=
orow. So i have no "couple" oopses, but 1 i have. Now i put
>  link to .config, 4 oopses during "make modules_install", first 2 are=
 from 3.2.27 without "nosmp", 3th is with "nosmp",and the last - 4th is=
 from 2.5.2 (debug) without "nosmp", and whole dmesg after it:
>=20
> /usr/src/linux/.config:=C2=A0 http://pastebin.com/tRimKcp1
>=20
> 3.2.27
>=20
> [=C2=A0 127.451016] BUG: unable to handle kernel NULL pointer derefer=
ence at 0000000000000001
> [=C2=A0 127.451069] IP: [<ffffffff819f9440>] start_show+0x30/0x30
> [=C2=A0 127.451069] PGD 0=20
> [=C2=A0 127.451069] Oops: 0002 [#1] SMP=20
> [=C2=A0 127.451069] CPU 1=20
> [=C2=A0 127.451069] Modules linked in: netconsole snd_seq_dummy snd_s=
eq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss ipt_REJECT =
xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat nf_conntrack_ip=
v4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x_tables lp fus=
e nouveau mxm_wmi wmi video ttm snd_via82xx drm_kms_helper snd_ac97_cod=
ec amd64_agp drm i2c_algo_bit agpgart shpchp k8temp snd_mpu401_uart snd=
_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer snd processor =
thermal_sys i2c_viapro hwmon soundcore ac97_bus gameport ppdev skge i2c=
_core parport_pc parport button evdev loop
> [=C2=A0 127.451069]=20
> [=C2=A0 127.451069] Pid: 0, comm: swapper/1 Not tainted 3.2.27 #2 To =
Be Filled By O.E.M. To Be Filled By O.E.M./A8V Deluxe
> [=C2=A0 127.451069] RIP: 0010:[<ffffffff819f9440>]=C2=A0 [<ffffffff81=
9f9440>] start_show+0x30/0x30
> [=C2=A0 127.451069] RSP: 0018:ffff88007fd03f00=C2=A0 EFLAGS: 00010006
> [=C2=A0 127.451069] RAX: 0000000000000001 RBX: ffffffff820c2fc0 RCX: =
ffff88007d0ec4c0
> [=C2=A0 127.451069] RDX: ffff88007fd11c40 RSI: 0000000000000000 RDI: =
ffffffff820c2fc0
> [=C2=A0 127.451069] RBP: ffff88007fd03f28 R08: 0000000000000000 R09: =
0000000000000000
> [=C2=A0 127.451069] R10: 0000000000000000 R11: 0000000000000000 R12: =
000000000000007e
> [=C2=A0 127.451069] R13: 0000000056606b05 R14: 00000000000177f2 R15: =
0000000000000000
> [=C2=A0 127.451069] FS:=C2=A0 00007f15a6e18740(0000) GS:ffff88007fd00=
000(0000) knlGS:00000000f6f85700
> [=C2=A0 127.451069] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800=
5003b
> [=C2=A0 127.451069] CR2: 0000000000000001 CR3: 0000000075dc7000 CR4: =
00000000000006e0
> [=C2=A0 127.451069] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [=C2=A0 127.451069] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: =
0000000000000400
> [=C2=A0 127.451069] Process swapper/1 (pid: 0, threadinfo ffff88007bd=
18000, task ffff88007d0ec4c0)
> [=C2=A0 127.451069] Stack:
> [=C2=A0 127.451069]=C2=A0 ffffffff8107df04 ffff88007fd0d300 000000000=
0000001 000000000000d300
> [=C2=A0 127.451069]=C2=A0 0000000000000000 ffff88007fd03f68 ffffffff8=
1085b1d 0000000000000000
> [=C2=A0 127.451069]=C2=A0 0000000000000096 0000000000000000 000000000=
0000001 0000000000000000
> [=C2=A0 127.451069] Call Trace:
> [=C2=A0 127.451069]=C2=A0 <IRQ>=20
> [=C2=A0 127.451069]=C2=A0 [<ffffffff8107df04>] ? ktime_get+0x64/0xe0
> [=C2=A0 127.451069]=C2=A0 [<ffffffff81085b1d>] tick_check_idle+0x5d/0=
xd0
> [=C2=A0 127.451069]=C2=A0 [<ffffffff8105a749>] irq_enter+0x69/0x70
> [=C2=A0 127.451069]=C2=A0 [<ffffffff81b31653>] smp_apic_timer_interru=
pt+0x43/0x99
> [=C2=A0 127.451069]=C2=A0 [<ffffffff81b2f9cb>] apic_timer_interrupt+0=
x6b/0x70
> [=C2=A0 127.451069]=C2=A0 <EOI>=20
> [=C2=A0 127.451069]=C2=A0 [<ffffffff8107aa58>] ? sched_clock_cpu+0xa8=
/0x120
> [=C2=A0 127.451069]=C2=A0 [<ffffffff8100a89a>] ? default_idle+0x5a/0x=
180
> [=C2=A0 127.451069]=C2=A0 [<ffffffff810009b6>] cpu_idle+0xf6/0x110
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81b146ea>] start_secondary+0x1cf/=
0x1d6
> [=C2=A0 127.944008] Code: 66 66 66 90 48 8b 0f 48 c7 c2 0d 46 dc 81 4=
8 89 f0 be 00 10 00 00 48 89 c7 31 c0 e8 5b 71 b9 ff 5d 48 98 c3 0f 1f =
80 00 00 00 00 <55> 48 89 e5 66 66 66 66 90 8b 15 39 31 6f 00 ed 25 ff =
ff ff 00=20
> [=C2=A0 127.944008] RIP=C2=A0 [<ffffffff819f9440>] start_show+0x30/0x=
30
> [=C2=A0 127.944008]=C2=A0 RSP <ffff88007fd03f00>
> [=C2=A0 127.944008] CR2: 0000000000000001
> [=C2=A0 127.944008] ---[ end trace 01731399a4823159 ]---
> [=C2=A0 127.944008] Kernel panic - not syncing: Fatal exception in in=
terrupt
> [=C2=A0 127.944008] Pid: 0, comm: swapper/1 Tainted: G=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.2.27 #2
> [=C2=A0 127.944008] Call Trace:
> [=C2=A0 127.944008]=C2=A0 <IRQ>=C2=A0 [<ffffffff81b1aeea>] panic+0x91=
/0x189
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81005491>] oops_end+0x91/0xa0
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81b1a85f>] no_context+0x1fa/0x225
> [=C2=A0 127.944008]=C2=A0 [<ffffffff8167cb70>] ? scsi_request_fn+0xa0=
/0x4a0
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81b1aa3b>] __bad_area_nosemaphore=
+0x1b1/0x1d0
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81b1aa6d>] bad_area_nosemaphore+0=
x13/0x15
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81028794>] do_page_fault+0x2b4/0x=
480
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81586d37>] ? kobject_put+0x27/0x6=
0
> [=C2=A0 127.944008]=C2=A0 [<ffffffff8163d387>] ? put_device+0x17/0x20
> [=C2=A0 127.944008]=C2=A0 [<ffffffff8167dbda>] ? scsi_next_command+0x=
4a/0x60
> [=C2=A0 127.944008]=C2=A0 [<ffffffff8167dfee>] ? scsi_io_completion+0=
x39e/0x5c0
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81b2ea2f>] page_fault+0x1f/0x30
> [=C2=A0 127.944008]=C2=A0 [<ffffffff819f9440>] ? start_show+0x30/0x30
> [=C2=A0 127.944008]=C2=A0 [<ffffffff8107df04>] ? ktime_get+0x64/0xe0
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81085b1d>] tick_check_idle+0x5d/0=
xd0
> [=C2=A0 127.944008]=C2=A0 [<ffffffff8105a749>] irq_enter+0x69/0x70
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81b31653>] smp_apic_timer_interru=
pt+0x43/0x99
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81b2f9cb>] apic_timer_interrupt+0=
x6b/0x70
> [=C2=A0 127.944008]=C2=A0 <EOI>=C2=A0 [<ffffffff8107aa58>] ? sched_cl=
ock_cpu+0xa8/0x120
> [=C2=A0 127.944008]=C2=A0 [<ffffffff8100a89a>] ? default_idle+0x5a/0x=
180
> [=C2=A0 127.944008]=C2=A0 [<ffffffff810009b6>] cpu_idle+0xf6/0x110
> [=C2=A0 127.944008]=C2=A0 [<ffffffff81b146ea>] start_secondary+0x1cf/=
0x1d6
> [=C2=A0 127.944008] panic occurred, switching back to text console
> [=C2=A0 127.944008] Rebooting in 10 seconds..
>=20
>=20
>=20
>=20
> *********************************************************************=
*****************
> 2
>=20
>=20
> 3.2.27
>=20
> [=C2=A0 881.391001] BUG: unable to handle kernel paging request at ff=
ff88007fd03ef8
> [=C2=A0 881.391001] IP: [<ffff88007fd03ef8>] 0xffff88007fd03ef7
> [=C2=A0 881.391001] PGD 2006063 PUD 1fffc067 PMD 800000007fc001e3=20
> [=C2=A0 881.391001] Oops: 0011 [#1] SMP=20
> [=C2=A0 881.391001] CPU 1=20
> [=C2=A0 881.391001] Modules linked in: netconsole snd_seq_dummy snd_s=
eq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss ipt_REJECT =
xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat nf_conntrack_ip=
v4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x_tables lp fus=
e nouveau mxm_wmi wmi video ttm drm_kms_helper snd_via82xx snd_ac97_cod=
ec snd_mpu401_uart snd_rawmidi drm processor ppdev snd_seq_device parpo=
rt_pc snd_pcm snd_page_alloc snd_timer snd soundcore ac97_bus thermal_s=
ys amd64_agp k8temp gameport parport hwmon i2c_viapro i2c_algo_bit shpc=
hp skge agpgart i2c_core button evdev loop
> [=C2=A0 881.391001]=20
> [=C2=A0 881.391001] Pid: 0, comm: swapper/1 Not tainted 3.2.27 #2 To =
Be Filled By O.E.M. To Be Filled By O.E.M./A8V Deluxe
> [=C2=A0 881.391001] RIP: 0010:[<ffff88007fd03ef8>]=C2=A0 [<ffff88007f=
d03ef8>] 0xffff88007fd03ef7
> [=C2=A0 881.391001] RSP: 0018:ffff88007fd03ee0=C2=A0 EFLAGS: 00010006
> [=C2=A0 881.391001] RAX: 0000000000d0d2b8 RBX: ffffffff820c2fc0 RCX: =
000000cd36e108a0
> [=C2=A0 881.391001] RDX: 000000000000004b RSI: ffff88007fd0d2b8 RDI: =
ffffffff820c2fc0
> [=C2=A0 881.391001] RBP: ffffffff8107e9c3 R08: 0000000000000000 R09: =
0000000000000001
> [=C2=A0 881.391001] R10: 0000000000000000 R11: 0000000000000000 R12: =
00000000000e4fd4
> [=C2=A0 881.391001] R13: ffff88007fd0d278 R14: 00000000137b7de3 R15: =
00000000503e13fc
> [=C2=A0 881.391001] FS:=C2=A0 00007f7355284740(0000) GS:ffff88007fd00=
000(0000) knlGS:00000000f6fa2700
> [=C2=A0 881.391001] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800=
5003b
> [=C2=A0 881.391001] CR2: ffff88007fd03ef8 CR3: 0000000002005000 CR4: =
00000000000006e0
> [=C2=A0 881.391001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [=C2=A0 881.391001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: =
0000000000000400
> [=C2=A0 881.391001] Process swapper/1 (pid: 0, threadinfo ffff88007bd=
18000, task ffff88007d0ec4c0)
> [=C2=A0 881.391001] Stack:
> [=C2=A0 881.391001]=C2=A0 ffff88007fd0d2b8 ffff88007fd0d300 ffff88007=
fd0cc00 ffff88007fd0d1c0
> [=C2=A0 881.391001]=C2=A0 0000000000000000 0000000000000000 000000000=
0000000 ffff88007fd03f88
> [=C2=A0 881.391001]=C2=A0 ffffffff81078d43 ffff88007fd03f68 ffff88007=
fd0d2b8 ffff88007fd0d278
> [=C2=A0 881.391001] Call Trace:
> [=C2=A0 881.391001]=C2=A0 <IRQ>=20
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81078d43>] ? hrtimer_interrupt+0x=
73/0x220
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81b31679>] ? smp_apic_timer_inter=
rupt+0x69/0x99
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81b2f9cb>] ? apic_timer_interrupt=
+0x6b/0x70
> [=C2=A0 881.391001]=C2=A0 <EOI>=20
> [=C2=A0 881.391001]=C2=A0 [<ffffffff8107aa58>] ? sched_clock_cpu+0xa8=
/0x120
> [=C2=A0 881.391001]=C2=A0 [<ffffffff8100a89a>] ? default_idle+0x5a/0x=
180
> [=C2=A0 881.391001]=C2=A0 [<ffffffff810009b6>] ? cpu_idle+0xf6/0x110
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81b146ea>] ? start_secondary+0x1c=
f/0x1d6
> [=C2=A0 881.391001] Code: 00 00 00 e0 3e d0 7f 00 88 ff ff 18 00 00 0=
0 00 00 00 00 b8 d2 d0 7f 00 88 ff ff 00 d3 d0 7f 00 88 ff ff 00 cc d0 =
7f 00 88 ff ff <c0> d1 d0 7f 00 88 ff ff 00 00 00 00 00 00 00 00 00 00 =
00 00 00=20
> [=C2=A0 881.391001] RIP=C2=A0 [<ffff88007fd03ef8>] 0xffff88007fd03ef7
> [=C2=A0 881.391001]=C2=A0 RSP <ffff88007fd03ee0>
> [=C2=A0 881.391001] CR2: ffff88007fd03ef8
> [=C2=A0 881.391001] ---[ end trace 8da31a3db7829ee7 ]---
> [=C2=A0 881.391001] Kernel panic - not syncing: Fatal exception in in=
terrupt
> [=C2=A0 881.391001] Pid: 0, comm: swapper/1 Tainted: G=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.2.27 #2
> [=C2=A0 881.391001] Call Trace:
> [=C2=A0 881.391001]=C2=A0 <IRQ>=C2=A0 [<ffffffff81b1aeea>] panic+0x91=
/0x189
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81005491>] oops_end+0x91/0xa0
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81b1a85f>] no_context+0x1fa/0x225
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81a5ca88>] ? ip_local_deliver+0x8=
8/0x90
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81b1aa3b>] __bad_area_nosemaphore=
+0x1b1/0x1d0
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81a5cce0>] ? ip_rcv+0x250/0x330
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81b1aa6d>] bad_area_nosemaphore+0=
x13/0x15
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81028794>] do_page_fault+0x2b4/0x=
480
> [=C2=A0 881.391001]=C2=A0 [<ffffffff8107a8b5>] ? sched_clock_local+0x=
25/0xa0
> [=C2=A0 881.391001]=C2=A0 [<ffffffff810b727b>] ? rcu_start_gp+0x16b/0=
x280
> [=C2=A0 881.391001]=C2=A0 [<ffffffff8107e9c3>] ? ktime_get_update_off=
sets+0x53/0xe0
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81b2ea2f>] page_fault+0x1f/0x30
> [=C2=A0 881.391001]=C2=A0 [<ffffffff8107e9c3>] ? ktime_get_update_off=
sets+0x53/0xe0
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81078d43>] ? hrtimer_interrupt+0x=
73/0x220
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81b31679>] ? smp_apic_timer_inter=
rupt+0x69/0x99
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81b2f9cb>] ? apic_timer_interrupt=
+0x6b/0x70
> [=C2=A0 881.391001]=C2=A0 <EOI>=C2=A0 [<ffffffff8107aa58>] ? sched_cl=
ock_cpu+0xa8/0x120
> [=C2=A0 881.391001]=C2=A0 [<ffffffff8100a89a>] ? default_idle+0x5a/0x=
180
> [=C2=A0 881.391001]=C2=A0 [<ffffffff810009b6>] ? cpu_idle+0xf6/0x110
> [=C2=A0 881.391001]=C2=A0 [<ffffffff81b146ea>] ? start_secondary+0x1c=
f/0x1d6
> [=C2=A0 881.391001] panic occurred, switching back to text console
> [=C2=A0 881.391001] Rebooting in 10 seconds..
>=20
>=20
>=20
>=20
> *********************************************************************=
*****************
> 3
>=20
>=20
> 3.2.27 nosmp
>=20
> [=C2=A0=C2=A0 81.006347] BUG: unable to handle kernel NULL pointer de=
reference at 000000000000003a
> [=C2=A0=C2=A0 81.007329] IP: [<ffffffff810b1080>] alloc_desc+0xc0/0xc=
0
> [=C2=A0=C2=A0 81.007329] PGD 781f8067 PUD 78082067 PMD 0=20
> [=C2=A0=C2=A0 81.007329] Oops: 0002 [#1] SMP=20
> [=C2=A0=C2=A0 81.007329] CPU 0=20
> [=C2=A0=C2=A0 81.007329] Modules linked in: netconsole snd_seq_dummy =
snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss ipt_RE=
JECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat nf_conntra=
ck_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x_tables l=
p fuse nouveau mxm_wmi wmi processor snd_via82xx video ttm drm_kms_help=
er drm i2c_viapro thermal_sys i2c_algo_bit i2c_core snd_ac97_codec snd_=
mpu401_uart snd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer=
 skge ppdev parport_pc snd parport shpchp k8temp hwmon amd64_agp soundc=
ore ac97_bus agpgart button evdev gameport loop
> [=C2=A0=C2=A0 81.007329]=20
> [=C2=A0=C2=A0 81.007329] Pid: 0, comm: swapper/0 Not tainted 3.2.27 #=
2 To Be Filled By O.E.M. To Be Filled By O.E.M./A8V Deluxe
> [=C2=A0=C2=A0 81.007329] RIP: 0010:[<ffffffff810b1080>]=C2=A0 [<fffff=
fff810b1080>] alloc_desc+0xc0/0xc0
> [=C2=A0=C2=A0 81.007329] RSP: 0018:ffff88007fc03f60=C2=A0 EFLAGS: 000=
10092
> [=C2=A0=C2=A0 81.007329] RAX: 000000000000003a RBX: 000000000000000a =
RCX: 000000000074370e
> [=C2=A0=C2=A0 81.007329] RDX: fffffffffffff04b RSI: ffffffff82001e68 =
RDI: 000000000000000a
> [=C2=A0=C2=A0 81.007329] RBP: ffff88007fc03f78 R08: ffffffff35dc1000 =
R09: 00128970e6000000
> [=C2=A0=C2=A0 81.007329] R10: 0000000000743710 R11: 000000000080ffad =
R12: 000000000000003a
> [=C2=A0=C2=A0 81.007329] R13: 000000000000000a R14: 0000000000000000 =
R15: 0000000000000000
> [=C2=A0=C2=A0 81.007329] FS:=C2=A0 00007ffb7f691740(0000) GS:ffff8800=
7fc00000(0000) knlGS:00000000f6f81700
> [=C2=A0=C2=A0 81.007329] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000=
008005003b
> [=C2=A0=C2=A0 81.007329] CR2: 000000000000003a CR3: 0000000078e1d000 =
CR4: 00000000000006f0
> [=C2=A0=C2=A0 81.007329] DR0: 0000000000000000 DR1: 0000000000000000 =
DR2: 0000000000000000
> [=C2=A0=C2=A0 81.007329] DR3: 0000000000000000 DR6: 00000000ffff0ff0 =
DR7: 0000000000000400
> [=C2=A0=C2=A0 81.007329] Process swapper/0 (pid: 0, threadinfo ffffff=
ff82000000, task ffffffff8200d020)
> [=C2=A0=C2=A0 81.007329] Stack:
> [=C2=A0=C2=A0 81.007329]=C2=A0 ffffffff81003d05 ffff88007fc03f78 ffff=
ffff82001e68 ffff88007fc03fa8
> [=C2=A0=C2=A0 81.007329]=C2=A0 ffffffff81b3158a ffffffff82001fd8 0000=
000000000000 ffff88007ff7d8c0
> [=C2=A0=C2=A0 81.007329]=C2=A0 ffffffffffffffff ffffffff82001f28 ffff=
ffff81b2e82b ffffffff82001e88
> [=C2=A0=C2=A0 81.007329] Call Trace:
> [=C2=A0=C2=A0 81.007329]=C2=A0 <IRQ>=20
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81003d05>] ? handle_irq+0x15=
/0x40
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81b3158a>] do_IRQ+0x5a/0xe0
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81b2e82b>] common_interrupt+=
0x6b/0x6b
> [=C2=A0=C2=A0 81.007329]=C2=A0 <EOI>=20
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff8107aa58>] ? sched_clock_cpu=
+0xa8/0x120
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff8100a89a>] ? default_idle+0x=
5a/0x180
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff810009b6>] cpu_idle+0xf6/0x1=
10
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81ae5b89>] rest_init+0x6d/0x=
74
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff82103b70>] start_kernel+0x38=
5/0x390
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff82103322>] x86_64_start_rese=
rvations+0x132/0x136
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff821033fe>] x86_64_start_kern=
el+0xd8/0xdc
> [=C2=A0=C2=A0 81.007329] Code: 48 8b 5d e0 4c 8b 6d f0 4c 8b 75 f8 c9=
 c3 0f 1f 44 00 00 bb 10 00 00 00 eb 9a 90 48 89 df 31 db e8 56 27 07 0=
0 eb d2 0f 1f 40 00 <55> 48 89 e5 66 66 66 66 90 89 fe 48 c7 c7 f0 ee 0=
1 82 e8 c9 8f=20
> [=C2=A0=C2=A0 81.007329] RIP=C2=A0 [<ffffffff810b1080>] alloc_desc+0x=
c0/0xc0
> [=C2=A0=C2=A0 81.007329]=C2=A0 RSP <ffff88007fc03f60>
> [=C2=A0=C2=A0 81.007329] CR2: 000000000000003a
> [=C2=A0=C2=A0 81.007329] ---[ end trace 2cefd006012bde68 ]---
> [=C2=A0=C2=A0 81.007329] Kernel panic - not syncing: Fatal exception =
in interrupt
> [=C2=A0=C2=A0 81.007329] Pid: 0, comm: swapper/0 Tainted: G=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.2.27 #2
> [=C2=A0=C2=A0 81.007329] Call Trace:
> [=C2=A0=C2=A0 81.007329]=C2=A0 <IRQ>=C2=A0 [<ffffffff81b1aeea>] panic=
+0x91/0x189
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81005491>] oops_end+0x91/0xa=
0
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81b1a85f>] no_context+0x1fa/=
0x225
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81b1aa3b>] __bad_area_nosema=
phore+0x1b1/0x1d0
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff8104cf8b>] ? scheduler_tick+=
0xdb/0x2c0
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81b1aa6d>] bad_area_nosemaph=
ore+0x13/0x15
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81028794>] do_page_fault+0x2=
b4/0x480
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff819f95c4>] ? pit_next_event+=
0x34/0x50
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff8107df04>] ? ktime_get+0x64/=
0xe0
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff819f95c4>] ? pit_next_event+=
0x34/0x50
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81083a66>] ? clockevents_pro=
gram_event+0x76/0x120
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81078948>] ? __hrtimer_start=
_range_ns+0x1b8/0x420
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81b2ea2f>] page_fault+0x1f/0=
x30
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff810b1080>] ? alloc_desc+0xc0=
/0xc0
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81003d05>] ? handle_irq+0x15=
/0x40
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81b3158a>] do_IRQ+0x5a/0xe0
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81b2e82b>] common_interrupt+=
0x6b/0x6b
> [=C2=A0=C2=A0 81.007329]=C2=A0 <EOI>=C2=A0 [<ffffffff8107aa58>] ? sch=
ed_clock_cpu+0xa8/0x120
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff8100a89a>] ? default_idle+0x=
5a/0x180
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff810009b6>] cpu_idle+0xf6/0x1=
10
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff81ae5b89>] rest_init+0x6d/0x=
74
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff82103b70>] start_kernel+0x38=
5/0x390
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff82103322>] x86_64_start_rese=
rvations+0x132/0x136
> [=C2=A0=C2=A0 81.007329]=C2=A0 [<ffffffff821033fe>] x86_64_start_kern=
el+0xd8/0xdc
> [=C2=A0=C2=A0 81.007329] panic occurred, switching back to text conso=
le
> [=C2=A0=C2=A0 81.007329] Rebooting in 10 seconds..[=C2=A0 145.137832]=
 Adding 4008212k swap on /dev/sda3.=C2=A0 Priority:-1 extents:1 across:=
4008212k=20
>=20
>=20
>=20
>=20
> *********************************************************************=
*****************
> 4
>=20
>=20
> 2.5.2
>=20
> [ 5826.382007] BUG: unable to handle kernel NULL pointer dereference =
at 0000000000000001
> [ 5826.385025] IP: [<ffffffff81095330>] update_ts_time_stats+0x90/0x9=
0
> [ 5826.385025] PGD 0=20
> [ 5826.385025] Oops: 0002 [#1] SMP=20
> [ 5826.385025] CPU 1=20
> [ 5826.385025] Modules linked in:[ 5826.385025]=C2=A0 netconsole snd_=
seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_=
oss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat =
nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables =
x_tables lp fuse snd_via82xx snd_ac97_codec snd_mpu401_uart snd_rawmidi=
 snd_seq_device nouveau snd_pcm mxm_wmi wmi video ttm drm_kms_helper dr=
m snd_page_alloc snd_timer snd powernow_k8 mperf processor amd64_agp fr=
eq_table k8temp thermal_sys ppdev i2c_algo_bit soundcore i2c_viapro skg=
e hwmon button evdev agpgart parport_pc parport i2c_core ac97_bus gamep=
ort shpchp loop
>=20
> [ 5826.385025] Pid: 0, comm: swapper/1 Not tainted 3.5.2 #4 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
> [ 5826.385025] RIP: 0010:[<ffffffff81095330>]=C2=A0 [<ffffffff8109533=
0>] update_ts_time_stats+0x90/0x90
> [ 5826.385025] RSP: 0018:ffff88007fd03f40=C2=A0 EFLAGS: 00010002
> [ 5826.385025] RAX: 0000000000000001 RBX: ffff88007fd0da40 RCX: 00000=
00000000017
> [ 5826.385025] RDX: 0000000225c17d03 RSI: 0000054c8f6df3f2 RDI: 00000=
00000000001
> [ 5826.385025] RBP: ffff88007fd03f68 R08: 0000000000000000 R09: 00000=
00000000000
> [ 5826.385025] R10: 0000000000000000 R11: 0000000000000000 R12: 00000=
00000000001
> [ 5826.385025] R13: 000000000000da40 R14: 0000054c8f6df3f2 R15: 00000=
00000000000
> [ 5826.385025] FS:=C2=A0 00007fa10e20e740(0000) GS:ffff88007fd00000(0=
000) knlGS:00000000f6fd0700
> [ 5826.385025] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [ 5826.385025] CR2: 0000000000000001 CR3: 000000000200b000 CR4: 00000=
000000007e0
> [ 5826.385025] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> [ 5826.385025] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
> [ 5826.385025] Process swapper/1 (pid: 0, threadinfo ffff88007c524000=
, task ffff88007d07dd60)
> [ 5826.385025] Stack:
> [ 5826.385025]=C2=A0 ffffffff81095873 0000000000000001 00000000000000=
00 0000000000000000
> [ 5826.385025]=C2=A0 0000000000000000 ffff88007fd03f88 ffffffff8104a3=
5c 0000000000000000
> [ 5826.385025]=C2=A0 000000000000cfc0 ffff88007fd03fa8 ffffffff81b4fe=
6e ffff88007c525fd8
> [ 5826.385025] Call Trace:
> [ 5826.385025]=C2=A0 <IRQ>=20
> [ 5826.385025]=C2=A0 [<ffffffff81095873>] ? tick_check_idle+0xc3/0xe0
> [ 5826.385025]=C2=A0 [<ffffffff8104a35c>] irq_enter+0x7c/0x90
> [ 5826.385025]=C2=A0 [<ffffffff81b4fe6e>] smp_apic_timer_interrupt+0x=
3e/0x99
> [ 5826.385025]=C2=A0 [<ffffffff81b4eedc>] apic_timer_interrupt+0x6c/0=
x80
> [ 5826.385025]=C2=A0 <EOI>=20
> [ 5826.385025]=C2=A0 [<ffffffff8100ab7d>] ? default_idle+0x5d/0x1b0
> [ 5826.385025]=C2=A0 [<ffffffff8100ab7f>] ? default_idle+0x5f/0x1b0
> [ 5826.385025]=C2=A0 [<ffffffff8100ab7d>] ? default_idle+0x5d/0x1b0
> [ 5826.385025]=C2=A0 [<ffffffff8100b816>] cpu_idle+0x106/0x120
> [ 5826.385025]=C2=A0 [<ffffffff81b2c7db>] start_secondary+0x1dd/0x1e4
> [ 5826.385025] Code: c0 48 8b 75 c8 75 14 4c 01 a6 b8 00 00 00 48 89 =
96 a0 00 00 00 eb a8 0f 1f 40 00 4c 01 a6 c0 00 00 00 eb ea 0f 1f 80 00=
 00 00 00 <55> 48 89 e5 53 48 83 ec 08 66 66 66 66 90 48 c7 c3 40 da 00=
 00=20
> [ 5826.385025] RIP=C2=A0 [<ffffffff81095330>] update_ts_time_stats+0x=
90/0x90
> [ 5826.385025]=C2=A0 RSP <ffff88007fd03f40>
> [ 5826.385025] CR2: 0000000000000001
> [ 5826.949382] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga=
 encoder (output 0)
> [ 5826.971364] ---[ end trace 4684667b9eecc18f ]---
> [ 5826.971364] Kernel panic - not syncing: Fatal exception in interru=
pt
> [ 5826.971364] panic occurred, switching back to text console
> [ 5826.971364] Rebooting in 10 seconds..
>=20
>=20
>=20
> dmesg:
>=20
> [=C2=A0=C2=A0=C2=A0 0.000000] Initializing cgroup subsys cpuset
> [=C2=A0=C2=A0=C2=A0 0.000000] Initializing cgroup subsys cpu
> [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 3.5.2 (root@b) (gcc versi=
on 4.7.1 (GCC) ) #4 SMP Wed Aug 29 15:47:00 MSK 2012
> [=C2=A0=C2=A0=C2=A0 0.000000] Command line: auto BOOT_IMAGE=3Ddebug r=
o root=3D802 vt.default_utf8=3D0
> [=C2=A0=C2=A0=C2=A0 0.000000] e820: BIOS-provided physical RAM map:
> [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x0000000000000000-0x00=
0000000009fbff] usable
> [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x000000000009fc00-0x00=
0000000009ffff] reserved
> [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000000e4000-0x00=
000000000fffff] reserved
> [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x0000000000100000-0x00=
0000007ffaffff] usable
> [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x000000007ffb0000-0x00=
0000007ffbffff] ACPI data
> [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x000000007ffc0000-0x00=
0000007ffeffff] ACPI NVS
> [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x000000007fff0000-0x00=
0000007fffffff] reserved
> [=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000ff780000-0x00=
000000ffffffff] reserved
> [=C2=A0=C2=A0=C2=A0 0.000000] NX (Execute Disable) protection: active
> [=C2=A0=C2=A0=C2=A0 0.000000] DMI 2.3 present.
> [=C2=A0=C2=A0=C2=A0 0.000000] DMI: To Be Filled By O.E.M. To Be Fille=
d By O.E.M./A8V Deluxe, BIOS 1013.005 05/19/2005
> [=C2=A0=C2=A0=C2=A0 0.000000] e820: update [mem 0x00000000-0x0000ffff=
] usable =3D=3D> reserved
> [=C2=A0=C2=A0=C2=A0 0.000000] e820: remove [mem 0x000a0000-0x000fffff=
] usable
> [=C2=A0=C2=A0=C2=A0 0.000000] AGP bridge at 00:00:00
> [=C2=A0=C2=A0=C2=A0 0.000000] Aperture from AGP @ ec000000 old size 3=
2 MB
> [=C2=A0=C2=A0=C2=A0 0.000000] Aperture from AGP @ ec000000 size 64 MB=
 (APSIZE f30)
> [=C2=A0=C2=A0=C2=A0 0.000000] e820: last_pfn =3D 0x7ffb0 max_arch_pfn=
 =3D 0x400000000
> [=C2=A0=C2=A0=C2=A0 0.000000] MTRR default type: uncachable
> [=C2=A0=C2=A0=C2=A0 0.000000] MTRR fixed ranges enabled:
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 00000-9FFFF write-back
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 A0000-EFFFF uncachable
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 F0000-FFFFF write-protect
> [=C2=A0=C2=A0=C2=A0 0.000000] MTRR variable ranges enabled:
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 0 base 0000000000 mask FF80=
000000 write-back
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 1 base 00EC000000 mask FFFC=
000000 write-combining
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 2 disabled
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 3 disabled
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 4 disabled
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 5 disabled
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 6 disabled
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 7 disabled
> [=C2=A0=C2=A0=C2=A0 0.000000] x86 PAT enabled: cpu 0, old 0x704060007=
0406, new 0x7010600070106
> [=C2=A0=C2=A0=C2=A0 0.000000] found SMP MP-table at [mem 0x000ff780-0=
x000ff78f] mapped at [ffff8800000ff780]
> [=C2=A0=C2=A0=C2=A0 0.000000] initial memory mapped: [mem 0x00000000-=
0x1fffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] Base memory trampoline at [ffff88000009=
7000] 97000 size 24576
> [=C2=A0=C2=A0=C2=A0 0.000000] init_memory_mapping: [mem 0x00000000-0x=
7ffaffff]
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 [mem 0x00000000-0x7fdfffff] page =
2M
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 [mem 0x7fe00000-0x7ffaffff] page =
4k
> [=C2=A0=C2=A0=C2=A0 0.000000] kernel direct mapping tables up to 0x7f=
faffff @ [mem 0x1fbfd000-0x1fffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: RSDP 00000000000fa7c0 00014 (v00 =
ACPIAM)
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: RSDT 000000007ffb0000 00030 (v01 =
A M I=C2=A0 OEMRSDT=C2=A0 05000519 MSFT 00000097)
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: FACP 000000007ffb0200 00081 (v01 =
A M I=C2=A0 OEMFACP=C2=A0 05000519 MSFT 00000097)
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: DSDT 000000007ffb03f0 03A3E (v01=C2=
=A0 A0036 A0036001 00000001 MSFT 0100000D)
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: FACS 000000007ffc0000 00040
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: APIC 000000007ffb0390 00052 (v01 =
A M I=C2=A0 OEMAPIC=C2=A0 05000519 MSFT 00000097)
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: OEMB 000000007ffc0040 0003F (v01 =
A M I=C2=A0 OEMBIOS=C2=A0 05000519 MSFT 00000097)
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: Local APIC address 0xfee00000
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 [ffffea0000000000-ffffea0001fffff=
f] PMD -> [ffff88007d600000-ffff88007f5fffff] on node 0
> [=C2=A0=C2=A0=C2=A0 0.000000] Zone ranges:
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 [mem 0x00010000-0x00ffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA32=C2=A0=C2=A0=C2=A0 [me=
m 0x01000000-0xffffffff]
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 Normal=C2=A0=C2=A0 empty
> [=C2=A0=C2=A0=C2=A0 0.000000] Movable zone start for each node
> [=C2=A0=C2=A0=C2=A0 0.000000] Early memory node ranges
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x=
00010000-0x0009efff]
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x=
00100000-0x7ffaffff]
> [=C2=A0=C2=A0=C2=A0 0.000000] On node 0 totalpages: 524095
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA zone: 64 pages used for=
 memmap
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA zone: 8 pages reserved
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA zone: 3911 pages, LIFO =
batch:0
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA32 zone: 8127 pages used=
 for memmap
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA32 zone: 511985 pages, L=
IFO batch:31
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: PM-Timer IO Port: 0x808
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: Local APIC address 0xfee00000
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x0=
0] enabled)
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x0=
1] enabled)
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: IOAPIC (id[0x02] address[0xfec000=
00] gsi_base[0])
> [=C2=A0=C2=A0=C2=A0 0.000000] IOAPIC[0]: apic_id 2, version 3, addres=
s 0xfec00000, GSI 0-23
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 glob=
al_irq 2 dfl dfl)
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: IRQ0 used by override.
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: IRQ2 used by override.
> [=C2=A0=C2=A0=C2=A0 0.000000] ACPI: IRQ9 used by override.
> [=C2=A0=C2=A0=C2=A0 0.000000] Using ACPI (MADT) for SMP configuration=
 information
> [=C2=A0=C2=A0=C2=A0 0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
> [=C2=A0=C2=A0=C2=A0 0.000000] nr_irqs_gsi: 40
> [=C2=A0=C2=A0=C2=A0 0.000000] PM: Registered nosave memory: 000000000=
009f000 - 00000000000a0000
> [=C2=A0=C2=A0=C2=A0 0.000000] PM: Registered nosave memory: 000000000=
00a0000 - 00000000000e4000
> [=C2=A0=C2=A0=C2=A0 0.000000] PM: Registered nosave memory: 000000000=
00e4000 - 0000000000100000
> [=C2=A0=C2=A0=C2=A0 0.000000] e820: [mem 0x80000000-0xff77ffff] avail=
able for PCI devices
> [=C2=A0=C2=A0=C2=A0 0.000000] setup_percpu: NR_CPUS:2 nr_cpumask_bits=
:2 nr_cpu_ids:2 nr_node_ids:1
> [=C2=A0=C2=A0=C2=A0 0.000000] PERCPU: Embedded 27 pages/cpu @ffff8800=
7fc00000 s79104 r8192 d23296 u1048576
> [=C2=A0=C2=A0=C2=A0 0.000000] pcpu-alloc: s79104 r8192 d23296 u104857=
6 alloc=3D1*2097152
> [=C2=A0=C2=A0=C2=A0 0.000000] pcpu-alloc: [0] 0 1=20
> [=C2=A0=C2=A0=C2=A0 0.000000] Built 1 zonelists in Zone order, mobili=
ty grouping on.=C2=A0 Total pages: 515896
> [=C2=A0=C2=A0=C2=A0 0.000000] Kernel command line: auto BOOT_IMAGE=3D=
debug ro root=3D802 vt.default_utf8=3D0
> [=C2=A0=C2=A0=C2=A0 0.000000] PID hash table entries: 4096 (order: 3,=
 32768 bytes)
> [=C2=A0=C2=A0=C2=A0 0.000000] Dentry cache hash table entries: 262144=
 (order: 9, 2097152 bytes)
> [=C2=A0=C2=A0=C2=A0 0.000000] Inode-cache hash table entries: 131072 =
(order: 8, 1048576 bytes)
> [=C2=A0=C2=A0=C2=A0 0.000000] __ex_table already sorted, skipping sor=
t
> [=C2=A0=C2=A0=C2=A0 0.000000] Checking aperture...
> [=C2=A0=C2=A0=C2=A0 0.000000] AGP bridge at 00:00:00
> [=C2=A0=C2=A0=C2=A0 0.000000] Aperture from AGP @ ec000000 old size 3=
2 MB
> [=C2=A0=C2=A0=C2=A0 0.000000] Aperture from AGP @ ec000000 size 64 MB=
 (APSIZE f30)
> [=C2=A0=C2=A0=C2=A0 0.000000] Node 0: aperture @ ec000000 size 64 MB
> [=C2=A0=C2=A0=C2=A0 0.000000] Memory: 2030720k/2096832k available (11=
592k kernel code, 452k absent, 65660k reserved, 5906k data, 868k init)
> [=C2=A0=C2=A0=C2=A0 0.000000] SLUB: Genslabs=3D15, HWalign=3D64, Orde=
r=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1
> [=C2=A0=C2=A0=C2=A0 0.000000] Hierarchical RCU implementation.
> [=C2=A0=C2=A0=C2=A0 0.000000] =C2=A0=C2=A0=C2=A0 CONFIG_RCU_FANOUT se=
t to non-default value of 32
> [=C2=A0=C2=A0=C2=A0 0.000000] NR_IRQS:4352 nr_irqs:512 16
> [=C2=A0=C2=A0=C2=A0 0.000000] Console: colour dummy device 80x25
> [=C2=A0=C2=A0=C2=A0 0.000000] console [tty0] enabled
> [=C2=A0=C2=A0=C2=A0 0.000000] Lock dependency validator: Copyright (c=
) 2006 Red Hat, Inc., Ingo Molnar
> [=C2=A0=C2=A0=C2=A0 0.000000] ... MAX_LOCKDEP_SUBCLASSES:=C2=A0 8
> [=C2=A0=C2=A0=C2=A0 0.000000] ... MAX_LOCK_DEPTH:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 48
> [=C2=A0=C2=A0=C2=A0 0.000000] ... MAX_LOCKDEP_KEYS:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 8191
> [=C2=A0=C2=A0=C2=A0 0.000000] ... CLASSHASH_SIZE:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
> [=C2=A0=C2=A0=C2=A0 0.000000] ... MAX_LOCKDEP_ENTRIES:=C2=A0=C2=A0=C2=
=A0=C2=A0 16384
> [=C2=A0=C2=A0=C2=A0 0.000000] ... MAX_LOCKDEP_CHAINS:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 32768
> [=C2=A0=C2=A0=C2=A0 0.000000] ... CHAINHASH_SIZE:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 memory used by lock dependency in=
fo: 5855 kB
> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0 per task-struct memory footprint:=
 1920 bytes
> [=C2=A0=C2=A0=C2=A0 0.000000] allocated 8388608 bytes of page_cgroup
> [=C2=A0=C2=A0=C2=A0 0.000000] please try 'cgroup_disable=3Dmemory' op=
tion if you don't want memory cgroups
> [=C2=A0=C2=A0=C2=A0 0.000000] ODEBUG: 0 of 0 active objects replaced
> [=C2=A0=C2=A0=C2=A0 0.000000] Fast TSC calibration using PIT
> [=C2=A0=C2=A0=C2=A0 0.000000] Detected 2202.837 MHz processor.
> [=C2=A0=C2=A0=C2=A0 0.000000] Marking TSC unstable due to TSCs unsync=
hronized
> [=C2=A0=C2=A0=C2=A0 0.001011] Calibrating delay loop (skipped), value=
 calculated using timer frequency.. 4405.67 BogoMIPS (lpj=3D2202837)
> [=C2=A0=C2=A0=C2=A0 0.001026] pid_max: default: 32768 minimum: 301
> [=C2=A0=C2=A0=C2=A0 0.001112] Security Framework initialized
> [=C2=A0=C2=A0=C2=A0 0.001147] Mount-cache hash table entries: 256
> [=C2=A0=C2=A0=C2=A0 0.002455] Initializing cgroup subsys cpuacct
> [=C2=A0=C2=A0=C2=A0 0.002464] Initializing cgroup subsys memory
> [=C2=A0=C2=A0=C2=A0 0.002510] Initializing cgroup subsys devices
> [=C2=A0=C2=A0=C2=A0 0.002518] Initializing cgroup subsys freezer
> [=C2=A0=C2=A0=C2=A0 0.002525] Initializing cgroup subsys net_cls
> [=C2=A0=C2=A0=C2=A0 0.002532] Initializing cgroup subsys blkio
> [=C2=A0=C2=A0=C2=A0 0.002539] Initializing cgroup subsys perf_event
> [=C2=A0=C2=A0=C2=A0 0.002608] tseg: 0000000000
> [=C2=A0=C2=A0=C2=A0 0.002674] CPU: Physical Processor ID: 0
> [=C2=A0=C2=A0=C2=A0 0.002679] CPU: Processor Core ID: 0
> [=C2=A0=C2=A0=C2=A0 0.002683] mce: CPU supports 5 MCE banks
> [=C2=A0=C2=A0=C2=A0 0.002744] ACPI: Core revision 20120320
> [=C2=A0=C2=A0=C2=A0 0.006660] ftrace: allocating 35220 entries in 138=
 pages
> [=C2=A0=C2=A0=C2=A0 0.021998] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D=
2 apic2=3D0 pin2=3D0
> [=C2=A0=C2=A0=C2=A0 0.031952] CPU0: AMD Athlon(tm) 64 X2 Dual Core Pr=
ocessor 4200+ stepping 01
> [=C2=A0=C2=A0=C2=A0 0.031997] Performance Events: AMD PMU driver.
> [=C2=A0=C2=A0=C2=A0 0.031997] ... version:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> [=C2=A0=C2=A0=C2=A0 0.031997] ... bit width:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 48
> [=C2=A0=C2=A0=C2=A0 0.031997] ... generic registers:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 4
> [=C2=A0=C2=A0=C2=A0 0.031997] ... value mask:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000ffffffffffff
> [=C2=A0=C2=A0=C2=A0 0.031997] ... max period:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00007fffffffffff
> [=C2=A0=C2=A0=C2=A0 0.031997] ... fixed-purpose events:=C2=A0=C2=A0 0
> [=C2=A0=C2=A0=C2=A0 0.031997] ... event mask:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000000000000f
> [=C2=A0=C2=A0=C2=A0 0.031997] MCE: In-kernel MCE decoding enabled.
> [=C2=A0=C2=A0=C2=A0 0.031997] lockdep: fixing up alternatives.
> [=C2=A0=C2=A0=C2=A0 0.031997] Booting Node=C2=A0=C2=A0 0, Processors=C2=
=A0 #1 Ok.
> [=C2=A0=C2=A0=C2=A0 0.102048] Brought up 2 CPUs
> [=C2=A0=C2=A0=C2=A0 0.102054] Total of 2 processors activated (8810.6=
6 BogoMIPS).
> [=C2=A0=C2=A0=C2=A0 0.103313] devtmpfs: initialized
> [=C2=A0=C2=A0=C2=A0 0.106101] PM: Registering ACPI NVS region [mem 0x=
7ffc0000-0x7ffeffff] (196608 bytes)
> [=C2=A0=C2=A0=C2=A0 0.106225] xor: automatically using best checksumm=
ing function:
> [=C2=A0=C2=A0=C2=A0 0.115993]=C2=A0=C2=A0=C2=A0 generic_sse:=C2=A0 70=
48.000 MB/sec
> [=C2=A0=C2=A0=C2=A0 0.116002] atomic64 test passed for x86-64 platfor=
m with CX8 and with SSE
> [=C2=A0=C2=A0=C2=A0 0.117080] dummy:=20
> [=C2=A0=C2=A0=C2=A0 0.117258] NET: Registered protocol family 16
> [=C2=A0=C2=A0=C2=A0 0.118081] node 0 link 0: io port [1000, ffffff]
> [=C2=A0=C2=A0=C2=A0 0.118082] TOM: 0000000080000000 aka 2048M
> [=C2=A0=C2=A0=C2=A0 0.118090] node 0 link 0: mmio [a0000, bffff]
> [=C2=A0=C2=A0=C2=A0 0.118094] node 0 link 0: mmio [80000000, ffffffff=
]
> [=C2=A0=C2=A0=C2=A0 0.118098] bus: [00, ff] on node 0 link 0
> [=C2=A0=C2=A0=C2=A0 0.118101] bus: 00 [io=C2=A0 0x0000-0xffff]
> [=C2=A0=C2=A0=C2=A0 0.118103] bus: 00 [mem 0x000a0000-0x000bffff]
> [=C2=A0=C2=A0=C2=A0 0.118105] bus: 00 [mem 0x80000000-0xfcffffffff]
> [=C2=A0=C2=A0=C2=A0 0.118206] ACPI: bus type pci registered
> [=C2=A0=C2=A0=C2=A0 0.118234] PCI: Using configuration type 1 for bas=
e access
> [=C2=A0=C2=A0=C2=A0 0.163084] bio: create slab <bio-0> at 0
> [=C2=A0=C2=A0=C2=A0 0.179938] raid6: sse2x1=C2=A0=C2=A0=C2=A0=C2=A0 7=
38 MB/s
> [=C2=A0=C2=A0=C2=A0 0.196933] raid6: sse2x2=C2=A0=C2=A0=C2=A0=C2=A0 8=
75 MB/s
> [=C2=A0=C2=A0=C2=A0 0.213954] raid6: sse2x4=C2=A0=C2=A0=C2=A0 1398 MB=
/s
> [=C2=A0=C2=A0=C2=A0 0.213959] raid6: using algorithm sse2x4 (1398 MB/=
s)
> [=C2=A0=C2=A0=C2=A0 0.213965] raid6: using intx1 recovery algorithm
> [=C2=A0=C2=A0=C2=A0 0.214084] ACPI: Added _OSI(Module Device)
> [=C2=A0=C2=A0=C2=A0 0.214084] ACPI: Added _OSI(Processor Device)
> [=C2=A0=C2=A0=C2=A0 0.214084] ACPI: Added _OSI(3.0 _SCP Extensions)
> [=C2=A0=C2=A0=C2=A0 0.214084] ACPI: Added _OSI(Processor Aggregator D=
evice)
> [=C2=A0=C2=A0=C2=A0 0.217956] ACPI: EC: Look up EC in DSDT
> [=C2=A0=C2=A0=C2=A0 0.221983] ACPI: Executed 1 blocks of module-level=
 executable AML code
> [=C2=A0=C2=A0=C2=A0 0.226439] ACPI: Interpreter enabled
> [=C2=A0=C2=A0=C2=A0 0.226448] ACPI: (supports S0 S1 S3 S4 S5)
> [=C2=A0=C2=A0=C2=A0 0.226522] ACPI: Using IOAPIC for interrupt routin=
g
> [=C2=A0=C2=A0=C2=A0 0.243376] ACPI: No dock devices found.
> [=C2=A0=C2=A0=C2=A0 0.243392] PCI: Ignoring host bridge windows from =
ACPI; if necessary, use "pci=3Duse_crs" and report a bug
> [=C2=A0=C2=A0=C2=A0 0.243553] ACPI: PCI Root Bridge [PCI0] (domain 00=
00 [bus 00-ff])
> [=C2=A0=C2=A0=C2=A0 0.244179] pci_root PNP0A03:00: host bridge window=
 [io=C2=A0 0x0000-0x0cf7] (ignored)
> [=C2=A0=C2=A0=C2=A0 0.244182] pci_root PNP0A03:00: host bridge window=
 [io=C2=A0 0x0d00-0xffff] (ignored)
> [=C2=A0=C2=A0=C2=A0 0.244186] pci_root PNP0A03:00: host bridge window=
 [mem 0x000a0000-0x000bffff] (ignored)
> [=C2=A0=C2=A0=C2=A0 0.244189] pci_root PNP0A03:00: host bridge window=
 [mem 0x80000000-0xffffffff] (ignored)
> [=C2=A0=C2=A0=C2=A0 0.244192] PCI: root bus 00: hardware-probed resou=
rces
> [=C2=A0=C2=A0=C2=A0 0.244383] PCI host bridge to bus 0000:00
> [=C2=A0=C2=A0=C2=A0 0.244383] pci_bus 0000:00: root bus resource [io=C2=
=A0 0x0000-0xffff]
> [=C2=A0=C2=A0=C2=A0 0.244383] pci_bus 0000:00: root bus resource [mem=
 0x000a0000-0x000bffff]
> [=C2=A0=C2=A0=C2=A0 0.244383] pci_bus 0000:00: root bus resource [mem=
 0x80000000-0xfcffffffff]
> [=C2=A0=C2=A0=C2=A0 0.244383] pci 0000:00:00.0: [1106:0282] type 00 c=
lass 0x060000
> [=C2=A0=C2=A0=C2=A0 0.244383] pci 0000:00:00.0: reg 10: [mem 0xec0000=
00-0xefffffff pref]
> [=C2=A0=C2=A0=C2=A0 0.244383] pci 0000:00:00.1: [1106:1282] type 00 c=
lass 0x060000
> [=C2=A0=C2=A0=C2=A0 0.244386] pci 0000:00:00.2: [1106:2282] type 00 c=
lass 0x060000
> [=C2=A0=C2=A0=C2=A0 0.244454] pci 0000:00:00.3: [1106:3282] type 00 c=
lass 0x060000
> [=C2=A0=C2=A0=C2=A0 0.244521] pci 0000:00:00.4: [1106:4282] type 00 c=
lass 0x060000
> [=C2=A0=C2=A0=C2=A0 0.245085] pci 0000:00:00.7: [1106:7282] type 00 c=
lass 0x060000
> [=C2=A0=C2=A0=C2=A0 0.245168] pci 0000:00:01.0: [1106:b188] type 01 c=
lass 0x060400
> [=C2=A0=C2=A0=C2=A0 0.245247] pci 0000:00:01.0: supports D1
> [=C2=A0=C2=A0=C2=A0 0.245281] pci 0000:00:08.0: [105a:3373] type 00 c=
lass 0x010400
> [=C2=A0=C2=A0=C2=A0 0.245305] pci 0000:00:08.0: reg 10: [io=C2=A0 0xa=
800-0xa83f]
> [=C2=A0=C2=A0=C2=A0 0.245319] pci 0000:00:08.0: reg 14: [io=C2=A0 0xa=
400-0xa40f]
> [=C2=A0=C2=A0=C2=A0 0.245332] pci 0000:00:08.0: reg 18: [io=C2=A0 0xa=
000-0xa07f]
> [=C2=A0=C2=A0=C2=A0 0.245347] pci 0000:00:08.0: reg 1c: [mem 0xfaa000=
00-0xfaa00fff]
> [=C2=A0=C2=A0=C2=A0 0.245360] pci 0000:00:08.0: reg 20: [mem 0xfa9000=
00-0xfa91ffff]
> [=C2=A0=C2=A0=C2=A0 0.245422] pci 0000:00:08.0: supports D1
> [=C2=A0=C2=A0=C2=A0 0.245452] pci 0000:00:0a.0: [11ab:4320] type 00 c=
lass 0x020000
> [=C2=A0=C2=A0=C2=A0 0.245478] pci 0000:00:0a.0: reg 10: [mem 0xfac000=
00-0xfac03fff]
> [=C2=A0=C2=A0=C2=A0 0.245492] pci 0000:00:0a.0: reg 14: [io=C2=A0 0xb=
000-0xb0ff]
> [=C2=A0=C2=A0=C2=A0 0.245549] pci 0000:00:0a.0: reg 30: [mem 0xfab000=
00-0xfab1ffff pref]
> [=C2=A0=C2=A0=C2=A0 0.245601] pci 0000:00:0a.0: supports D1 D2
> [=C2=A0=C2=A0=C2=A0 0.245604] pci 0000:00:0a.0: PME# supported from D=
0 D1 D2 D3hot D3cold
> [=C2=A0=C2=A0=C2=A0 0.245672] pci 0000:00:0f.0: [1106:3149] type 00 c=
lass 0x010400
> [=C2=A0=C2=A0=C2=A0 0.245696] pci 0000:00:0f.0: reg 10: [io=C2=A0 0xd=
000-0xd007]
> [=C2=A0=C2=A0=C2=A0 0.245710] pci 0000:00:0f.0: reg 14: [io=C2=A0 0xc=
800-0xc803]
> [=C2=A0=C2=A0=C2=A0 0.245723] pci 0000:00:0f.0: reg 18: [io=C2=A0 0xc=
400-0xc407]
> [=C2=A0=C2=A0=C2=A0 0.245738] pci 0000:00:0f.0: reg 1c: [io=C2=A0 0xc=
000-0xc003]
> [=C2=A0=C2=A0=C2=A0 0.245751] pci 0000:00:0f.0: reg 20: [io=C2=A0 0xb=
800-0xb80f]
> [=C2=A0=C2=A0=C2=A0 0.245765] pci 0000:00:0f.0: reg 24: [io=C2=A0 0xb=
400-0xb4ff]
> [=C2=A0=C2=A0=C2=A0 0.245838] pci 0000:00:0f.1: [1106:0571] type 00 c=
lass 0x01018a
> [=C2=A0=C2=A0=C2=A0 0.245905] pci 0000:00:0f.1: reg 20: [io=C2=A0 0xf=
c00-0xfc0f]
> [=C2=A0=C2=A0=C2=A0 0.246008] pci 0000:00:10.0: [1106:3038] type 00 c=
lass 0x0c0300
> [=C2=A0=C2=A0=C2=A0 0.246074] pci 0000:00:10.0: reg 20: [io=C2=A0 0xd=
400-0xd41f]
> [=C2=A0=C2=A0=C2=A0 0.246136] pci 0000:00:10.0: supports D1 D2
> [=C2=A0=C2=A0=C2=A0 0.246139] pci 0000:00:10.0: PME# supported from D=
0 D1 D2 D3hot D3cold
> [=C2=A0=C2=A0=C2=A0 0.246166] pci 0000:00:10.1: [1106:3038] type 00 c=
lass 0x0c0300
> [=C2=A0=C2=A0=C2=A0 0.246232] pci 0000:00:10.1: reg 20: [io=C2=A0 0xd=
800-0xd81f]
> [=C2=A0=C2=A0=C2=A0 0.246294] pci 0000:00:10.1: supports D1 D2
> [=C2=A0=C2=A0=C2=A0 0.246297] pci 0000:00:10.1: PME# supported from D=
0 D1 D2 D3hot D3cold
> [=C2=A0=C2=A0=C2=A0 0.246324] pci 0000:00:10.2: [1106:3038] type 00 c=
lass 0x0c0300
> [=C2=A0=C2=A0=C2=A0 0.246390] pci 0000:00:10.2: reg 20: [io=C2=A0 0xe=
000-0xe01f]
> [=C2=A0=C2=A0=C2=A0 0.246451] pci 0000:00:10.2: supports D1 D2
> [=C2=A0=C2=A0=C2=A0 0.246454] pci 0000:00:10.2: PME# supported from D=
0 D1 D2 D3hot D3cold
> [=C2=A0=C2=A0=C2=A0 0.246485] pci 0000:00:10.3: [1106:3038] type 00 c=
lass 0x0c0300
> [=C2=A0=C2=A0=C2=A0 0.246551] pci 0000:00:10.3: reg 20: [io=C2=A0 0xe=
400-0xe41f]
> [=C2=A0=C2=A0=C2=A0 0.246612] pci 0000:00:10.3: supports D1 D2
> [=C2=A0=C2=A0=C2=A0 0.246615] pci 0000:00:10.3: PME# supported from D=
0 D1 D2 D3hot D3cold
> [=C2=A0=C2=A0=C2=A0 0.246643] pci 0000:00:10.4: [1106:3104] type 00 c=
lass 0x0c0320
> [=C2=A0=C2=A0=C2=A0 0.246667] pci 0000:00:10.4: reg 10: [mem 0xfae000=
00-0xfae000ff]
> [=C2=A0=C2=A0=C2=A0 0.246770] pci 0000:00:10.4: supports D1 D2
> [=C2=A0=C2=A0=C2=A0 0.246773] pci 0000:00:10.4: PME# supported from D=
0 D1 D2 D3hot D3cold
> [=C2=A0=C2=A0=C2=A0 0.246806] pci 0000:00:11.0: [1106:3227] type 00 c=
lass 0x060100
> [=C2=A0=C2=A0=C2=A0 0.246897] HPET not enabled in BIOS. You might try=
 hpet=3Dforce boot option
> [=C2=A0=C2=A0=C2=A0 0.246910] pci 0000:00:11.0: Enabled onboard AC97/=
MC97 devices
> [=C2=A0=C2=A0=C2=A0 0.246985] pci 0000:00:11.5: [1106:3059] type 00 c=
lass 0x040100
> [=C2=A0=C2=A0=C2=A0 0.247009] pci 0000:00:11.5: reg 10: [io=C2=A0 0xe=
800-0xe8ff]
> [=C2=A0=C2=A0=C2=A0 0.247114] pci 0000:00:11.5: supports D1 D2
> [=C2=A0=C2=A0=C2=A0 0.247138] pci 0000:00:11.6: [1106:3068] type 00 c=
lass 0x078000
> [=C2=A0=C2=A0=C2=A0 0.247162] pci 0000:00:11.6: reg 10: [io=C2=A0 0x0=
000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.247297] pci 0000:00:18.0: [1022:1100] type 00 c=
lass 0x060000
> [=C2=A0=C2=A0=C2=A0 0.247360] pci 0000:00:18.1: [1022:1101] type 00 c=
lass 0x060000
> [=C2=A0=C2=A0=C2=A0 0.247409] pci 0000:00:18.2: [1022:1102] type 00 c=
lass 0x060000
> [=C2=A0=C2=A0=C2=A0 0.247457] pci 0000:00:18.3: [1022:1103] type 00 c=
lass 0x060000
> [=C2=A0=C2=A0=C2=A0 0.247562] pci 0000:01:00.0: [10de:0181] type 00 c=
lass 0x030000
> [=C2=A0=C2=A0=C2=A0 0.247583] pci 0000:01:00.0: reg 10: [mem 0xfb0000=
00-0xfbffffff]
> [=C2=A0=C2=A0=C2=A0 0.247594] pci 0000:01:00.0: reg 14: [mem 0xf00000=
00-0xf7ffffff pref]
> [=C2=A0=C2=A0=C2=A0 0.247640] pci 0000:01:00.0: reg 30: [mem 0xfaf000=
00-0xfaf1ffff pref]
> [=C2=A0=C2=A0=C2=A0 0.247731] pci 0000:00:01.0: PCI bridge to [bus 01=
-01]
> [=C2=A0=C2=A0=C2=A0 0.247743] pci 0000:00:01.0:=C2=A0=C2=A0 bridge wi=
ndow [mem 0xfaf00000-0xfbffffff]
> [=C2=A0=C2=A0=C2=A0 0.247749] pci 0000:00:01.0:=C2=A0=C2=A0 bridge wi=
ndow [mem 0xf0000000-0xf9ffffff pref]
> [=C2=A0=C2=A0=C2=A0 0.247760] pci_bus 0000:00: on NUMA node 0
> [=C2=A0=C2=A0=C2=A0 0.247766] ACPI: PCI Interrupt Routing Table [\_SB=
_.PCI0._PRT]
> [=C2=A0=C2=A0=C2=A0 0.248427]=C2=A0 pci0000:00: Unable to request _OS=
C control (_OSC support mask: 0x1e)
> [=C2=A0=C2=A0=C2=A0 0.267173] ACPI: PCI Interrupt Link [LNKA] (IRQs 3=
 4 5 7 10 *11 14 15)
> [=C2=A0=C2=A0=C2=A0 0.267312] ACPI: PCI Interrupt Link [LNKB] (IRQs 3=
 4 5 7 *10 11 14 15)
> [=C2=A0=C2=A0=C2=A0 0.267430] ACPI: PCI Interrupt Link [LNKC] (IRQs 3=
 4 *5 7 10 11 14 15)
> [=C2=A0=C2=A0=C2=A0 0.268056] ACPI: PCI Interrupt Link [LNKD] (IRQs 3=
 4 5 7 10 11 14 15) *0, disabled.
> [=C2=A0=C2=A0=C2=A0 0.268176] ACPI: PCI Interrupt Link [LNKE] (IRQs 3=
 4 5 7 10 11 14 15) *0, disabled.
> [=C2=A0=C2=A0=C2=A0 0.268295] ACPI: PCI Interrupt Link [LNKF] (IRQs 3=
 4 5 7 10 11 14 15) *0, disabled.
> [=C2=A0=C2=A0=C2=A0 0.268418] ACPI: PCI Interrupt Link [LNKG] (IRQs 3=
 4 5 7 10 11 14 15) *0, disabled.
> [=C2=A0=C2=A0=C2=A0 0.268539] ACPI: PCI Interrupt Link [LNKH] (IRQs 3=
 4 5 7 10 11 14 15) *0, disabled.
> [=C2=A0=C2=A0=C2=A0 0.269104] vgaarb: device added: PCI:0000:01:00.0,=
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
> [=C2=A0=C2=A0=C2=A0 0.269115] vgaarb: loaded
> [=C2=A0=C2=A0=C2=A0 0.269119] vgaarb: bridge control possible 0000:01=
:00.0
> [=C2=A0=C2=A0=C2=A0 0.269217] SCSI subsystem initialized
> [=C2=A0=C2=A0=C2=A0 0.270016] libata version 3.00 loaded.
> [=C2=A0=C2=A0=C2=A0 0.270024] ACPI: bus type usb registered
> [=C2=A0=C2=A0=C2=A0 0.270072] usbcore: registered new interface drive=
r usbfs
> [=C2=A0=C2=A0=C2=A0 0.270072] usbcore: registered new interface drive=
r hub
> [=C2=A0=C2=A0=C2=A0 0.270072] usbcore: registered new device driver u=
sb
> [=C2=A0=C2=A0=C2=A0 0.271028] PCI: Using ACPI for IRQ routing
> [=C2=A0=C2=A0=C2=A0 0.271028] PCI: pci_cache_line_size set to 64 byte=
s
> [=C2=A0=C2=A0=C2=A0 0.271036] pci 0000:00:00.0: address space collisi=
on: [mem 0xec000000-0xefffffff pref] conflicts with GART [mem 0xec00000=
0-0xefffffff]
> [=C2=A0=C2=A0=C2=A0 0.271221] e820: reserve RAM buffer [mem 0x0009fc0=
0-0x0009ffff]
> [=C2=A0=C2=A0=C2=A0 0.271224] e820: reserve RAM buffer [mem 0x7ffb000=
0-0x7fffffff]
> [=C2=A0=C2=A0=C2=A0 0.313100] pnp: PnP ACPI init
> [=C2=A0=C2=A0=C2=A0 0.313100] ACPI: bus type pnp registered
> [=C2=A0=C2=A0=C2=A0 0.313261] pnp 00:00: [bus 00-ff]
> [=C2=A0=C2=A0=C2=A0 0.313265] pnp 00:00: [io=C2=A0 0x0cf8-0x0cff]
> [=C2=A0=C2=A0=C2=A0 0.313269] pnp 00:00: [io=C2=A0 0x0000-0x0cf7 wind=
ow]
> [=C2=A0=C2=A0=C2=A0 0.313271] pnp 00:00: [io=C2=A0 0x0d00-0xffff wind=
ow]
> [=C2=A0=C2=A0=C2=A0 0.313275] pnp 00:00: [mem 0x000a0000-0x000bffff w=
indow]
> [=C2=A0=C2=A0=C2=A0 0.313277] pnp 00:00: [mem 0x00000000 window]
> [=C2=A0=C2=A0=C2=A0 0.313280] pnp 00:00: [mem 0x80000000-0xffffffff w=
indow]
> [=C2=A0=C2=A0=C2=A0 0.313420] pnp 00:00: Plug and Play ACPI device, I=
Ds PNP0a03 (active)
> [=C2=A0=C2=A0=C2=A0 0.313420] pnp 00:01: [dma 4]
> [=C2=A0=C2=A0=C2=A0 0.313420] pnp 00:01: [io=C2=A0 0x0000-0x000f]
> [=C2=A0=C2=A0=C2=A0 0.313420] pnp 00:01: [io=C2=A0 0x0081-0x0083]
> [=C2=A0=C2=A0=C2=A0 0.313420] pnp 00:01: [io=C2=A0 0x0087]
> [=C2=A0=C2=A0=C2=A0 0.313420] pnp 00:01: [io=C2=A0 0x0089-0x008b]
> [=C2=A0=C2=A0=C2=A0 0.313420] pnp 00:01: [io=C2=A0 0x008f]
> [=C2=A0=C2=A0=C2=A0 0.313420] pnp 00:01: [io=C2=A0 0x00c0-0x00df]
> [=C2=A0=C2=A0=C2=A0 0.313420] pnp 00:01: Plug and Play ACPI device, I=
Ds PNP0200 (active)
> [=C2=A0=C2=A0=C2=A0 0.313420] pnp 00:02: [io=C2=A0 0x0070-0x0071]
> [=C2=A0=C2=A0=C2=A0 0.313420] pnp 00:02: [irq 8]
> [=C2=A0=C2=A0=C2=A0 0.314028] pnp 00:02: Plug and Play ACPI device, I=
Ds PNP0b00 (active)
> [=C2=A0=C2=A0=C2=A0 0.314062] pnp 00:03: [io=C2=A0 0x0060]
> [=C2=A0=C2=A0=C2=A0 0.314065] pnp 00:03: [io=C2=A0 0x0064]
> [=C2=A0=C2=A0=C2=A0 0.314074] pnp 00:03: [irq 1]
> [=C2=A0=C2=A0=C2=A0 0.314163] pnp 00:03: Plug and Play ACPI device, I=
Ds PNP0303 PNP030b (active)
> [=C2=A0=C2=A0=C2=A0 0.314163] pnp 00:04: [io=C2=A0 0x0061]
> [=C2=A0=C2=A0=C2=A0 0.314163] pnp 00:04: Plug and Play ACPI device, I=
Ds PNP0800 (active)
> [=C2=A0=C2=A0=C2=A0 0.314163] pnp 00:05: [io=C2=A0 0x00f0-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.314163] pnp 00:05: [irq 13]
> [=C2=A0=C2=A0=C2=A0 0.314163] pnp 00:05: Plug and Play ACPI device, I=
Ds PNP0c04 (active)
> [=C2=A0=C2=A0=C2=A0 0.315164] pnp 00:06: [irq 6]
> [=C2=A0=C2=A0=C2=A0 0.315167] pnp 00:06: [dma 2]
> [=C2=A0=C2=A0=C2=A0 0.315170] pnp 00:06: [io=C2=A0 0x03f0-0x03f5]
> [=C2=A0=C2=A0=C2=A0 0.315173] pnp 00:06: [io=C2=A0 0x03f7]
> [=C2=A0=C2=A0=C2=A0 0.315287] pnp 00:06: Plug and Play ACPI device, I=
Ds PNP0700 (active)
> [=C2=A0=C2=A0=C2=A0 0.315455] pnp 00:07: [io=C2=A0 0x0378-0x037f]
> [=C2=A0=C2=A0=C2=A0 0.315466] pnp 00:07: [irq 7]
> [=C2=A0=C2=A0=C2=A0 0.316068] pnp 00:07: Plug and Play ACPI device, I=
Ds PNP0400 (active)
> [=C2=A0=C2=A0=C2=A0 0.316108] pnp 00:08: [io=C2=A0 0x0000-0xfffffffff=
fffffff disabled]
> [=C2=A0=C2=A0=C2=A0 0.316111] pnp 00:08: [io=C2=A0 0x0680-0x06ff]
> [=C2=A0=C2=A0=C2=A0 0.316114] pnp 00:08: [io=C2=A0 0x0290-0x0297]
> [=C2=A0=C2=A0=C2=A0 0.316241] system 00:08: [io=C2=A0 0x0680-0x06ff] =
has been reserved
> [=C2=A0=C2=A0=C2=A0 0.316241] system 00:08: [io=C2=A0 0x0290-0x0297] =
has been reserved
> [=C2=A0=C2=A0=C2=A0 0.316241] system 00:08: Plug and Play ACPI device=
, IDs PNP0c02 (active)
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0010-0x001f]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0022-0x003f]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0044-0x005f]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0062-0x0063]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0065-0x006f]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0072-0x007f]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0080]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0084-0x0086]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0088]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x008c-0x008e]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0090-0x009f]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x00a2-0x00bf]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x00e0-0x00ef]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x03e1-0x03e7]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x04d0-0x04d1]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0800-0x087f]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0400-0x041f]
> [=C2=A0=C2=A0=C2=A0 0.316241] pnp 00:09: [io=C2=A0 0x0000-0xfffffffff=
fffffff disabled]
> [=C2=A0=C2=A0=C2=A0 0.316282] pnp 00:09: disabling [io=C2=A0 0x0010-0=
x001f] because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316293] pnp 00:09: disabling [io=C2=A0 0x0022-0=
x003f] because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316302] pnp 00:09: disabling [io=C2=A0 0x0044-0=
x005f] because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316311] pnp 00:09: disabling [io=C2=A0 0x0062-0=
x0063] because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316320] pnp 00:09: disabling [io=C2=A0 0x0065-0=
x006f] because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316329] pnp 00:09: disabling [io=C2=A0 0x0072-0=
x007f] because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316338] pnp 00:09: disabling [io=C2=A0 0x0080] =
because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316347] pnp 00:09: disabling [io=C2=A0 0x0084-0=
x0086] because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316356] pnp 00:09: disabling [io=C2=A0 0x0088] =
because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316365] pnp 00:09: disabling [io=C2=A0 0x008c-0=
x008e] because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316374] pnp 00:09: disabling [io=C2=A0 0x0090-0=
x009f] because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316383] pnp 00:09: disabling [io=C2=A0 0x00a2-0=
x00bf] because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.316392] pnp 00:09: disabling [io=C2=A0 0x00e0-0=
x00ef] because it overlaps 0000:00:11.6 BAR 0 [io=C2=A0 0x0000-0x00ff]
> [=C2=A0=C2=A0=C2=A0 0.317005] system 00:09: [io=C2=A0 0x03e1-0x03e7] =
has been reserved
> [=C2=A0=C2=A0=C2=A0 0.317014] system 00:09: [io=C2=A0 0x04d0-0x04d1] =
has been reserved
> [=C2=A0=C2=A0=C2=A0 0.317021] system 00:09: [io=C2=A0 0x0800-0x087f] =
has been reserved
> [=C2=A0=C2=A0=C2=A0 0.317028] system 00:09: [io=C2=A0 0x0400-0x041f] =
has been reserved
> [=C2=A0=C2=A0=C2=A0 0.317039] system 00:09: Plug and Play ACPI device=
, IDs PNP0c02 (active)
> [=C2=A0=C2=A0=C2=A0 0.317151] pnp 00:0a: [mem 0xfec00000-0xfec00fff]
> [=C2=A0=C2=A0=C2=A0 0.317154] pnp 00:0a: [mem 0xfee00000-0xfee00fff]
> [=C2=A0=C2=A0=C2=A0 0.317157] pnp 00:0a: [mem 0xfff80000-0xffffffff]
> [=C2=A0=C2=A0=C2=A0 0.317280] system 00:0a: [mem 0xfec00000-0xfec00ff=
f] could not be reserved
> [=C2=A0=C2=A0=C2=A0 0.317280] system 00:0a: [mem 0xfee00000-0xfee00ff=
f] has been reserved
> [=C2=A0=C2=A0=C2=A0 0.317280] system 00:0a: [mem 0xfff80000-0xfffffff=
f] has been reserved
> [=C2=A0=C2=A0=C2=A0 0.317280] system 00:0a: Plug and Play ACPI device=
, IDs PNP0c02 (active)
> [=C2=A0=C2=A0=C2=A0 0.317459] pnp 00:0b: [irq 3]
> [=C2=A0=C2=A0=C2=A0 0.317462] pnp 00:0b: [dma 0 disabled]
> [=C2=A0=C2=A0=C2=A0 0.317465] pnp 00:0b: [io=C2=A0 0x02f8-0x02ff]
> [=C2=A0=C2=A0=C2=A0 0.318009] pnp 00:0b: Plug and Play ACPI device, I=
Ds PNP0501 (active)
> [=C2=A0=C2=A0=C2=A0 0.318432] pnp 00:0c: [io=C2=A0 0x03f8-0x03ff]
> [=C2=A0=C2=A0=C2=A0 0.318442] pnp 00:0c: [irq 4]
> [=C2=A0=C2=A0=C2=A0 0.318580] pnp 00:0c: Plug and Play ACPI device, I=
Ds PNP0501 (active)
> [=C2=A0=C2=A0=C2=A0 0.319310] pnp 00:0d: [mem 0x00000000-0x0009ffff]
> [=C2=A0=C2=A0=C2=A0 0.319313] pnp 00:0d: [mem 0x000c0000-0x000dffff]
> [=C2=A0=C2=A0=C2=A0 0.319317] pnp 00:0d: [mem 0x000e0000-0x000fffff]
> [=C2=A0=C2=A0=C2=A0 0.319320] pnp 00:0d: [mem 0x00100000-0x7ffeffff]
> [=C2=A0=C2=A0=C2=A0 0.319322] pnp 00:0d: [mem 0x00000000-0xffffffffff=
ffffff disabled]
> [=C2=A0=C2=A0=C2=A0 0.319330] pnp 00:0d: disabling [mem 0x00000000-0x=
0009ffff] because it overlaps 0000:00:00.0 BAR 0 [mem 0x00000000-0x03ff=
ffff pref]
> [=C2=A0=C2=A0=C2=A0 0.319342] pnp 00:0d: disabling [mem 0x000c0000-0x=
000dffff] because it overlaps 0000:00:00.0 BAR 0 [mem 0x00000000-0x03ff=
ffff pref]
> [=C2=A0=C2=A0=C2=A0 0.319352] pnp 00:0d: disabling [mem 0x000e0000-0x=
000fffff] because it overlaps 0000:00:00.0 BAR 0 [mem 0x00000000-0x03ff=
ffff pref]
> [=C2=A0=C2=A0=C2=A0 0.319362] pnp 00:0d: disabling [mem 0x00100000-0x=
7ffeffff] because it overlaps 0000:00:00.0 BAR 0 [mem 0x00000000-0x03ff=
ffff pref]
> [=C2=A0=C2=A0=C2=A0 0.319520] system 00:0d: Plug and Play ACPI device=
, IDs PNP0c01 (active)
> [=C2=A0=C2=A0=C2=A0 0.319520] pnp: PnP ACPI: found 14 devices
> [=C2=A0=C2=A0=C2=A0 0.319520] ACPI: ACPI bus type pnp unregistered
> [=C2=A0=C2=A0=C2=A0 0.335173] Switching to clocksource acpi_pm
> [=C2=A0=C2=A0=C2=A0 0.335305] pci 0000:00:11.6: BAR 0: assigned [io=C2=
=A0 0x1000-0x10ff]
> [=C2=A0=C2=A0=C2=A0 0.335318] pci 0000:00:01.0: PCI bridge to [bus 01=
-01]
> [=C2=A0=C2=A0=C2=A0 0.335329] pci 0000:00:01.0:=C2=A0=C2=A0 bridge wi=
ndow [mem 0xfaf00000-0xfbffffff]
> [=C2=A0=C2=A0=C2=A0 0.335339] pci 0000:00:01.0:=C2=A0=C2=A0 bridge wi=
ndow [mem 0xf0000000-0xf9ffffff pref]
> [=C2=A0=C2=A0=C2=A0 0.335364] pci 0000:00:01.0: setting latency timer=
 to 64
> [=C2=A0=C2=A0=C2=A0 0.335369] pci_bus 0000:00: resource 4 [io=C2=A0 0=
x0000-0xffff]
> [=C2=A0=C2=A0=C2=A0 0.335372] pci_bus 0000:00: resource 5 [mem 0x000a=
0000-0x000bffff]
> [=C2=A0=C2=A0=C2=A0 0.335375] pci_bus 0000:00: resource 6 [mem 0x8000=
0000-0xfcffffffff]
> [=C2=A0=C2=A0=C2=A0 0.335378] pci_bus 0000:01: resource 1 [mem 0xfaf0=
0000-0xfbffffff]
> [=C2=A0=C2=A0=C2=A0 0.335381] pci_bus 0000:01: resource 2 [mem 0xf000=
0000-0xf9ffffff pref]
> [=C2=A0=C2=A0=C2=A0 0.335457] NET: Registered protocol family 2
> [=C2=A0=C2=A0=C2=A0 0.335600] IP route cache hash table entries: 6553=
6 (order: 7, 524288 bytes)
> [=C2=A0=C2=A0=C2=A0 0.336370] TCP established hash table entries: 262=
144 (order: 10, 4194304 bytes)
> [=C2=A0=C2=A0=C2=A0 0.338748] TCP bind hash table entries: 65536 (ord=
er: 10, 4194304 bytes)
> [=C2=A0=C2=A0=C2=A0 0.348019] TCP: Hash tables configured (establishe=
d 262144 bind 65536)
> [=C2=A0=C2=A0=C2=A0 0.348083] TCP: reno registered
> [=C2=A0=C2=A0=C2=A0 0.348104] UDP hash table entries: 1024 (order: 5,=
 163840 bytes)
> [=C2=A0=C2=A0=C2=A0 0.348413] UDP-Lite hash table entries: 1024 (orde=
r: 5, 163840 bytes)
> [=C2=A0=C2=A0=C2=A0 0.348875] NET: Registered protocol family 1
> [=C2=A0=C2=A0=C2=A0 0.349246] RPC: Registered named UNIX socket trans=
port module.
> [=C2=A0=C2=A0=C2=A0 0.349259] RPC: Registered udp transport module.
> [=C2=A0=C2=A0=C2=A0 0.349264] RPC: Registered tcp transport module.
> [=C2=A0=C2=A0=C2=A0 0.349270] RPC: Registered tcp NFSv4.1 backchannel=
 transport module.
> [=C2=A0=C2=A0=C2=A0 0.349368] pci 0000:00:01.0: disabling DAC on VIA =
PCI bridge
> [=C2=A0=C2=A0=C2=A0 0.349385] PCI: CLS mismatch (580 !=3D 64), using =
64 bytes
> [=C2=A0=C2=A0=C2=A0 0.349605] pci 0000:01:00.0: Boot video device
> [=C2=A0=C2=A0=C2=A0 0.351738] audit: initializing netlink socket (dis=
abled)
> [=C2=A0=C2=A0=C2=A0 0.351797] type=3D2000 audit(1346246761.350:1): in=
itialized
> [=C2=A0=C2=A0=C2=A0 0.364668] VFS: Disk quotas dquot_6.5.2
> [=C2=A0=C2=A0=C2=A0 0.364861] Dquot-cache hash table entries: 512 (or=
der 0, 4096 bytes)
> [=C2=A0=C2=A0=C2=A0 0.367808] NFS: Registering the id_resolver key ty=
pe
> [=C2=A0=C2=A0=C2=A0 0.367939] Key type id_resolver registered
> [=C2=A0=C2=A0=C2=A0 0.367945] Key type id_legacy registered
> [=C2=A0=C2=A0=C2=A0 0.368666] Installing knfsd (copyright (C) 1996 ok=
ir@monad.swb.de).
> [=C2=A0=C2=A0=C2=A0 0.369454] NTFS driver 2.1.30 [Flags: R/W].
> [=C2=A0=C2=A0=C2=A0 0.369788] ROMFS MTD (C) 2007 Red Hat, Inc.
> [=C2=A0=C2=A0=C2=A0 0.370393] JFS: nTxBlock =3D 8192, nTxLock =3D 655=
36
> [=C2=A0=C2=A0=C2=A0 0.376707] SGI XFS with ACLs, security attributes,=
 large block/inode numbers, no debug enabled
> [=C2=A0=C2=A0=C2=A0 0.378035] OCFS2 1.5.0
> [=C2=A0=C2=A0=C2=A0 0.378326] ocfs2: Registered cluster interface o2c=
b
> [=C2=A0=C2=A0=C2=A0 0.378336] OCFS2 DLMFS 1.5.0
> [=C2=A0=C2=A0=C2=A0 0.378564] OCFS2 User DLM kernel interface loaded
> [=C2=A0=C2=A0=C2=A0 0.378573] OCFS2 Node Manager 1.5.0
> [=C2=A0=C2=A0=C2=A0 0.379247] OCFS2 DLM 1.5.0
> [=C2=A0=C2=A0=C2=A0 0.380884] Btrfs loaded
> [=C2=A0=C2=A0=C2=A0 0.380907] msgmni has been set to 3966
> [=C2=A0=C2=A0=C2=A0 0.383850] async_tx: api initialized (async)
> [=C2=A0=C2=A0=C2=A0 0.384215] Block layer SCSI generic (bsg) driver v=
ersion 0.4 loaded (major 252)
> [=C2=A0=C2=A0=C2=A0 0.384376] io scheduler noop registered
> [=C2=A0=C2=A0=C2=A0 0.384388] io scheduler deadline registered
> [=C2=A0=C2=A0=C2=A0 0.384600] io scheduler cfq registered (default)
> [=C2=A0=C2=A0=C2=A0 0.385456] pci_hotplug: PCI Hot Plug PCI Core vers=
ion: 0.5
> [=C2=A0=C2=A0=C2=A0 0.385765] vesafb: mode is 1024x768x16, linelength=
=3D2048, pages=3D1
> [=C2=A0=C2=A0=C2=A0 0.385771] vesafb: scrolling: redraw
> [=C2=A0=C2=A0=C2=A0 0.385777] vesafb: Truecolor: size=3D0:5:6:5, shif=
t=3D0:11:5:0
> [=C2=A0=C2=A0=C2=A0 0.386104] vesafb: framebuffer at 0xf0000000, mapp=
ed to 0xffffc90000700000, using 3072k, total 65536k
> [=C2=A0=C2=A0=C2=A0 0.422852] Console: switching to colour frame buff=
er device 128x48
> [=C2=A0=C2=A0=C2=A0 0.456134] fb0: VESA VGA frame buffer device
> [=C2=A0=C2=A0=C2=A0 0.456672] GHES: HEST is not enabled!
> [=C2=A0=C2=A0=C2=A0 0.466562] Serial: 8250/16550 driver, 4 ports, IRQ=
 sharing enabled
> [=C2=A0=C2=A0=C2=A0 0.732291] serial8250: ttyS0 at I/O 0x3f8 (irq =3D=
 4) is a 16550A
> [=C2=A0=C2=A0=C2=A0 0.997289] serial8250: ttyS1 at I/O 0x2f8 (irq =3D=
 3) is a 16550A
> [=C2=A0=C2=A0=C2=A0 1.020196] 00:0b: ttyS1 at I/O 0x2f8 (irq =3D 3) i=
s a 16550A
> [=C2=A0=C2=A0=C2=A0 1.041571] 00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) i=
s a 16550A
> [=C2=A0=C2=A0=C2=A0 1.043410] Floppy drive(s): fd0 is 1.44M
> [=C2=A0=C2=A0=C2=A0 1.057982] FDC 0 is a post-1991 82077
> [=C2=A0=C2=A0=C2=A0 1.066402] brd: module loaded
> [=C2=A0=C2=A0=C2=A0 1.066619] Compaq SMART2 Driver (v 2.6.0)
> [=C2=A0=C2=A0=C2=A0 1.067336] HP CISS Driver (v 3.6.26)
> [=C2=A0=C2=A0=C2=A0 1.070622] fnic: Cisco FCoE HBA Driver, ver 1.5.0.=
2
> [=C2=A0=C2=A0=C2=A0 1.072101] Adaptec aacraid driver 1.2-0[28900]-ms
> [=C2=A0=C2=A0=C2=A0 1.072920] aic94xx: Adaptec aic94xx SAS/SATA drive=
r version 1.0.3 loaded
> [=C2=A0=C2=A0=C2=A0 1.073957] scsi: <fdomain> Detection failed (no ca=
rd)
> [=C2=A0=C2=A0=C2=A0 1.074461] qla2xxx [0000:00:00.0]-0005: : QLogic F=
ibre Channel HBA Driver: 8.04.00.03-k.
> [=C2=A0=C2=A0=C2=A0 1.075183] Emulex LightPulse Fibre Channel SCSI dr=
iver 8.3.31
> [=C2=A0=C2=A0=C2=A0 1.086630] Copyright(c) 2004-2009 Emulex.=C2=A0 Al=
l rights reserved.
> [=C2=A0=C2=A0=C2=A0 1.098503] Brocade BFA FC/FCOE SCSI driver - versi=
on: 3.0.23.0
> [=C2=A0=C2=A0=C2=A0 1.110585] DC390: clustering now enabled by defaul=
t. If you get problems load
> [=C2=A0=C2=A0=C2=A0 1.122137]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 with "disable_clustering=3D1" and report to maintainers
> [=C2=A0=C2=A0=C2=A0 1.134055] megaraid cmm: 2.20.2.7 (Release Date: S=
un Jul 16 00:01:03 EST 2006)
> [=C2=A0=C2=A0=C2=A0 1.146184] megaraid: 2.20.5.1 (Release Date: Thu N=
ov 16 15:32:35 EST 2006)
> [=C2=A0=C2=A0=C2=A0 1.158397] megasas: 00.00.06.15-rc1 Mon. Mar. 19 1=
7:00:00 PDT 2012
> [=C2=A0=C2=A0=C2=A0 1.170724] mpt2sas version 13.100.00.00 loaded
> [=C2=A0=C2=A0=C2=A0 1.183336] GDT-HA: Storage RAID Controller Driver.=
 Version: 3.05
> [=C2=A0=C2=A0=C2=A0 1.196196] 3ware Storage Controller device driver =
for Linux v1.26.02.003.
> [=C2=A0=C2=A0=C2=A0 1.209111] 3ware 9000 Storage Controller device dr=
iver for Linux v2.26.02.014.
> [=C2=A0=C2=A0=C2=A0 1.222272] LSI 3ware SAS/SATA-RAID Controller devi=
ce driver for Linux v3.26.02.000.
> [=C2=A0=C2=A0=C2=A0 1.235683] ipr: IBM Power RAID SCSI Device Driver =
version: 2.5.3 (March 10, 2012)
> [=C2=A0=C2=A0=C2=A0 1.249146] RocketRAID 3xxx/4xxx Controller driver =
v1.6 (090910)
> [=C2=A0=C2=A0=C2=A0 1.262466] stex: Promise SuperTrak EX Driver versi=
on: 4.6.0000.4
> [=C2=A0=C2=A0=C2=A0 1.276286] st: Version 20101219, fixed bufsize 327=
68, s/g segs 256
> [=C2=A0=C2=A0=C2=A0 1.291908] sata_promise 0000:00:08.0: version 2.12
> [=C2=A0=C2=A0=C2=A0 1.305272] scsi0 : sata_promise
> [=C2=A0=C2=A0=C2=A0 1.319375] scsi1 : sata_promise
> [=C2=A0=C2=A0=C2=A0 1.333087] scsi2 : sata_promise
> [=C2=A0=C2=A0=C2=A0 1.346344] ata1: SATA max UDMA/133 mmio m4096@0xfa=
a00000 ata 0xfaa00200 irq 18
> [=C2=A0=C2=A0=C2=A0 1.359696] ata2: SATA max UDMA/133 mmio m4096@0xfa=
a00000 ata 0xfaa00280 irq 18
> [=C2=A0=C2=A0=C2=A0 1.372854] ata3: PATA max UDMA/133 mmio m4096@0xfa=
a00000 ata 0xfaa00300 irq 18
> [=C2=A0=C2=A0=C2=A0 1.386920] sata_via 0000:00:0f.0: version 2.6
> [=C2=A0=C2=A0=C2=A0 1.387026] sata_via 0000:00:0f.0: routed to hard i=
rq line 10
> [=C2=A0=C2=A0=C2=A0 1.400982] scsi3 : sata_via
> [=C2=A0=C2=A0=C2=A0 1.413857] scsi4 : sata_via
> [=C2=A0=C2=A0=C2=A0 1.426325] ata4: SATA max UDMA/133 cmd 0xd000 ctl =
0xc800 bmdma 0xb800 irq 20
> [=C2=A0=C2=A0=C2=A0 1.438985] ata5: SATA max UDMA/133 cmd 0xc400 ctl =
0xc000 bmdma 0xb808 irq 20
> [=C2=A0=C2=A0=C2=A0 1.455989] pata_via 0000:00:0f.1: version 0.3.4
> [=C2=A0=C2=A0=C2=A0 1.457804] scsi5 : pata_via
> [=C2=A0=C2=A0=C2=A0 1.470493] scsi6 : pata_via
> [=C2=A0=C2=A0=C2=A0 1.486232] ata6: PATA max UDMA/133 cmd 0x1f0 ctl 0=
x3f6 bmdma 0xfc00 irq 14
> [=C2=A0=C2=A0=C2=A0 1.498656] ata7: PATA max UDMA/133 cmd 0x170 ctl 0=
x376 bmdma 0xfc08 irq 15
> [=C2=A0=C2=A0=C2=A0 1.512403] I2O subsystem v1.325
> [=C2=A0=C2=A0=C2=A0 1.524679] i2o: max drivers =3D 8
> [=C2=A0=C2=A0=C2=A0 1.537342] I2O Configuration OSM v1.323
> [=C2=A0=C2=A0=C2=A0 1.549732] I2O Bus Adapter OSM v1.317
> [=C2=A0=C2=A0=C2=A0 1.562070] I2O Block Device OSM v1.325
> [=C2=A0=C2=A0=C2=A0 1.574615] I2O SCSI Peripheral OSM v1.316
> [=C2=A0=C2=A0=C2=A0 1.586856] I2O ProcFS OSM v1.316
> [=C2=A0=C2=A0=C2=A0 1.598969] Fusion MPT base driver 3.04.20
> [=C2=A0=C2=A0=C2=A0 1.610891] Copyright (c) 1999-2008 LSI Corporation
> [=C2=A0=C2=A0=C2=A0 1.622769] Fusion MPT SPI Host driver 3.04.20
> [=C2=A0=C2=A0=C2=A0 1.634555] Fusion MPT FC Host driver 3.04.20
> [=C2=A0=C2=A0=C2=A0 1.646080] Fusion MPT SAS Host driver 3.04.20
> [=C2=A0=C2=A0=C2=A0 1.657311] ata4: SATA link up 1.5 Gbps (SStatus 11=
3 SControl 300)
> [=C2=A0=C2=A0=C2=A0 1.663083] Fusion MPT misc device (ioctl) driver 3=
=2E04.20
> [=C2=A0=C2=A0=C2=A0 1.663249] mptctl: Registered with Fusion MPT base=
 driver
> [=C2=A0=C2=A0=C2=A0 1.663251] mptctl: /dev/mptctl @ (major,minor=3D10=
,220)
> [=C2=A0=C2=A0=C2=A0 1.663252] Fusion MPT LAN driver 3.04.20
> [=C2=A0=C2=A0=C2=A0 1.663593] ehci_hcd: USB 2.0 'Enhanced' Host Contr=
oller (EHCI) Driver
> [=C2=A0=C2=A0=C2=A0 1.663672] ehci_hcd 0000:00:10.4: EHCI Host Contro=
ller
> [=C2=A0=C2=A0=C2=A0 1.664256] ehci_hcd 0000:00:10.4: new USB bus regi=
stered, assigned bus number 1
> [=C2=A0=C2=A0=C2=A0 1.664375] ehci_hcd 0000:00:10.4: irq 21, io mem 0=
xfae00000
> [=C2=A0=C2=A0=C2=A0 1.670025] ehci_hcd 0000:00:10.4: USB 2.0 started,=
 EHCI 1.00
> [=C2=A0=C2=A0=C2=A0 1.670170] usb usb1: New USB device found, idVendo=
r=3D1d6b, idProduct=3D0002
> [=C2=A0=C2=A0=C2=A0 1.670173] usb usb1: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
> [=C2=A0=C2=A0=C2=A0 1.670175] usb usb1: Product: EHCI Host Controller
> [=C2=A0=C2=A0=C2=A0 1.670177] usb usb1: Manufacturer: Linux 3.5.2 ehc=
i_hcd
> [=C2=A0=C2=A0=C2=A0 1.670178] usb usb1: SerialNumber: 0000:00:10.4
> [=C2=A0=C2=A0=C2=A0 1.671025] hub 1-0:1.0: USB hub found
> [=C2=A0=C2=A0=C2=A0 1.671058] hub 1-0:1.0: 8 ports detected
> [=C2=A0=C2=A0=C2=A0 1.671844] ohci_hcd: USB 1.1 'Open' Host Controlle=
r (OHCI) Driver
> [=C2=A0=C2=A0=C2=A0 1.671965] uhci_hcd: USB Universal Host Controller=
 Interface driver
> [=C2=A0=C2=A0=C2=A0 1.672057] uhci_hcd 0000:00:10.0: UHCI Host Contro=
ller
> [=C2=A0=C2=A0=C2=A0 1.672272] uhci_hcd 0000:00:10.0: new USB bus regi=
stered, assigned bus number 2
> [=C2=A0=C2=A0=C2=A0 1.672307] uhci_hcd 0000:00:10.0: irq 21, io base =
0x0000d400
> [=C2=A0=C2=A0=C2=A0 1.672443] usb usb2: New USB device found, idVendo=
r=3D1d6b, idProduct=3D0001
> [=C2=A0=C2=A0=C2=A0 1.672445] usb usb2: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
> [=C2=A0=C2=A0=C2=A0 1.672447] usb usb2: Product: UHCI Host Controller
> [=C2=A0=C2=A0=C2=A0 1.672449] usb usb2: Manufacturer: Linux 3.5.2 uhc=
i_hcd
> [=C2=A0=C2=A0=C2=A0 1.672451] usb usb2: SerialNumber: 0000:00:10.0
> [=C2=A0=C2=A0=C2=A0 1.672868] hub 2-0:1.0: USB hub found
> [=C2=A0=C2=A0=C2=A0 1.672881] hub 2-0:1.0: 2 ports detected
> [=C2=A0=C2=A0=C2=A0 1.673132] uhci_hcd 0000:00:10.1: UHCI Host Contro=
ller
> [=C2=A0=C2=A0=C2=A0 1.673322] uhci_hcd 0000:00:10.1: new USB bus regi=
stered, assigned bus number 3
> [=C2=A0=C2=A0=C2=A0 1.673353] uhci_hcd 0000:00:10.1: irq 21, io base =
0x0000d800
> [=C2=A0=C2=A0=C2=A0 1.673427] usb usb3: New USB device found, idVendo=
r=3D1d6b, idProduct=3D0001
> [=C2=A0=C2=A0=C2=A0 1.673429] usb usb3: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
> [=C2=A0=C2=A0=C2=A0 1.673431] usb usb3: Product: UHCI Host Controller
> [=C2=A0=C2=A0=C2=A0 1.673433] usb usb3: Manufacturer: Linux 3.5.2 uhc=
i_hcd
> [=C2=A0=C2=A0=C2=A0 1.673434] usb usb3: SerialNumber: 0000:00:10.1
> [=C2=A0=C2=A0=C2=A0 1.673830] hub 3-0:1.0: USB hub found
> [=C2=A0=C2=A0=C2=A0 1.673840] hub 3-0:1.0: 2 ports detected
> [=C2=A0=C2=A0=C2=A0 1.674082] uhci_hcd 0000:00:10.2: UHCI Host Contro=
ller
> [=C2=A0=C2=A0=C2=A0 1.674266] uhci_hcd 0000:00:10.2: new USB bus regi=
stered, assigned bus number 4
> [=C2=A0=C2=A0=C2=A0 1.674297] uhci_hcd 0000:00:10.2: irq 21, io base =
0x0000e000
> [=C2=A0=C2=A0=C2=A0 1.674372] usb usb4: New USB device found, idVendo=
r=3D1d6b, idProduct=3D0001
> [=C2=A0=C2=A0=C2=A0 1.674374] usb usb4: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
> [=C2=A0=C2=A0=C2=A0 1.674376] usb usb4: Product: UHCI Host Controller
> [=C2=A0=C2=A0=C2=A0 1.674378] usb usb4: Manufacturer: Linux 3.5.2 uhc=
i_hcd
> [=C2=A0=C2=A0=C2=A0 1.674380] usb usb4: SerialNumber: 0000:00:10.2
> [=C2=A0=C2=A0=C2=A0 1.674771] hub 4-0:1.0: USB hub found
> [=C2=A0=C2=A0=C2=A0 1.674781] hub 4-0:1.0: 2 ports detected
> [=C2=A0=C2=A0=C2=A0 1.674986] uhci_hcd 0000:00:10.3: UHCI Host Contro=
ller
> [=C2=A0=C2=A0=C2=A0 1.675203] uhci_hcd 0000:00:10.3: new USB bus regi=
stered, assigned bus number 5
> [=C2=A0=C2=A0=C2=A0 1.675233] uhci_hcd 0000:00:10.3: irq 21, io base =
0x0000e400
> [=C2=A0=C2=A0=C2=A0 1.675312] usb usb5: New USB device found, idVendo=
r=3D1d6b, idProduct=3D0001
> [=C2=A0=C2=A0=C2=A0 1.675314] usb usb5: New USB device strings: Mfr=3D=
3, Product=3D2, SerialNumber=3D1
> [=C2=A0=C2=A0=C2=A0 1.675316] usb usb5: Product: UHCI Host Controller
> [=C2=A0=C2=A0=C2=A0 1.675318] usb usb5: Manufacturer: Linux 3.5.2 uhc=
i_hcd
> [=C2=A0=C2=A0=C2=A0 1.675320] usb usb5: SerialNumber: 0000:00:10.3
> [=C2=A0=C2=A0=C2=A0 1.675721] hub 5-0:1.0: USB hub found
> [=C2=A0=C2=A0=C2=A0 1.675731] hub 5-0:1.0: 2 ports detected
> [=C2=A0=C2=A0=C2=A0 1.677086] Initializing USB Mass Storage driver...
> [=C2=A0=C2=A0=C2=A0 1.677214] usbcore: registered new interface drive=
r usb-storage
> [=C2=A0=C2=A0=C2=A0 1.677215] USB Mass Storage support registered.
> [=C2=A0=C2=A0=C2=A0 1.677303] usbcore: registered new interface drive=
r ums-alauda
> [=C2=A0=C2=A0=C2=A0 1.677389] usbcore: registered new interface drive=
r ums-cypress
> [=C2=A0=C2=A0=C2=A0 1.677477] usbcore: registered new interface drive=
r ums-datafab
> [=C2=A0=C2=A0=C2=A0 1.677562] usbcore: registered new interface drive=
r ums-freecom
> [=C2=A0=C2=A0=C2=A0 1.677650] usbcore: registered new interface drive=
r ums-isd200
> [=C2=A0=C2=A0=C2=A0 1.677734] usbcore: registered new interface drive=
r ums-jumpshot
> [=C2=A0=C2=A0=C2=A0 1.677819] usbcore: registered new interface drive=
r ums-karma
> [=C2=A0=C2=A0=C2=A0 1.677907] usbcore: registered new interface drive=
r ums-onetouch
> [=C2=A0=C2=A0=C2=A0 1.677998] usbcore: registered new interface drive=
r ums-sddr09
> [=C2=A0=C2=A0=C2=A0 1.678105] usbcore: registered new interface drive=
r ums-sddr55
> [=C2=A0=C2=A0=C2=A0 1.678190] usbcore: registered new interface drive=
r ums-usbat
> [=C2=A0=C2=A0=C2=A0 1.678395] i8042: PNP: PS/2 Controller [PNP0303:PS=
2K] at 0x60,0x64 irq 1
> [=C2=A0=C2=A0=C2=A0 1.678396] i8042: PNP: PS/2 appears to have AUX po=
rt disabled, if this is incorrect please boot with i8042.nopnp
> [=C2=A0=C2=A0=C2=A0 1.678750] serio: i8042 KBD port at 0x60,0x64 irq =
1
> [=C2=A0=C2=A0=C2=A0 1.679583] mousedev: PS/2 mouse device common for =
all mice
> [=C2=A0=C2=A0=C2=A0 1.679749] rtc_cmos 00:02: RTC can wake from S4
> [=C2=A0=C2=A0=C2=A0 1.680491] rtc_cmos 00:02: rtc core: registered rt=
c_cmos as rtc0
> [=C2=A0=C2=A0=C2=A0 1.680558] rtc0: alarms up to one year, y3k, 114 b=
ytes nvram
> [=C2=A0=C2=A0=C2=A0 1.680675] md: linear personality registered for l=
evel -1
> [=C2=A0=C2=A0=C2=A0 1.680677] md: raid0 personality registered for le=
vel 0
> [=C2=A0=C2=A0=C2=A0 1.680678] md: raid1 personality registered for le=
vel 1
> [=C2=A0=C2=A0=C2=A0 1.680680] md: raid10 personality registered for l=
evel 10
> [=C2=A0=C2=A0=C2=A0 1.680681] md: raid6 personality registered for le=
vel 6
> [=C2=A0=C2=A0=C2=A0 1.680682] md: raid5 personality registered for le=
vel 5
> [=C2=A0=C2=A0=C2=A0 1.680683] md: raid4 personality registered for le=
vel 4
> [=C2=A0=C2=A0=C2=A0 1.680685] md: multipath personality registered fo=
r level -4
> [=C2=A0=C2=A0=C2=A0 1.680988] device-mapper: uevent: version 1.0.3
> [=C2=A0=C2=A0=C2=A0 1.681350] device-mapper: ioctl: 4.22.0-ioctl (201=
1-10-19) initialised: dm-devel@redhat.com
> [=C2=A0=C2=A0=C2=A0 1.681706] cpuidle: using governor ladder
> [=C2=A0=C2=A0=C2=A0 1.681708] cpuidle: using governor menu
> [=C2=A0=C2=A0=C2=A0 1.681892] input: Speakup as /devices/virtual/inpu=
t/input0
> [=C2=A0=C2=A0=C2=A0 1.682165] initialized device: /dev/synth, node (M=
AJOR 10, MINOR 25)
> [=C2=A0=C2=A0=C2=A0 1.682240] speakup 3.1.6: initialized
> [=C2=A0=C2=A0=C2=A0 1.682240] synth name on entry is: (null)
> [=C2=A0=C2=A0=C2=A0 1.682420] TCP: cubic registered
> [=C2=A0=C2=A0=C2=A0 1.682420] Initializing XFRM netlink socket
> [=C2=A0=C2=A0=C2=A0 1.682449] NET: Registered protocol family 17
> [=C2=A0=C2=A0=C2=A0 1.682558] Key type dns_resolver registered
> [=C2=A0=C2=A0=C2=A0 1.709879] input: AT Translated Set 2 keyboard as =
/devices/platform/i8042/serio0/input/input1
> [=C2=A0=C2=A0=C2=A0 1.711034] ata1: SATA link down (SStatus 0 SContro=
l 300)
> [=C2=A0=C2=A0=C2=A0 2.016029] ata2: SATA link down (SStatus 0 SContro=
l 300)
> [=C2=A0=C2=A0=C2=A0 2.979596]=20
> [=C2=A0=C2=A0=C2=A0 2.980587] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [=C2=A0=C2=A0=C2=A0 2.980587] [ INFO: inconsistent lock state ]
> [=C2=A0=C2=A0=C2=A0 2.980587] 3.5.2 #4 Not tainted
> [=C2=A0=C2=A0=C2=A0 2.980587] ---------------------------------
> [=C2=A0=C2=A0=C2=A0 2.980587] inconsistent {HARDIRQ-ON-W} -> {IN-HARD=
IRQ-W} usage.
> [=C2=A0=C2=A0=C2=A0 2.980587] swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] tak=
es:
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 (&(&host->lock)->rlock){?.+...}, =
at: [<ffffffff818f4e47>] ata_bmdma_interrupt+0x27/0x1d0
> [=C2=A0=C2=A0=C2=A0 2.980587] {HARDIRQ-ON-W} state was registered at:
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff810998fb>] __lock=
_acquire+0x61b/0x1af0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff8109b31a>] lock_a=
cquire+0x8a/0x110
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff81b4d051>] _raw_s=
pin_lock+0x31/0x40
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff8190b3c5>] pdc_sa=
ta_hardreset+0x85/0x100
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff818eabba>] ata_do=
_reset+0x3a/0x90
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff818edd72>] ata_eh=
_reset+0x372/0xe00
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff818eec25>] ata_eh=
_recover+0x2a5/0x13d0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff818f073d>] ata_do=
_eh+0x4d/0xb0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff818f33ba>] ata_sf=
f_error_handler+0xca/0x120
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff8190a9e4>] pdc_er=
ror_handler+0x24/0x30
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff818f029c>] ata_sc=
si_port_error_handler+0x47c/0x800
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff818f06be>] ata_sc=
si_error+0x9e/0xd0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff816732e8>] scsi_e=
rror_handler+0xf8/0x500
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff810654fe>] kthrea=
d+0xae/0xc0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 [<ffffffff81b4f5f4>] kernel=
_thread_helper+0x4/0x10
> [=C2=A0=C2=A0=C2=A0 2.980587] irq event stamp: 44044
> [=C2=A0=C2=A0=C2=A0 2.980587] hardirqs last=C2=A0 enabled at (44041):=
 [<ffffffff8100ab7d>] default_idle+0x5d/0x1b0
> [=C2=A0=C2=A0=C2=A0 2.980587] hardirqs last disabled at (44042): [<ff=
ffffff81b4da67>] common_interrupt+0x67/0x6c
> [=C2=A0=C2=A0=C2=A0 2.980587] softirqs last=C2=A0 enabled at (44044):=
 [<ffffffff810498d3>] _local_bh_enable+0x13/0x20
> [=C2=A0=C2=A0=C2=A0 2.980587] softirqs last disabled at (44043): [<ff=
ffffff8104a355>] irq_enter+0x75/0x90
> [=C2=A0=C2=A0=C2=A0 2.980587]=20
> [=C2=A0=C2=A0=C2=A0 2.980587] other info that might help us debug thi=
s:
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 Possible unsafe locking scenario:
> [=C2=A0=C2=A0=C2=A0 2.980587]=20
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 CPU0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ----
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 lock(&(&host->lock)->rlock)=
;
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0 <Interrupt>
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0=C2=A0=C2=A0=C2=A0 lock(&(&host->l=
ock)->rlock);
> [=C2=A0=C2=A0=C2=A0 2.980587]=20
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 *** DEADLOCK ***
> [=C2=A0=C2=A0=C2=A0 2.980587]=20
> [=C2=A0=C2=A0=C2=A0 2.980587] no locks held by swapper/1/0.
> [=C2=A0=C2=A0=C2=A0 2.980587]=20
> [=C2=A0=C2=A0=C2=A0 2.980587] stack backtrace:
> [=C2=A0=C2=A0=C2=A0 2.980587] Pid: 0, comm: swapper/1 Not tainted 3.5=
=2E2 #4
> [=C2=A0=C2=A0=C2=A0 2.980587] Call Trace:
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 <IRQ>=C2=A0 [<ffffffff81b35961>] =
print_usage_bug+0x1f7/0x208
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff8101001f>] ? save_stack=
_trace+0x2f/0x50
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff81098730>] ? print_shor=
test_lock_dependencies+0x1d0/0x1d0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff810992a2>] mark_lock+0x=
262/0x2a0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff81099af3>] __lock_acqui=
re+0x813/0x1af0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff8107da11>] ? load_balan=
ce+0xd1/0x730
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff8107baa0>] ? update_cfs=
_shares+0x100/0x100
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff8109b31a>] lock_acquire=
+0x8a/0x110
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff818f4e47>] ? ata_bmdma_=
interrupt+0x27/0x1d0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff81b4d151>] _raw_spin_lo=
ck_irqsave+0x41/0x60
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff818f4e47>] ? ata_bmdma_=
interrupt+0x27/0x1d0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff8107e070>] ? load_balan=
ce+0x730/0x730
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff818f4e47>] ata_bmdma_in=
terrupt+0x27/0x1d0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff810c2d5d>] handle_irq_e=
vent_percpu+0x5d/0x1f0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff810c2f38>] handle_irq_e=
vent+0x48/0x70
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff81b4d059>] ? _raw_spin_=
lock+0x39/0x40
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff810c5f0e>] ? handle_fas=
teoi_irq+0x1e/0xf0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff810c5f4a>] handle_faste=
oi_irq+0x5a/0xf0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff81003ce2>] handle_irq+0=
x22/0x40
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff81b4fdaa>] do_IRQ+0x5a/=
0xe0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff81b4da6c>] common_inter=
rupt+0x6c/0x6c
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 <EOI>=C2=A0 [<ffffffff8100ab7f>] =
? default_idle+0x5f/0x1b0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff8100ab7d>] ? default_id=
le+0x5d/0x1b0
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff8100b816>] cpu_idle+0x1=
06/0x120
> [=C2=A0=C2=A0=C2=A0 2.980587]=C2=A0 [<ffffffff81b2c7db>] start_second=
ary+0x1dd/0x1e4
> [=C2=A0=C2=A0=C2=A0 3.680628] ata4.00: ATA-6: ST3200822AS, 3.01, max =
UDMA/133
> [=C2=A0=C2=A0=C2=A0 3.689097] ata4.00: 390721968 sectors, multi 16: L=
BA48=20
> [=C2=A0=C2=A0=C2=A0 3.719600] ata4.00: configured for UDMA/133
> [=C2=A0=C2=A0=C2=A0 3.728236] scsi 3:0:0:0: Direct-Access=C2=A0=C2=A0=
=C2=A0=C2=A0 ATA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ST3200822AS=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 3.01 PQ: 0 ANSI: 5
> [=C2=A0=C2=A0=C2=A0 3.737545] sd 3:0:0:0: [sda] 390721968 512-byte lo=
gical blocks: (200 GB/186 GiB)
> [=C2=A0=C2=A0=C2=A0 3.746818] sd 3:0:0:0: [sda] Write Protect is off
> [=C2=A0=C2=A0=C2=A0 3.756109] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 =
00
> [=C2=A0=C2=A0=C2=A0 3.765428] sd 3:0:0:0: [sda] Write cache: enabled,=
 read cache: enabled, doesn't support DPO or FUA
> [=C2=A0=C2=A0=C2=A0 3.822517]=C2=A0 sda: sda1 sda2 sda3 sda4 < sda5 s=
da6 >
> [=C2=A0=C2=A0=C2=A0 3.833451] sd 3:0:0:0: [sda] Attached SCSI disk
> [=C2=A0=C2=A0=C2=A0 3.938019] ata5: SATA link down 1.5 Gbps (SStatus =
0 SControl 300)
> [=C2=A0=C2=A0=C2=A0 4.121436] registered taskstats version 1
> [=C2=A0=C2=A0=C2=A0 4.132352] rtc_cmos 00:02: setting system clock to=
 2012-08-29 13:26:05 UTC (1346246765)
> [=C2=A0=C2=A0=C2=A0 4.143433] md: Waiting for all devices to be avail=
able before autodetect
> [=C2=A0=C2=A0=C2=A0 4.154521] md: If you don't use raid, use raid=3Dn=
oautodetect
> [=C2=A0=C2=A0=C2=A0 4.166163] md: Autodetecting RAID arrays.
> [=C2=A0=C2=A0=C2=A0 4.177349] md: Scanned 0 and added 0 devices.
> [=C2=A0=C2=A0=C2=A0 4.188521] md: autorun ...
> [=C2=A0=C2=A0=C2=A0 4.199442] md: ... autorun DONE.
> [=C2=A0=C2=A0=C2=A0 4.231279] EXT3-fs (sda2): error: couldn't mount b=
ecause of unsupported optional features (240)
> [=C2=A0=C2=A0=C2=A0 4.250247] EXT2-fs (sda2): error: couldn't mount b=
ecause of unsupported optional features (240)
> [=C2=A0=C2=A0=C2=A0 4.288970] EXT4-fs (sda2): mounted filesystem with=
 ordered data mode. Opts: (null)
> [=C2=A0=C2=A0=C2=A0 4.300227] VFS: Mounted root (ext4 filesystem) rea=
donly on device 8:2.
> [=C2=A0=C2=A0=C2=A0 4.325724] devtmpfs: mounted
> [=C2=A0=C2=A0=C2=A0 4.338730] Freeing unused kernel memory: 868k free=
d
> [=C2=A0=C2=A0=C2=A0 4.350638] Write protecting the kernel read-only d=
ata: 16384k
> [=C2=A0=C2=A0=C2=A0 4.365030] Freeing unused kernel memory: 684k free=
d
> [=C2=A0=C2=A0=C2=A0 4.377568] Freeing unused kernel memory: 112k free=
d
> [=C2=A0=C2=A0=C2=A0 5.419243] loop: module loaded
> [=C2=A0=C2=A0=C2=A0 5.609483] udevd[1366]: starting version 182
> [=C2=A0=C2=A0=C2=A0 6.522401] microcode: AMD CPU family 0xf not suppo=
rted
> [=C2=A0=C2=A0=C2=A0 6.655672] shpchp: Standard Hot Plug PCI Controlle=
r Driver version: 0.4
> [=C2=A0=C2=A0=C2=A0 6.843767] parport_pc 00:07: reported by Plug and =
Play ACPI
> [=C2=A0=C2=A0=C2=A0 6.856734] parport0: PC-style at 0x378, irq 7 [PCS=
PP]
> [=C2=A0=C2=A0=C2=A0 6.973779] Linux agpgart interface v0.103
> [=C2=A0=C2=A0=C2=A0 7.063376] input: Power Button as /devices/LNXSYST=
M:00/device:00/PNP0C0C:00/input/input2
> [=C2=A0=C2=A0=C2=A0 7.076658] ACPI: Power Button [PWRB]
> [=C2=A0=C2=A0=C2=A0 7.089628] input: Sleep Button as /devices/LNXSYST=
M:00/device:00/PNP0C0E:00/input/input3
> [=C2=A0=C2=A0=C2=A0 7.102852] ACPI: Sleep Button [SLPB]
> [=C2=A0=C2=A0=C2=A0 7.115993] input: Power Button as /devices/LNXSYST=
M:00/LNXPWRBN:00/input/input4
> [=C2=A0=C2=A0=C2=A0 7.116305] skge 0000:00:0a.0: PCI: Disallowing DAC=
 for device
> [=C2=A0=C2=A0=C2=A0 7.116342] skge: 1.14 addr 0xfac00000 irq 17 chip =
Yukon-Lite rev 9
> [=C2=A0=C2=A0=C2=A0 7.116534] skge 0000:00:0a.0: eth0: addr 00:15:f2:=
09:ed:bf
> [=C2=A0=C2=A0=C2=A0 7.169302] ACPI: Power Button [PWRF]
> [=C2=A0=C2=A0=C2=A0 7.287407] ppdev: user-space parallel port driver
> [=C2=A0=C2=A0=C2=A0 7.695675] agpgart-amd64 0000:00:00.0: AGP bridge =
[1106/0282]
> [=C2=A0=C2=A0=C2=A0 7.711535] agpgart-amd64 0000:00:00.0: AGP apertur=
e is 64M @ 0xec000000
> [=C2=A0=C2=A0=C2=A0 8.049819] powernow-k8: Found 1 AMD Athlon(tm) 64 =
X2 Dual Core Processor 4200+ (2 cpu cores) (version 2.20.00)
> [=C2=A0=C2=A0=C2=A0 8.063857] powernow-k8: fid 0xe (2200 MHz), vid 0x=
8
> [=C2=A0=C2=A0=C2=A0 8.077436] powernow-k8: fid 0xc (2000 MHz), vid 0x=
a
> [=C2=A0=C2=A0=C2=A0 8.091026] powernow-k8: fid 0xa (1800 MHz), vid 0x=
c
> [=C2=A0=C2=A0=C2=A0 8.104258] powernow-k8: fid 0x2 (1000 MHz), vid 0x=
12
> [=C2=A0=C2=A0=C2=A0 8.545648] [drm] Initialized drm 1.1.0 20060810
> [=C2=A0=C2=A0=C2=A0 8.727695] wmi: Mapper loaded
> [=C2=A0=C2=A0=C2=A0 9.537504] [drm] nouveau 0000:01:00.0: Detected an=
 NV10 generation card (0x018100c1)
> [=C2=A0=C2=A0=C2=A0 9.551302] checking generic (f0000000 4000000) vs =
hw (f0000000 8000000)
> [=C2=A0=C2=A0=C2=A0 9.564505] fb: conflicting fb hw usage nouveaufb v=
s VESA VGA - removing generic driver
> [=C2=A0=C2=A0=C2=A0 9.578309] Console: switching to colour dummy devi=
ce 80x25
> [=C2=A0=C2=A0=C2=A0 9.578806] [drm] nouveau 0000:01:00.0: Checking PR=
AMIN for VBIOS
> [=C2=A0=C2=A0=C2=A0 9.626640] [drm] nouveau 0000:01:00.0: ... appears=
 to be valid
> [=C2=A0=C2=A0=C2=A0 9.626649] [drm] nouveau 0000:01:00.0: Using VBIOS=
 from PRAMIN
> [=C2=A0=C2=A0=C2=A0 9.626860] [drm] nouveau 0000:01:00.0: BMP BIOS fo=
und
> [=C2=A0=C2=A0=C2=A0 9.626868] [drm] nouveau 0000:01:00.0: BMP version=
 5.40
> [=C2=A0=C2=A0=C2=A0 9.626876] [drm] nouveau 0000:01:00.0: Bios versio=
n 04.18.20.42
> [=C2=A0=C2=A0=C2=A0 9.627068] [drm] nouveau 0000:01:00.0: MXM: no VBI=
OS data, nothing to do
> [=C2=A0=C2=A0=C2=A0 9.627078] [drm] nouveau 0000:01:00.0: DCB version=
 2.2
> [=C2=A0=C2=A0=C2=A0 9.627087] [drm] nouveau 0000:01:00.0: DCB outp 00=
: 01000300 000088b8
> [=C2=A0=C2=A0=C2=A0 9.627099] [drm] nouveau 0000:01:00.0: DCB outp 01=
: 02010321 00000733
> [=C2=A0=C2=A0=C2=A0 9.627267] [drm] nouveau 0000:01:00.0: Loading NV1=
7 power sequencing microcode
> [=C2=A0=C2=A0=C2=A0 9.627279] [drm] nouveau 0000:01:00.0: Parsing VBI=
OS init table 0 at offset 0xED14
> [=C2=A0=C2=A0=C2=A0 9.629327] [drm] nouveau 0000:01:00.0: Parsing VBI=
OS init table 1 at offset 0xF20C
> [=C2=A0=C2=A0=C2=A0 9.629358] [drm] nouveau 0000:01:00.0: Parsing VBI=
OS init table 2 at offset 0xEE96
> [=C2=A0=C2=A0=C2=A0 9.644421] [drm] nouveau 0000:01:00.0: Parsing VBI=
OS init table 3 at offset 0xF57F
> [=C2=A0=C2=A0=C2=A0 9.644435] [drm] nouveau 0000:01:00.0: Parsing VBI=
OS init table 4 at offset 0xF59C
> [=C2=A0=C2=A0=C2=A0 9.644448] [drm] nouveau 0000:01:00.0: Parsing VBI=
OS init table 5 at offset 0xF081
> [=C2=A0=C2=A0=C2=A0 9.655425] [drm] nouveau 0000:01:00.0: Parsing VBI=
OS init table 6 at offset 0xF1A7
> [=C2=A0=C2=A0=C2=A0 9.655712] [TTM] Zone=C2=A0 kernel: Available grap=
hics memory: 1016192 kiB
> [=C2=A0=C2=A0=C2=A0 9.655730] [TTM] Initializing pool allocator
> [=C2=A0=C2=A0=C2=A0 9.655743] [TTM] Initializing DMA pool allocator
> [=C2=A0=C2=A0=C2=A0 9.655771] [drm] nouveau 0000:01:00.0: Detected 64=
MiB VRAM (DDR1)
> [=C2=A0=C2=A0=C2=A0 9.656188] agpgart-amd64 0000:00:00.0: AGP 3.0 bri=
dge
> [=C2=A0=C2=A0=C2=A0 9.656220] agpgart: udevd tried to set rate=3Dx12.=
 Setting to AGP3 x8 mode.
> [=C2=A0=C2=A0=C2=A0 9.656234] agpgart-amd64 0000:00:00.0: putting AGP=
 V3 device into 8x mode
> [=C2=A0=C2=A0=C2=A0 9.656334] nouveau 0000:01:00.0: putting AGP V3 de=
vice into 8x mode
> [=C2=A0=C2=A0=C2=A0 9.656343] [drm] nouveau 0000:01:00.0: 64 MiB GART=
 (aperture)
> [=C2=A0=C2=A0=C2=A0 9.658112] [drm] Supports vblank timestamp caching=
 Rev 1 (10.10.2010).
> [=C2=A0=C2=A0=C2=A0 9.658122] [drm] No driver support for vblank time=
stamp query.
> [=C2=A0=C2=A0=C2=A0 9.664243] [drm] nouveau 0000:01:00.0: 0 available=
 performance level(s)
> [=C2=A0=C2=A0=C2=A0 9.664262] [drm] nouveau 0000:01:00.0: c: core 274=
MHz memory 300MHz
> [=C2=A0=C2=A0=C2=A0 9.666667] [drm] nouveau 0000:01:00.0: MM: using M=
2MF for buffer copies
> [=C2=A0=C2=A0=C2=A0 9.685815] [drm] nouveau 0000:01:00.0: Setting dpm=
s mode 3 on vga encoder (output 0)
> [=C2=A0=C2=A0=C2=A0 9.685824] [drm] nouveau 0000:01:00.0: Setting dpm=
s mode 3 on TV encoder (output 1)
> [=C2=A0=C2=A0=C2=A0 9.710508] snd_via82xx 0000:00:11.5: setting laten=
cy timer to 64
> [=C2=A0=C2=A0=C2=A0 9.750214] [drm] nouveau 0000:01:00.0: allocated 1=
280x1024 fb: 0x49000, bo ffff88007a961400
> [=C2=A0=C2=A0=C2=A0 9.750317] fbcon: nouveaufb (fb0) is primary devic=
e
> [=C2=A0=C2=A0 10.411090] [drm] nouveau 0000:01:00.0: Setting dpms mod=
e 0 on vga encoder (output 0)
> [=C2=A0=C2=A0 10.411093] [drm] nouveau 0000:01:00.0: Output VGA-1 is =
running on CRTC 0 using output A
> [=C2=A0=C2=A0 10.411126] Console: switching to colour frame buffer de=
vice 160x64
> [=C2=A0=C2=A0 10.413031] fb0: nouveaufb frame buffer device
> [=C2=A0=C2=A0 10.413032] drm: registered panic notifier
> [=C2=A0=C2=A0 10.413039] [drm] Initialized nouveau 1.0.0 20120316 for=
 0000:01:00.0 on minor 0
> [=C2=A0=C2=A0 10.659241] fuse init (API version 7.19)
> [=C2=A0=C2=A0 10.919831] EXT4-fs (sda2): re-mounted. Opts: (null)
> [=C2=A0=C2=A0 12.320662] lp0: using parport0 (interrupt-driven).
> [=C2=A0=C2=A0 12.320694] lp0: console ready
> [=C2=A0=C2=A0 15.703016] EXT4-fs (sda1): mounted filesystem with orde=
red data mode. Opts: (null)
> [=C2=A0=C2=A0 15.704557] REISERFS (device sda5): found reiserfs forma=
t "3.6" with standard journal
> [=C2=A0=C2=A0 15.704587] REISERFS (device sda5): using ordered data m=
ode
> [=C2=A0=C2=A0 15.704597] reiserfs: using flush barriers
> [=C2=A0=C2=A0 15.705022] REISERFS (device sda5): journal params: devi=
ce sda5, size 8192, journal first block 18, max trans len 1024, max bat=
ch 900, max commit age 30, max trans age 30
> [=C2=A0=C2=A0 15.706483] REISERFS (device sda5): checking transaction=
 log (sda5)
> [=C2=A0=C2=A0 15.783261] REISERFS (device sda5): Using r5 hash to sor=
t names
> [=C2=A0=C2=A0 15.824579] REISERFS (device sda6): found reiserfs forma=
t "3.6" with standard journal
> [=C2=A0=C2=A0 15.825093] REISERFS (device sda6): using ordered data m=
ode
> [=C2=A0=C2=A0 15.825755] reiserfs: using flush barriers
> [=C2=A0=C2=A0 15.835069] REISERFS (device sda6): journal params: devi=
ce sda6, size 8192, journal first block 18, max trans len 1024, max bat=
ch 900, max commit age 30, max trans age 30
> [=C2=A0=C2=A0 15.837852] REISERFS (device sda6): checking transaction=
 log (sda6)
> [=C2=A0=C2=A0 15.925045] REISERFS (device sda6): Using r5 hash to sor=
t names
>=20
>=20
> Thanks for helping !
>=20
> Best regards
> Adko.
>=20
> [
>=20
>=20

--=20
Regards/Gruss,
    Boris.
