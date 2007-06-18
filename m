From: Chr <chunkeey@web.de>
Subject: libata: ATA_PIIX missing ICH8M PCIIDs.
Date: Mon, 18 Jun 2007 15:20:06 +0200
Message-ID: <200706181520.06682.chunkeey@web.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GaodGGFPAGcYV6+"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:51845 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758104AbXFRNUJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 09:20:09 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id C80F986B4B8E
	for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2007 15:20:07 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: chunkeey@web.de

--Boundary-00=_GaodGGFPAGcYV6+
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I got a new laptop and I had a little problem that the DVD drive wasn't rec=
ognized by
libata's piix driver (but the old IDE Subsystem found it!).

So, after adding the new pciid 8086:2850 it works!
But, I don't know if it's ich_pata_100 or ich_pata_133 since the=20
dvd/cd drives only goes up to udma2 speeds.

Thanks,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Chr.

(I'm not on the list, please keep the cc!)=20

=2D
this patch adds a necessary PCIID for santa rosa's PATA controller.

Signed-off-by: Christian Lamparter <chunkeey@web.de>

--Boundary-00=_GaodGGFPAGcYV6+
Content-Type: text/x-diff;
  charset="utf-8";
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
+	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
=20
 	/* NOTE: The following PCI ids must be kept in sync with the
 	 * list in drivers/pci/quirks.c.

--Boundary-00=_GaodGGFPAGcYV6+--
