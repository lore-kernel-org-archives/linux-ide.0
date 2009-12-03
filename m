From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/6] sis5513: remove stale TODO
Date: Thu, 03 Dec 2009 20:52:28 +0100
Message-ID: <20091203195228.9093.40016.sendpatchset@localhost>
References: <20091203195145.9093.88261.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756807AbZLCTxV@vger.kernel.org>
In-Reply-To: <20091203195145.9093.88261.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] sis5513: remove stale TODO

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/sis5513.c |    9 ---------
 1 file changed, 9 deletions(-)

Index: b/drivers/ide/sis5513.c
===================================================================
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -632,12 +632,3 @@ module_exit(sis5513_ide_exit);
 MODULE_AUTHOR("Lionel Bouton, L C Chang, Andre Hedrick, Vojtech Pavlik");
 MODULE_DESCRIPTION("PCI driver module for SIS IDE");
 MODULE_LICENSE("GPL");
-
-/*
- * TODO:
- *	- CLEANUP
- *	- More checks in the config registers (force values instead of
- *	  relying on the BIOS setting them correctly).
- *	- Further optimisations ?
- *	  . for example ATA66+ regs 0x48 & 0x4A
- */
