From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/6] cmd64x: remove /proc/ide/cmd64x
Date: Mon, 3 Dec 2007 22:55:07 +0100
Message-ID: <200712032255.08012.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:20822 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbXLCVrX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 16:47:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2458801ugc
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2007 13:47:22 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


This belongs to user-space (and only if really needed).

   text    data     bss     dec     hex filename
   3874     180      28    4082     ff2 drivers/ide/pci/cmd64x.o.before
   2231     180       0    2411     96b drivers/ide/pci/cmd64x.o.after

Additionaly to being bloat the code contained two bugs:
- incorrect UDMA modes were reported for reserved values of UDIDETCR0/1 regs
- MRDMODE_BLK_CH0/1 bits are not defined on CMD643 and early CMD646 revisions

Also while at it remove unused CNTRL_DIS_RA0/1 defines.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cmd64x.c |  114 -----------------------------------------------
 1 file changed, 1 insertion(+), 113 deletions(-)

Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cmd64x.c		Version 1.51	Nov 8, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.52	Dec 2, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Due to massive hardware bugs, UltraDMA is only supported
@@ -22,8 +22,6 @@
 
 #include <asm/io.h>
 
-#define DISPLAY_CMD64X_TIMINGS
-
 #define CMD_DEBUG 0
 
 #if CMD_DEBUG
@@ -37,11 +35,6 @@
  */
 #define CFR		0x50
 #define   CFR_INTR_CH0		0x04
-#define CNTRL		0x51
-#define   CNTRL_ENA_1ST 	0x04
-#define   CNTRL_ENA_2ND 	0x08
-#define   CNTRL_DIS_RA0 	0x40
-#define   CNTRL_DIS_RA1 	0x80
 
 #define	CMDTIM		0x52
 #define	ARTTIM0		0x53
@@ -60,108 +53,13 @@
 #define MRDMODE		0x71
 #define   MRDMODE_INTR_CH0	0x04
 #define   MRDMODE_INTR_CH1	0x08
-#define   MRDMODE_BLK_CH0	0x10
-#define   MRDMODE_BLK_CH1	0x20
-#define BMIDESR0	0x72
 #define UDIDETCR0	0x73
 #define DTPR0		0x74
 #define BMIDECR1	0x78
 #define BMIDECSR	0x79
-#define BMIDESR1	0x7A
 #define UDIDETCR1	0x7B
 #define DTPR1		0x7C
 
-#if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 cmd64x_proc = 0;
-
-#define CMD_MAX_DEVS		5
-
-static struct pci_dev *cmd_devs[CMD_MAX_DEVS];
-static int n_cmd_devs;
-
-static char * print_cmd64x_get_info (char *buf, struct pci_dev *dev, int index)
-{
-	char *p = buf;
-	u8 reg72 = 0, reg73 = 0;			/* primary */
-	u8 reg7a = 0, reg7b = 0;			/* secondary */
-	u8 reg50 = 1, reg51 = 1, reg57 = 0, reg71 = 0;	/* extra */
-
-	p += sprintf(p, "\nController: %d\n", index);
-	p += sprintf(p, "PCI-%x Chipset.\n", dev->device);
-
-	(void) pci_read_config_byte(dev, CFR,       &reg50);
-	(void) pci_read_config_byte(dev, CNTRL,     &reg51);
-	(void) pci_read_config_byte(dev, ARTTIM23,  &reg57);
-	(void) pci_read_config_byte(dev, MRDMODE,   &reg71);
-	(void) pci_read_config_byte(dev, BMIDESR0,  &reg72);
-	(void) pci_read_config_byte(dev, UDIDETCR0, &reg73);
-	(void) pci_read_config_byte(dev, BMIDESR1,  &reg7a);
-	(void) pci_read_config_byte(dev, UDIDETCR1, &reg7b);
-
-	/* PCI0643/6 originally didn't have the primary channel enable bit */
-	if ((dev->device == PCI_DEVICE_ID_CMD_643) ||
-	    (dev->device == PCI_DEVICE_ID_CMD_646 && dev->revision < 3))
-		reg51 |= CNTRL_ENA_1ST;
-
-	p += sprintf(p, "---------------- Primary Channel "
-			"---------------- Secondary Channel ------------\n");
-	p += sprintf(p, "                 %s                         %s\n",
-		 (reg51 & CNTRL_ENA_1ST) ? "enabled " : "disabled",
-		 (reg51 & CNTRL_ENA_2ND) ? "enabled " : "disabled");
-	p += sprintf(p, "---------------- drive0 --------- drive1 "
-			"-------- drive0 --------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:     %s              %s"
-			"             %s              %s\n",
-		(reg72 & 0x20) ? "yes" : "no ", (reg72 & 0x40) ? "yes" : "no ",
-		(reg7a & 0x20) ? "yes" : "no ", (reg7a & 0x40) ? "yes" : "no ");
-	p += sprintf(p, "UltraDMA mode:   %s (%c)          %s (%c)",
-		( reg73 & 0x01) ? " on" : "off",
-		((reg73 & 0x30) == 0x30) ? ((reg73 & 0x04) ? '3' : '0') :
-		((reg73 & 0x30) == 0x20) ? ((reg73 & 0x04) ? '3' : '1') :
-		((reg73 & 0x30) == 0x10) ? ((reg73 & 0x04) ? '4' : '2') :
-		((reg73 & 0x30) == 0x00) ? ((reg73 & 0x04) ? '5' : '2') : '?',
-		( reg73 & 0x02) ? " on" : "off",
-		((reg73 & 0xC0) == 0xC0) ? ((reg73 & 0x08) ? '3' : '0') :
-		((reg73 & 0xC0) == 0x80) ? ((reg73 & 0x08) ? '3' : '1') :
-		((reg73 & 0xC0) == 0x40) ? ((reg73 & 0x08) ? '4' : '2') :
-		((reg73 & 0xC0) == 0x00) ? ((reg73 & 0x08) ? '5' : '2') : '?');
-	p += sprintf(p, "         %s (%c)          %s (%c)\n",
-		( reg7b & 0x01) ? " on" : "off",
-		((reg7b & 0x30) == 0x30) ? ((reg7b & 0x04) ? '3' : '0') :
-		((reg7b & 0x30) == 0x20) ? ((reg7b & 0x04) ? '3' : '1') :
-		((reg7b & 0x30) == 0x10) ? ((reg7b & 0x04) ? '4' : '2') :
-		((reg7b & 0x30) == 0x00) ? ((reg7b & 0x04) ? '5' : '2') : '?',
-		( reg7b & 0x02) ? " on" : "off",
-		((reg7b & 0xC0) == 0xC0) ? ((reg7b & 0x08) ? '3' : '0') :
-		((reg7b & 0xC0) == 0x80) ? ((reg7b & 0x08) ? '3' : '1') :
-		((reg7b & 0xC0) == 0x40) ? ((reg7b & 0x08) ? '4' : '2') :
-		((reg7b & 0xC0) == 0x00) ? ((reg7b & 0x08) ? '5' : '2') : '?');
-	p += sprintf(p, "Interrupt:       %s, %s                 %s, %s\n",
-		(reg71 & MRDMODE_BLK_CH0  ) ? "blocked" : "enabled",
-		(reg50 & CFR_INTR_CH0	  ) ? "pending" : "clear  ",
-		(reg71 & MRDMODE_BLK_CH1  ) ? "blocked" : "enabled",
-		(reg57 & ARTTIM23_INTR_CH1) ? "pending" : "clear  ");
-
-	return (char *)p;
-}
-
-static int cmd64x_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	int i;
-
-	for (i = 0; i < n_cmd_devs; i++) {
-		struct pci_dev *dev	= cmd_devs[i];
-		p = print_cmd64x_get_info(p, dev, i);
-	}
-	return p-buffer;	/* => must be less than 4k! */
-}
-
-#endif	/* defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_IDE_PROC_FS) */
-
 static u8 quantize_timing(int timing, int quant)
 {
 	return (timing + quant - 1) / quant;
@@ -472,16 +370,6 @@ static unsigned int __devinit init_chips
 	mrdmode &= ~0x30;
 	(void) pci_write_config_byte(dev, MRDMODE, (mrdmode | 0x02));
 
-#if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
-
-	cmd_devs[n_cmd_devs++] = dev;
-
-	if (!cmd64x_proc) {
-		cmd64x_proc = 1;
-		ide_pci_create_host_proc("cmd64x", cmd64x_get_info);
-	}
-#endif /* DISPLAY_CMD64X_TIMINGS && CONFIG_IDE_PROC_FS */
-
 	return 0;
 }
 
