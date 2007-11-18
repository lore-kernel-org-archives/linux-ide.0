From: Akkana Peck <akkana@shallowsky.com>
Subject: Problem with PCMCIA IDE
Date: Sun, 18 Nov 2007 12:23:09 -0800
Message-ID: <20071118202309.GE15355@shallowsky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl-69-105-235-1.dsl.pltn13.pacbell.net ([69.105.235.1]:39820
	"EHLO moon.timocharis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbXKRUwK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 15:52:10 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've been having problems getting PCMCIA IDE to work on my Vaio
laptop on recent kernels (I've been working most with 2.6.23.1 and
.8). I've been hesitant to report it as a kernel bug because it
may very well be a problem with my .config parameters -- the CDROM
worked in distro kernels back around 2.6.17 and .18, and self-built
kernels even earlier than that, but the configuration has changed
quite a bit since then so it's hard to compare directly and figure
out if I'm missing something.

First, is this a reasonable place to report problems with PCMCIA,
or does it belong on a PCMCIA list?

The machine is a Vaio SR17 and I'm hotplugging a PCMCIA CDROM drive
(this is a subnotebook, so the drive is external).  I don't think
it's CD specific (the CONFIG_BLK_DEV_IDECD code), because /proc/ide
only shows ide0, not ide2 like I'm used to seeing in earlier kernels
when the CD drive was connected.

PCMCIA/Cardbus itself works fine (e.g. for network cards).
There's no sata (this is an old machine).

Depending on how I set kernel options, I can get the kernel to lock
up when the PCMCIA CDROM drive is plugged in, or not. When it locks,
it stays locked up (no keyboard or X events), until I eject the
PCMCIA plug, then after a few seconds things are back to normal.
Either way, it never notices the CD drive or creates an ide2 bus.

In the cases where it locks up, dmesg says:
BUG: soft lockup detected on CPU#0!
 [<c01213b7>] update_process_times+0x27/0x70
 [<c0130e7d>] tick_nohz_handler+0x5d/0xf0
 [<c01069ab>] timer_interrupt+0xb/0x20
 [<c013c795>] handle_IRQ_event+0x25/0x60
 [<c013dd14>] handle_level_irq+0x44/0xa0
 [<c0105d72>] do_IRQ+0x42/0x80
 [<c01041af>] common_interrupt+0x23/0x28
 [<c011dbcd>] __do_softirq+0x2d/0x90
 [<c011dc56>] do_softirq+0x26/0x30
 [<c011df1a>] irq_exit+0x5a/0x60
 [<c0105d77>] do_IRQ+0x47/0x80
 [<c01041af>] common_interrupt+0x23/0x28
 [<c02eb163>] ide_register_hw_with_fixup+0x33/0x1e0
 [<c02fc3d6>] idecs_register+0x76/0x80
[ various more backtrace, then ]
 =======================
Probing IDE interface ide2...

then that last message keeps repeating until I eject.

Since it's obviously complaining about IRQs, I tried turning on
CONFIG_IDEPCI_SHARE_IRQ=y (I also turned off CONFIG_BLK_DEV_IDEACPI
to see if that made any difference) and that stopped the
"BUG: soft lockup", but I still got the loop over "Probing IDE
interface ide2..." and it still doesn't see the CDROM or ide2.

I've put the full .config files at http://shallowsky.com/tmp/configs/
so as not to clutter this list.

Can anybody offer any tips for figuring out whether this is a
config error on my part, or a real kernel bug in IDECS?
Or send me to a more appropriate forum, if this isn't it?

Thanks in advance!

	...Akkana
