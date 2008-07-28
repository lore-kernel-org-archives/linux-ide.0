From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: ide pmac breakage
Date: Mon, 28 Jul 2008 11:29:56 +1000
Message-ID: <1217208596.11188.144.camel@pasglop>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:34979 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111AbYG1BaH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Jul 2008 21:30:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>

The current ide-pmac upstream is broken. It calls
media_bay_set_ide_infos() with an uninitialized "hwif" argument.

It's not a trivial mistake, there's a chicken-and-egg problem in the
init code in there.

I've locally fixed it with this patch that i'll merge via the powerpc
tree unless you have an objection.

However, the machine crashes when removing the media-bay CD-ROM drive.

Crash appears to be a NULL deref, possibly in elv_may_queue() though
I don't have a clean backtrace yet, working on it...

Cheers,
Ben.

diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index c521bf6..fa2be26 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1086,6 +1086,11 @@ static int __devinit pmac_ide_setup_device(pmac_ide_hwif_t *pmif, hw_regs_t *hw)
 	/* Make sure we have sane timings */
 	sanitize_timings(pmif);
 
+	host = ide_host_alloc(&d, hws);
+	if (host == NULL)
+		return -ENOMEM;
+	hwif = host->ports[0];
+
 #ifndef CONFIG_PPC64
 	/* XXX FIXME: Media bay stuff need re-organizing */
 	if (np->parent && np->parent->name
@@ -1119,11 +1124,11 @@ static int __devinit pmac_ide_setup_device(pmac_ide_hwif_t *pmif, hw_regs_t *hw)
 			 pmif->mdev ? "macio" : "PCI", pmif->aapl_bus_id,
 			 pmif->mediabay ? " (mediabay)" : "", hw->irq);
 
-	rc = ide_host_add(&d, hws, &host);
-	if (rc)
+	rc = ide_host_register(host, &d, hws);
+	if (rc) {
+		ide_host_free(host);
 		return rc;
-
-	hwif = host->ports[0];
+	}
 
 	return 0;
 }


