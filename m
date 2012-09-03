From: Adko Branil <adkobranil@yahoo.com>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Mon, 3 Sep 2012 14:46:31 -0700 (PDT)
Message-ID: <1346708791.72123.YahooMailNeo@web124701.mail.ne1.yahoo.com>
References: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20120826130152.GA20021@liondog.tnic> <1346086872.65665.YahooMailNeo@web124704.mail.ne1.yahoo.com> <20120827215952.GA18719@liondog.tnic> <1346259574.81504.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20120830095808.GB24680@liondog.tnic> <1346325007.23643.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20547.48101.900727.735398@pilspetsen.it.uu.se>
Reply-To: Adko Branil <adkobranil@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm25-vm2.bullet.mail.ne1.yahoo.com ([98.138.91.213]:27511 "HELO
	nm25-vm2.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753732Ab2ICVqd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Sep 2012 17:46:33 -0400
In-Reply-To: <20547.48101.900727.735398@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Borislav Petkov <bp@alien8.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>





> But now an interrupt occurs during the hard
>reset, and pdc_interrupt also has to take the host lock.

I have 4 sata connectors on the motherboard - http://www.hardwareheaven=
=2Ecom/reviews/asusA8V/
If i understand right, just 2 of them are linked to promise controller.=
 Well i changed the connector where my HDD=C2=A0 is connected,=20
and dmesg warning message is a bit different now - "ata_bmdma_interrupt=
" was replaced by "pdc_interrupt".




[=C2=A0=C2=A0=C2=A0 1.973049] ata1: SATA link up 1.5 Gbps (SStatus 113 =
SControl 300)
[=C2=A0=C2=A0=C2=A0 1.984574]=20
[=C2=A0=C2=A0=C2=A0 1.984575] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=C2=A0=C2=A0=C2=A0 1.984576] [ INFO: inconsistent lock state ]
[=C2=A0=C2=A0=C2=A0 1.984578] 3.5.2 #4 Not tainted
[=C2=A0=C2=A0=C2=A0 1.984578] ---------------------------------
[=C2=A0=C2=A0=C2=A0 1.984579] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIR=
Q-W} usage.
[=C2=A0=C2=A0=C2=A0 1.984581] swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes=
:
[=C2=A0=C2=A0=C2=A0 1.984582]=C2=A0 (&(&host->lock)->rlock){?.+...}, at=
: [<ffffffff8190abd8>] pdc_interrupt+0x48/0x420
[=C2=A0=C2=A0=C2=A0 1.984590] {HARDIRQ-ON-W} state was registered at:
[=C2=A0=C2=A0=C2=A0 1.984591]=C2=A0=C2=A0 [<ffffffff810998fb>] __lock_a=
cquire+0x61b/0x1af0
[=C2=A0=C2=A0=C2=A0 1.984595]=C2=A0=C2=A0 [<ffffffff8109b31a>] lock_acq=
uire+0x8a/0x110
[=C2=A0=C2=A0=C2=A0 1.984597]=C2=A0=C2=A0 [<ffffffff81b4d051>] _raw_spi=
n_lock+0x31/0x40
[=C2=A0=C2=A0=C2=A0 1.984602]=C2=A0=C2=A0 [<ffffffff8190b3c5>] pdc_sata=
_hardreset+0x85/0x100
[=C2=A0=C2=A0=C2=A0 1.984604]=C2=A0=C2=A0 [<ffffffff818eabba>] ata_do_r=
eset+0x3a/0x90
[=C2=A0=C2=A0=C2=A0 1.984607]=C2=A0=C2=A0 [<ffffffff818edd72>] ata_eh_r=
eset+0x372/0xe00
[=C2=A0=C2=A0=C2=A0 1.984610]=C2=A0=C2=A0 [<ffffffff818eec25>] ata_eh_r=
ecover+0x2a5/0x13d0
[=C2=A0=C2=A0=C2=A0 1.984612]=C2=A0=C2=A0 [<ffffffff818f073d>] ata_do_e=
h+0x4d/0xb0
[=C2=A0=C2=A0=C2=A0 1.984614]=C2=A0=C2=A0 [<ffffffff818f33ba>] ata_sff_=
error_handler+0xca/0x120
[=C2=A0=C2=A0=C2=A0 1.984617]=C2=A0=C2=A0 [<ffffffff8190a9e4>] pdc_erro=
r_handler+0x24/0x30
[=C2=A0=C2=A0=C2=A0 1.984619]=C2=A0=C2=A0 [<ffffffff818f029c>] ata_scsi=
_port_error_handler+0x47c/0x800
[=C2=A0=C2=A0=C2=A0 1.984622]=C2=A0=C2=A0 [<ffffffff818f06be>] ata_scsi=
_error+0x9e/0xd0
[=C2=A0=C2=A0=C2=A0 1.984624]=C2=A0=C2=A0 [<ffffffff816732e8>] scsi_err=
or_handler+0xf8/0x500
[=C2=A0=C2=A0=C2=A0 1.984628]=C2=A0=C2=A0 [<ffffffff810654fe>] kthread+=
0xae/0xc0
[=C2=A0=C2=A0=C2=A0 1.984631]=C2=A0=C2=A0 [<ffffffff81b4f5f4>] kernel_t=
hread_helper+0x4/0x10
[=C2=A0=C2=A0=C2=A0 1.984634] irq event stamp: 49968
[=C2=A0=C2=A0=C2=A0 1.984635] hardirqs last=C2=A0 enabled at (49965): [=
<ffffffff8100ab7d>] default_idle+0x5d/0x1b0
[=C2=A0=C2=A0=C2=A0 1.984639] hardirqs last disabled at (49966): [<ffff=
ffff81b4da67>] common_interrupt+0x67/0x6c
[=C2=A0=C2=A0=C2=A0 1.984641] softirqs last=C2=A0 enabled at (49968): [=
<ffffffff810498d3>] _local_bh_enable+0x13/0x20
[=C2=A0=C2=A0=C2=A0 1.984645] softirqs last disabled at (49967): [<ffff=
ffff8104a355>] irq_enter+0x75/0x90
[=C2=A0=C2=A0=C2=A0 1.984648]=20
[=C2=A0=C2=A0=C2=A0 1.984648] other info that might help us debug this:
[=C2=A0=C2=A0=C2=A0 1.984648]=C2=A0 Possible unsafe locking scenario:
[=C2=A0=C2=A0=C2=A0 1.984648]=20
[=C2=A0=C2=A0=C2=A0 1.984649]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 CPU0
[=C2=A0=C2=A0=C2=A0 1.984649]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ----
[=C2=A0=C2=A0=C2=A0 1.984650]=C2=A0=C2=A0 lock(&(&host->lock)->rlock);
[=C2=A0=C2=A0=C2=A0 1.984651]=C2=A0=C2=A0 <Interrupt>
[=C2=A0=C2=A0=C2=A0 1.984651]=C2=A0=C2=A0=C2=A0=C2=A0 lock(&(&host->loc=
k)->rlock);
[=C2=A0=C2=A0=C2=A0 1.984653]=20
[=C2=A0=C2=A0=C2=A0 1.984653]=C2=A0 *** DEADLOCK ***
[=C2=A0=C2=A0=C2=A0 1.984653]=20
[=C2=A0=C2=A0=C2=A0 1.984654] no locks held by swapper/1/0.
[=C2=A0=C2=A0=C2=A0 1.984654]=20
[=C2=A0=C2=A0=C2=A0 1.984654] stack backtrace:
[=C2=A0=C2=A0=C2=A0 1.984656] Pid: 0, comm: swapper/1 Not tainted 3.5.2=
 #4
[=C2=A0=C2=A0=C2=A0 1.984656] Call Trace:
[=C2=A0=C2=A0=C2=A0 1.984657]=C2=A0 <IRQ>=C2=A0 [<ffffffff81b35961>] pr=
int_usage_bug+0x1f7/0x208
[=C2=A0=C2=A0=C2=A0 1.984662]=C2=A0 [<ffffffff8101001f>] ? save_stack_t=
race+0x2f/0x50
[=C2=A0=C2=A0=C2=A0 1.984665]=C2=A0 [<ffffffff81098730>] ? print_shorte=
st_lock_dependencies+0x1d0/0x1d0
[=C2=A0=C2=A0=C2=A0 1.984668]=C2=A0 [<ffffffff810992a2>] mark_lock+0x26=
2/0x2a0
[=C2=A0=C2=A0=C2=A0 1.984670]=C2=A0 [<ffffffff81099af3>] __lock_acquire=
+0x813/0x1af0
[=C2=A0=C2=A0=C2=A0 1.984672]=C2=A0 [<ffffffff8107da11>] ? load_balance=
+0xd1/0x730
[=C2=A0=C2=A0=C2=A0 1.984676]=C2=A0 [<ffffffff8107baa0>] ? update_cfs_s=
hares+0x100/0x100
[=C2=A0=C2=A0=C2=A0 1.984678]=C2=A0 [<ffffffff8109b31a>] lock_acquire+0=
x8a/0x110
[=C2=A0=C2=A0=C2=A0 1.984680]=C2=A0 [<ffffffff8190abd8>] ? pdc_interrup=
t+0x48/0x420
[=C2=A0=C2=A0=C2=A0 1.984682]=C2=A0 [<ffffffff81b4d051>] _raw_spin_lock=
+0x31/0x40
[=C2=A0=C2=A0=C2=A0 1.984685]=C2=A0 [<ffffffff8190abd8>] ? pdc_interrup=
t+0x48/0x420
[=C2=A0=C2=A0=C2=A0 1.984686]=C2=A0 [<ffffffff8107e228>] ? rebalance_do=
mains+0x1b8/0x1e0
[=C2=A0=C2=A0=C2=A0 1.984689]=C2=A0 [<ffffffff8190abd8>] pdc_interrupt+=
0x48/0x420
[=C2=A0=C2=A0=C2=A0 1.984691]=C2=A0 [<ffffffff810c2d5d>] handle_irq_eve=
nt_percpu+0x5d/0x1f0
[=C2=A0=C2=A0=C2=A0 1.984694]=C2=A0 [<ffffffff810c2f38>] handle_irq_eve=
nt+0x48/0x70
[=C2=A0=C2=A0=C2=A0 1.984695]=C2=A0 [<ffffffff81b4d059>] ? _raw_spin_lo=
ck+0x39/0x40
[=C2=A0=C2=A0=C2=A0 1.984698]=C2=A0 [<ffffffff810c5f0e>] ? handle_faste=
oi_irq+0x1e/0xf0
[=C2=A0=C2=A0=C2=A0 1.984700]=C2=A0 [<ffffffff810c5f4a>] handle_fasteoi=
_irq+0x5a/0xf0
[=C2=A0=C2=A0=C2=A0 1.984702]=C2=A0 [<ffffffff81003ce2>] handle_irq+0x2=
2/0x40
[=C2=A0=C2=A0=C2=A0 1.984706]=C2=A0 [<ffffffff81b4fdaa>] do_IRQ+0x5a/0x=
e0
[=C2=A0=C2=A0=C2=A0 1.984708]=C2=A0 [<ffffffff81b4da6c>] common_interru=
pt+0x6c/0x6c
[=C2=A0=C2=A0=C2=A0 1.984711]=C2=A0 <EOI>=C2=A0 [<ffffffff8100ab7f>] ? =
default_idle+0x5f/0x1b0
[=C2=A0=C2=A0=C2=A0 1.984714]=C2=A0 [<ffffffff8100ab7d>] ? default_idle=
+0x5d/0x1b0
[=C2=A0=C2=A0=C2=A0 1.984717]=C2=A0 [<ffffffff8100b816>] cpu_idle+0x106=
/0x120
[=C2=A0=C2=A0=C2=A0 1.984719]=C2=A0 [<ffffffff81b2c7db>] start_secondar=
y+0x1dd/0x1e4
[=C2=A0=C2=A0=C2=A0 1.984761] ata1.00: ATA-6: ST3200822AS, 3.01, max UD=
MA/133
[=C2=A0=C2=A0=C2=A0 1.984763] ata1.00: 390721968 sectors, multi 0: LBA4=
8=20
[=C2=A0=C2=A0=C2=A0 2.006548] ata1.00: configured for UDMA/133




Here is the full dmesg - http://pastebin.com/1xLETNd5
And the crashes are continuing - heavy disk operations like "md5sum -c =
=D0=B0.md5", where a.md5 contains md5 sums of more than 300 000 files,

speed up the crash between 10 and 100 times, compared to the idle case,=
 and it crashes with oops like:




[10432.283017] BUG: unable to handle kernel NULL pointer dereference at=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (null)
[10432.293110] IP: [<ffffffff8109530c>] update_ts_time_stats+0x6c/0x90
[10432.293110] PGD 7a223067 PUD 7958a067 PMD 0=20
[10432.293110] Oops: 0002 [#1] SMP=20
[10432.293110] CPU 1=20
[10432.293110] Modules linked in:[10432.293110]=C2=A0 netconsole snd_se=
q_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_os=
s ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat nf=
_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x_=
tables lp fuse nouveau mxm_wmi wmi video ttm drm_kms_helper drm snd_via=
82xx snd_ac97_codec snd_mpu401_uart snd_rawmidi powernow_k8 snd_seq_dev=
ice snd_pcm mperf processor snd_page_alloc snd_timer i2c_algo_bit snd s=
oundcore ac97_bus gameport ppdev k8temp shpchp parport_pc freq_table am=
d64_agp i2c_viapro thermal_sys button skge parport evdev i2c_core hwmon=
 agpgart loop

[10432.293110] Pid: 0, comm: swapper/1 Not tainted 3.5.2 #4 To Be Fille=
d By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[10432.293110] RIP: 0010:[<ffffffff8109530c>]=C2=A0 [<ffffffff8109530c>=
] update_ts_time_stats+0x6c/0x90
[10432.293110] RSP: 0018:ffff88007fd03ed8=C2=A0 EFLAGS: 00010046
[10432.293110] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000=
000000000
[10432.293110] RDX: 0000097cf485c143 RSI: ffff88007fd0da40 RDI: 0000000=
000000001
[10432.293110] RBP: ffff88007fd03f18 R08: 0000000000000000 R09: 0000000=
000000000
[10432.293110] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000=
0000e1360
[10432.293110] R13: 000000000000da40 R14: 0000097cf485c143 R15: 0000000=
000000000
[10432.293110] FS:=C2=A0 00007f8de7906740(0000) GS:ffff88007fd00000(000=
0) knlGS:00000000f6f66700
[10432.293110] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[10432.293110] CR2: 0000000000000000 CR3: 000000007a9d7000 CR4: 0000000=
0000007e0
[10432.293110] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[10432.293110] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[10432.293110] Process swapper/1 (pid: 0, threadinfo ffff88007c524000, =
task ffff88007d07dd60)
[10432.293110] Stack:
[10432.293110]=C2=A0 0000097cf485c143 ffff88007fd0da40 ffff88007c525fd8=
 ffff88007c525fd8
[10432.293110]=C2=A0 0000010000000009 0000000000000012 ffff88007fd0da40=
 0000000000000001
[10432.293110]=C2=A0 ffff88007fd03f38 ffffffff8109535d 000000000000da40=
 ffff88007fd0da40
[10432.293110] Call Trace:
[10432.293110]=C2=A0 <IRQ>=20
[10432.293110]=C2=A0 [<ffffffff8109535d>] tick_nohz_stop_idle+0x2d/0x50
[10432.293110]=C2=A0 [<ffffffff81095873>] tick_check_idle+0xc3/0xe0
[10432.293110]=C2=A0 [<ffffffff8104a35c>] irq_enter+0x7c/0x90
[10432.293110]=C2=A0 [<ffffffff81b4fe6e>] smp_apic_timer_interrupt+0x3e=
/0x99
[10432.293110]=C2=A0 [<ffffffff81b4eedc>] apic_timer_interrupt+0x6c/0x8=
0
[10432.293110]=C2=A0 <EOI>=20
[10432.293110]=C2=A0 [<ffffffff8100ab7d>] ? default_idle+0x5d/0x1b0
[10432.293110]=C2=A0 [<ffffffff8100ab7f>] ? default_idle+0x5f/0x1b0
[10432.293110]=C2=A0 [<ffffffff8100ab7d>] ? default_idle+0x5d/0x1b0
[10432.293110]=C2=A0 [<ffffffff8100b816>] cpu_idle+0x106/0x120
[10432.293110]=C2=A0 [<ffffffff81b2c7db>] start_secondary+0x1dd/0x1e4
[10432.293110] Code: f0 4c 8b 65 f8 c9 c3 49 89 d4 4c 2b a6 a0 00 00 00=
 48 89 55 c0 48 89 75 c8 e8 11 fb fd ff 48 85 c0 48 8b 55 c0 48 8b 75 c=
8 75 14 <4c> 01 a6 b8 00 00 00 48 89 96 a0 00 00 00 eb a8 0f 1f 40 00 4=
c=20
[10432.293110] RIP=C2=A0 [<ffffffff8109530c>] update_ts_time_stats+0x6c=
/0x90
[10432.293110]=C2=A0 RSP <ffff88007fd03ed8>
[10432.293110] CR2: 0000000000000000
[10432.293110] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga e=
ncoder (output 0)
[10432.293110] ---[ end trace 9b7353d10a6013b6 ]---
[10432.293110] Kernel panic - not syncing: Fatal exception in interrupt
[10432.293110] panic occurred, switching back to text console
[10432.293110] Rebooting in 10 seconds..




>I don't know why the interrupt occurs, hotplug events are supposed to =
have been masked
>by ->freeze before ->hardreset. It might come from a different device

If this is the case, does it mean hardware bug ? Broken PIC, or just pa=
rticular device, like integrated sound or lan ?
Is this interrupt, with unknown origin, the reason of both - dmesg warn=
ing and the crash caused this oops?

Any cure about that ? Except that i will try to disable what i can in B=
IOS.=20


>I think I'll have to introduce a new private lock just for serializing
>pdc_hard_reset_port. Expect a patch next weekend (I'll be away from
>my Promise test equipment until then.)


Could this future patch solve the "crash problem", as well as the "warn=
ing problem",
or it will not bearing on the "crash problem"?




Thanks.

Best regards.
Adko.
