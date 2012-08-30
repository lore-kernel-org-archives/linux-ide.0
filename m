From: Adko Branil <adkobranil@yahoo.com>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Thu, 30 Aug 2012 04:10:07 -0700 (PDT)
Message-ID: <1346325007.23643.YahooMailNeo@web124706.mail.ne1.yahoo.com>
References: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20120826130152.GA20021@liondog.tnic> <1346086872.65665.YahooMailNeo@web124704.mail.ne1.yahoo.com> <20120827215952.GA18719@liondog.tnic> <1346259574.81504.YahooMailNeo@web124706.mail.ne1.yahoo.com> <20120830095808.GB24680@liondog.tnic>
Reply-To: Adko Branil <adkobranil@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm17-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.34]:46208 "HELO
	nm17-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753178Ab2H3LKJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Aug 2012 07:10:09 -0400
In-Reply-To: <20120830095808.GB24680@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

>Right near the end there's a lockdep warning about a deadlock

>between sata_promise's hardreset thing and the machine getting a
>ata_bmdma_interrupt.

>But since I don't know this code, it would be nice if you could take a
>look at it.

I picked up 3 more dmesg after rebooting, and 2 more oopses.
=A0I will put here just pieces from dmesgs about these locks, they diff=
ers slightly each-other:

***********************************************************************=
************
1.


[=A0=A0=A0 1.859215] input: AT Translated Set 2 keyboard as /devices/pl=
atform/i8042/serio0/input/input1
[=A0=A0=A0 1.943678]=20
[=A0=A0=A0 1.943679] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=A0=A0=A0 1.943680] [ INFO: inconsistent lock state ]
[=A0=A0=A0 1.943682] 3.5.2 #4 Not tainted
[=A0=A0=A0 1.943683] ---------------------------------
[=A0=A0=A0 1.943684] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usag=
e.
[=A0=A0=A0 1.943686] swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[=A0=A0=A0 1.943687]=A0 (&(&host->lock)->rlock){?.+...}, at: [<ffffffff=
818f4e47>] ata_bmdma_interrupt+0x27/0x1d0
[=A0=A0=A0 1.943695] {HARDIRQ-ON-W} state was registered at:
[=A0=A0=A0 1.943696]=A0=A0 [<ffffffff810998fb>] __lock_acquire+0x61b/0x=
1af0
[=A0=A0=A0 1.943701]=A0=A0 [<ffffffff8109b31a>] lock_acquire+0x8a/0x110
[=A0=A0=A0 1.943703]=A0=A0 [<ffffffff81b4d051>] _raw_spin_lock+0x31/0x4=
0
[=A0=A0=A0 1.943708]=A0=A0 [<ffffffff8190b3c5>] pdc_sata_hardreset+0x85=
/0x100
[=A0=A0=A0 1.943711]=A0=A0 [<ffffffff818eabba>] ata_do_reset+0x3a/0x90
[=A0=A0=A0 1.943713]=A0=A0 [<ffffffff818edd72>] ata_eh_reset+0x372/0xe0=
0
[=A0=A0=A0 1.943716]=A0=A0 [<ffffffff818eec25>] ata_eh_recover+0x2a5/0x=
13d0
[=A0=A0=A0 1.943718]=A0=A0 [<ffffffff818f073d>] ata_do_eh+0x4d/0xb0
[=A0=A0=A0 1.943721]=A0=A0 [<ffffffff818f33ba>] ata_sff_error_handler+0=
xca/0x120
[=A0=A0=A0 1.943723]=A0=A0 [<ffffffff8190a9e4>] pdc_error_handler+0x24/=
0x30
[=A0=A0=A0 1.943725]=A0=A0 [<ffffffff818f029c>] ata_scsi_port_error_han=
dler+0x47c/0x800
[=A0=A0=A0 1.943728]=A0=A0 [<ffffffff818f06be>] ata_scsi_error+0x9e/0xd=
0
[=A0=A0=A0 1.943730]=A0=A0 [<ffffffff816732e8>] scsi_error_handler+0xf8=
/0x500
[=A0=A0=A0 1.943734]=A0=A0 [<ffffffff810654fe>] kthread+0xae/0xc0
[=A0=A0=A0 1.943737]=A0=A0 [<ffffffff81b4f5f4>] kernel_thread_helper+0x=
4/0x10
[=A0=A0=A0 1.943740] irq event stamp: 51304
[=A0=A0=A0 1.943741] hardirqs last=A0 enabled at (51301): [<ffffffff810=
0ab7d>] default_idle+0x5d/0x1b0
[=A0=A0=A0 1.943745] hardirqs last disabled at (51302): [<ffffffff81b4d=
a67>] common_interrupt+0x67/0x6c
[=A0=A0=A0 1.943748] softirqs last=A0 enabled at (51304): [<ffffffff810=
498d3>] _local_bh_enable+0x13/0x20
[=A0=A0=A0 1.943752] softirqs last disabled at (51303): [<ffffffff8104a=
355>] irq_enter+0x75/0x90
[=A0=A0=A0 1.943754]=20
[=A0=A0=A0 1.943754] other info that might help us debug this:
[=A0=A0=A0 1.943755]=A0 Possible unsafe locking scenario:
[=A0=A0=A0 1.943755]=20
[=A0=A0=A0 1.943755]=A0=A0=A0=A0=A0=A0=A0 CPU0
[=A0=A0=A0 1.943755]=A0=A0=A0=A0=A0=A0=A0 ----
[=A0=A0=A0 1.943756]=A0=A0 lock(&(&host->lock)->rlock);
[=A0=A0=A0 1.943757]=A0=A0 <Interrupt>
[=A0=A0=A0 1.943758]=A0=A0=A0=A0 lock(&(&host->lock)->rlock);
[=A0=A0=A0 1.943759]=20
[=A0=A0=A0 1.943759]=A0 *** DEADLOCK ***
[=A0=A0=A0 1.943759]=20
[=A0=A0=A0 1.943760] no locks held by swapper/1/0.
[=A0=A0=A0 1.943760]=20
[=A0=A0=A0 1.943760] stack backtrace:
[=A0=A0=A0 1.943762] Pid: 0, comm: swapper/1 Not tainted 3.5.2 #4
[=A0=A0=A0 1.943762] Call Trace:
[=A0=A0=A0 1.943763]=A0 <IRQ>=A0 [<ffffffff81b35961>] print_usage_bug+0=
x1f7/0x208
[=A0=A0=A0 1.943768]=A0 [<ffffffff8101001f>] ? save_stack_trace+0x2f/0x=
50
[=A0=A0=A0 1.943772]=A0 [<ffffffff81098730>] ? print_shortest_lock_depe=
ndencies+0x1d0/0x1d0
[=A0=A0=A0 1.943774]=A0 [<ffffffff810992a2>] mark_lock+0x262/0x2a0
[=A0=A0=A0 1.943776]=A0 [<ffffffff81099af3>] __lock_acquire+0x813/0x1af=
0
[=A0=A0=A0 1.943779]=A0 [<ffffffff810c9920>] ? force_qs_rnp+0x40/0x180
[=A0=A0=A0 1.943782]=A0 [<ffffffff81076f93>] ? try_to_wake_up+0x1c3/0x2=
d0
[=A0=A0=A0 1.943786]=A0 [<ffffffff8109b31a>] lock_acquire+0x8a/0x110
[=A0=A0=A0 1.943788]=A0 [<ffffffff818f4e47>] ? ata_bmdma_interrupt+0x27=
/0x1d0
[=A0=A0=A0 1.943791]=A0 [<ffffffff81b4d151>] _raw_spin_lock_irqsave+0x4=
1/0x60
[=A0=A0=A0 1.943794]=A0 [<ffffffff818f4e47>] ? ata_bmdma_interrupt+0x27=
/0x1d0
[=A0=A0=A0 1.943796]=A0 [<ffffffff818f4e47>] ata_bmdma_interrupt+0x27/0=
x1d0
[=A0=A0=A0 1.943799]=A0 [<ffffffff810c2d5d>] handle_irq_event_percpu+0x=
5d/0x1f0
[=A0=A0=A0 1.943801]=A0 [<ffffffff810c2f38>] handle_irq_event+0x48/0x70
[=A0=A0=A0 1.943803]=A0 [<ffffffff81b4d059>] ? _raw_spin_lock+0x39/0x40
[=A0=A0=A0 1.943806]=A0 [<ffffffff810c5f0e>] ? handle_fasteoi_irq+0x1e/=
0xf0
[=A0=A0=A0 1.943808]=A0 [<ffffffff810c5f4a>] handle_fasteoi_irq+0x5a/0x=
f0
[=A0=A0=A0 1.943810]=A0 [<ffffffff81003ce2>] handle_irq+0x22/0x40
[=A0=A0=A0 1.943813]=A0 [<ffffffff81b4fdaa>] do_IRQ+0x5a/0xe0
[=A0=A0=A0 1.943816]=A0 [<ffffffff81b4da6c>] common_interrupt+0x6c/0x6c
[=A0=A0=A0 1.943819]=A0 <EOI>=A0 [<ffffffff8100ab7f>] ? default_idle+0x=
5f/0x1b0
[=A0=A0=A0 1.943822]=A0 [<ffffffff8100ab7d>] ? default_idle+0x5d/0x1b0
[=A0=A0=A0 1.943824]=A0 [<ffffffff8100b816>] cpu_idle+0x106/0x120
[=A0=A0=A0 1.943827]=A0 [<ffffffff81b2c7db>] start_secondary+0x1dd/0x1e=
4
[=A0=A0=A0 1.943854] ata4.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
[=A0=A0=A0 1.943856] ata4.00: 390721968 sectors, multi 16: LBA48=20
[=A0=A0=A0 1.965556] ata4.00: configured for UDMA/133
[=A0=A0=A0 2.028035] ata2: SATA link down (SStatus 0 SControl 300)



***********************************************************************=
**
2.

[=A0=A0=A0 1.760599] input: AT Translated Set 2 keyboard as /devices/pl=
atform/i8042/serio0/input/input1
[=A0=A0=A0 1.943627]=20
[=A0=A0=A0 1.943628] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=A0=A0=A0 1.943628] [ INFO: inconsistent lock state ]
[=A0=A0=A0 1.943630] 3.5.2 #4 Not tainted
[=A0=A0=A0 1.943631] ---------------------------------
[=A0=A0=A0 1.943632] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usag=
e.
[=A0=A0=A0 1.943634] swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[=A0=A0=A0 1.943635]=A0 (&(&host->lock)->rlock){?.+...}, at: [<ffffffff=
818f4e47>] ata_bmdma_interrupt+0x27/0x1d0
[=A0=A0=A0 1.943644] {HARDIRQ-ON-W} state was registered at:
[=A0=A0=A0 1.943645]=A0=A0 [<ffffffff810998fb>] __lock_acquire+0x61b/0x=
1af0
[=A0=A0=A0 1.943649]=A0=A0 [<ffffffff8109b31a>] lock_acquire+0x8a/0x110
[=A0=A0=A0 1.943652]=A0=A0 [<ffffffff81b4d051>] _raw_spin_lock+0x31/0x4=
0
[=A0=A0=A0 1.943656]=A0=A0 [<ffffffff8190b3c5>] pdc_sata_hardreset+0x85=
/0x100
[=A0=A0=A0 1.943659]=A0=A0 [<ffffffff818eabba>] ata_do_reset+0x3a/0x90
[=A0=A0=A0 1.943661]=A0=A0 [<ffffffff818edd72>] ata_eh_reset+0x372/0xe0=
0
[=A0=A0=A0 1.943664]=A0=A0 [<ffffffff818eec25>] ata_eh_recover+0x2a5/0x=
13d0
[=A0=A0=A0 1.943666]=A0=A0 [<ffffffff818f073d>] ata_do_eh+0x4d/0xb0
[=A0=A0=A0 1.943668]=A0=A0 [<ffffffff818f33ba>] ata_sff_error_handler+0=
xca/0x120
[=A0=A0=A0 1.943671]=A0=A0 [<ffffffff8190a9e4>] pdc_error_handler+0x24/=
0x30
[=A0=A0=A0 1.943673]=A0=A0 [<ffffffff818f029c>] ata_scsi_port_error_han=
dler+0x47c/0x800
[=A0=A0=A0 1.943675]=A0=A0 [<ffffffff818f06be>] ata_scsi_error+0x9e/0xd=
0
[=A0=A0=A0 1.943677]=A0=A0 [<ffffffff816732e8>] scsi_error_handler+0xf8=
/0x500
[=A0=A0=A0 1.943680]=A0=A0 [<ffffffff810654fe>] kthread+0xae/0xc0
[=A0=A0=A0 1.943683]=A0=A0 [<ffffffff81b4f5f4>] kernel_thread_helper+0x=
4/0x10
[=A0=A0=A0 1.943687] irq event stamp: 73472
[=A0=A0=A0 1.943688] hardirqs last=A0 enabled at (73469): [<ffffffff810=
0ab7d>] default_idle+0x5d/0x1b0
[=A0=A0=A0 1.943691] hardirqs last disabled at (73470): [<ffffffff81b4d=
a67>] common_interrupt+0x67/0x6c
[=A0=A0=A0 1.943694] softirqs last=A0 enabled at (73472): [<ffffffff810=
498d3>] _local_bh_enable+0x13/0x20
[=A0=A0=A0 1.943698] softirqs last disabled at (73471): [<ffffffff8104a=
355>] irq_enter+0x75/0x90
[=A0=A0=A0 1.943701]=20
[=A0=A0=A0 1.943701] other info that might help us debug this:
[=A0=A0=A0 1.943701]=A0 Possible unsafe locking scenario:
[=A0=A0=A0 1.943701]=20
[=A0=A0=A0 1.943701]=A0=A0=A0=A0=A0=A0=A0 CPU0
[=A0=A0=A0 1.943702]=A0=A0=A0=A0=A0=A0=A0 ----
[=A0=A0=A0 1.943702]=A0=A0 lock(&(&host->lock)->rlock);
[=A0=A0=A0 1.943704]=A0=A0 <Interrupt>
[=A0=A0=A0 1.943704]=A0=A0=A0=A0 lock(&(&host->lock)->rlock);
[=A0=A0=A0 1.943705]=20
[=A0=A0=A0 1.943705]=A0 *** DEADLOCK ***
[=A0=A0=A0 1.943705]=20
[=A0=A0=A0 1.943706] no locks held by swapper/0/0.
[=A0=A0=A0 1.943706]=20
[=A0=A0=A0 1.943706] stack backtrace:
[=A0=A0=A0 1.943708] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #4
[=A0=A0=A0 1.943709] Call Trace:
[=A0=A0=A0 1.943710]=A0 <IRQ>=A0 [<ffffffff81b35961>] print_usage_bug+0=
x1f7/0x208
[=A0=A0=A0 1.943715]=A0 [<ffffffff8101001f>] ? save_stack_trace+0x2f/0x=
50
[=A0=A0=A0 1.943718]=A0 [<ffffffff81098730>] ? print_shortest_lock_depe=
ndencies+0x1d0/0x1d0
[=A0=A0=A0 1.943720]=A0 [<ffffffff810992a2>] mark_lock+0x262/0x2a0
[=A0=A0=A0 1.943723]=A0 [<ffffffff81099af3>] __lock_acquire+0x813/0x1af=
0
[=A0=A0=A0 1.943725]=A0 [<ffffffff8107da11>] ? load_balance+0xd1/0x730
[=A0=A0=A0 1.943728]=A0 [<ffffffff8107baa0>] ? update_cfs_shares+0x100/=
0x100
[=A0=A0=A0 1.943731]=A0 [<ffffffff8109b31a>] lock_acquire+0x8a/0x110
[=A0=A0=A0 1.943733]=A0 [<ffffffff818f4e47>] ? ata_bmdma_interrupt+0x27=
/0x1d0
[=A0=A0=A0 1.943736]=A0 [<ffffffff81b4d151>] _raw_spin_lock_irqsave+0x4=
1/0x60
[=A0=A0=A0 1.943738]=A0 [<ffffffff818f4e47>] ? ata_bmdma_interrupt+0x27=
/0x1d0
[=A0=A0=A0 1.943741]=A0 [<ffffffff8107e070>] ? load_balance+0x730/0x730
[=A0=A0=A0 1.943743]=A0 [<ffffffff818f4e47>] ata_bmdma_interrupt+0x27/0=
x1d0
[=A0=A0=A0 1.943746]=A0 [<ffffffff810c2d5d>] handle_irq_event_percpu+0x=
5d/0x1f0
[=A0=A0=A0 1.943748]=A0 [<ffffffff810c2f38>] handle_irq_event+0x48/0x70
[=A0=A0=A0 1.943750]=A0 [<ffffffff81b4d059>] ? _raw_spin_lock+0x39/0x40
[=A0=A0=A0 1.943753]=A0 [<ffffffff810c5f0e>] ? handle_fasteoi_irq+0x1e/=
0xf0
[=A0=A0=A0 1.943755]=A0 [<ffffffff810c5f4a>] handle_fasteoi_irq+0x5a/0x=
f0
[=A0=A0=A0 1.943757]=A0 [<ffffffff81003ce2>] handle_irq+0x22/0x40
[=A0=A0=A0 1.943761]=A0 [<ffffffff81b4fdaa>] do_IRQ+0x5a/0xe0
[=A0=A0=A0 1.943763]=A0 [<ffffffff81b4da6c>] common_interrupt+0x6c/0x6c
[=A0=A0=A0 1.943766]=A0 <EOI>=A0 [<ffffffff8100ab7f>] ? default_idle+0x=
5f/0x1b0
[=A0=A0=A0 1.943769]=A0 [<ffffffff8100ab7d>] ? default_idle+0x5d/0x1b0
[=A0=A0=A0 1.943771]=A0 [<ffffffff8100b816>] cpu_idle+0x106/0x120
[=A0=A0=A0 1.943774]=A0 [<ffffffff81b0014e>] rest_init+0xb2/0xc4
[=A0=A0=A0 1.943777]=A0 [<ffffffff81b0009c>] ? csum_partial_copy_generi=
c+0x16c/0x16c
[=A0=A0=A0 1.943779]=A0 [<ffffffff8212cbbd>] start_kernel+0x3af/0x3bc
[=A0=A0=A0 1.943782]=A0 [<ffffffff8212c60d>] ? repair_env_string+0x5e/0=
x5e
[=A0=A0=A0 1.943784]=A0 [<ffffffff8212c32d>] x86_64_start_reservations+=
0x131/0x135
[=A0=A0=A0 1.943787]=A0 [<ffffffff8212c409>] x86_64_start_kernel+0xd8/0=
xdc
[=A0=A0=A0 1.943812] ata4.00: ATA-6: ST3200822AS, 3.01, max UDMA/133



***********************************************************************=
*
3
[=A0=A0=A0 1.938534] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=A0=A0=A0 1.938535] [ INFO: inconsistent lock state ]
[=A0=A0=A0 1.938537] 3.5.2 #4 Not tainted
[=A0=A0=A0 1.938538] ---------------------------------
[=A0=A0=A0 1.938539] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usag=
e.
[=A0=A0=A0 1.938540] swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[=A0=A0=A0 1.938542]=A0 (&(&host->lock)->rlock){?.+...}, at: [<ffffffff=
818f4e47>] ata_bmdma_interrupt+0x27/0x1d0
[=A0=A0=A0 1.938550] {HARDIRQ-ON-W} state was registered at:
[=A0=A0=A0 1.938551]=A0=A0 [<ffffffff810998fb>] __lock_acquire+0x61b/0x=
1af0
[=A0=A0=A0 1.938556]=A0=A0 [<ffffffff8109b31a>] lock_acquire+0x8a/0x110
[=A0=A0=A0 1.938558]=A0=A0 [<ffffffff81b4d051>] _raw_spin_lock+0x31/0x4=
0
[=A0=A0=A0 1.938563]=A0=A0 [<ffffffff8190b3c5>] pdc_sata_hardreset+0x85=
/0x100
[=A0=A0=A0 1.938565]=A0=A0 [<ffffffff818eabba>] ata_do_reset+0x3a/0x90
[=A0=A0=A0 1.938568]=A0=A0 [<ffffffff818edd72>] ata_eh_reset+0x372/0xe0=
0
[=A0=A0=A0 1.938571]=A0=A0 [<ffffffff818eec25>] ata_eh_recover+0x2a5/0x=
13d0
[=A0=A0=A0 1.938573]=A0=A0 [<ffffffff818f073d>] ata_do_eh+0x4d/0xb0
[=A0=A0=A0 1.938575]=A0=A0 [<ffffffff818f33ba>] ata_sff_error_handler+0=
xca/0x120
[=A0=A0=A0 1.938578]=A0=A0 [<ffffffff8190a9e4>] pdc_error_handler+0x24/=
0x30
[=A0=A0=A0 1.938580]=A0=A0 [<ffffffff818f029c>] ata_scsi_port_error_han=
dler+0x47c/0x800
[=A0=A0=A0 1.938583]=A0=A0 [<ffffffff818f06be>] ata_scsi_error+0x9e/0xd=
0
[=A0=A0=A0 1.938585]=A0=A0 [<ffffffff816732e8>] scsi_error_handler+0xf8=
/0x500
[=A0=A0=A0 1.938588]=A0=A0 [<ffffffff810654fe>] kthread+0xae/0xc0
[=A0=A0=A0 1.938591]=A0=A0 [<ffffffff81b4f5f4>] kernel_thread_helper+0x=
4/0x10
[=A0=A0=A0 1.938595] irq event stamp: 51552
[=A0=A0=A0 1.938596] hardirqs last=A0 enabled at (51549): [<ffffffff810=
0ab7d>] default_idle+0x5d/0x1b0
[=A0=A0=A0 1.938599] hardirqs last disabled at (51550): [<ffffffff81b4d=
a67>] common_interrupt+0x67/0x6c
[=A0=A0=A0 1.938602] softirqs last=A0 enabled at (51552): [<ffffffff810=
498d3>] _local_bh_enable+0x13/0x20
[=A0=A0=A0 1.938606] softirqs last disabled at (51551): [<ffffffff8104a=
355>] irq_enter+0x75/0x90
[=A0=A0=A0 1.938608]=20
[=A0=A0=A0 1.938608] other info that might help us debug this:
[=A0=A0=A0 1.938609]=A0 Possible unsafe locking scenario:
[=A0=A0=A0 1.938609]=20
[=A0=A0=A0 1.938609]=A0=A0=A0=A0=A0=A0=A0 CPU0
[=A0=A0=A0 1.938610]=A0=A0=A0=A0=A0=A0=A0 ----
[=A0=A0=A0 1.938610]=A0=A0 lock(&(&host->lock)->rlock);
[=A0=A0=A0 1.938611]=A0=A0 <Interrupt>
[=A0=A0=A0 1.938612]=A0=A0=A0=A0 lock(&(&host->lock)->rlock);
[=A0=A0=A0 1.938613]=20
[=A0=A0=A0 1.938613]=A0 *** DEADLOCK ***
[=A0=A0=A0 1.938613]=20
[=A0=A0=A0 1.938614] no locks held by swapper/1/0.
[=A0=A0=A0 1.938614]=20
[=A0=A0=A0 1.938614] stack backtrace:
[=A0=A0=A0 1.938616] Pid: 0, comm: swapper/1 Not tainted 3.5.2 #4
[=A0=A0=A0 1.938617] Call Trace:
[=A0=A0=A0 1.938618]=A0 <IRQ>=A0 [<ffffffff81b35961>] print_usage_bug+0=
x1f7/0x208
[=A0=A0=A0 1.938623]=A0 [<ffffffff8101001f>] ? save_stack_trace+0x2f/0x=
50
[=A0=A0=A0 1.938626]=A0 [<ffffffff810972da>] ? add_lock_to_list.isra.25=
=2Econstprop.39+0x7a/0xd0
[=A0=A0=A0 1.938629]=A0 [<ffffffff81098730>] ? print_shortest_lock_depe=
ndencies+0x1d0/0x1d0
[=A0=A0=A0 1.938631]=A0 [<ffffffff810992a2>] mark_lock+0x262/0x2a0
[=A0=A0=A0 1.938633]=A0 [<ffffffff81099af3>] __lock_acquire+0x813/0x1af=
0
[=A0=A0=A0 1.938636]=A0 [<ffffffff8107c655>] ? enqueue_task_fair+0x85/0=
xc0
[=A0=A0=A0 1.938639]=A0 [<ffffffff8109bbc9>] ? mark_held_locks+0xa9/0x1=
00
[=A0=A0=A0 1.938641]=A0 [<ffffffff81076f93>] ? try_to_wake_up+0x1c3/0x2=
d0
[=A0=A0=A0 1.938645]=A0 [<ffffffff8109b31a>] lock_acquire+0x8a/0x110
[=A0=A0=A0 1.938647]=A0 [<ffffffff818f4e47>] ? ata_bmdma_interrupt+0x27=
/0x1d0
[=A0=A0=A0 1.938650]=A0 [<ffffffff81b4d151>] _raw_spin_lock_irqsave+0x4=
1/0x60
[=A0=A0=A0 1.938652]=A0 [<ffffffff818f4e47>] ? ata_bmdma_interrupt+0x27=
/0x1d0
[=A0=A0=A0 1.938655]=A0 [<ffffffff8105fee0>] ? __queue_work+0x390/0x390
[=A0=A0=A0 1.938658]=A0 [<ffffffff818f4e47>] ata_bmdma_interrupt+0x27/0=
x1d0
[=A0=A0=A0 1.938661]=A0 [<ffffffff810c2d5d>] handle_irq_event_percpu+0x=
5d/0x1f0
[=A0=A0=A0 1.938664]=A0 [<ffffffff810c2f38>] handle_irq_event+0x48/0x70
[=A0=A0=A0 1.938665]=A0 [<ffffffff81b4d059>] ? _raw_spin_lock+0x39/0x40
[=A0=A0=A0 1.938668]=A0 [<ffffffff810c5f0e>] ? handle_fasteoi_irq+0x1e/=
0xf0
[=A0=A0=A0 1.938670]=A0 [<ffffffff810c5f4a>] handle_fasteoi_irq+0x5a/0x=
f0
[=A0=A0=A0 1.938672]=A0 [<ffffffff81003ce2>] handle_irq+0x22/0x40
[=A0=A0=A0 1.938676]=A0 [<ffffffff81b4fdaa>] do_IRQ+0x5a/0xe0
[=A0=A0=A0 1.938678]=A0 [<ffffffff81b4da6c>] common_interrupt+0x6c/0x6c
[=A0=A0=A0 1.938681]=A0 <EOI>=A0 [<ffffffff8100ab7f>] ? default_idle+0x=
5f/0x1b0
[=A0=A0=A0 1.938685]=A0 [<ffffffff8100ab7d>] ? default_idle+0x5d/0x1b0
[=A0=A0=A0 1.938687]=A0 [<ffffffff8100b816>] cpu_idle+0x106/0x120
[=A0=A0=A0 1.938689]=A0 [<ffffffff81b2c7db>] start_secondary+0x1dd/0x1e=
4
[=A0=A0=A0 1.938717] ata4.00: ATA-6: ST3200822AS, 3.01, max UDMA/133





oopses:
*****************************************************************
1



[=A0 918.496049] [drm] nouveau 0000:01:00.0: Setting dpms mode 1 on vga=
 encoder (output 0)
[1346318855.630001] BUG: unable to handle kernel NULL pointer dereferen=
ce at=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (null)
[1346318855.630001] IP: [<ffffffff81099430>] __lock_acquire+0x150/0x1af=
0
[1346318855.630001] PGD 0=20
[1346318855.630001] Oops: 0002 [#1] SMP=20
[1346318855.630001] CPU 1=20
[1346318855.630001] Modules linked in:[1346318855.630001]=A0 netconsole=
 snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_m=
ixer_oss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf=
_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_ta=
bles x_tables lp fuse nouveau snd_via82xx snd_ac97_codec snd_mpu401_uar=
t mxm_wmi wmi snd_rawmidi video ttm drm_kms_helper drm snd_seq_device s=
nd_pcm snd_page_alloc snd_timer snd powernow_k8 button i2c_algo_bit mpe=
rf i2c_viapro shpchp amd64_agp agpgart skge soundcore ac97_bus gameport=
 ppdev freq_table evdev i2c_core processor k8temp parport_pc parport th=
ermal_sys hwmon loop

[1346318855.630001] Pid: 0, comm: swapper/1 Not tainted 3.5.2 #4 To Be =
=46illed By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[1346318855.630001] RIP: 0010:[<ffffffff81099430>]=A0 [<ffffffff8109943=
0>] __lock_acquire+0x150/0x1af0
[1346318855.630001] RSP: 0018:ffff88007fd03d98=A0 EFLAGS: 00010046
[1346318855.630001] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00=
00000000000002
[1346318855.630001] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff=
ffffff82022180
[1346318855.630001] RBP: ffff88007fd03e88 R08: 0000000000000001 R09: 00=
00000000000001
[1346318855.630001] R10: ffff88007d07dd60 R11: 0000000000000001 R12: 00=
00000000000001
[1346318855.630001] R13: 0000000000000002 R14: 0000000000000001 R15: 00=
00000000000000
[1346318855.630001] FS:=A0 00007f38d8c5f740(0000) GS:ffff88007fd00000(0=
000) knlGS:00000000f6f7a700
[1346318855.630001] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[1346318855.630001] CR2: 0000000000000000 CR3: 000000000200b000 CR4: 00=
000000000007e0
[1346318855.630001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00=
00000000000000
[1346318855.630001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00=
00000000000400
[1346318855.630001] Process swapper/1 (pid: 0, threadinfo ffff88007c524=
000, task ffff88007d07dd60)
[1346318855.630001] Stack:
[1346318855.630001]=A0 ffffffff81051c0e ffffffff00000000 00000000000000=
06 0000000000000096
[1346318855.630001]=A0 0000000000000046 000000008107e70c ffff88007c5340=
18 ffff88007fd12780
[1346318855.630001]=A0 0000000000000082 ffff88007c534000 ffff88007c5340=
00 ffff88007c534000
[1346318855.630001] Call Trace:
[1346318855.630001]=A0 <IRQ>=20
[1346318855.630001]=A0 [<ffffffff81051c0e>] ? run_timer_softirq+0x3e/0x=
390
[1346318855.630001]=A0 [<ffffffff8109bdbd>] ? trace_hardirqs_on+0xd/0x1=
0
[1346318855.630001]=A0 [<ffffffff81b4d7c0>] ? _raw_spin_unlock_irq+0x30=
/0x40
[1346318855.630001]=A0 [<ffffffff81051dde>] ? run_timer_softirq+0x20e/0=
x390
[1346318855.630001]=A0 [<ffffffff8109b31a>] lock_acquire+0x8a/0x110
[1346318855.630001]=A0 [<ffffffff8106b8a0>] ? raw_notifier_call_chain+0=
x20/0x20
[1346318855.630001]=A0 [<ffffffff8106b8f6>] __atomic_notifier_call_chai=
n+0x56/0xa0
[1346318855.630001]=A0 [<ffffffff8106b8a0>] ? raw_notifier_call_chain+0=
x20/0x20
[1346318855.630001]=A0 [<ffffffff8109536e>] ? tick_nohz_stop_idle+0x3e/=
0x50
[1346318855.630001]=A0 [<ffffffff8106b956>] atomic_notifier_call_chain+=
0x16/0x20
[1346318855.630001]=A0 [<ffffffff8100b703>] exit_idle+0x43/0x50
[1346318855.630001]=A0 [<ffffffff81b4fe73>] smp_apic_timer_interrupt+0x=
43/0x99
[1346318855.630001]=A0 [<ffffffff81b4eedc>] apic_timer_interrupt+0x6c/0=
x80
[1346318855.630001]=A0 <EOI>=20
[1346318855.630001]=A0 [<ffffffff8100ab7d>] ? default_idle+0x5d/0x1b0
[1346318855.630001]=A0 [<ffffffff8100ab7f>] ? default_idle+0x5f/0x1b0
[1346318855.630001]=A0 [<ffffffff8100ab7d>] ? default_idle+0x5d/0x1b0
[1346318855.630001]=A0 [<ffffffff8100b816>] cpu_idle+0x106/0x120
[1346318855.630001]=A0 [<ffffffff81b2c7db>] start_secondary+0x1dd/0x1e4
[1346318855.630001] Code: 85 f6 0f 85 91 11 00 00 49 89 5d 08 83 3d 58 =
0f 19 01 00 75 0a 44 3b 73 28 0f 85 8e 17 00 00 48 85 db 75 60 0f 1f 80=
 00 00 00 00 <31> c0 48 8b 5d d8 4c 8b 65 e0 4c 8b 6d e8 4c 8b 75 f0 4c=
 8b 7d=20
[1346318855.630001] RIP=A0 [<ffffffff81099430>] __lock_acquire+0x150/0x=
1af0
[1346318855.630001]=A0 RSP <ffff88007fd03d98>
[1346318855.630001] CR2: 0000000000000000
[1346318855.630001] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on =
vga encoder (output 0)
[1346318855.630001] ---[ end trace 8d0e3b845eb2daca ]---
[1346318855.630001] Kernel panic - not syncing: Fatal exception in inte=
rrupt
[1346318855.630001] panic occurred, switching back to text console
[1346318855.630001] Rebooting in 10 seconds..


*************************************************************
2

[=A0 890.786007] general protection fault: 0000 [#1] SMP=20
[=A0 890.786007] CPU 0=20
[=A0 890.786007] Modules linked in:[=A0 890.786007]=A0 netconsole snd_s=
eq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_o=
ss ipt_REJECT xt_tcpudp iptable_raw iptable_mangle iptable_nat nf_nat n=
f_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_filter ip_tables x=
_tables lp fuse nouveau mxm_wmi wmi video ttm drm_kms_helper drm snd_vi=
a82xx snd_ac97_codec snd_mpu401_uart snd_rawmidi powernow_k8 mperf snd_=
seq_device snd_pcm snd_page_alloc processor amd64_agp snd_timer agpgart=
 skge freq_table i2c_algo_bit i2c_viapro i2c_core snd k8temp soundcore =
thermal_sys ac97_bus gameport hwmon button ppdev shpchp evdev parport_p=
c parport loop

[=A0 890.786007] Pid: 0, comm: swapper/0 Not tainted 3.5.2 #4 To Be Fil=
led By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[=A0 890.786007] RIP: 0010:[<ffffffff810957ea>]=A0 [<ffffffff810957ea>]=
 tick_check_idle+0x3a/0xe0
[=A0 890.786007] RSP: 0018:ffff88007fc03f50=A0 EFLAGS: 00010086
[=A0 890.786007] RAX: 0000000000015180 RBX: c31e1ad9b83b64d7 RCX: fffff=
fffffffffff
[=A0 890.786007] RDX: 0000000000000000 RSI: 0000000000000200 RDI: 00000=
00000015180
[=A0 890.786007] RBP: ffff88007fc03f88 R08: 0000000000000000 R09: 00000=
00000000000
[=A0 890.786007] R10: 0000000000000000 R11: 0000000000000000 R12: 00000=
00000015180
[=A0 890.786007] R13: 000000000000da40 R14: ffff88007ff1d8c0 R15: 00000=
00000000000
[=A0 890.786007] FS:=A0 00007f79bf1b6740(0000) GS:ffff88007fc00000(0000=
) knlGS:00000000f719c940
[=A0 890.786007] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[=A0 890.786007] CR2: 00007fff8f780518 CR3: 000000007af3c000 CR4: 00000=
000000007f0
[=A0 890.786007] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
[=A0 890.786007] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
[=A0 890.786007] Process swapper/0 (pid: 0, threadinfo ffffffff82000000=
, task ffffffff82013440)
[=A0 890.786007] Stack:
[=A0 890.786007]=A0 ffffffff821762c0 ffff88007fc03f68 ffffffff810497f7 =
0000000000000000
[=A0 890.786007]=A0 0000000000000000 ffffffff821762c0 ffff88007ff1d8c0 =
ffff88007fc03fa8
[=A0 890.786007]=A0 ffffffff81b4fe6e ffffffff82001fd8 0000000000000000 =
ffffffff82001ef8
[=A0 890.786007] Call Trace:
[=A0 890.786007]=A0 <IRQ>=20
[=A0 890.786007]=A0 [<ffffffff810497f7>] ? local_bh_disable+0x17/0x20
[=A0 890.786007]=A0 [<ffffffff81b4fe6e>] smp_apic_timer_interrupt+0x3e/=
0x99
[=A0 890.786007]=A0 [<ffffffff81b4eedc>] apic_timer_interrupt+0x6c/0x80
[=A0 890.786007]=A0 <EOI>=20
[=A0 890.786007]=A0 [<ffffffff8100ab7d>] ? default_idle+0x5d/0x1b0
[=A0 890.786007]=A0 [<ffffffff8100ab7f>] ? default_idle+0x5f/0x1b0
[=A0 890.786007]=A0 [<ffffffff8100ab7d>] ? default_idle+0x5d/0x1b0
[=A0 890.786007]=A0 [<ffffffff8100b816>] cpu_idle+0x106/0x120
[=A0 890.786007]=A0 [<ffffffff81b0014e>] rest_init+0xb2/0xc4
[=A0 890.786007]=A0 [<ffffffff81b0009c>] ? csum_partial_copy_generic+0x=
16c/0x16c
[=A0 890.786007]=A0 [<ffffffff8212cbbd>] start_kernel+0x3af/0x3bc
[=A0 890.786007]=A0 [<ffffffff8212c60d>] ? repair_env_string+0x5e/0x5e
[=A0 890.786007]=A0 [<ffffffff8212c32d>] x86_64_start_reservations+0x13=
1/0x135
[=A0 890.786007]=A0 [<ffffffff8212c409>] x86_64_start_kernel+0xd8/0xdc
[=A0 890.786007] Code: e8 4c 89 6d f0 4c 89 75 f8 66 66 66 66 90 49 c7 =
c5 40 da 00 00 41 89 fc 4c 89 eb e8 31 ed ff ff 49 63 c4 48 03 1c c5 80=
 18 11 82 <8b> 83 98 00 00 00 85 c0 75 1c 8b 43 7c 85 c0 75 15 48 8b 5d=
 e0=20
[=A0 890.786007] RIP=A0 [<ffffffff810957ea>] tick_check_idle+0x3a/0xe0
[=A0 890.786007]=A0 RSP <ffff88007fc03f50>
[=A0 890.786007] ---[ end trace 5a3761b5f4473308 ]---
[=A0 890.786007] Kernel panic - not syncing: Fatal exception in interru=
pt
[=A0 890.786007] panic occurred, switching back to text console
[=A0 890.786007] Rebooting in 10 seconds..


Thanks.

Best regards
Adko.
