From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: IDE deadlock on CRC errors
Date: Sun, 28 Nov 2004 16:02:12 +0000
Message-ID: <1101657731.16756.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:35473 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261531AbUK1RFg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Nov 2004 12:05:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

do_reset1 takes the ide lock and disables interrupts
calls pre_reset
calls check_dma_crc
calls ide_set_xfer_rate
calls ->speedproc
  blah_tune_chipset)
calls ide_config_drive_speed
  disable_irq_nosync
  drops IRQ mask
  Wait up to ten seconds

Unfortunately an IRQ can arrive before the disable_irq_nosync and in
that situation we drop the IRQ mask, and the pending _intr routines
deadlock. If we remove the _nosync then the IDE layer deadlocks on the
disable_irq. If we drop the lock then we change the locking semantics
for all IDE drivers on speedproc handling, and some rely on it by
inspection.

I can see some possible ways to fix this but none of them are exactly
trivial because they change the locking or ordering around a lot. The
cleanest is probably to bite the bullet and leave speedproc internal
locking to the drivers. This also clean up a variety of up to two second
delays. As far as I can see speedproc is never called with work
outstanding. Another approach might be to queue the speedproc command to
head of queue, remove the whacked out special case logic and let the IDE
command engine do the right thing.

There is a second deadlock in ide_abort when you call the reset function
from ioctl status at the wrong time. I'll take a look into that since I
wrote the original ide_abort code and the bug. I don't however really
have time to look at the CRC deadlock until I've had a chance to fix the
fact ide-cdrom is unsafe/unsable with CD-R/CD-RW media on some drivess
in 2.6.9 when doing disk copies/compares or mount without the -t flag
(so next year at the earliest)



