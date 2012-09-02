From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Sun, 2 Sep 2012 22:04:53 +0200
Message-ID: <20547.48101.900727.735398@pilspetsen.it.uu.se>
References: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com>
	<20120826130152.GA20021@liondog.tnic>
	<1346086872.65665.YahooMailNeo@web124704.mail.ne1.yahoo.com>
	<20120827215952.GA18719@liondog.tnic>
	<1346259574.81504.YahooMailNeo@web124706.mail.ne1.yahoo.com>
	<20120830095808.GB24680@liondog.tnic>
	<1346325007.23643.YahooMailNeo@web124706.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346325007.23643.YahooMailNeo@web124706.mail.ne1.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adko Branil <adkobranil@yahoo.com>
Cc: Borislav Petkov <bp@alien8.de>, Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Adko Branil writes:
 > >Right near the end there's a lockdep warning about a deadlock
 >=20
 > >between sata_promise's hardreset thing and the machine getting a
 > >ata_bmdma_interrupt.
 >=20
 > >But since I don't know this code, it would be nice if you could tak=
e a
 > >look at it.
 >=20
 > I picked up 3 more dmesg after rebooting, and 2 more oopses.
 > =A0I will put here just pieces from dmesgs about these locks, they d=
iffers slightly each-other:
 >=20
 > ********************************************************************=
***************
 > 1.
 >=20
 >=20
 > [=A0=A0=A0 1.859215] input: AT Translated Set 2 keyboard as /devices=
/platform/i8042/serio0/input/input1
 > [=A0=A0=A0 1.943678]=20
 > [=A0=A0=A0 1.943679] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 > [=A0=A0=A0 1.943680] [ INFO: inconsistent lock state ]
 > [=A0=A0=A0 1.943682] 3.5.2 #4 Not tainted
 > [=A0=A0=A0 1.943683] ---------------------------------
 > [=A0=A0=A0 1.943684] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} u=
sage.
 > [=A0=A0=A0 1.943686] swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 > [=A0=A0=A0 1.943687]=A0 (&(&host->lock)->rlock){?.+...}, at: [<fffff=
fff818f4e47>] ata_bmdma_interrupt+0x27/0x1d0
 > [=A0=A0=A0 1.943695] {HARDIRQ-ON-W} state was registered at:
 > [=A0=A0=A0 1.943696]=A0=A0 [<ffffffff810998fb>] __lock_acquire+0x61b=
/0x1af0
 > [=A0=A0=A0 1.943701]=A0=A0 [<ffffffff8109b31a>] lock_acquire+0x8a/0x=
110
 > [=A0=A0=A0 1.943703]=A0=A0 [<ffffffff81b4d051>] _raw_spin_lock+0x31/=
0x40
 > [=A0=A0=A0 1.943708]=A0=A0 [<ffffffff8190b3c5>] pdc_sata_hardreset+0=
x85/0x100
 > [=A0=A0=A0 1.943711]=A0=A0 [<ffffffff818eabba>] ata_do_reset+0x3a/0x=
90
 > [=A0=A0=A0 1.943713]=A0=A0 [<ffffffff818edd72>] ata_eh_reset+0x372/0=
xe00
 > [=A0=A0=A0 1.943716]=A0=A0 [<ffffffff818eec25>] ata_eh_recover+0x2a5=
/0x13d0
 > [=A0=A0=A0 1.943718]=A0=A0 [<ffffffff818f073d>] ata_do_eh+0x4d/0xb0
 > [=A0=A0=A0 1.943721]=A0=A0 [<ffffffff818f33ba>] ata_sff_error_handle=
r+0xca/0x120
 > [=A0=A0=A0 1.943723]=A0=A0 [<ffffffff8190a9e4>] pdc_error_handler+0x=
24/0x30
 > [=A0=A0=A0 1.943725]=A0=A0 [<ffffffff818f029c>] ata_scsi_port_error_=
handler+0x47c/0x800
 > [=A0=A0=A0 1.943728]=A0=A0 [<ffffffff818f06be>] ata_scsi_error+0x9e/=
0xd0
 > [=A0=A0=A0 1.943730]=A0=A0 [<ffffffff816732e8>] scsi_error_handler+0=
xf8/0x500
 > [=A0=A0=A0 1.943734]=A0=A0 [<ffffffff810654fe>] kthread+0xae/0xc0
 > [=A0=A0=A0 1.943737]=A0=A0 [<ffffffff81b4f5f4>] kernel_thread_helper=
+0x4/0x10
 > [=A0=A0=A0 1.943740] irq event stamp: 51304
 > [=A0=A0=A0 1.943741] hardirqs last=A0 enabled at (51301): [<ffffffff=
8100ab7d>] default_idle+0x5d/0x1b0
 > [=A0=A0=A0 1.943745] hardirqs last disabled at (51302): [<ffffffff81=
b4da67>] common_interrupt+0x67/0x6c
 > [=A0=A0=A0 1.943748] softirqs last=A0 enabled at (51304): [<ffffffff=
810498d3>] _local_bh_enable+0x13/0x20
 > [=A0=A0=A0 1.943752] softirqs last disabled at (51303): [<ffffffff81=
04a355>] irq_enter+0x75/0x90
 > [=A0=A0=A0 1.943754]=20
 > [=A0=A0=A0 1.943754] other info that might help us debug this:
 > [=A0=A0=A0 1.943755]=A0 Possible unsafe locking scenario:
 > [=A0=A0=A0 1.943755]=20
 > [=A0=A0=A0 1.943755]=A0=A0=A0=A0=A0=A0=A0 CPU0
 > [=A0=A0=A0 1.943755]=A0=A0=A0=A0=A0=A0=A0 ----
 > [=A0=A0=A0 1.943756]=A0=A0 lock(&(&host->lock)->rlock);
 > [=A0=A0=A0 1.943757]=A0=A0 <Interrupt>
 > [=A0=A0=A0 1.943758]=A0=A0=A0=A0 lock(&(&host->lock)->rlock);

I was initially able to reproduce the lockdep warning, and wrote
a crude test patch, but now I can't seem to reproduce the warning
with or without that patch, so I'm not sure what to make of it.

pdc_hard_reset_port needs to serialize because hard reset has to flip
a port-specific bit in a controller register that's shared by all ports=
,
so it takes the host lock. But now an interrupt occurs during the hard
reset, and pdc_interrupt also has to take the host lock. (I don't know
why the interrupt occurs, hotplug events are supposed to have been mask=
ed
by ->freeze before ->hardreset. It might come from a different device,
my test machine has multiple ATA controllers from different vendors,
and some of them do share IRQ.)

Jeff: ->hardreset is called with the host lock NOT held, right?

I think I'll have to introduce a new private lock just for serializing
pdc_hard_reset_port. Expect a patch next weekend (I'll be away from
my Promise test equipment until then.)

/Mikael
