From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: fix MAP VALUE interpretation for for ICH6/7
Date: Sun, 18 Dec 2005 17:17:07 +0900
Message-ID: <20051218081707.GA4129@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:20679 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932511AbVLRIRM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 03:17:12 -0500
Received: by zproxy.gmail.com with SMTP id 14so1682186nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 00:17:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Unlike their older siblings, ICH6 and 7 use different scheme for MAP
VALUE.  This patch makes ata_piix interpret MV properly on ICH6/7.

Pre-ICH6/7

 The value of these bits indicate the address range the SATA port
 responds to, and whether or not the SATA and IDE functions are
 combined.

 000 = Non-combined. P0 is primary master. P1 is secondary master.
 001 = Non-combined. P0 is secondary master. P1 is primary master.
 100 = Combined. P0 is primary master. P1 is primary slave. P-ATA is
       2:0 Map Value secondary.
 101 = Combined. P0 is primary slave. P1 is primary master. P-ATA is
       secondary.
 110 = Combined. P-ATA is primary. P0 is secondary master. P1 is
       secondary slave.
 111 = Combined. P-ATA is primary. P0 is secondary slave. P1 is
       secondary master.

ICH6/7

 Map Value - R/W. Map Value (MV): The value in the bits below indicate
the address range the SATA ports responds to, and whether or not the
PATA and SATA functions are combined. When in combined mode, the AHCI
memory space is not available and AHCI may not be used.

 00 = Non-combined. P0 is primary master, P2 is the primary slave. P1
      is secondary master, P3 is the 1:0 secondary slave (desktop
      only). P0 is primary master, P2 is the primary slave (mobile
      only).
 01 = Combined. IDE is primary. P1 is secondary master, P3 is the
      secondary slave. (desktop only)
 10 = Combined. P0 is primary master. P2 is primary slave. IDE is secondary
 11 = Reserved

Signed-off-by: Tejun Heo <htejun@gmail.com>

--

Jeff, without this patch, ata_piix misdetects my ICH7's combined mode,
ending up not applying bridge limits to PX-710SA and configuring IDE
drive on 40-c cable to UDMA/66.

Thanks.

Index: work/drivers/scsi/ata_piix.c
===================================================================
--- work.orig/drivers/scsi/ata_piix.c	2005-12-18 16:32:04.000000000 +0900
+++ work/drivers/scsi/ata_piix.c	2005-12-18 16:55:28.000000000 +0900
@@ -101,9 +101,11 @@ enum {
 	ICH5_PCS		= 0x92,	/* port control and status */
 	PIIX_SCC		= 0x0A, /* sub-class code register */
 
-	PIIX_FLAG_AHCI		= (1 << 28), /* AHCI possible */
-	PIIX_FLAG_CHECKINTR	= (1 << 29), /* make sure PCI INTx enabled */
-	PIIX_FLAG_COMBINED	= (1 << 30), /* combined mode possible */
+	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
+	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
+	PIIX_FLAG_COMBINED	= (1 << 29), /* combined mode possible */
+	/* ICH6/7 use different scheme for map value */
+	PIIX_FLAG_COMBINED_ICH6	= PIIX_FLAG_COMBINED | (1 << 30),
 
 	/* combined mode.  if set, PATA is channel 0.
 	 * if clear, PATA is channel 1.
@@ -291,8 +293,8 @@ static struct ata_port_info piix_port_in
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
-				  ATA_FLAG_SLAVE_POSS,
+				  PIIX_FLAG_COMBINED_ICH6 |
+				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -303,8 +305,9 @@ static struct ata_port_info piix_port_in
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
-				  ATA_FLAG_SLAVE_POSS | PIIX_FLAG_AHCI,
+				  PIIX_FLAG_COMBINED_ICH6 |
+				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
+				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -674,6 +677,7 @@ static int piix_init_one (struct pci_dev
 	struct ata_port_info *port_info[2];
 	unsigned int combined = 0;
 	unsigned int pata_chan = 0, sata_chan = 0;
+	unsigned long host_flags;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
@@ -686,7 +690,9 @@ static int piix_init_one (struct pci_dev
 	port_info[0] = &piix_port_info[ent->driver_data];
 	port_info[1] = &piix_port_info[ent->driver_data];
 
-	if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
+	host_flags = port_info[0]->host_flags;
+
+	if (host_flags & PIIX_FLAG_AHCI) {
 		u8 tmp;
 		pci_read_config_byte(pdev, PIIX_SCC, &tmp);
 		if (tmp == PIIX_AHCI_DEVICE) {
@@ -696,16 +702,35 @@ static int piix_init_one (struct pci_dev
 		}
 	}
 
-	if (port_info[0]->host_flags & PIIX_FLAG_COMBINED) {
+	if (host_flags & PIIX_FLAG_COMBINED) {
 		u8 tmp;
 		pci_read_config_byte(pdev, ICH5_PMR, &tmp);
 
-		if (tmp & PIIX_COMB) {
-			combined = 1;
-			if (tmp & PIIX_COMB_PATA_P0)
+		if (host_flags & PIIX_FLAG_COMBINED_ICH6) {
+			switch (tmp) {
+			case 0:
+				break;
+			case 1:
+				combined = 1;
 				sata_chan = 1;
-			else
+				break;
+			case 2:
+				combined = 1;
 				pata_chan = 1;
+				break;
+			case 3:
+				dev_printk(KERN_WARNING, &pdev->dev,
+					   "invalid MAP value %u\n", tmp);
+				break;
+			}
+		} else {
+			if (tmp & PIIX_COMB) {
+				combined = 1;
+				if (tmp & PIIX_COMB_PATA_P0)
+					sata_chan = 1;
+				else
+					pata_chan = 1;
+			}
 		}
 	}
 
@@ -715,7 +740,7 @@ static int piix_init_one (struct pci_dev
 	 * MSI is disabled (and it is disabled, as we don't use
 	 * message-signalled interrupts currently).
 	 */
-	if (port_info[0]->host_flags & PIIX_FLAG_CHECKINTR)
+	if (host_flags & PIIX_FLAG_CHECKINTR)
 		pci_intx(pdev, 1);
 
 	if (combined) {
