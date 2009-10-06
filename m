From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] sis5513: fix PIO setup for ATAPI devices
Date: Wed, 7 Oct 2009 00:27:35 +0200
Message-ID: <200910070027.35193.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933631AbZJFW21@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>, Joao Ramos <joao.ramos@inov.pt>, David Fries <david@fries.net>, d.stussy@yahoo.com, stable@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] sis5513: fix PIO setup for ATAPI devices

Clear prefetch setting before potentially (re-)enabling it in
config_drive_art_rwp() so the transition of the device type on
the port from ATA to ATAPI (i.e. during warm-plug operation)
is handled correctly.

This is a really old bug (it probably goes back to very early
days of the driver) but it was only affecting warm-plug operation
until the recent "ide: try to use PIO Mode 0 during probe if
possible" change (commit 6029336426a2b43e4bc6f4a84be8789a047d139e).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Joao Ramos <joao.ramos@inov.pt>
Cc: David Fries <david@fries.net>
Cc: d.stussy@yahoo.com
Cc: stable@kernel.org
---
Oh, if you're curious pata_sis doesn't have the bug but the fix
was never backported for some unknown reasons..

 drivers/ide/sis5513.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/drivers/ide/sis5513.c
===================================================================
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -2,7 +2,7 @@
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
  * Copyright (C) 2003		Vojtech Pavlik <vojtech@suse.cz>
- * Copyright (C) 2007		Bartlomiej Zolnierkiewicz
+ * Copyright (C) 2007-2009	Bartlomiej Zolnierkiewicz
  *
  * May be copied or modified under the terms of the GNU General Public License
  *
@@ -281,6 +281,8 @@ static void config_drive_art_rwp(ide_dri
 
 	pci_read_config_byte(dev, 0x4b, &reg4bh);
 
+	reg4bh &= ~(0x11 << drive->dn);
+
 	if (drive->media == ide_disk)
 		rw_prefetch = 0x11 << drive->dn;
 
