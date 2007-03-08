From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] sata_sil:  First step to removing ->post_set_mode
Date: Thu, 8 Mar 2007 23:09:12 +0000
Message-ID: <20070308230912.4ce2e943@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60436 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030749AbXCHWGF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:06:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Now that we have ata_do_set_mode() available for drivers to use we don't
actually need ->post_set_mode() as the driver can wrap set_mode nicely
and do stuff before or after (eg PCMCIA needs before), so we can kill off
a method in all the structs

While I was at it I added kernel-doc to the function involved.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/sata_sil.c linux-2.6.21-rc3-mm2/drivers/ata/sata_sil.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/sata_sil.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/sata_sil.c	2007-03-08 16:40:43.000000000 +0000
@@ -46,7 +46,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sil"
-#define DRV_VERSION	"2.1"
+#define DRV_VERSION	"2.1ac1"
 
 enum {
 	SIL_MMIO_BAR		= 5,
@@ -117,7 +117,7 @@
 static void sil_dev_config(struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
-static void sil_post_set_mode (struct ata_port *ap);
+static int sil_set_mode (struct ata_port *ap, struct ata_device **r_failed);
 static irqreturn_t sil_interrupt(int irq, void *dev_instance);
 static void sil_freeze(struct ata_port *ap);
 static void sil_thaw(struct ata_port *ap);
@@ -197,7 +197,7 @@
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.post_set_mode		= sil_post_set_mode,
+	.set_mode		= sil_set_mode,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -297,7 +297,16 @@
 	return cache_line;
 }
 
-static void sil_post_set_mode (struct ata_port *ap)
+/**
+ *	sil_set_mode		-	wrap set_mode functions
+ *	@ap: port to set up
+ *	@r_failed: returned device when we fail
+ *
+ *	Wrap the libata method for device setup as after the setup we need
+ *	to inspect the results and do some configuration work
+ */
+
+static int sil_set_mode (struct ata_port *ap, struct ata_device **r_failed)
 {
 	struct ata_host *host = ap->host;
 	struct ata_device *dev;
@@ -305,6 +314,11 @@
 	void __iomem *addr = mmio_base + sil_port[ap->port_no].xfer_mode;
 	u32 tmp, dev_mode[2];
 	unsigned int i;
+	int rc;
+	
+	rc = ata_do_set_mode(ap, r_failed);
+	if (rc)
+		return rc;
 
 	for (i = 0; i < 2; i++) {
 		dev = &ap->device[i];
@@ -323,6 +337,7 @@
 	tmp |= (dev_mode[1] << 4);
 	writel(tmp, addr);
 	readl(addr);	/* flush */
+	return 0;
 }
 
 static inline void __iomem *sil_scr_addr(struct ata_port *ap, unsigned int sc_reg)
