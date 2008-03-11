From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Re: Marvell 6121 SATA support?
Date: Tue, 11 Mar 2008 23:10:32 +0100
Message-ID: <200803112310.32589.jareguero@telefonica.net>
References: <47D6945F.3080201@aquazul.com> <47D697B0.90009@garzik.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YNw1HmQpjkTvN4P"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmailhost.telefonica.net ([213.4.149.242]:13051 "EHLO
	ctsmtpout4.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752226AbYCKWL0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 18:11:26 -0400
In-Reply-To: <47D697B0.90009@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mourad De Clerck <mourad@aquazul.com>, linux-ide@vger.kernel.org

--Boundary-00=_YNw1HmQpjkTvN4P
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El Martes, 11 de Marzo de 2008, Jeff Garzik escribi=F3:
> Mourad De Clerck wrote:
> > Hello,
> >
> > I was wondering what the status was of Marvell 6121 SATA support. I've
> > seen earlier messages saying it was pretty much working with the AHCI
> > driver, and that it would be merged in mainline soon, but that was in
> > 2.6.22 times.
> >
> > I've not seen support for it in 2.6.25-rc5's ahci, so I guess I
> > shouldn't expect it in 2.6.25?
>
> I would just add the PCI ID to ahci.c, it should most likely work...
>
> 	Jeff
>
>
>

 I use this patch for kernels 2.6.25-rc

Jose Alberto

--Boundary-00=_YNw1HmQpjkTvN4P
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="ahci_6121.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ahci_6121.diff"

diff -ur linux-2.6.25-rc3/drivers/ata/ahci.c linux-2.6.25-rc3.new/drivers/ata/ahci.c
--- linux-2.6.25-rc3/drivers/ata/ahci.c	2008-02-24 22:25:54.000000000 +0100
+++ linux-2.6.25-rc3.new/drivers/ata/ahci.c	2008-02-25 00:59:43.000000000 +0100
@@ -570,7 +570,7 @@
 	{ PCI_VDEVICE(SI, 0x0186), board_ahci }, /* SiS 968 */
 
 	/* Marvell */
-	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
+	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
 
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
@@ -682,10 +682,10 @@
 	if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "MV_AHCI HACK: port_map %x -> %x\n",
-			   hpriv->port_map,
-			   hpriv->port_map & 0xf);
+			   port_map,
+			   port_map & 0x3);
 
-		port_map &= 0xf;
+		port_map &= 0x3;
 	}
 
 	/* cross check port_map and cap.n_ports */
@@ -1148,7 +1148,7 @@
 	u32 tmp;
 
 	if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
-		port_mmio = __ahci_port_base(host, 4);
+		port_mmio = __ahci_port_base(host, 2);
 
 		writel(0, port_mmio + PORT_IRQ_MASK);
 

--Boundary-00=_YNw1HmQpjkTvN4P--
