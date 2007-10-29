From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH]ata: sata_nv fix mcp51 timeout with SWNCQ
Date: Mon, 29 Oct 2007 06:55:46 -0400
Message-ID: <4725BC32.8070207@garzik.org>
References: <15F501D1A78BD343BE8F4D8DB854566B059FE1DB@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070402090104020806080106"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35295 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454AbXJ2Kzv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Oct 2007 06:55:51 -0400
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B059FE1DB@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>

This is a multi-part message in MIME format.
--------------070402090104020806080106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kuan Luo wrote:
> @@ -2383,6 +2383,9 @@ static int nv_init_one (struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  		type = ADMA;
>  	}
>  
> +	if (type == SWNCQ && !swncq_enabled)
> +		type = GENERIC;
> +
>  	ppi[0] = &nv_port_info[type];
>  	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
>  	if (rc)

I applied the attached patch.

If PCI ID revisions are still needed (please look carefully, I changed 
the sense of the test a bit), please send them as a separate patch.

Also, Kuan, your patch was corrupted by your email client:

> @@ -365,9 +365,9 @@ static const struct pci_device_id nv_pci_tbl[] =3D {
> =20	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2),
> SWNCQ },
> =20	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA),
> SWNCQ },
> =20	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2),
> SWNCQ },

and so it not apply-able by Linus's git tools that everybody uses.


Please make sure you get a reliable email setup, it is /critical/ for 
Linux development.  We use email for everything...  Email is a tool in 
our workflow almost as important as the compiler itself.

	Jeff




--------------070402090104020806080106
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

commit 360737a982b1ae09e1659e0bb27085c03f02f404
Author: Jeff Garzik <jeff@garzik.org>
Date:   Mon Oct 29 06:49:24 2007 -0400

    [libata] sata_nv: fix SWNCQ enabling
    
    Adapted from patches by Kuan Lou @ NVIDIA and Bartlomiej Zolnierkiewicz.
    
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

 drivers/ata/sata_nv.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

360737a982b1ae09e1659e0bb27085c03f02f404
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index fea8d8d..35b2df2 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -2385,6 +2385,14 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		type = ADMA;
 	}
 
+	if (type == SWNCQ) {
+		if (swncq_enabled)
+			dev_printk(KERN_NOTICE, &pdev->dev,
+				   "Using SWNCQ mode\n");
+		else
+			type = GENERIC;
+	}
+
 	ppi[0] = &nv_port_info[type];
 	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
 	if (rc)
@@ -2426,10 +2434,8 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		rc = nv_adma_host_init(host);
 		if (rc)
 			return rc;
-	} else if (type == SWNCQ && swncq_enabled) {
-		dev_printk(KERN_NOTICE, &pdev->dev, "Using SWNCQ mode\n");
+	} else if (type == SWNCQ)
 		nv_swncq_host_init(host);
-	}
 
 	pci_set_master(pdev);
 	return ata_host_activate(host, pdev->irq, ppi[0]->irq_handler,

--------------070402090104020806080106--
