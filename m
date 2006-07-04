From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 20/24] jmicron: Further clean up
Date: Tue, 4 Jul 2006 18:15:32 +0000 (UTC)
Message-ID: <11520361243147-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxo
 rguk.ukuu.org.uk> <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036122125!
 0-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361232889-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58510 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932323AbWGDSPX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:15:23 -0400
Date: Maw, 04 Gor 2006 19:01:44 +0100
In-Reply-To: <11520361232889-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

From: Alan Cox <alan@redhat.com>

- Fix the comment that is bass ackwards in jmicron.c
- Switch ahci to use PCI_VENDOR_ID.. definitions

[PS: Jeff you'd tell me off for not using PCI_DEVICE_ID() here... ;)]

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/ahci.c        |   10 +++++-----
 drivers/scsi/ata_jmicron.c |   34 +++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 22 deletions(-)

954521d7fd805123573035d3d9eba59cd8705549
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 1edfade..71b626b 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -319,15 +319,15 @@ static const struct pci_device_id ahci_p
 	  board_ahci }, /* ICH8M */
 
 	/* JMicron */
-	{ 0x197b, 0x2360, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB360 */
-	{ 0x197b, 0x2361, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB361 */
-	{ 0x197b, 0x2363, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB363 */
-	{ 0x197b, 0x2365, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB365 */
-	{ 0x197b, 0x2366, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB366 */
 
 	/* ATI */
diff --git a/drivers/scsi/ata_jmicron.c b/drivers/scsi/ata_jmicron.c
index 23f362b..b3136c8 100644
--- a/drivers/scsi/ata_jmicron.c
+++ b/drivers/scsi/ata_jmicron.c
@@ -21,11 +21,11 @@
 #define DRV_NAME	"ata_jmicron"
 #define DRV_VERSION	"0.1"
 
-enum port_type {
-	PORT_PATA0 = 0;
-	PORT_PATA1 = 1;
-	PORT_SATA = 2;
-}
+typedef enum {
+	PORT_PATA0 = 0,
+	PORT_PATA1 = 1,
+	PORT_SATA = 2,
+} port_type;
 
 /**
  *	jmicron_pre_reset	-	check for 40/80 pin
@@ -45,7 +45,6 @@ static int jmicron_pre_reset(struct ata_
 	u32 control;
 	u32 control5;
 	int port_mask = 1<< (4 * ap->hard_port_no);
-	int is_sata = 0;
 	int port = ap->hard_port_no;
 	port_type port_map[2];
 
@@ -69,7 +68,7 @@ static int jmicron_pre_reset(struct ata_
 	   as the internal primary channel */	
 	pci_read_config_dword(pdev, 0x80, &control5);
 	if (control5 & (1<<24))
-		port_map[0] == PORT_PATA1;
+		port_map[0] = PORT_PATA1;
 
 	/* The two ports may then be logically swapped by the firmware */
 	if (control & (1 << 22))
@@ -100,7 +99,7 @@ static int jmicron_pre_reset(struct ata_
 			ap->cbl = ATA_CBL_PATA80;
 		break;
 	case PORT_SATA:	
-		ap->cbl = ATA_CBL_SATA
+		ap->cbl = ATA_CBL_SATA;
 		break;
 	}		
 	return ata_std_prereset(ap);
@@ -191,7 +190,7 @@ static const struct ata_port_operations 
  *	Zero on success, or -ERRNO value.
  */
 
-static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static struct ata_port_info info = {
 		.sht		= &jmicron_sht,
@@ -203,10 +202,11 @@ static int jmicron_init_one (struct pci_
 
 		.port_ops	= &jmicron_ops,
 	};
+	struct ata_port_info *port_info[2] = { &info, &info };
 	
 	u32 reg;
 
-	if (id->device_data != 368) {
+	if (id->driver_data != 368) {
 		/* Put the controller into AHCI mode in case the AHCI driver
 		   has not yet been loaded. This can be done with either
 		   function present */
@@ -215,11 +215,11 @@ static int jmicron_init_one (struct pci_
 		pci_write_config_byte(pdev, 0x41, 0xa1);
 	}
 
-	/* PATA controller is fn 0, AHCI is fn 1 */
+	/* PATA controller is fn 1, AHCI is fn 0 */
 	if (PCI_FUNC(pdev->devfn) != 1)
 		return -ENODEV;
 		
-	if ( id->device_data == 365 || id->device_data == 366) {
+	if ( id->driver_data == 365 || id->driver_data == 366) {
 		/* The 365/66 have two PATA channels, redirect the second */
 		pci_read_config_dword(pdev, 0x80, &reg);
 		reg |= (1 << 24);	/* IDE1 to PATA IDE secondary */
@@ -230,11 +230,11 @@ static int jmicron_init_one (struct pci_
 }
 
 static const struct pci_device_id jmicron_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRO, PCI_DEVICE_ID_JMICRON_JMB361), 361},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRO, PCI_DEVICE_ID_JMICRON_JMB363), 363},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRO, PCI_DEVICE_ID_JMICRON_JMB365), 365},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRO, PCI_DEVICE_ID_JMICRON_JMB366), 366},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRO, PCI_DEVICE_ID_JMICRON_JMB368), 368},
+	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361), 361},
+	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363), 363},
+	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365), 365},
+	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366), 366},
+	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368), 368},
 	{ }	/* terminate list */
 };
 
-- 
1.2.GIT

