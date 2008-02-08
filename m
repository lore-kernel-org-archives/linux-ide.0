From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/18] ide-generic: add ide_generic class and attribute for adding new interfaces
Date: Fri, 08 Feb 2008 01:45:37 +0100
Message-ID: <20080208004537.17746.56138.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:56846 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbYBHAb0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 19:31:26 -0500
Received: by py-out-1112.google.com with SMTP id u52so5202282pyb.10
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 16:31:26 -0800 (PST)
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Add ide_generic_sysfs_init() helper registering 'ide_generic' class
  (together with ide_generic_class_release() ->class_release method)
  and use it in ide_generic_init().

* Add "add" class attribute to 'ide_generic' class for adding new interfaces
  (it is intended to be a replacement for obsoleted "idex=base[,ctl[,irq]]"
  kernel parameters).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
+391 bytes (x86-32)

I also tried interface based on kernel parameters but it sucked
(more complex, bigger source code + resulting binary).

 drivers/ide/ide-generic.c |   78 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -1,17 +1,89 @@
 /*
  * generic/default IDE host driver
  *
- * Copyright (C) 2004 Bartlomiej Zolnierkiewicz
+ * Copyright (C) 2004, 2008 Bartlomiej Zolnierkiewicz
  * This code was split off from ide.c.  See it for original copyrights.
  *
  * May be copied or modified under the terms of the GNU General Public License.
  */
 
+/*
+ * For special cases new interfaces may be added using sysfs, i.e.
+ *
+ *	echo -n "0x168:0x36e:10" > /sys/class/ide_generic/add
+ *
+ * will add an interface using I/O ports 0x168-0x16f/0x36e and IRQ 10.
+ */
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/ide.h>
 
+#define DRV_NAME	"ide_generic"
+
+static ssize_t store_add(struct class *cls, const char *buf, size_t n)
+{
+	ide_hwif_t *hwif;
+	unsigned int base, ctl;
+	int irq;
+	hw_regs_t hw;
+	u8 idx[] = { 0xff, 0xff, 0xff, 0xff };
+
+	if (sscanf(buf, "%x:%x:%d", &base, &ctl, &irq) != 3)
+		return -EINVAL;
+
+	hwif = ide_find_port(base);
+	if (hwif == NULL)
+		return -ENOENT;
+
+	memset(&hw, 0, sizeof(hw));
+	ide_std_init_ports(&hw, base, ctl);
+	hw.irq = irq;
+	hw.chipset = ide_generic;
+
+	ide_init_port_hw(hwif, &hw);
+
+	idx[0] = hwif->index;
+
+	ide_device_add(idx, NULL);
+
+	return n;
+};
+
+static struct class_attribute ide_generic_class_attrs[] = {
+	__ATTR(add, S_IWUSR, NULL, store_add),
+	__ATTR_NULL
+};
+
+static void ide_generic_class_release(struct class *cls)
+{
+	kfree(cls);
+}
+
+static int __init ide_generic_sysfs_init(void)
+{
+	struct class *cls;
+	int rc;
+
+	cls = kzalloc(sizeof(*cls), GFP_KERNEL);
+	if (!cls)
+		return -ENOMEM;
+
+	cls->name = DRV_NAME;
+	cls->owner = THIS_MODULE;
+	cls->class_release = ide_generic_class_release;
+	cls->class_attrs = ide_generic_class_attrs;
+
+	rc = class_register(cls);
+	if (rc) {
+		kfree(cls);
+		return rc;
+	}
+
+	return 0;
+}
+
 static int __init ide_generic_init(void)
 {
 	u8 idx[MAX_HWIFS];
@@ -36,6 +108,10 @@ static int __init ide_generic_init(void)
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
 		ide_release_lock();	/* for atari only */
 
+	if (ide_generic_sysfs_init())
+		printk(KERN_ERR DRV_NAME ": failed to create ide_generic "
+					 "class\n");
+
 	return 0;
 }
 
