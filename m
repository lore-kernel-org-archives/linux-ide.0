From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] ide: add ->cur_port to struct ide_host and use it for serialized hosts
Date: Sun, 14 Dec 2008 00:39:39 +0100
Message-ID: <20081213233939.4653.49654.sendpatchset@localhost.localdomain>
References: <20081213233925.4653.58008.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:21825 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbYLMXjz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Dec 2008 18:39:55 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1146869muf.1
        for <linux-ide@vger.kernel.org>; Sat, 13 Dec 2008 15:39:53 -0800 (PST)
In-Reply-To: <20081213233925.4653.58008.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add ->cur_port to struct ide_host and use it for serialized hosts

* Pass 'ide_hwif_t *' instead of 'ide_hwgroup_t *' to unexpected_intr().

* Cache pointer to the port currently being serviced in ->cur_port
  and use it instead of hwif->hwgroup on serialized hosts.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   25 +++++++++++++++----------
 include/linux/ide.h  |    1 +
 2 files changed, 16 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -726,7 +726,7 @@ void do_ide_request(struct request_queue
 	if (!ide_lock_hwgroup(hwgroup)) {
 		ide_hwif_t *prev_port;
 repeat:
-		prev_port = hwgroup->hwif;
+		prev_port = hwif->host->cur_port;
 		hwgroup->rq = NULL;
 
 		if (drive->dev_flags & IDE_DFLAG_SLEEPING) {
@@ -736,15 +736,17 @@ repeat:
 			}
 		}
 
-		if (hwif != prev_port) {
+		if ((hwif->host->host_flags & IDE_HFLAG_SERIALIZE) &&
+		    hwif != prev_port) {
 			/*
 			 * set nIEN for previous port, drives in the
 			 * quirk_list may not like intr setups/cleanups
 			 */
-			if (hwgroup->drive->quirk_list == 0)
+			if (prev_port && hwgroup->drive->quirk_list == 0)
 				prev_port->tp_ops->set_irq(prev_port, 0);
+
+			hwif->host->cur_port = hwif;
 		}
-		hwgroup->hwif = hwif;
 		hwgroup->drive = drive;
 		drive->dev_flags &= ~(IDE_DFLAG_SLEEPING | IDE_DFLAG_PARKED);
 
@@ -976,7 +978,7 @@ void ide_timer_expiry (unsigned long dat
 /**
  *	unexpected_intr		-	handle an unexpected IDE interrupt
  *	@irq: interrupt line
- *	@hwgroup: hwgroup being processed
+ *	@hwif: port being processed
  *
  *	There's nothing really useful we can do with an unexpected interrupt,
  *	other than reading the status register (to clear it), and logging it.
@@ -1005,11 +1007,11 @@ void ide_timer_expiry (unsigned long dat
  *	is doing the current command, but we don't know which hwif burped
  *	mysteriously.
  */
- 
-static void unexpected_intr (int irq, ide_hwgroup_t *hwgroup)
+
+static void unexpected_intr(int irq, ide_hwif_t *hwif)
 {
+	ide_hwgroup_t *hwgroup = hwif->hwgroup;
 	u8 stat;
-	ide_hwif_t *hwif = hwgroup->hwif;
 
 	/*
 	 * handle the unexpected interrupt
@@ -1044,7 +1046,7 @@ static void unexpected_intr (int irq, id
  *	not need to override it. If you do be aware it is subtle in
  *	places
  *
- *	hwgroup->hwif is the interface in the group currently performing
+ *	hwif is the interface in the group currently performing
  *	a command. hwgroup->drive is the drive and hwgroup->handler is
  *	the IRQ handler to call. As we issue a command the handlers
  *	step through multiple states, reassigning the handler to the
@@ -1070,6 +1072,9 @@ irqreturn_t ide_intr (int irq, void *dev
 	irqreturn_t irq_ret = IRQ_NONE;
 	int plug_device = 0;
 
+	if (hwif->host->host_flags & IDE_HFLAG_SERIALIZE)
+		hwif = hwif->host->cur_port;
+
 	spin_lock_irqsave(&hwgroup->lock, flags);
 
 	if (!ide_ack_intr(hwif))
@@ -1099,7 +1104,7 @@ irqreturn_t ide_intr (int irq, void *dev
 			 * Probably not a shared PCI interrupt,
 			 * so we can safely try to do something about it:
 			 */
-			unexpected_intr(irq, hwgroup);
+			unexpected_intr(irq, hwif);
 #ifdef CONFIG_BLK_DEV_IDEPCI
 		} else {
 			/*
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -852,6 +852,7 @@ struct ide_host {
 	unsigned int	(*init_chipset)(struct pci_dev *);
 	unsigned long	host_flags;
 	void		*host_priv;
+	ide_hwif_t	*cur_port;	/* for hosts requiring serialization */
 };
 
 /*
