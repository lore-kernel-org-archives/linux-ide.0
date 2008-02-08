From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/18] ide: remove ->hold field from ide_hwif_t
Date: Fri, 08 Feb 2008 01:46:19 +0100
Message-ID: <20080208004619.17746.469.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:46536 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763296AbYBHAcI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 19:32:08 -0500
Received: by wr-out-0506.google.com with SMTP id c48so3446847wra.23
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 16:32:07 -0800 (PST)
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

->hold is write-only now, remove it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |    3 ---
 drivers/ide/ppc/pmac.c        |    1 -
 include/linux/ide.h           |    1 -
 3 files changed, 5 deletions(-)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -617,9 +617,6 @@ static int au_ide_probe(struct device *d
 
 	hwif->dev = dev;
 
-	/* hold should be on in all cases */
-	hwif->hold                      = 1;
-
 	hwif->mmio  = 1;
 
 	/* If the user has selected DDMA assisted copies,
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1120,7 +1120,6 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	hwif->hwif_data = pmif;
 	ide_init_port_hw(hwif, hw);
 	hwif->noprobe = pmif->mediabay;
-	hwif->hold = pmif->mediabay;
 	hwif->cbl = pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
 	hwif->set_pio_mode = pmac_ide_set_pio_mode;
 	if (pmif->kind == controller_un_ata6
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -573,7 +573,6 @@ typedef struct hwif_s {
 
 	unsigned	noprobe    : 1;	/* don't probe for this interface */
 	unsigned	present    : 1;	/* this interface exists */
-	unsigned	hold       : 1; /* this interface is always present */
 	unsigned	serialized : 1;	/* serialized all channel operation */
 	unsigned	sharing_irq: 1;	/* 1 = sharing irq with another hwif */
 	unsigned	reset      : 1;	/* reset after probe */
