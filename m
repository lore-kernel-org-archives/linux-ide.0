From: Greg KH <gregkh@suse.de>
Subject: [2.6.22.2 review 06/84] Add a PCI ID for santa rosas PATA
	controller.
Date: Tue, 7 Aug 2007 13:42:57 -0700
Message-ID: <20070807204257.GG23028@kroah.com>
References: <20070807204034.882009319@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:51320 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964816AbXHGUqt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 16:46:49 -0400
Content-Disposition: inline; filename="add-a-pci-id-for-santa-rosa-s-pata-controller.patch"
In-Reply-To: <20070807204157.GA23028@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Christian Lamparter <chunkeey@web.de>


From: Christian Lamparter <chunkeey@web.de>

This is commit c1e6f28cc5de37dcd113b9668a185c0b9334ba8a which is
merged during 23-rc1 window.  Considering the popularity of these
chips, I think including it in -stable release would be good idea.

Signed-off-by: Christian Lamparter <chunkeey@web.de>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ata/ata_piix.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -200,6 +200,8 @@ static const struct pci_device_id piix_p
 	/* ICH7/7-R (i945, i975) UDMA 100*/
 	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
 	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+	/* ICH8 Mobile PATA Controller */
+	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 
 	/* NOTE: The following PCI ids must be kept in sync with the
 	 * list in drivers/pci/quirks.c.

-- 
