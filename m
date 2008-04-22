From: John Keller <jpk@sgi.com>
Subject: ide0: DISABLED, NO IRQ
Date: Tue, 22 Apr 2008 16:42:49 -0500 (CDT)
Message-ID: <200804222142.m3MLgoAx034693@fcbayern.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:42783 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752810AbYDVVmw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2008 17:42:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jpk@sgi.com

When running the latest -mm kernel on our ia64 SN simulator,
we are seeing the following error, which results in a failed boot.


Uniform Multi-Platform E-IDE driver
Unknown Chipset addr = 0x000000028c000000 @ 96938783, PC = 0xa000000100302420
ide0: DISABLED, NO IRQ
ide0: failed to initialize IDE interface
mice: PS/2 mouse device common for all mice
VFS: Cannot open root device "hda2" or unknown-block(0,0)
Please append a correct "root=" boot option; here are the available partitions:


-------------

We also see this error when booting real hardware (we did not see it
in the past), though the boot is successful in this case.

For what it's worth, the following hack allows our simulator to boot.
My knowledge of the ide code is little to none, so I don't claim this
is a real fix, but hopefully it will give some insight into what
the problem might be.


John Keller
jpk@sgi.com
-----------


Index: linux/drivers/ide/ide-generic.c
===================================================================
--- linux.orig/drivers/ide/ide-generic.c        2008-04-22 15:57:38.000000000 -0500
+++ linux/drivers/ide/ide-generic.c     2008-04-22 16:12:28.575628712 -0500
@@ -124,7 +124,9 @@ static int __init ide_generic_init(void)

                        memset(&hw, 0, sizeof(hw));
                        ide_std_init_ports(&hw, io_addr, io_addr + 0x206);
+#if 0          /* Don't set default irq value, so autoprobe will be done. */
                        hw.irq = ide_default_irq(io_addr);
+#endif
                        ide_init_port_hw(hwif, &hw);

                        idx[i] = i;
Index: linux/drivers/ide/ide.c
===================================================================
--- linux.orig/drivers/ide/ide.c        2008-04-22 15:57:38.000000000 -0500
+++ linux/drivers/ide/ide.c     2008-04-22 16:10:18.123372600 -0500
@@ -98,8 +98,11 @@ static void ide_port_init_devices_data(i
  */
 void ide_init_port_data(ide_hwif_t *hwif, unsigned int index)
 {
+#if 0  /* This is called multiple times for the same hwif,
+        * because ide_find_port() returns the same hwif. */
        /* bulk initialize hwif & drive info with zeros */
        memset(hwif, 0, sizeof(ide_hwif_t));
+#endif

        /* fill in any non-zero initial values */
        hwif->index     = index;

---------

Output when booting with the above hack....


Uniform Multi-Platform E-IDE driver
Medusa disk: 8-bit read from 01f7 = 50 {DISK}
hda: Generic 1234, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 224
hda: max request size: 128KiB
hda: 614400 sectors (314 MB) w/256KiB Cache, CHS=600/16/64
 hda: hda1 hda2
mice: PS/2 mouse device common for all mice
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 1888kB freed
bash-2.05b# 

