From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata pmp support
Date: Thu, 23 Aug 2007 12:45:52 +0900
Message-ID: <46CD02F0.7060508@gmail.com>
References: <200708181350.14544.iweksler@bezeqint.net> <200708220015.55805.iweksler@bezeqint.net> <46CBA631.2050600@gmail.com> <200708221810.14494.iweksler@bezeqint.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040506070405090902040000"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:28074 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbXHWDp7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 23:45:59 -0400
Received: by rv-out-0910.google.com with SMTP id k20so290567rvb
        for <linux-ide@vger.kernel.org>; Wed, 22 Aug 2007 20:45:58 -0700 (PDT)
In-Reply-To: <200708221810.14494.iweksler@bezeqint.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: iweksler@bezeqint.net
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040506070405090902040000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Izik Weksler wrote:
> Tejun,
> 
> If you're sending the patch please send it to this address.

Okay, please test the attached patch and please cc
linux-ide@vger.kernel.org when replying.  Thanks.

-- 
tejun

--------------040506070405090902040000
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 06f212f..d838bdd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -44,6 +44,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
+#include <linux/dmi.h>
 
 #define DRV_NAME	"ahci"
 #define DRV_VERSION	"2.3"
@@ -1631,6 +1632,31 @@ static int ahci_pci_device_resume(struct pci_dev *pdev)
 }
 #endif
 
+static void ahci_port_mark_nosrst(struct ata_port *ap)
+{
+	static struct dmi_system_id sysids[] = {
+		{
+			.ident = "P5W DH Deluxe",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTEK COMPUTER INC"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "P5W DH Deluxe"),
+			},
+		},
+		{ }
+	};
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+	/* The second port of the PCI device 00:1f.2 is connected to a
+	 * SIMG PMP which pukes on SRST.
+	 */
+	if (pdev->bus->number == 0 && pdev->devfn == PCI_DEVFN(0x1f, 2) &&
+	    ap->port_no == 1 && dmi_check_system(sysids)) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "enabling ASUS on-board PMP workaround\n");
+		ap->flags |= ATA_FLAG_NO_SRST;
+	}
+}
+
 static int ahci_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
@@ -1639,6 +1665,8 @@ static int ahci_port_start(struct ata_port *ap)
 	dma_addr_t mem_dma;
 	int rc;
 
+	ahci_port_mark_nosrst(ap);
+
 	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
 	if (!pp)
 		return -ENOMEM;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ac6ceed..c51fa7f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1759,9 +1759,12 @@ static int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
 	return 0;
 }
 
-static int ata_eh_followup_srst_needed(int rc, int classify,
+static int ata_eh_followup_srst_needed(struct ata_port *ap,
+				       int rc, int classify,
 				       const unsigned int *classes)
 {
+	if (ap->flags & ATA_FLAG_NO_SRST)
+		return 0;
 	if (rc == -EAGAIN)
 		return 1;
 	if (rc != 0)
@@ -1792,7 +1795,8 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 	 */
 	action = ehc->i.action;
 	ehc->i.action &= ~ATA_EH_RESET_MASK;
-	if (softreset && (!hardreset || (!sata_set_spd_needed(ap) &&
+	if (softreset && (!hardreset || (!(ap->flags & ATA_FLAG_NO_SRST) &&
+					 !sata_set_spd_needed(ap) &&
 					 !(action & ATA_EH_HARDRESET))))
 		ehc->i.action |= ATA_EH_SOFTRESET;
 	else
@@ -1855,7 +1859,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 	rc = ata_do_reset(ap, reset, classes, deadline);
 
 	if (reset == hardreset &&
-	    ata_eh_followup_srst_needed(rc, classify, classes)) {
+	    ata_eh_followup_srst_needed(ap, rc, classify, classes)) {
 		/* okay, let's do follow-up softreset */
 		reset = softreset;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 41978a5..8f98689 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -177,6 +177,7 @@ enum {
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
 	ATA_FLAG_ACPI_SATA	= (1 << 17), /* need native SATA ACPI layout */
+	ATA_FLAG_NO_SRST	= (1 << 18), /* avoid softreset */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be

--------------040506070405090902040000--
