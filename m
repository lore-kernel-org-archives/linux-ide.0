From: Chr <chunkeey@web.de>
Subject: Re: libata: ATA_PIIX missing ICH8M PCIIDs.
Date: Mon, 18 Jun 2007 22:14:33 +0200
Message-ID: <200706182214.34162.chunkeey@web.de>
References: <39B20DF628532344BC7A2692CB6AEE07016FE51B@orsmsx420.amr.corp.intel.com> <4676E15C.80300@garzik.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qeudGDPJ6284aTR"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:36088 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588AbXFRUOi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 16:14:38 -0400
In-Reply-To: <4676E15C.80300@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

--Boundary-00=_qeudGDPJ6284aTR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday, 18. June 2007, Jeff Garzik wrote:
> Gaston, Jason D wrote:
> > I don't think we want to have the same DeviceID supported in more then one driver.  Would they not conflict with each other?
> 
> In Fedora 7, CONFIG_IDE is disabled.  ata_piix drives all hardware at 
> that point.
> 
> 	Jeff

here's a updated version. (thanks alan for pointing out that it's a ich_pata_133..) 
OK/(N)ACK/...? 

-
this patch adds a necessary PCIID for Santa Rosa's PATA controller.

Signed-off-by: Christian Lamparter <chunkeey@web.de>
-


--Boundary-00=_qeudGDPJ6284aTR
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ich8m-add-pci-id.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ich8m-add-pci-id.patch"

=2D-- ata_piix.c.org	2007-06-17 12:58:17.000000000 +0200
+++ ata_piix.c	2007-06-17 13:00:24.000000000 +0200
@@ -201,6 +201,8 @@ static const struct pci_device_id piix_p
 	/* ICH7/7-R (i945, i975) UDMA 100*/
 	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
 	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+	/* ICH8 Mobile PATA Controller */
+	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
=20
 	/* NOTE: The following PCI ids must be kept in sync with the
 	 * list in drivers/pci/quirks.c.

--Boundary-00=_qeudGDPJ6284aTR--
