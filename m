From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (pata-2.6 fix queue) cmd64x: procfs code fixes/cleanups
Date: Thu, 15 Feb 2007 22:17:08 +0300
Message-ID: <200702152217.08984.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:42601 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030713AbXBOTRR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Feb 2007 14:17:17 -0500
In-Reply-To: <200702040004.24918.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Fix several issues with the driver's procfs output:

- when testing if channel is enabled, the code looks at the "simplex" bits, not
  at the real enable bits -- add #define for the primary channel enable bit;

- UltraDMA modes 0, 1, 3 for slave drive reported incorrectly due to using the
  master drive's clock cycle resolution bit.

While at it, also perform some cleanups:

- don't read from the registers which are not used for dump;

- correct the chipset names (from CMDxxx to PCI-xxx);

- rework UltraDMA mode dump code;

- remove PIO mode dump code that has never been finished;

- remove the duplicate interrupt status dump (the MRDMODE register bits mirror
  those in the CFR and ARTTIM23 registers);

- add spaces in the ?: operators...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Warning: as usual, this has only been compile-tested. :-)

 drivers/ide/pci/cmd64x.c |   99 ++++++++++++++++++-----------------------------
 1 files changed, 39 insertions(+), 60 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,6 +1,6 @@
 /* $Id: cmd64x.c,v 1.21 2000/01/30 23:23:16
  *
- * linux/drivers/ide/pci/cmd64x.c		Version 1.45	Feb 14, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.46	Feb 15, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Note, this driver is not used at all on other systems because
@@ -41,9 +41,10 @@
 #define CFR		0x50
 #define   CFR_INTR_CH0		0x04
 #define CNTRL		0x51
-#define	  CNTRL_DIS_RA0		0x40
-#define   CNTRL_DIS_RA1		0x80
-#define	  CNTRL_ENA_2ND		0x08
+#define   CNTRL_ENA_1ST 	0x04
+#define   CNTRL_ENA_2ND 	0x08
+#define   CNTRL_DIS_RA0 	0x40
+#define   CNTRL_DIS_RA1 	0x80
 
 #define	CMDTIM		0x52
 #define	ARTTIM0		0x53
@@ -90,23 +91,15 @@ static int n_cmd_devs;
 static char * print_cmd64x_get_info (char *buf, struct pci_dev *dev, int index)
 {
 	char *p = buf;
-
-	u8 reg53 = 0, reg54 = 0, reg55 = 0, reg56 = 0;	/* primary */
-	u8 reg57 = 0, reg58 = 0, reg5b;			/* secondary */
 	u8 reg72 = 0, reg73 = 0;			/* primary */
 	u8 reg7a = 0, reg7b = 0;			/* secondary */
-	u8 reg50 = 0, reg71 = 0;			/* extra */
+	u8 reg50 = 1, reg51 = 1, reg57 = 0, reg71 = 0;	/* extra */
 
 	p += sprintf(p, "\nController: %d\n", index);
-	p += sprintf(p, "CMD%x Chipset.\n", dev->device);
+	p += sprintf(p, "PCI-%x Chipset.\n", dev->device);
 	(void) pci_read_config_byte(dev, CFR,       &reg50);
-	(void) pci_read_config_byte(dev, ARTTIM0,   &reg53);
-	(void) pci_read_config_byte(dev, DRWTIM0,   &reg54);
-	(void) pci_read_config_byte(dev, ARTTIM1,   &reg55);
-	(void) pci_read_config_byte(dev, DRWTIM1,   &reg56);
-	(void) pci_read_config_byte(dev, ARTTIM2,   &reg57);
-	(void) pci_read_config_byte(dev, DRWTIM2,   &reg58);
-	(void) pci_read_config_byte(dev, DRWTIM3,   &reg5b);
+	(void) pci_read_config_byte(dev, CNTRL,     &reg51);
+	(void) pci_read_config_byte(dev, ARTTIM23,  &reg57);
 	(void) pci_read_config_byte(dev, MRDMODE,   &reg71);
 	(void) pci_read_config_byte(dev, BMIDESR0,  &reg72);
 	(void) pci_read_config_byte(dev, UDIDETCR0, &reg73);
@@ -116,57 +109,43 @@ static char * print_cmd64x_get_info (cha
 	p += sprintf(p, "--------------- Primary Channel "
 			"---------------- Secondary Channel "
 			"-------------\n");
-	p += sprintf(p, "                %sabled           "
-			"              %sabled\n",
-		(reg72&0x80)?"dis":" en",
-		(reg7a&0x80)?"dis":" en");
+	p += sprintf(p, "                %sabled         "
+			"                %sabled\n",
+		(reg51 & CNTRL_ENA_1ST) ? "dis" : " en",
+		(reg51 & CNTRL_ENA_2ND) ? "dis" : " en");
 	p += sprintf(p, "--------------- drive0 "
 		"--------- drive1 -------- drive0 "
 		"---------- drive1 ------\n");
 	p += sprintf(p, "DMA enabled:    %s              %s"
 			"             %s               %s\n",
-		(reg72&0x20)?"yes":"no ", (reg72&0x40)?"yes":"no ",
-		(reg7a&0x20)?"yes":"no ", (reg7a&0x40)?"yes":"no ");
+		(reg72 & 0x20) ? "yes" : "no ", (reg72 & 0x40)? "yes" : "no ",
+		(reg7a & 0x20) ? "yes" : "no ", (reg7a & 0x40)? "yes" : "no ");
 
-	p += sprintf(p, "DMA Mode:       %s(%s)          %s(%s)",
-		(reg72&0x20)?((reg73&0x01)?"UDMA":" DMA"):" PIO",
-		(reg72&0x20)?(
-			((reg73&0x30)==0x30)?(((reg73&0x35)==0x35)?"3":"0"):
-			((reg73&0x20)==0x20)?(((reg73&0x25)==0x25)?"3":"1"):
-			((reg73&0x10)==0x10)?(((reg73&0x15)==0x15)?"4":"2"):
-			((reg73&0x00)==0x00)?(((reg73&0x05)==0x05)?"5":"2"):
-			"X"):"?",
-		(reg72&0x40)?((reg73&0x02)?"UDMA":" DMA"):" PIO",
-		(reg72&0x40)?(
-			((reg73&0xC0)==0xC0)?(((reg73&0xC5)==0xC5)?"3":"0"):
-			((reg73&0x80)==0x80)?(((reg73&0x85)==0x85)?"3":"1"):
-			((reg73&0x40)==0x40)?(((reg73&0x4A)==0x4A)?"4":"2"):
-			((reg73&0x00)==0x00)?(((reg73&0x0A)==0x0A)?"5":"2"):
-			"X"):"?");
-	p += sprintf(p, "         %s(%s)           %s(%s)\n",
-		(reg7a&0x20)?((reg7b&0x01)?"UDMA":" DMA"):" PIO",
-		(reg7a&0x20)?(
-			((reg7b&0x30)==0x30)?(((reg7b&0x35)==0x35)?"3":"0"):
-			((reg7b&0x20)==0x20)?(((reg7b&0x25)==0x25)?"3":"1"):
-			((reg7b&0x10)==0x10)?(((reg7b&0x15)==0x15)?"4":"2"):
-			((reg7b&0x00)==0x00)?(((reg7b&0x05)==0x05)?"5":"2"):
-			"X"):"?",
-		(reg7a&0x40)?((reg7b&0x02)?"UDMA":" DMA"):" PIO",
-		(reg7a&0x40)?(
-			((reg7b&0xC0)==0xC0)?(((reg7b&0xC5)==0xC5)?"3":"0"):
-			((reg7b&0x80)==0x80)?(((reg7b&0x85)==0x85)?"3":"1"):
-			((reg7b&0x40)==0x40)?(((reg7b&0x4A)==0x4A)?"4":"2"):
-			((reg7b&0x00)==0x00)?(((reg7b&0x0A)==0x0A)?"5":"2"):
-			"X"):"?" );
-	p += sprintf(p, "PIO Mode:       %s                %s"
-			"               %s                 %s\n",
-			"?", "?", "?", "?");
-	p += sprintf(p, "                %s                     %s\n",
-		(reg50 & CFR_INTR_CH0) ? "interrupting" : "polling     ",
-		(reg57 & ARTTIM23_INTR_CH1) ? "interrupting" : "polling");
+	p += sprintf(p, "UDMA Mode:     %s (%c)         %s (%c)",
+		( reg73 & 0x01) ? " on" : "off",
+		((reg73 & 0x30) == 0x30) ? ((reg73 & 0x04) ? '3' : '0') :
+		((reg73 & 0x30) == 0x20) ? ((reg73 & 0x04) ? '3' : '1') :
+		((reg73 & 0x30) == 0x10) ? ((reg73 & 0x04) ? '4' : '2') :
+		((reg73 & 0x30) == 0x00) ? ((reg73 & 0x04) ? '5' : '2') : '?',
+		( reg73 & 0x02) ? " on" : "off",
+		((reg73 & 0xC0) == 0xC0) ? ((reg73 & 0x08) ? '3' : '0') :
+		((reg73 & 0xC0) == 0x80) ? ((reg73 & 0x08) ? '3' : '1') :
+		((reg73 & 0xC0) == 0x40) ? ((reg73 & 0x08) ? '4' : '2') :
+		((reg73 & 0xC0) == 0x00) ? ((reg73 & 0x08) ? '5' : '2') : '?');
+	p += sprintf(p, "        %s (%c)          %s (%c)\n",
+		( reg7b & 0x01) ? " on" : "off",
+		((reg7b & 0x30) == 0x30) ? ((reg7b & 0x04) ? '3' : '0') :
+		((reg7b & 0x30) == 0x20) ? ((reg7b & 0x04) ? '3' : '1') :
+		((reg7b & 0x30) == 0x10) ? ((reg7b & 0x04) ? '4' : '2') :
+		((reg7b & 0x30) == 0x00) ? ((reg7b & 0x04) ? '5' : '2') : '?',
+		( reg7b & 0x02) ? " on" : "off",
+		((reg7b & 0xC0) == 0xC0) ? ((reg7b & 0x08) ? '3' : '0'):
+		((reg7b & 0xC0) == 0x80) ? ((reg7b & 0x08) ? '3' : '1'):
+		((reg7b & 0xC0) == 0x40) ? ((reg7b & 0x08) ? '4' : '2'):
+		((reg7b & 0xC0) == 0x00) ? ((reg7b & 0x08) ? '5' : '2'): '?');
 	p += sprintf(p, "                %s                          %s\n",
-		(reg71 & MRDMODE_INTR_CH0) ? "pending" : "clear  ",
-		(reg71 & MRDMODE_INTR_CH1) ? "pending" : "clear");
+		(reg50 & CFR_INTR_CH0	  ) ? "pending" : "clear  ",
+		(reg57 & ARTTIM23_INTR_CH1) ? "pending" : "clear  ");
 	p += sprintf(p, "                %s                          %s\n",
 		(reg71 & MRDMODE_BLK_CH0) ? "blocked" : "enabled",
 		(reg71 & MRDMODE_BLK_CH1) ? "blocked" : "enabled");

