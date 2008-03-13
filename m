From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Re: Marvell 6121 SATA support?
Date: Thu, 13 Mar 2008 23:22:24 +0100
Message-ID: <200803132322.24308.jareguero@telefonica.net>
References: <47D6945F.3080201@aquazul.com> <47D697B0.90009@garzik.org> <200803112310.32589.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gka2Hx+uULIPjDq"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmailhost.telefonica.net ([213.4.149.242]:28330 "EHLO
	ctsmtpout3.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753865AbYCMWXO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 18:23:14 -0400
In-Reply-To: <200803112310.32589.jareguero@telefonica.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mourad De Clerck <mourad@aquazul.com>, linux-ide@vger.kernel.org

--Boundary-00=_gka2Hx+uULIPjDq
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El Martes, 11 de Marzo de 2008, Jose Alberto Reguero escribi=F3:
> El Martes, 11 de Marzo de 2008, Jeff Garzik escribi=F3:
> > Mourad De Clerck wrote:
> > > Hello,
> > >
> > > I was wondering what the status was of Marvell 6121 SATA support. I've
> > > seen earlier messages saying it was pretty much working with the AHCI
> > > driver, and that it would be merged in mainline soon, but that was in
> > > 2.6.22 times.
> > >
> > > I've not seen support for it in 2.6.25-rc5's ahci, so I guess I
> > > shouldn't expect it in 2.6.25?
> >
> > I would just add the PCI ID to ahci.c, it should most likely work...
> >
> > 	Jeff
>
>  I use this patch for kernels 2.6.25-rc
>
> Jose Alberto

Attached is a patch against 2.6.25-rc5 kernel to add suport for Marvell 612=
1=20
SATA.

Signed-off-by: Jose Alberto Reguero <jareguero@telefonica.net>

Jose Alberto

--Boundary-00=_gka2Hx+uULIPjDq
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="ahci_6121_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ahci_6121_2.patch"

--- linux-2.6.25-rc5/drivers/ata/ahci.c	2008-03-10 06:22:27.000000000 +0100
+++ linux-2.6.25-rc5.new/drivers/ata/ahci.c	2008-03-13 22:06:22.000000000 +0100
@@ -575,6 +575,7 @@
 
 	/* Marvell */
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
+	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
 
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
@@ -649,6 +650,7 @@
 	void __iomem *mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
 	u32 cap, port_map;
 	int i;
+	int mv;
 
 	/* make sure AHCI mode is enabled before accessing CAP */
 	ahci_enable_ahci(mmio);
@@ -684,12 +686,16 @@
 	 * presence register, as bit 4 (counting from 0)
 	 */
 	if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
+		if (pdev->device == 0x6121)
+			mv = 0x3;
+		else
+			mv = 0xf;
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "MV_AHCI HACK: port_map %x -> %x\n",
-			   hpriv->port_map,
-			   hpriv->port_map & 0xf);
+			   port_map,
+			   port_map & mv);
 
-		port_map &= 0xf;
+		port_map &= mv;
 	}
 
 	/* cross check port_map and cap.n_ports */
@@ -1150,9 +1156,14 @@
 	int i;
 	void __iomem *port_mmio;
 	u32 tmp;
+	int mv;
 
 	if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
-		port_mmio = __ahci_port_base(host, 4);
+		if (pdev->device == 0x6121)
+			mv = 2;
+		else
+			mv = 4;
+		port_mmio = __ahci_port_base(host, mv);
 
 		writel(0, port_mmio + PORT_IRQ_MASK);
 

--Boundary-00=_gka2Hx+uULIPjDq--
