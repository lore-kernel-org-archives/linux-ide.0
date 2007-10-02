From: akpm@linux-foundation.org
Subject: [patch 03/10] libata: correct handling of SRST reset sequences
Date: Tue, 02 Oct 2007 13:53:00 -0700
Message-ID: <200710022053.l92Kr06K021679@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39270 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752173AbXJBUxZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 16:53:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Correct handling of SRST reset sequences.  After an SRST it is undefined
whether the drive has gone back to PIO0.  In order to talk safely we should
talk slowly and carefully until we know.

Thus when we do the reset if the controller has a pio setup method we call it
to flip back to PIO 0 and a known state.  After the reset completes the
identify will then be done at the safe speed and the drive/controller will
pick suitable faster modes and reconfigure the controller to these timings.

As a side effect it means we force the controller to PIO 0 as we bring it up
which fixes funnies on a few systems where the BIOS firmware leaves us in an
interesting choice of modes, or embedded boxes with no firmware which come up
in random states.

For smart controllers there is nothing to do - they know about this internally.

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff -puN drivers/ata/libata-core.c~libata-correct-handling-of-srst-reset-sequences drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-correct-handling-of-srst-reset-sequences
+++ a/drivers/ata/libata-core.c
@@ -3258,6 +3258,8 @@ static int ata_bus_softreset(struct ata_
 			     unsigned long deadline)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
+	struct ata_device *dev;
+	int i = 0;
 
 	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
 
@@ -3268,6 +3270,25 @@ static int ata_bus_softreset(struct ata_
 	udelay(20);	/* FIXME: flush */
 	iowrite8(ap->ctl, ioaddr->ctl_addr);
 
+	/* If we issued an SRST then an ATA drive (not ATAPI)
+	 * may have changed configuration and be in PIO0 timing. If
+	 * we did a hard reset (or are coming from power on) this is
+	 * true for ATA or ATAPI. Until we've set a suitable controller
+	 * mode we should not touch the bus as we may be talking too fast.
+	 */
+
+	ata_link_for_each_dev(dev, &ap->link)
+		dev->pio_mode = XFER_PIO_0;
+
+	/* If the controller has a pio mode setup function then use
+	   it to set the chipset to rights. Don't touch the DMA setup
+	   as that will be dealt with when revalidating */
+	if (ap->ops->set_piomode) {
+		ata_link_for_each_dev(dev, &ap->link)
+			if (devmask & (1 << i++))
+				ap->ops->set_piomode(ap, dev);
+	}
+
 	/* wait a while before checking status */
 	ata_wait_after_reset(ap, deadline);
 
_
