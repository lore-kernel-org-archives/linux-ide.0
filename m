From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] ide: remove IDE_ARCH_LOCK
Date: Tue, 27 Jan 2009 19:02:59 +0100
Message-ID: <20090127180259.28089.56908.sendpatchset@localhost.localdomain>
References: <20090127180246.28089.2981.sendpatchset@localhost.localdomain>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20090127180246.28089.2981.sendpatchset@localhost.localdomain>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitz@debian.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-m68k@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove IDE_ARCH_LOCK

* Add ->{get,release}_lock methods to struct ide_port_info
  and struct ide_host.

* Convert core IDE code, m68k IDE code and falconide support to use
  ->{get,release}_lock methods instead of ide_{get,release}_lock().

* Remove IDE_ARCH_LOCK.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@debian.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
We may also consider adding struct ide_host_ops later...

 drivers/ide/falconide.c |   25 +++++++++++++++++++++++--
 drivers/ide/ide-io.c    |    8 ++++----
 drivers/ide/ide-probe.c |    2 ++
 include/asm-m68k/ide.h  |   36 ------------------------------------
 include/linux/ide.h     |   16 ++++++++++------
 5 files changed, 39 insertions(+), 48 deletions(-)

Index: b/drivers/ide/falconide.c
===================================================================
--- a/drivers/ide/falconide.c
+++ b/drivers/ide/falconide.c
@@ -40,8 +40,27 @@
      *  which is shared between several drivers.
      */
 
-int falconide_intr_lock;
-EXPORT_SYMBOL(falconide_intr_lock);
+static int falconide_intr_lock;
+
+static void falconide_release_lock(void)
+{
+	if (falconide_intr_lock == 0) {
+		printk(KERN_ERR "%s: bug\n", __func__);
+		return;
+	}
+	falconide_intr_lock = 0;
+	stdma_release();
+}
+
+static void falconide_get_lock(irq_handler_t handler, void *data)
+{
+	if (falconide_intr_lock == 0) {
+		if (in_interrupt() > 0)
+			panic("Falcon IDE hasn't ST-DMA lock in interrupt");
+		stdma_lock(handler, data);
+		falconide_intr_lock = 1;
+	}
+}
 
 static void falconide_input_data(ide_drive_t *drive, struct request *rq,
 				 void *buf, unsigned int len)
@@ -81,6 +100,8 @@ static const struct ide_tp_ops falconide
 };
 
 static const struct ide_port_info falconide_port_info = {
+	.get_lock		= falconide_get_lock,
+	.release_lock		= falconide_release_lock,
 	.tp_ops			= &falconide_tp_ops,
 	.host_flags		= IDE_HFLAG_NO_DMA | IDE_HFLAG_SERIALIZE,
 };
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -498,8 +498,8 @@ static inline int ide_lock_host(struct i
 	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
 		rc = test_and_set_bit_lock(IDE_HOST_BUSY, &host->host_busy);
 		if (rc == 0) {
-			/* for atari only */
-			ide_get_lock(ide_intr, hwif);
+			if (host->get_lock)
+				host->get_lock(ide_intr, hwif);
 		}
 	}
 	return rc;
@@ -508,8 +508,8 @@ static inline int ide_lock_host(struct i
 static inline void ide_unlock_host(struct ide_host *host)
 {
 	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
-		/* for atari only */
-		ide_release_lock();
+		if (host->release_lock)
+			host->release_lock();
 		clear_bit_unlock(IDE_HOST_BUSY, &host->host_busy);
 	}
 }
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1320,6 +1320,8 @@ struct ide_host *ide_host_alloc(const st
 
 	if (d) {
 		host->init_chipset = d->init_chipset;
+		host->get_lock     = d->get_lock;
+		host->release_lock = d->release_lock;
 		host->host_flags = d->host_flags;
 	}
 
Index: b/include/asm-m68k/ide.h
===================================================================
--- a/include/asm-m68k/ide.h
+++ b/include/asm-m68k/ide.h
@@ -36,11 +36,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#ifdef CONFIG_ATARI
-#include <linux/interrupt.h>
-#include <asm/atari_stdma.h>
-#endif
-
 #ifdef CONFIG_MAC
 #include <asm/macints.h>
 #endif
@@ -92,36 +87,5 @@
 #define outsw_swapw(port, addr, n)	raw_outsw_swapw((u16 *)port, addr, n)
 #endif
 
-#ifdef CONFIG_BLK_DEV_FALCON_IDE
-#define IDE_ARCH_LOCK
-
-extern int falconide_intr_lock;
-
-static __inline__ void ide_release_lock (void)
-{
-	if (MACH_IS_ATARI) {
-		if (falconide_intr_lock == 0) {
-			printk("ide_release_lock: bug\n");
-			return;
-		}
-		falconide_intr_lock = 0;
-		stdma_release();
-	}
-}
-
-static __inline__ void
-ide_get_lock(irq_handler_t handler, void *data)
-{
-	if (MACH_IS_ATARI) {
-		if (falconide_intr_lock == 0) {
-			if (in_interrupt() > 0)
-				panic( "Falcon IDE hasn't ST-DMA lock in interrupt" );
-			stdma_lock(handler, data);
-			falconide_intr_lock = 1;
-		}
-	}
-}
-#endif /* CONFIG_BLK_DEV_FALCON_IDE */
-
 #endif /* __KERNEL__ */
 #endif /* _M68K_IDE_H */
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -202,12 +202,6 @@ static inline void ide_std_init_ports(hw
 
 #define MAX_HWIFS	10
 
-/* Currently only Atari needs it */
-#ifndef IDE_ARCH_LOCK
-# define ide_release_lock()			do {} while (0)
-# define ide_get_lock(hdlr, data)		do {} while (0)
-#endif /* IDE_ARCH_LOCK */
-
 /*
  * Now for the data we need to maintain per-drive:  ide_drive_t
  */
@@ -844,7 +838,12 @@ struct ide_host {
 	ide_hwif_t	*ports[MAX_HOST_PORTS + 1];
 	unsigned int	n_ports;
 	struct device	*dev[2];
+
 	int		(*init_chipset)(struct pci_dev *);
+
+	void		(*get_lock)(irq_handler_t, void *);
+	void		(*release_lock)(void);
+
 	unsigned long	host_flags;
 	void		*host_priv;
 	ide_hwif_t	*cur_port;	/* for hosts requiring serialization */
@@ -1355,7 +1354,12 @@ enum {
 
 struct ide_port_info {
 	char			*name;
+
 	int			(*init_chipset)(struct pci_dev *);
+
+	void			(*get_lock)(irq_handler_t, void *);
+	void			(*release_lock)(void);
+
 	void			(*init_iops)(ide_hwif_t *);
 	void                    (*init_hwif)(ide_hwif_t *);
 	int			(*init_dma)(ide_hwif_t *,
