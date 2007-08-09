From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/4] sis5513: remove /proc/ide/sis
Date: Thu, 9 Aug 2007 22:14:46 +0200
Message-ID: <200708092214.46220.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:30798 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797AbXHIUQH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 16:16:07 -0400
Received: by mu-out-0910.google.com with SMTP id i10so796186mue
        for <linux-ide@vger.kernel.org>; Thu, 09 Aug 2007 13:16:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


This belongs to user-space (and only if really needed).

   text    data     bss     dec     hex filename
   7129     404       8    7541    1d75 drivers/ide/pci/sis5513.o.before
   3916     404       1    4321    10e1 drivers/ide/pci/sis5513.o.after

Additionaly to being bloat the code contained two bugs:
- wrong cable bit was checked (0x0001 instead of 0x8000) on ATA_133 chipsets
- incorrect UDMA cycle time was reported on ATA_100a/ATA_133 chipsets

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sis5513.c |  249 ----------------------------------------------
 1 file changed, 1 insertion(+), 248 deletions(-)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sis5513.c	Version 0.30	Aug 9, 2007
+ * linux/drivers/ide/pci/sis5513.c	Version 0.31	Aug 9, 2007
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
@@ -65,8 +65,6 @@
 
 #include "ide-timing.h"
 
-#define DISPLAY_SIS_TIMINGS
-
 /* registers layout and init values are chipset family dependant */
 
 #define ATA_16		0x01
@@ -193,243 +191,6 @@ static char* chipset_capability[] = {
 	"ATA 133 (1st gen)", "ATA 133 (2nd gen)"
 };
 
-#if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 sis_proc = 0;
-
-static struct pci_dev *bmide_dev;
-
-static char* cable_type[] = {
-	"80 pins",
-	"40 pins"
-};
-
-static char* recovery_time[] ={
-	"12 PCICLK", "1 PCICLK",
-	"2 PCICLK", "3 PCICLK",
-	"4 PCICLK", "5 PCICLCK",
-	"6 PCICLK", "7 PCICLCK",
-	"8 PCICLK", "9 PCICLCK",
-	"10 PCICLK", "11 PCICLK",
-	"13 PCICLK", "14 PCICLK",
-	"15 PCICLK", "15 PCICLK"
-};
-
-static char* active_time[] = {
-	"8 PCICLK", "1 PCICLCK",
-	"2 PCICLK", "3 PCICLK",
-	"4 PCICLK", "5 PCICLK",
-	"6 PCICLK", "12 PCICLK"
-};
-
-static char* cycle_time[] = {
-	"Reserved", "2 CLK",
-	"3 CLK", "4 CLK",
-	"5 CLK", "6 CLK",
-	"7 CLK", "8 CLK",
-	"9 CLK", "10 CLK",
-	"11 CLK", "12 CLK",
-	"13 CLK", "14 CLK",
-	"15 CLK", "16 CLK"
-};
-
-/* Generic add master or slave info function */
-static char* get_drives_info (char *buffer, u8 pos)
-{
-	u8 reg00, reg01, reg10, reg11; /* timing registers */
-	u32 regdw0, regdw1;
-	char* p = buffer;
-
-/* Postwrite/Prefetch */
-	if (chipset_family < ATA_133) {
-		pci_read_config_byte(bmide_dev, 0x4b, &reg00);
-		p += sprintf(p, "Drive %d:        Postwrite %s \t \t Postwrite %s\n",
-			     pos, (reg00 & (0x10 << pos)) ? "Enabled" : "Disabled",
-			     (reg00 & (0x40 << pos)) ? "Enabled" : "Disabled");
-		p += sprintf(p, "                Prefetch  %s \t \t Prefetch  %s\n",
-			     (reg00 & (0x01 << pos)) ? "Enabled" : "Disabled",
-			     (reg00 & (0x04 << pos)) ? "Enabled" : "Disabled");
-		pci_read_config_byte(bmide_dev, 0x40+2*pos, &reg00);
-		pci_read_config_byte(bmide_dev, 0x41+2*pos, &reg01);
-		pci_read_config_byte(bmide_dev, 0x44+2*pos, &reg10);
-		pci_read_config_byte(bmide_dev, 0x45+2*pos, &reg11);
-	} else {
-		u32 reg54h;
-		u8 drive_pci = 0x40;
-		pci_read_config_dword(bmide_dev, 0x54, &reg54h);
-		if (reg54h & 0x40000000) {
-			// Configuration space remapped to 0x70
-			drive_pci = 0x70;
-		}
-		pci_read_config_dword(bmide_dev, (unsigned long)drive_pci+4*pos, &regdw0);
-		pci_read_config_dword(bmide_dev, (unsigned long)drive_pci+4*pos+8, &regdw1);
-
-		p += sprintf(p, "Drive %d:\n", pos);
-	}
-
-
-/* UDMA */
-	if (chipset_family >= ATA_133) {
-		p += sprintf(p, "                UDMA %s \t \t \t UDMA %s\n",
-			     (regdw0 & 0x04) ? "Enabled" : "Disabled",
-			     (regdw1 & 0x04) ? "Enabled" : "Disabled");
-		p += sprintf(p, "                UDMA Cycle Time    %s \t UDMA Cycle Time    %s\n",
-			     cycle_time[(regdw0 & 0xF0) >> 4],
-			     cycle_time[(regdw1 & 0xF0) >> 4]);
-	} else if (chipset_family >= ATA_33) {
-		p += sprintf(p, "                UDMA %s \t \t \t UDMA %s\n",
-			     (reg01 & 0x80) ? "Enabled" : "Disabled",
-			     (reg11 & 0x80) ? "Enabled" : "Disabled");
-
-		p += sprintf(p, "                UDMA Cycle Time    ");
-		switch(chipset_family) {
-			case ATA_33:	p += sprintf(p, cycle_time[(reg01 & 0x60) >> 5]); break;
-			case ATA_66:
-			case ATA_100a:	p += sprintf(p, cycle_time[(reg01 & 0x70) >> 4]); break;
-			case ATA_100:
-			case ATA_133a:	p += sprintf(p, cycle_time[reg01 & 0x0F]); break;
-			default:	p += sprintf(p, "?"); break;
-		}
-		p += sprintf(p, " \t UDMA Cycle Time    ");
-		switch(chipset_family) {
-			case ATA_33:	p += sprintf(p, cycle_time[(reg11 & 0x60) >> 5]); break;
-			case ATA_66:
-			case ATA_100a:	p += sprintf(p, cycle_time[(reg11 & 0x70) >> 4]); break;
-			case ATA_100:
-			case ATA_133a:  p += sprintf(p, cycle_time[reg11 & 0x0F]); break;
-			default:	p += sprintf(p, "?"); break;
-		}
-		p += sprintf(p, "\n");
-	}
-
-
-	if (chipset_family < ATA_133) {	/* else case TODO */
-
-/* Data Active */
-		p += sprintf(p, "                Data Active Time   ");
-		switch(chipset_family) {
-			case ATA_16: /* confirmed */
-			case ATA_33:
-			case ATA_66:
-			case ATA_100a: p += sprintf(p, active_time[reg01 & 0x07]); break;
-			case ATA_100:
-			case ATA_133a: p += sprintf(p, active_time[(reg00 & 0x70) >> 4]); break;
-			default: p += sprintf(p, "?"); break;
-		}
-		p += sprintf(p, " \t Data Active Time   ");
-		switch(chipset_family) {
-			case ATA_16:
-			case ATA_33:
-			case ATA_66:
-			case ATA_100a: p += sprintf(p, active_time[reg11 & 0x07]); break;
-			case ATA_100:
-			case ATA_133a: p += sprintf(p, active_time[(reg10 & 0x70) >> 4]); break;
-			default: p += sprintf(p, "?"); break;
-		}
-		p += sprintf(p, "\n");
-
-/* Data Recovery */
-	/* warning: may need (reg&0x07) for pre ATA66 chips */
-		p += sprintf(p, "                Data Recovery Time %s \t Data Recovery Time %s\n",
-			     recovery_time[reg00 & 0x0f], recovery_time[reg10 & 0x0f]);
-	}
-
-	return p;
-}
-
-static char* get_masters_info(char* buffer)
-{
-	return get_drives_info(buffer, 0);
-}
-
-static char* get_slaves_info(char* buffer)
-{
-	return get_drives_info(buffer, 1);
-}
-
-/* Main get_info, called on /proc/ide/sis reads */
-static int sis_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	int len;
-	u8 reg;
-	u16 reg2, reg3;
-
-	p += sprintf(p, "\nSiS 5513 ");
-	switch(chipset_family) {
-		case ATA_16: p += sprintf(p, "DMA 16"); break;
-		case ATA_33: p += sprintf(p, "Ultra 33"); break;
-		case ATA_66: p += sprintf(p, "Ultra 66"); break;
-		case ATA_100a:
-		case ATA_100: p += sprintf(p, "Ultra 100"); break;
-		case ATA_133a:
-		case ATA_133: p += sprintf(p, "Ultra 133"); break;
-		default: p+= sprintf(p, "Unknown???"); break;
-	}
-	p += sprintf(p, " chipset\n");
-	p += sprintf(p, "--------------- Primary Channel "
-		     "---------------- Secondary Channel "
-		     "-------------\n");
-
-/* Status */
-	pci_read_config_byte(bmide_dev, 0x4a, &reg);
-	if (chipset_family == ATA_133) {
-		pci_read_config_word(bmide_dev, 0x50, &reg2);
-		pci_read_config_word(bmide_dev, 0x52, &reg3);
-	}
-	p += sprintf(p, "Channel Status: ");
-	if (chipset_family < ATA_66) {
-		p += sprintf(p, "%s \t \t \t \t %s\n",
-			     (reg & 0x04) ? "On" : "Off",
-			     (reg & 0x02) ? "On" : "Off");
-	} else if (chipset_family < ATA_133) {
-		p += sprintf(p, "%s \t \t \t \t %s \n",
-			     (reg & 0x02) ? "On" : "Off",
-			     (reg & 0x04) ? "On" : "Off");
-	} else { /* ATA_133 */
-		p += sprintf(p, "%s \t \t \t \t %s \n",
-			     (reg2 & 0x02) ? "On" : "Off",
-			     (reg3 & 0x02) ? "On" : "Off");
-	}
-
-/* Operation Mode */
-	pci_read_config_byte(bmide_dev, 0x09, &reg);
-	p += sprintf(p, "Operation Mode: %s \t \t \t %s \n",
-		     (reg & 0x01) ? "Native" : "Compatible",
-		     (reg & 0x04) ? "Native" : "Compatible");
-
-/* 80-pin cable ? */
-	if (chipset_family >= ATA_133) {
-		p += sprintf(p, "Cable Type:     %s \t \t \t %s\n",
-			     (reg2 & 0x01) ? cable_type[1] : cable_type[0],
-			     (reg3 & 0x01) ? cable_type[1] : cable_type[0]);
-	} else if (chipset_family > ATA_33) {
-		pci_read_config_byte(bmide_dev, 0x48, &reg);
-		p += sprintf(p, "Cable Type:     %s \t \t \t %s\n",
-			     (reg & 0x10) ? cable_type[1] : cable_type[0],
-			     (reg & 0x20) ? cable_type[1] : cable_type[0]);
-	}
-
-/* Prefetch Count */
-	if (chipset_family < ATA_133) {
-		pci_read_config_word(bmide_dev, 0x4c, &reg2);
-		pci_read_config_word(bmide_dev, 0x4e, &reg3);
-		p += sprintf(p, "Prefetch Count: %d \t \t \t \t %d\n",
-			     reg2, reg3);
-	}
-
-	p = get_masters_info(p);
-	p = get_slaves_info(p);
-
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-
-	return len > count ? count : len;
-}
-#endif /* defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_IDE_PROC_FS) */
-
 /*
  * Configuration functions
  */
@@ -751,14 +512,6 @@ static unsigned int __devinit init_chips
 				}
 				break;
 		}
-
-#if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
-		if (!sis_proc) {
-			sis_proc = 1;
-			bmide_dev = dev;
-			ide_pci_create_host_proc("sis", sis_get_info);
-		}
-#endif
 	}
 
 	return 0;
