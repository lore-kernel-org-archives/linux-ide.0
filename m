From: Brett Russ <russb@emc.com>
Subject: [PATCH libata-2.6] AHCI: print port ID not number
Date: Thu, 24 Feb 2005 14:26:26 -0500
Message-ID: <421E2A62.9060303@emc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070308030205090003010607"
Received: from mailhub.lss.emc.com ([168.159.2.31]:29890 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262461AbVBXT03
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 14:26:29 -0500
Received: from [168.159.31.32] (lns1032.lss.emc.com [168.159.31.32])
	by mailhub.lss.emc.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id j1OJQQ9s005725
	for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2005 14:26:27 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070308030205090003010607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch fixes the "ata#: error occurred, port reset" line to 
display the port id instead of the port number.

Signed-off-by: Brett Russ <russb@emc.com>

--------------070308030205090003010607
Content-Type: text/x-patch;
 name="libata-2.6-ahci-printk.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-2.6-ahci-printk.diff"

--- libata-2.6/drivers/scsi/ahci.c      Thu Feb 24 14:18:35 2005
+++ libata-2.6-ahci-printk/drivers/scsi/ahci.c  Thu Feb 24 14:21:41 2005
@@ -574,7 +574,7 @@
        writel(tmp, port_mmio + PORT_CMD);
        readl(port_mmio + PORT_CMD); /* flush */

-       printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->port_no);
+       printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);
 }

 static void ahci_eng_timeout(struct ata_port *ap)

--------------070308030205090003010607--
