From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH]
Date: Wed, 22 Aug 2007 23:19:40 +0100
Message-ID: <20070822231940.278c02e8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43956 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758571AbXHVWLj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 18:11:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Correct handling of SRST reset sequences. After an SRST it is undefined
whether the drive has gone back to PIO0. In order to talk safely we should
talk slowly and carefully until we know.

Thus when we do the reset if the controller has a pio setup method we call
it to flip back to PIO 0 and a known state. After the reset completes the
identify will then be done at the safe speed and the drive/controller will
pick suitable faster modes and reconfigure the controller to these timings.

As a side effect it means we force the controller to PIO 0 as we bring it
up which fixes funnies on a few systems where the BIOS firmware leaves us
in an interesting choice of modes, or embedded boxes with no firmware which
come up in random states.

For smart controllers there is nothing to do - they know about this internally.

Signed-off-by: Alan Cox <alan@redhat.com>


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/libata-core.c linux-2.6.23rc3-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/libata-core.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/libata-core.c	2007-08-22 18:17:31.321738376 +0100
@@ -3163,6 +3191,8 @@
 			     unsigned long deadline)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
+	struct ata_device *dev;
+	int i = 0;
 
 	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
 
@@ -3173,6 +3203,25 @@
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
 
