From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Serial ATA SIS 964
Date: Sun, 04 Apr 2004 14:24:05 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1081081444.2384.77.camel@uk2.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-on9qFy37JL+rjqhoAka7"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.de ([213.165.64.20]:27334 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262345AbUDDMYF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Apr 2004 08:24:05 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Daniela Engert <dani@ngrt.de>, linux-ide@vger.kernel.org


--=-on9qFy37JL+rjqhoAka7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Jeff,

it exists a variant of the serial ATA SIS 180. This variant has the same
functionality like the SIS 180 but a different PCI ID 0x0181.
I have no motherboard with that behavior. But I think it is good idea to
include this PCI ID too into the driver.
Thanks to Daniela Engert for this information.

regards

Uwe



--=-on9qFy37JL+rjqhoAka7
Content-Disposition: attachment; filename=sata_sis.c.diff
Content-Type: text/x-patch; name=sata_sis.c.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- sata_sis.c.old	2004-03-21 20:35:03.000000000 +0100
+++ sata_sis.c	2004-04-04 12:20:51.000000000 +0200
@@ -46,6 +46,7 @@
 
 static struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
+	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_181, PCI_ANA_ID, PCI_ANI_ID, 0, 0, sis_180 },
 	{ }	/* terminate list */
 };
 

--=-on9qFy37JL+rjqhoAka7--

