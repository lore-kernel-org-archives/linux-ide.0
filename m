From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH]: JMB 368 PATA detection
Date: Fri, 27 Oct 2006 13:07:41 +0100
Message-ID: <1161950862.16839.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46289 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946447AbWJ0MES (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Oct 2006 08:04:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-ide@vger.kernel.org

The Jmicron JMB368 is PATA only so has the PATA on function zero. Don't
therefore skip function zero on this device when probing

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/drivers/ide/pci/generic.c linux-2.6.19-rc2-mm1/drivers/ide/pci/generic.c
--- linux.vanilla-2.6.19-rc2-mm1/drivers/ide/pci/generic.c	2006-10-18 13:50:13.000000000 +0100
+++ linux-2.6.19-rc2-mm1/drivers/ide/pci/generic.c	2006-10-27 12:31:46.000000000 +0100
@@ -234,8 +234,10 @@
 	    (!(PCI_FUNC(dev->devfn) & 1)))
 		goto out;
 
-	if (dev->vendor == PCI_VENDOR_ID_JMICRON && PCI_FUNC(dev->devfn) != 1)
-		goto out;
+	if (dev->vendor == PCI_VENDOR_ID_JMICRON) {
+		if (dev->device != PCI_DEVICE_ID_JMICRON_JMB368 && PCI_FUNC(dev->devfn) != 1)
+			goto out;
+	}
 
 	if (dev->vendor != PCI_VENDOR_ID_JMICRON) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);

