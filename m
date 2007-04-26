From: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>
Subject: [PATCH] use mutex instead of semaphore in IDE driver
Date: Thu, 26 Apr 2007 11:20:32 +0200
Message-ID: <20070426092032.GB6468@traven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932247AbXDZJRj@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

the IDE driver uses a semaphore as mutex. use the mutex API instead of
the (binary) semaphore

Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>

--
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 8f15c23..34f79a5 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1025,7 +1025,7 @@ static int init_irq (ide_hwif_t *hwif)
 	BUG_ON(irqs_disabled());	
 	BUG_ON(hwif == NULL);
 
-	down(&ide_cfg_sem);
+	mutex_lock(&ide_cfg_mtx);
 	hwif->hwgroup = NULL;
 #if MAX_HWIFS > 1
 	/*
@@ -1154,7 +1154,7 @@ static int init_irq (ide_hwif_t *hwif)
 		printk(" (%sed with %s)",
 			hwif->sharing_irq ? "shar" : "serializ", match->name);
 	printk("\n");
-	up(&ide_cfg_sem);
+	mutex_unlock(&ide_cfg_mtx);
 	return 0;
 out_unlink:
 	spin_lock_irq(&ide_lock);
@@ -1177,7 +1177,7 @@ out_unlink:
 	}
 	spin_unlock_irq(&ide_lock);
 out_up:
-	up(&ide_cfg_sem);
+	mutex_unlock(&ide_cfg_mtx);
 	return 1;
 }
 
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index ae5bf2b..0a05799 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -170,7 +170,7 @@ static int idebus_parameter;	/* holds the "idebus=" parameter */
 static int system_bus_speed;	/* holds what we think is VESA/PCI bus speed */
 static int initializing;	/* set while initializing built-in drivers */
 
-DECLARE_MUTEX(ide_cfg_sem);
+DEFINE_MUTEX(ide_cfg_mtx);
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(ide_lock);
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
@@ -573,7 +573,7 @@ void ide_unregister(unsigned int index)
 {
 	ide_drive_t *drive;
 	ide_hwif_t *hwif, *g;
-	static ide_hwif_t tmp_hwif; /* protected by ide_cfg_sem */
+	static ide_hwif_t tmp_hwif; /* protected by ide_cfg_mtx */
 	ide_hwgroup_t *hwgroup;
 	int irq_count = 0, unit;
 
@@ -581,7 +581,7 @@ void ide_unregister(unsigned int index)
 
 	BUG_ON(in_interrupt());
 	BUG_ON(irqs_disabled());
-	down(&ide_cfg_sem);
+	mutex_lock(&ide_cfg_mtx);
 	spin_lock_irq(&ide_lock);
 	hwif = &ide_hwifs[index];
 	if (!hwif->present)
@@ -688,7 +688,7 @@ void ide_unregister(unsigned int index)
 
 abort:
 	spin_unlock_irq(&ide_lock);
-	up(&ide_cfg_sem);
+	mutex_unlock(&ide_cfg_mtx);
 }
 
 EXPORT_SYMBOL(ide_unregister);
diff --git a/include/linux/ide.h b/include/linux/ide.h
index d3bbc71..aeac9f1 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1378,11 +1378,11 @@ extern const ide_pio_timings_t ide_pio_timings[6];
 
 
 extern spinlock_t ide_lock;
-extern struct semaphore ide_cfg_sem;
+extern struct mutex ide_cfg_mtx;
 /*
  * Structure locking:
  *
- * ide_cfg_sem and ide_lock together protect changes to
+ * ide_cfg_mtx and ide_lock together protect changes to
  * ide_hwif_t->{next,hwgroup}
  * ide_drive_t->next
  *

-- 
Matthias Kaehlcke
Linux Application Developer
Barcelona

               If sharing a thing in no way diminishes it,
               it is not rightly owned if it is not shared
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
