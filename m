From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI Constants Update for SATA Driver
Date: Wed, 02 Mar 2005 12:46:30 +1100
Message-ID: <1109727990.5610.75.camel@gaston>
References: <1109526163.19325.2.camel@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from gate.crashing.org ([63.228.1.57]:44484 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261982AbVCBBsv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2005 20:48:51 -0500
In-Reply-To: <1109526163.19325.2.camel@forge.intermeta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henning Schmiedehausen <hps@intermeta.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailingliste <linux-ide@vger.kernel.org>

On Sun, 2005-02-27 at 18:42 +0100, Henning Schmiedehausen wrote:
 static struct pci_device_id k2_sata_pci_tbl[] = {
-       { 0x1166, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-       { 0x1166, 0x0241, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-       { 0x1166, 0x0242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+       { PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_K2_240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+       { PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_K2_241, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+       { PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_K2_242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
        { }

I'm not sure the "K2" in the names here it correct. K2 is Apple's G5 IO
chip, which happens to include a serverworks controller. Jeff should
probably fix the constants to the real cell names :) Besides, K2 afaik
only ever contains a 240...
Ben.


