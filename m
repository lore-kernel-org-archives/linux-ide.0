From: Mark Lehrer <mark@knm.org>
Subject: DVD causes kernel errors
Date: Tue, 15 Feb 2005 10:58:39 -0700
Message-ID: <20050215175839.GC32487@knm.org>
Reply-To: mark@knm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from dsl093-225-013.slc1.dsl.speakeasy.net ([66.93.225.13]:10145
	"EHLO home.knm.org") by vger.kernel.org with ESMTP id S261709AbVBOR6j
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Feb 2005 12:58:39 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org



I have an Asus P4P800-VM system (i865G chipset) and when I plug in
a DVD drive (NEC 3520) instead of a CDROM I get the following kernel
errors (versions 2.6.9 through 2.6.11-pre4):

Feb 15 00:20:21 mythtv kernel: hdb: _NEC DVD_RW ND-3520A, ATAPI CD/DVD-ROM driv\
e
Feb 15 00:20:21 mythtv kernel: ide0 at 0xefe0-0xefe7,0xefae on irq 11
Feb 15 00:20:21 mythtv kernel: hda: max request size: 128KiB
Feb 15 00:20:21 mythtv kernel:  [<c012f13a>] __report_bad_irq+0x2a/0xa0
Feb 15 00:20:21 mythtv kernel:  [<c012ea60>] handle_IRQ_event+0x30/0x70
Feb 15 00:20:21 mythtv kernel:  [<c012f240>] note_interrupt+0x70/0xb0
Feb 15 00:20:21 mythtv kernel:  [<c012ebe5>] __do_IRQ+0x145/0x160
Feb 15 00:20:21 mythtv kernel:  [<c01042b3>] do_IRQ+0x23/0x40
Feb 15 00:20:21 mythtv kernel:  [<c010288e>] common_interrupt+0x1a/0x20
Feb 15 00:20:21 mythtv kernel:  [<c011857e>] __do_softirq+0x2e/0x90
Feb 15 00:20:21 mythtv kernel:  [<c0118606>] do_softirq+0x26/0x30
Feb 15 00:20:21 mythtv kernel:  [<c01186d5>] irq_exit+0x35/0x40
Feb 15 00:20:21 mythtv kernel:  [<c01042b8>] do_IRQ+0x28/0x40
Feb 15 00:20:21 mythtv kernel:  [<c010288e>] common_interrupt+0x1a/0x20
Feb 15 00:20:21 mythtv kernel:  [<c01005d3>] default_idle+0x23/0x30
Feb 15 00:20:21 mythtv kernel:  [<c0100670>] cpu_idle+0x50/0x60
Feb 15 00:20:21 mythtv kernel:  [<c012f240>] note_interrupt+0x70/0xb0
Feb 15 00:20:21 mythtv kernel:  [<c012ebe5>] __do_IRQ+0x145/0x160
Feb 15 00:20:21 mythtv kernel:  [<c01042b3>] do_IRQ+0x23/0x40
Feb 15 00:20:21 mythtv kernel:  [<c010288e>] common_interrupt+0x1a/0x20
Feb 15 00:20:21 mythtv kernel:  [<c011857e>] __do_softirq+0x2e/0x90
Feb 15 00:20:21 mythtv kernel:  [<c0118606>] do_softirq+0x26/0x30
Feb 15 00:20:21 mythtv kernel:  [<c01186d5>] irq_exit+0x35/0x40
Feb 15 00:20:21 mythtv kernel:  [<c01042b8>] do_IRQ+0x28/0x40
Feb 15 00:20:21 mythtv kernel:  [<c010288e>] common_interrupt+0x1a/0x20
Feb 15 00:20:21 mythtv kernel:  [<c01005d3>] default_idle+0x23/0x30
Feb 15 00:20:21 mythtv kernel:  [<c0100670>] cpu_idle+0x50/0x60
Feb 15 00:20:21 mythtv kernel:  [<c056e7dd>] start_kernel+0x17d/0x1c0
Feb 15 00:20:21 mythtv kernel:  [<c056e360>] unknown_bootoption+0x0/0x1e0


Sometimes it won't boot, sometimes it will boot but lockup when I
try using the drive.  If I run with noirqdebug, it just freezes once
it displays the _NEC message.  I tried disabling APIC but no luck.

Any idea what could be causing this problem?

Thanks,
Mark
