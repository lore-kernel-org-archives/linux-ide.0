From: Alan Cox <alan@redhat.com>
Subject: PATCH: convert pci ide support to new locking
Date: Sun, 15 Aug 2004 11:17:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040815151746.GA16059@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266753AbUHOPYX@vger.kernel.org>
Content-Disposition: inline
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
List-Id: linux-ide@vger.kernel.org

Actually more like "to actually have any locking". Also add a helper for
PCI unregister.


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/setup-pci.c linux-2.6.8-rc3/drivers/ide/setup-pci.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/setup-pci.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/setup-pci.c	2004-08-12 17:55:34.000000000 +0100
@@ -1,7 +1,8 @@
 /*
- *  linux/drivers/ide/setup-pci.c		Version 1.10	2002/08/19
+ *  linux/drivers/ide/setup-pci.c		Version 1.14	2004/08/10
  *
  *  Copyright (c) 1998-2000  Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (c) 2004 Red Hat <alan@redhat.com>
  *
  *  Copyright (c) 1995-1998  Mark Lord
  *  May be copied or modified under the terms of the GNU General Public License
@@ -11,6 +12,7 @@
  *	Use pci_set_master
  *	Fix misreporting of I/O v MMIO problems
  *	Initial fixups for simplex devices
+ *	Hot unplug paths
  */
 
 /*
@@ -42,7 +44,7 @@
  *	Match a PCI IDE port against an entry in ide_hwifs[],
  *	based on io_base port if possible. Return the matching hwif,
  *	or a new hwif. If we find an error (clashing, out of devices, etc)
- *	return NULL
+ *	return NULL. The caller must hold the ide_cfg_sem.
  *
  *	FIXME: we need to handle mmio matches here too
  */
@@ -87,6 +89,8 @@
 	 *
 	 * Unless there is a bootable card that does not use the standard
 	 * ports 1f0/170 (the ide0/ide1 defaults). The (bootable) flag.
+	 *
+	 * FIXME: migrate use of ide_unknown to also use ->configured
 	 */
 	if (bootable) {
 		for (h = 0; h < MAX_HWIFS; ++h) {
@@ -435,8 +439,18 @@
 		ctl = port ? 0x374 : 0x3f4;
 		base = port ? 0x170 : 0x1f0;
 	}
+	
+	/*
+	 * Protect against a hwif being unloaded as we attach to it
+	 */
+	down(&ide_cfg_sem);
+	
 	if ((hwif = ide_match_hwif(base, d->bootable, d->name)) == NULL)
+	{
+		up(&ide_cfg_sem);
 		return NULL;	/* no room in ide_hwifs[] */
+	}
+	
 	if (hwif->io_ports[IDE_DATA_OFFSET] != base ||
 	    hwif->io_ports[IDE_CONTROL_OFFSET] != (ctl | 2)) {
 		memset(&hwif->hw, 0, sizeof(hwif->hw));
@@ -448,6 +462,9 @@
 	hwif->pci_dev = dev;
 	hwif->cds = (struct ide_pci_device_s *) d;
 	hwif->channel = port;
+	hwif->configured = 1;
+	
+	up(&ide_cfg_sem);
 
 	if (!hwif->irq)
 		hwif->irq = irq;
@@ -762,6 +779,53 @@
 
 EXPORT_SYMBOL_GPL(ide_setup_pci_devices);
 
+/**
+ *	ide_pci_remove_hwifs	-	remove PCI interfaces
+ *	@dev: PCI device
+ *
+ *	Remove any hwif attached to this PCI device. This will call
+ *	back the various hwif->remove functions. In order to get the
+ *	best results when delays occur we kill the iops before we
+ *	potentially start blocking for long periods untangling the
+ *	IDE layer.
+ *
+ *	Takes the ide_cfg_sem in order to protect against races with
+ *	new/old hwifs. Calls functions that take all the other locks
+ *	so should be called with no locks held.
+ */
+ 
+void ide_pci_remove_hwifs(struct pci_dev *dev)
+{
+	int i;
+	ide_hwif_t *hwif = ide_hwifs;
+
+	down(&ide_cfg_sem);
+#if 0
+	for(i = 0; i < MAX_HWIFS; i++)
+	{
+		if(hwif->configured && hwif->pci_dev == dev)
+		{
+			removed_hwif_iops(hwif);
+		}
+		i++;
+		hwif++;
+	}
+#endif
+	hwif = ide_hwifs;
+	
+	for(i = 0; i < MAX_HWIFS; i++)
+	{
+		if(hwif->configured && hwif->pci_dev == dev)
+			__ide_unregister_hwif(hwif);
+		i++;
+		hwif++;
+	}
+	up(&ide_cfg_sem);
+}
+
+EXPORT_SYMBOL_GPL(ide_pci_remove_hwifs);
+
+
 /*
  *	Module interfaces
  */
