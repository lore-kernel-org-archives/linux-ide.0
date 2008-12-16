From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/9] ide: update ide_unregister() documentation
Date: Tue, 16 Dec 2008 20:31:37 +0100
Message-ID: <20081216193137.3959.70339.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:33945 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbYLPTbr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 14:31:47 -0500
Received: by bwz14 with SMTP id 14so4417970bwz.13
        for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 11:31:45 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: update ide_unregister() documentation

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
just a couple of cleanups, should be applied on a top of Sunday's patchset
[ http://marc.info/?l=linux-kernel&m=122921159918716&w=2 ]

 drivers/ide/ide.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -155,22 +155,14 @@ EXPORT_SYMBOL_GPL(ide_port_unregister_de
  *	ide_unregister		-	free an IDE interface
  *	@hwif: IDE interface
  *
- *	Perform the final unregister of an IDE interface. At the moment
- *	we don't refcount interfaces so this will also get split up.
+ *	Perform the final unregister of an IDE interface.
  *
  *	Locking:
- *	The caller must not hold the IDE locks
- *	The drive present/vanishing is not yet properly locked
- *	Take care with the callbacks. These have been split to avoid
- *	deadlocking the IDE layer. The shutdown callback is called
- *	before we take the lock and free resources. It is up to the
- *	caller to be sure there is no pending I/O here, and that
- *	the interface will not be reopened (present/vanishing locking
- *	isn't yet done BTW). After we commit to the final kill we
- *	call the cleanup callback with the ide locks held.
+ *	The caller must not hold the IDE locks.
  *
- *	Unregister restores the hwif structures to the default state.
- *	This is raving bonkers.
+ *	It is up to the caller to be sure there is no pending I/O here,
+ *	and that the interface will not be reopened (present/vanishing
+ *	locking isn't yet done BTW).
  */
 
 void ide_unregister(ide_hwif_t *hwif)
