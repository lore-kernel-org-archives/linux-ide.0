From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 18/24] ide jmicron: Finish writing
Date: Tue, 4 Jul 2006 18:15:32 +0000 (UTC)
Message-ID: <11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxo
 rguk.ukuu.org.uk> <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036122125!
 0-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57998 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932321AbWGDSPN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:15:13 -0400
Date: Maw, 04 Gor 2006 19:01:42 +0100
In-Reply-To: <11520361221250-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

From: Alan Cox <alan@redhat.com>

Finish writing/compiling the IDE mode driver.

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/ide/pci/jmicron.c |   45 +++++++++++++++++----------------------------
 1 files changed, 17 insertions(+), 28 deletions(-)

d3dd976e6cf56cf3ea90f016fd0ae9e7d13a180e
diff --git a/drivers/ide/pci/jmicron.c b/drivers/ide/pci/jmicron.c
index b7301f0..987c81b 100644
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -16,11 +16,11 @@
 
 #include <asm/io.h>
 
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
  *	jmicron_ratemask	-	Compute available modes
@@ -45,17 +45,18 @@ static u8 jmicron_ratemask(ide_drive_t *
  *	Return 1 if the cable is 80pin
  */
 
-static int ata66_jmicron(ide_hwif_t *hwif)
+static int __devinit ata66_jmicron(ide_hwif_t *hwif)
 {
 	struct pci_dev *pdev = hwif->pci_dev;
 	
 	u32 control;
 	u32 control5;
 	
-	int port_mask = 1<< (4 * hwif->channel);
 	int port = hwif->channel;
 	port_type port_map[2];
 
+	pci_read_config_dword(pdev, 0x40, &control);
+	
 	/* There are two basic mappings. One has the two SATA ports merged
 	   as master/slave and the secondary as PATA, the other has only the 
 	   SATA port mapped */
@@ -71,7 +72,7 @@ static int ata66_jmicron(ide_hwif_t *hwi
 	   as the internal primary channel */	
 	pci_read_config_dword(pdev, 0x80, &control5);
 	if (control5 & (1<<24))
-		port_map[0] == PORT_PATA1;
+		port_map[0] = PORT_PATA1;
 
 	/* The two ports may then be logically swapped by the firmware */
 	if (control & (1 << 22))
@@ -87,14 +88,12 @@ static int ata66_jmicron(ide_hwif_t *hwi
 	case PORT_PATA0:
 		if (control & (1 << 3))	/* 40/80 pin primary */
 			return 1;
-		else	
-			return 0;
-		break;
+		return 0;
 	case PORT_PATA1:
 		if (control5 & (1 << 19))	/* 40/80 pin secondary */
 			return 0;
 		return 1;
-	case PORT_SATA
+	case PORT_SATA:
 		return 1;
 	}		
 }
@@ -113,6 +112,7 @@ static void jmicron_tuneproc (ide_drive_
 
 static void config_jmicron_chipset_for_pio (ide_drive_t *drive, byte set_speed)
 {
+	u8 speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
 	if (set_speed)
 		(void) ide_config_drive_speed(drive, speed);
 }
@@ -130,7 +130,6 @@ static void config_jmicron_chipset_for_p
 static int jmicron_tune_chipset (ide_drive_t *drive, byte xferspeed)
 {
 
-	ide_hwif_t *hwif	= drive->hwif;
 	u8 speed		= ide_rate_filter(jmicron_ratemask(drive), xferspeed);
 
 	return ide_config_drive_speed(drive, speed);
@@ -174,16 +173,6 @@ static int jmicron_config_drive_for_dma 
 }
 
 /**
- *	ata66_jmicron	-	check for 80 pin cable
- *	@hwif: interface to check
- *
- */
-
-static unsigned int __devinit ata66_jmicron(ide_hwif_t *hwif)
-{
-}
-
-/**
  *	init_hwif_jmicron	-	set up hwif structs
  *	@hwif: interface to set up
  *
@@ -252,11 +241,11 @@ static int __devinit jmicron_init_one(st
 }
 
 static struct pci_device_id jmicron_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRO, PCI_DEVICE_ID_JMICRON_JMB361), 0},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRO, PCI_DEVICE_ID_JMICRON_JMB363), 1},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRO, PCI_DEVICE_ID_JMICRON_JMB365), 2},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRO, PCI_DEVICE_ID_JMICRON_JMB366), 3},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRO, PCI_DEVICE_ID_JMICRON_JMB368), 4},
+	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361), 0},
+	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363), 1},
+	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365), 2},
+	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366), 3},
+	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368), 4},
 	{ 0, },
 };
 
-- 
1.2.GIT

