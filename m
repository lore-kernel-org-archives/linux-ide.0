From: Alexander Kandaurov <aakandaurov@yandex.ru>
Subject: System lockup with misc ATAPI commands on VT6415
Date: Mon, 1 Aug 2016 00:27:18 +0500
Message-ID: <20160801002718.38a0d88d@raspberrypi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from forward6p.cmail.yandex.net ([87.250.241.191]:46207 "EHLO
	forward6p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751199AbcGaVCp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Jul 2016 17:02:45 -0400
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [77.88.29.84])
	by forward6p.cmail.yandex.net (Yandex) with ESMTP id 44E652181C
	for <linux-ide@vger.kernel.org>; Sun, 31 Jul 2016 22:27:21 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (localhost.localdomain [127.0.0.1])
	by smtp1p.mail.yandex.net (Yandex) with ESMTP id 41AEE17804D6
	for <linux-ide@vger.kernel.org>; Sun, 31 Jul 2016 22:27:21 +0300 (MSK)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

There is an issue with the VIA VT6415 IDE controller where the system
sometimes locks up if an optical drive is connected.

I made a further investigation since this post:
https://bugzilla.kernel.org/show_bug.cgi?id=44111#c15

Some patterns I've found to trigger the lockup:
- MODE SENSE (10) when the length of the response is not a multiple
  of 8;
- GET CONFIGURATION command (I tested it on two drives that supported
  it and on both of them the response length also wasn't a multiple
  of 8);
- INQUIRY command with non-standard requested lengths when the device
  response is shorter than requested.

The lockup happens only when the command is sent with DMA enabled. It
also seems to be triggered by a second read of a device register in
the interrupt handler. Normally the first read is performed in
ata_sff_dma_pause() called from ata_bmdma_stop(), the second read
attempt causing the lockup is made in ata_sff_irq_status() called from
__ata_sff_port_intr(). If I try to add another read in
ata_sff_dma_pause() before reading of the alternate status, e. g. the
error register, then the hang will happen on that alternate status read.

I tried looking at the DMA buffer contents and from that it can be seen
that the difference between commands causing the hang and those that
are always successful is that in the failing command case all the
buffers including the drain buffer become filled with some repeating
pattern which seems to be comprised of bytes from current and previous
responses. Also, in the case before the system locks up, the drain
buffer is not filled up to the end.

Also, there seems to be a correlation between the lockup probability and
the buffer size. If I modify the atapi_drain_needed() function to never
add a drain buffer, the MODE SENSE (10) command with the default buffer
size of 0x1000 set by sg_modes takes several thousands of attempts to
hang the system, whereas with a buffer size of 0x3000 it takes only
about 10.

I also tested this on other OS's including FreeBSD (with default
settings) and Windows XP with the UniATA driver (set up to use UDMA4
and use DMA for all commands; the default Windows driver doesn't use
DMA for misc ATAPI commands). No hang occurs in these systems. I looked
at DMA buffers in FreeBSD and these are filled in the same manner as in
Linux.

A possible fix to this issue could be using PIO for the misc ATAPI
commands for this controller as is done in sata_promise.c, but what
confuses me here is that two other systems perform well in similar
conditions, so this could possibly be specifically some Linux bug.
