From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: [PATCH] namespace pollution in ide-probe.c
Date: Thu, 19 Dec 2002 01:12:02 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200212190112.02404.arnd@bergmann-dalldorf.de>
References: <200212190106.47973.arnd@bergmann-dalldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <200212190106.47973.arnd@bergmann-dalldorf.de>
List-Id: linux-ide@vger.kernel.org
To: kernel-janitor-discuss@lists.sourceforge.net
Cc: Trivial Patches <trivial@rustcorp.com.au>, linux-ide@vger.kernel.org

The function init_irq is only used in ide-probe.c, so it should
better be static.
===== drivers/ide/ide-probe.c 1.30 vs edited =====
--- 1.30/drivers/ide/ide-probe.c	Mon Dec  2 19:19:20 2002
+++ edited/drivers/ide/ide-probe.c	Wed Dec 18 18:00:31 2002
@@ -848,7 +848,7 @@
  * but anything else has led to problems on some machines.  We re-enable
  * interrupts as much as we can safely do in most places.
  */
-int init_irq (ide_hwif_t *hwif)
+static int init_irq (ide_hwif_t *hwif)
 {
 	unsigned long flags;
 	unsigned int index;
@@ -993,8 +993,6 @@
 	printk("\n");
 	return 0;
 }
-
-EXPORT_SYMBOL(init_irq);
 
 static int ata_lock(dev_t dev, void *data)
 {


