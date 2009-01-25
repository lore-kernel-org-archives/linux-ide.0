From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: 2.6.28: Moved to SATA driver (w/PATA support), kernel OOPS at boot
Date: Sun, 25 Jan 2009 07:46:02 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0901250741300.11258@p34.internal.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:56985 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbZAYMqE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jan 2009 07:46:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Switched from the old IDE interface (disabled it) to SATA only in the kernel:

[    1.788921] irq 11: nobody cared (try booting with the "irqpoll" option)
[    1.788978] Pid: 0, comm: swapper Not tainted 2.6.28 #4
[    1.789031] Call Trace:
[    1.789085]  [<c0134153>] __report_bad_irq+0x24/0x81
[    1.789138]  [<c01342df>] note_interrupt+0x12f/0x170
[    1.789191]  [<c01338dc>] handle_IRQ_event+0x25/0x4a
[    1.789244]  [<c01348c4>] handle_level_irq+0x7a/0x90
[    1.789299]  [<c0104e07>] do_IRQ+0x6f/0x88
[    1.789352]  [<c012c1c4>] getnstimeofday+0x3b/0xd1
[    1.789407]  [<c010f150>] smp_apic_timer_interrupt+0x41/0x71
[    1.789461]  [<c0103973>] common_interrupt+0x23/0x28
[    1.789515]  [<c011c9bf>] __do_softirq+0x2d/0xea
[    1.789535]  [<c011caa2>] do_softirq+0x26/0x2e
[    1.789535]  [<c010f150>] smp_apic_timer_interrupt+0x41/0x71
[    1.789535]  [<c01039a0>] apic_timer_interrupt+0x28/0x30
[    1.789535]  [<c0108362>] default_idle+0x36/0x42
[    1.789535]  [<c0101f7c>] cpu_idle+0x4b/0x5f
[    1.789535]  [<c0586925>] start_kernel+0x221/0x261
[    1.789535]  [<c05864d3>] unknown_bootoption+0x0/0x1e3
[    1.789535] handlers:
[    1.789535] [<c039e087>] (ata_sff_interrupt+0x0/0x242)
[    1.789535] Disabling IRQ #11

Full dmesg:
http://home.comcast.net/~jpiszcz/20090125/dmesg20090125.txt

Kernel config:
http://home.comcast.net/~jpiszcz/20090125/2.6.28-config.txt

This never happened with the old IDE layer.

Justin.

