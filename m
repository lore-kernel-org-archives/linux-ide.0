From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Add suport for Marvell 88SE6121 in ahci
Date: Wed, 31 Jan 2007 10:03:18 -0500
Message-ID: <45C0AFB6.5010907@garzik.org>
References: <200701311504.40277.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010808060203070002030001"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57318 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933332AbXAaPDW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Jan 2007 10:03:22 -0500
In-Reply-To: <200701311504.40277.jareguero@telefonica.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jose Alberto Reguero <jareguero@telefonica.net>
Cc: linux-ide@vger.kernel.org, Jay Cliburn <jacliburn@bellsouth.net>

This is a multi-part message in MIME format.
--------------010808060203070002030001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jose Alberto Reguero wrote:
> This work for kernel 2.6.20-rc6
> 
> First apply this patch:
> 
> http://marc.theaimsgroup.com/?l=linux-ide&m=116986924301674&w=2
> 
> Then apply the patch attached.
> 
> Comments:
> 
> The Marvell 88SE6121 has three ports (0,1,2). The PATA port is port 2. (PATA 
> port for 6141 is port 4). In M2V Motherboard(Marvell 88SE6121) there is only 
> two SATA ports, one of them is external SATA. This two ports work well with 
> this patch.
> 
> With this part:
> 
> <       if (pci_enable_msi(pdev) == 0)
> ---
>>       if ((pdev->vendor != PCI_VENDOR_ID_MARVELL) && (pci_enable_msi(pdev) 
> == 0))
> 
> you don't need to disable MSI in kernel.
> MMCONFIG is disabled at startup in M2V.
> 
> dmesg:
> ........
> PCI: Not using MMCONFIG.

Very useful data points, thanks!

For the future, please make sure to create patches using "diff -u", 
otherwise the patches are very difficult to read and apply.

I've attached your patch as a "diff -u" patch so that others can check 
it out.

	Jeff




--------------010808060203070002030001
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ab7ea55..c1925b2 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -439,6 +439,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 
 	/* SiS */
 	{ PCI_VDEVICE(SI, 0x1184), board_ahci }, /* SiS 966 */
+	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
 	{ PCI_VDEVICE(SI, 0x1185), board_ahci }, /* SiS 966 */
 	{ PCI_VDEVICE(SI, 0x0186), board_ahci }, /* SiS 968 */
 
@@ -716,7 +717,10 @@ static void ahci_init_controller(void __iomem *mmio, struct pci_dev *pdev,
 	u32 tmp;
 
 	if (port_flags & AHCI_FLAG_MV_PATA) {
-		port_mmio = ahci_port_base(mmio, 4);
+		if (pdev->device == 0x6121)
+			port_mmio = ahci_port_base(mmio, 2);
+		else
+			port_mmio = ahci_port_base(mmio, 4);
 
 		writel(0, port_mmio + PORT_IRQ_MASK);
 
@@ -1570,16 +1574,30 @@ static int ahci_host_init(struct ata_probe_ent *probe_ent)
 	 * presence register, as bit 4 (counting from 0)
 	 */
 	if (probe_ent->port_flags & AHCI_FLAG_MV_PATA) {
-		dev_printk(KERN_ERR, &pdev->dev,
-			   "MV_AHCI HACK: port_map %x -> %x, cap_n %u -> %u\n",
-			   hpriv->port_map,
-			   hpriv->port_map & 0xf,
-			   cap_n_ports,
-			   (cap_n_ports > 4) ? 4 : cap_n_ports);
-
-		hpriv->port_map &= 0xf;
-		if (cap_n_ports > 4)
-			cap_n_ports = 4;
+		if (pdev->device == 0x6121) {
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "MV_AHCI HACK: port_map %x -> %x, cap_n %u -> %u\n",
+				   hpriv->port_map,
+				   hpriv->port_map & 0x3,
+				   cap_n_ports,
+				   (cap_n_ports > 2) ? 2 : cap_n_ports);
+
+			hpriv->port_map &= 0x3;
+			if (cap_n_ports > 2)
+				cap_n_ports = 2;
+		}
+		else {
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "MV_AHCI HACK: port_map %x -> %x, cap_n %u -> %u\n",
+				   hpriv->port_map,
+				   hpriv->port_map & 0xf,
+				   cap_n_ports,
+				   (cap_n_ports > 4) ? 4 : cap_n_ports);
+
+			hpriv->port_map &= 0xf;
+			if (cap_n_ports > 4)
+				cap_n_ports = 4;
+		}
 	}
 
 	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
@@ -1757,7 +1775,7 @@ static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out;
 	}
 
-	if (pci_enable_msi(pdev) == 0)
+	if ((pdev->vendor != PCI_VENDOR_ID_MARVELL) && (pci_enable_msi(pdev) == 0))
 		have_msi = 1;
 	else {
 		pci_intx(pdev, 1);

--------------010808060203070002030001--
