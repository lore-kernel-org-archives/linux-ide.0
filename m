From: Pat LaVarre <p.lavarre@ieee.org>
Subject: IRQ re-disabled when SATAPI via CONFIG_BLK_DEV_IDE_SATA
Date: 17 Aug 2004 14:27:49 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1092774469.4599.4.camel@patlinux.iomegacorp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:11440 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S268416AbUHQU27
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2004 16:28:59 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

By the way,

I see the following dmesg repeat often, like once per open of the
device, if I connect SATAPI in 2.6.8.1 via CONFIG_BLK_DEV_IDE_SATA.

kernel: irq 18: nobody cared!
kernel:  [<c010822b>] __report_bad_irq+0x2a/0x8b
kernel:  [<c0108315>] note_interrupt+0x6f/0x9f
kernel:  [<c01086a8>] do_IRQ+0x1d4/0x226
kernel:  [<c0103cbe>] default_idle+0x0/0x2d
kernel:  [<c0106800>] common_interrupt+0x18/0x20
kernel:  [<c0103cbe>] default_idle+0x0/0x2d
kernel:  [<c0103ce8>] default_idle+0x2a/0x2d
kernel:  [<c0103d5c>] cpu_idle+0x37/0x40
kernel:  [<c0451885>] start_kernel+0x1b0/0x201
kernel:  [<c045130a>] unknown_bootoption+0x0/0x16f
kernel: handlers:
kernel: [<c0249b12>] (ide_intr+0x0/0x1d1)
kernel: Disabling IRQ #18

I recognise this "disabling IRQ" message from the history of libata.ko
development, where I more often saw it once and then immediately a
kernel crash.

I imagine we don't care.  I imagine for 2.6 we prefer to focus on
teaching libata.ko etc. to talk SATAPI, rather than working to document
the 2.6 behaviour of the old deprecated code.  But ...

I'm writing just to give everyone a chance to tell me this is not a
boringly normal result.

Pat LaVarre

P.S. Also in my one sample I see assymmetric thruput: writes out maybe
thirteen percent down below reads in, in the neighbourhood of the 1.5
GB/min = 25 MB/s that is the outside disc limit of my sample device.


