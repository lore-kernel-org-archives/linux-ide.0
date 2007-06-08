From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: claim ctl port for legacy SFF ports
Date: Fri, 8 Jun 2007 20:41:19 +0900
Message-ID: <20070608114119.GE29122@htj.dyndns.org>
References: <20070604235157.GD31462@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:15559 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966610AbXFHLlh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 07:41:37 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1027736wah
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 04:41:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070604235157.GD31462@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

libata used to claim only cmd ports for legacy SFF ports.  Claim ctl
ports too.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This has been this way as long as I can remember.  It's almost
pleasant to see that it survived through all the devres/init rework.
I guess it's time for a change.

 drivers/ata/libata-sff.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index e35d134..99a9f98 100644
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
@@ -764,12 +765,16 @@ static int ata_init_legacy_port(struct ata_port *ap,
 		ctl_port = ATA_SECONDARY_CTL;
 	}
 
-	/* request cmd_port */
+	/* request cmd and ctl port */
 	if (request_region(cmd_port, 8, "libata"))
 		legacy_dr->cmd_port[port_no] = cmd_port;
-	else {
+
+	if (request_region(ctl_port, 8, "libata"))
+		legacy_dr->ctl_port[port_no] = ctl_port;
+
+	if (!legacy_dr->cmd_port[port_no] || !legacy_dr->ctl_port[port_no]) {
 		dev_printk(KERN_WARNING, host->dev,
-			   "0x%0lX IDE port busy\n", cmd_port);
+			   "0x%0lX/0x%0lX IDE port busy\n", cmd_port, ctl_port);
 		return -EBUSY;
 	}
 
