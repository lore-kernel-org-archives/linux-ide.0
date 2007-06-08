From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: claim legacy SFF ctl ioport in legacy_dr
Date: Fri, 8 Jun 2007 21:30:28 +0900
Message-ID: <20070608123028.GF29122@htj.dyndns.org>
References: <20070604235157.GD31462@havoc.gtf.org> <20070608114119.GE29122@htj.dyndns.org> <20070608125128.59288dc3@the-village.bc.nu> <4669452B.4030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:41839 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935571AbXFHMae (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 08:30:34 -0400
Received: by py-out-1112.google.com with SMTP id a29so1199023pyi
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 05:30:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4669452B.4030101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

For legacy SFF port, cmd ioport is claimed in legacy_dr while ctl
ioport is claimed using resource-managed pci_request_region().  Move
ctl port claiming into legacy_dr for consistency.  This also makes
legacy SFF code easier to use for non-PCI device.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
ctl ports *were* claimed - this is why my wrong kernel test looked
fine.  It was just done in a different place.

Thanks.

 drivers/ata/libata-sff.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index e35d134..36d5f38 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -712,6 +712,7 @@ int ata_pci_prepare_native_host(struct pci_dev *pdev,
 struct ata_legacy_devres {
 	unsigned int	mask;
 	unsigned long	cmd_port[2];
+	unsigned long	ctl_port[2];
 	void __iomem *	cmd_addr[2];
 	void __iomem *	ctl_addr[2];
 	unsigned int	irq[2];
@@ -746,6 +747,8 @@ static void ata_legacy_release(struct device *gdev, void *res)
 			ioport_unmap(this->ctl_addr[i]);
 		if (this->cmd_port[i])
 			release_region(this->cmd_port[i], 8);
+		if (this->ctl_port[i])
+			release_region(this->ctl_port[i], 1);
 	}
 }
 
@@ -764,7 +767,7 @@ static int ata_init_legacy_port(struct ata_port *ap,
 		ctl_port = ATA_SECONDARY_CTL;
 	}
 
-	/* request cmd_port */
+	/* request and map cmd/ctl ports */
 	if (request_region(cmd_port, 8, "libata"))
 		legacy_dr->cmd_port[port_no] = cmd_port;
 	else {
@@ -773,15 +776,30 @@ static int ata_init_legacy_port(struct ata_port *ap,
 		return -EBUSY;
 	}
 
-	/* iomap cmd and ctl ports */
 	legacy_dr->cmd_addr[port_no] = ioport_map(cmd_port, 8);
-	legacy_dr->ctl_addr[port_no] = ioport_map(ctl_port, 1);
-	if (!legacy_dr->cmd_addr[port_no] || !legacy_dr->ctl_addr[port_no]) {
+	if (!legacy_dr->cmd_addr[port_no]) {
 		dev_printk(KERN_WARNING, host->dev,
-			   "failed to map cmd/ctl ports\n");
+			   "failed to map cmd port\n");
 		return -ENOMEM;
 	}
 
+	if (ctl_port) {
+		if (request_region(ctl_port, 1, "libata"))
+			legacy_dr->ctl_port[port_no] = ctl_port;
+		else {
+			dev_printk(KERN_WARNING, host->dev,
+				   "0x%0lX IDE port busy\n", ctl_port);
+			return -EBUSY;
+		}
+
+		legacy_dr->ctl_addr[port_no] = ioport_map(ctl_port, 1);
+		if (!legacy_dr->ctl_addr[port_no]) {
+			dev_printk(KERN_WARNING, host->dev,
+				   "failed to map ctl port\n");
+			return -ENOMEM;
+		}
+	}
+
 	/* init IO addresses */
 	ap->ioaddr.cmd_addr = legacy_dr->cmd_addr[port_no];
 	ap->ioaddr.altstatus_addr = legacy_dr->ctl_addr[port_no];
@@ -1029,10 +1047,6 @@ int ata_pci_init_one(struct pci_dev *pdev,
 			pcim_pin_device(pdev);
 		if (rc)
 			goto err_out;
-
-		/* request respective PCI regions, may fail */
-		rc = pci_request_region(pdev, 1, DRV_NAME);
-		rc = pci_request_region(pdev, 3, DRV_NAME);
 	}
 
 	/* init BMDMA, may fail */
