From: akpm@linux-foundation.org
Subject: [patch 1/2] sl82c105: Switch to ref counting API
Date: Thu, 10 May 2007 22:50:29 -0700
Message-ID: <200705110550.l4B5oTbW007723@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:44552 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758141AbXEKFvP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 01:51:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, sshtylyov@ru.mvista.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Not sure how this one got missed in the great purge some time ago but it
did.

Signed-off-by: Alan Cox <alan@redhat.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ide/pci/sl82c105.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff -puN drivers/ide/pci/sl82c105.c~sl82c105-switch-to-ref-counting-api drivers/ide/pci/sl82c105.c
--- a/drivers/ide/pci/sl82c105.c~sl82c105-switch-to-ref-counting-api
+++ a/drivers/ide/pci/sl82c105.c
@@ -343,7 +343,7 @@ static unsigned int sl82c105_bridge_revi
 	/*
 	 * The bridge should be part of the same device, but function 0.
 	 */
-	bridge = pci_find_slot(dev->bus->number,
+	bridge = pci_get_bus_and_slot(dev->bus->number,
 			       PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	if (!bridge)
 		return -1;
@@ -353,13 +353,15 @@ static unsigned int sl82c105_bridge_revi
 	 */
 	if (bridge->vendor != PCI_VENDOR_ID_WINBOND ||
 	    bridge->device != PCI_DEVICE_ID_WINBOND_83C553 ||
-	    bridge->class >> 8 != PCI_CLASS_BRIDGE_ISA)
+	    bridge->class >> 8 != PCI_CLASS_BRIDGE_ISA) {
+	    	pci_dev_put(bridge);
 		return -1;
-
+	}
 	/*
 	 * We need to find function 0's revision, not function 1
 	 */
 	pci_read_config_byte(bridge, PCI_REVISION_ID, &rev);
+	pci_dev_put(bridge);
 
 	return rev;
 }
_
