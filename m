From: Alan Cox <alan@redhat.com>
Subject: PATCH: IDE - put back removed_hwif_ops ready for hotplug users
Date: Sun, 15 Aug 2004 10:44:08 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040815144408.GA7488@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:29144 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266726AbUHOOpB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Aug 2004 10:45:01 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide-iops.c linux-2.6.8-rc3/drivers/ide/ide-iops.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-iops.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-iops.c	2004-08-10 16:47:57.000000000 +0100
@@ -107,6 +107,74 @@
 EXPORT_SYMBOL(default_hwif_iops);
 
 /*
+ *	Conventional PIO operations for ATA devices
+ */
+
+static u8 ide_no_inb(unsigned long port)
+{
+	return 0xFF;
+}
+
+static u16 ide_no_inw (unsigned long port)
+{
+	return 0xFFFF;
+}
+
+static void ide_no_insw (unsigned long port, void *addr, u32 count)
+{
+}
+
+static u32 ide_no_inl (unsigned long port)
+{
+	return 0xFFFFFFFF;
+}
+
+static void ide_no_insl (unsigned long port, void *addr, u32 count)
+{
+}
+
+static void ide_no_outb (u8 val, unsigned long port)
+{
+}
+
+static void ide_no_outbsync (ide_drive_t *drive, u8 addr, unsigned long port)
+{
+}
+
+static void ide_no_outw (u16 val, unsigned long port)
+{
+}
+
+static void ide_no_outsw (unsigned long port, void *addr, u32 count)
+{
+}
+
+static void ide_no_outl (u32 val, unsigned long port)
+{
+}
+
+static void ide_no_outsl (unsigned long port, void *addr, u32 count)
+{
+}
+
+void removed_hwif_iops (ide_hwif_t *hwif)
+{
+	hwif->OUTB	= ide_no_outb;
+	hwif->OUTBSYNC	= ide_no_outbsync;
+	hwif->OUTW	= ide_no_outw;
+	hwif->OUTL	= ide_no_outl;
+	hwif->OUTSW	= ide_no_outsw;
+	hwif->OUTSL	= ide_no_outsl;
+	hwif->INB	= ide_no_inb;
+	hwif->INW	= ide_no_inw;
+	hwif->INL	= ide_no_inl;
+	hwif->INSW	= ide_no_insw;
+	hwif->INSL	= ide_no_insl;
+}
+
+EXPORT_SYMBOL(removed_hwif_iops);
+
+/*
  *	MMIO operations, typically used for SATA controllers
  */
 


Signed-off-by: Alan Cox <alan@redhat.com>


