From: Greg KH <greg@kroah.com>
Subject: [PATCH] remove duplicate ids from ata_piix
Date: Thu, 25 Jan 2007 18:12:28 -0800
Message-ID: <20070126021228.GA3444@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:37454 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030705AbXAZCNX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 21:13:23 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, kay.sievers@suse.de

From: Greg Kroah-Hartman <gregkh@suse.de>

It seems that the ata_piix driver has two duplicate ids, one of them
with a different 'private' field in it, which was never being used due
to the match for the device happening on an earlier entry.

This patch removes the duplicates, if this is the correct thing to do in
this case for the ICH5 device or not, I'll leave to you :)

This duplication was pointed out to me by Kay Sievers <kay.sievers@suse.de>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ata/ata_piix.c |    4 ----
 1 file changed, 4 deletions(-)

--- gregkh-2.6.orig/drivers/ata/ata_piix.c
+++ gregkh-2.6/drivers/ata/ata_piix.c
@@ -191,12 +191,8 @@ static const struct pci_device_id piix_p
 	/* Intel ICH4 (i845GV, i845E, i852, i855) UDMA 100 */
 	{ 0x8086, 0x24CA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	{ 0x8086, 0x24CB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/* Intel ICH5 */
-	{ 0x8086, 0x24DB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
 	/* C-ICH (i810E2) */
 	{ 0x8086, 0x245B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
-	/* ESB (855GME/875P + 6300ESB) UDMA 100  */
-	{ 0x8086, 0x25A2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* ICH6 (and 6) (i915) UDMA 100 */
 	{ 0x8086, 0x266F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
 	/* ICH7/7-R (i945, i975) UDMA 100*/
