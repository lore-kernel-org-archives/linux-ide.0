From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Put the new API functions in the header files
Date: Fri, 05 Nov 2004 16:32:50 +0000
Message-ID: <1099672368.5630.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:10693 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262735AbUKERfp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:35:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/include/linux/ide.h linux-2.6.10rc1/include/linux/ide.h
--- linux.vanilla-2.6.10rc1/include/linux/ide.h	2004-11-05 15:42:18.000000000 +0000
+++ linux-2.6.10rc1/include/linux/ide.h	2004-11-05 16:26:18.000000000 +0000
@@ -266,6 +266,7 @@
  * Register new hardware with ide
  */
 int ide_register_hw(hw_regs_t *hw, struct hwif_s **hwifp);
+int ide_register_hw_with_fixup(hw_regs_t *hw, struct hwif_s **hwifp, void (*fixup)(struct hwif_s *));
 
 /*
  * Set up hw_regs_t structure before calling ide_register_hw (optional)
@@ -1470,6 +1475,7 @@
 	void			(*init_iops)(ide_hwif_t *);
 	void                    (*init_hwif)(ide_hwif_t *);
 	void			(*init_dma)(ide_hwif_t *, unsigned long);
+	void			(*fixup)(ide_hwif_t *);
 	u8			channels;
 	u8			autodma;
 	ide_pci_enablebit_t	enablebits[2];
@@ -1529,6 +1535,8 @@
 extern void ide_unregister (unsigned int index);
 
 extern int probe_hwif_init(ide_hwif_t *);
+extern int probe_hwif_init_with_fixup(ide_hwif_t *hwif, void (*fixup)(ide_hwif_t *hwif));
+extern void ide_undecoded_slave(ide_hwif_t *hwif);
 
 static inline void *ide_get_hwifdata (ide_hwif_t * hwif)
 {

