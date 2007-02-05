From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH -mm] sata_nv: wait for response on entering/leaving ADMA mode
Date: Sun, 04 Feb 2007 23:15:51 -0600
Message-ID: <45C6BD87.90802@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:54915 "EHLO
	pd5mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbXBEFTG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 00:19:06 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>

Update sata_nv to wait for the controller to indicate via the status register
that it has entered the requested state when switching between ADMA mode and
register mode. This issue came up recently when debugging some problems with
cache flush command timeouts and while it didn't appear to fix that problem,
this is something we should likely be doing in any case.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

--- linux-2.6.20-rc6-mm3/drivers/ata/sata_nv.c	2007-02-04 21:48:25.000000000 -0600
+++ linux-2.6.20-rc6-mm3edit/drivers/ata/sata_nv.c	2007-02-04 22:13:36.000000000 -0600
@@ -507,14 +507,38 @@ static void nv_adma_register_mode(struct
{
	struct nv_adma_port_priv *pp = ap->private_data;
	void __iomem *mmio = pp->ctl_block;
-	u16 tmp;
+	u16 tmp, status;
+	int count = 0;

	if (pp->flags & NV_ADMA_PORT_REGISTER_MODE)
		return;

+	status = readw(mmio + NV_ADMA_STAT);
+	while(!(status & NV_ADMA_STAT_IDLE) && count < 20) {
+		ndelay(50);
+		status = readw(mmio + NV_ADMA_STAT);
+		count++;
+	}
+	if(count == 20)
+		ata_port_printk(ap, KERN_WARNING,
+			"timeout waiting for ADMA IDLE, stat=0x%hx\n",
+			status);
+
	tmp = readw(mmio + NV_ADMA_CTL);
	writew(tmp & ~NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);

+	count = 0;
+	status = readw(mmio + NV_ADMA_STAT);
+	while(!(status & NV_ADMA_STAT_LEGACY) && count < 20) {
+		ndelay(50);
+		status = readw(mmio + NV_ADMA_STAT);
+		count++;
+	}
+	if(count == 20)
+		ata_port_printk(ap, KERN_WARNING,
+			 "timeout waiting for ADMA LEGACY, stat=0x%hx\n",
+			 status);
+
	pp->flags |= NV_ADMA_PORT_REGISTER_MODE;
}

@@ -522,7 +546,8 @@ static void nv_adma_mode(struct ata_port
{
	struct nv_adma_port_priv *pp = ap->private_data;
	void __iomem *mmio = pp->ctl_block;
-	u16 tmp;
+	u16 tmp, status;
+	int count = 0;

	if (!(pp->flags & NV_ADMA_PORT_REGISTER_MODE))
		return;
@@ -532,6 +557,18 @@ static void nv_adma_mode(struct ata_port
	tmp = readw(mmio + NV_ADMA_CTL);
	writew(tmp | NV_ADMA_CTL_GO, mmio + NV_ADMA_CTL);

+	status = readw(mmio + NV_ADMA_STAT);
+	while(((status & NV_ADMA_STAT_LEGACY) ||
+	      !(status & NV_ADMA_STAT_IDLE)) && count < 20) {
+		ndelay(50);
+		status = readw(mmio + NV_ADMA_STAT);
+		count++;
+	}
+	if(count == 20)
+		ata_port_printk(ap, KERN_WARNING,
+			"timeout waiting for ADMA LEGACY clear and IDLE, stat=0x%hx\n",
+			status);
+
	pp->flags &= ~NV_ADMA_PORT_REGISTER_MODE;
}



