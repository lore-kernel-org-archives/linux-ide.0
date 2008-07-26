From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/10] ide: sanitize struct ide_port_ops documentation
Date: Sat, 26 Jul 2008 15:40:10 +0200
Message-ID: <20080726134010.10589.51679.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:35107 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYGZNmP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jul 2008 09:42:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1822666fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 26 Jul 2008 06:42:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
some easy/trivial changes just to keep the ball rolling...

 include/linux/ide.h |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -508,24 +508,33 @@ struct ide_tp_ops {
 
 extern const struct ide_tp_ops default_tp_ops;
 
+/**
+ * struct ide_port_ops - IDE port operations
+ *
+ * init_dev:		host specific initialization of a device
+ * set_pio_mode:	routine to program host for PIO mode
+ * set_dma_mode:	routine to program host for DMA mode
+ * selectproc:		tweaks hardware to select drive
+ * reset_poll:		chipset polling based on hba specifics
+ * pre_reset:		chipset specific changes to default for device-hba resets
+ * resetproc:		routine to reset controller after a disk reset
+ * maskproc:		special host masking for drive selection
+ * quirkproc:		check host's drive quirk list
+ *
+ * mdma_filter:		filter MDMA modes
+ * udma_filter:		filter UDMA modes
+ *
+ * cable_detect:	detect cable type
+ */
 struct ide_port_ops {
-	/* host specific initialization of a device */
 	void	(*init_dev)(ide_drive_t *);
-	/* routine to program host for PIO mode */
 	void	(*set_pio_mode)(ide_drive_t *, const u8);
-	/* routine to program host for DMA mode */
 	void	(*set_dma_mode)(ide_drive_t *, const u8);
-	/* tweaks hardware to select drive */
 	void	(*selectproc)(ide_drive_t *);
-	/* chipset polling based on hba specifics */
 	int	(*reset_poll)(ide_drive_t *);
-	/* chipset specific changes to default for device-hba resets */
 	void	(*pre_reset)(ide_drive_t *);
-	/* routine to reset controller after a disk reset */
 	void	(*resetproc)(ide_drive_t *);
-	/* special host masking for drive selection */
 	void	(*maskproc)(ide_drive_t *, int);
-	/* check host's drive quirk list */
 	void	(*quirkproc)(ide_drive_t *);
 
 	u8	(*mdma_filter)(ide_drive_t *);
