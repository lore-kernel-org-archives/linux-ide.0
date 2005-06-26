From: maximilian attems <janitor@sternwelten.at>
Subject: [patch 3/13] ide hotplug mark __devinit cmd640.c
Date: Sun, 26 Jun 2005 18:46:12 +0200
Message-ID: <20050626164612.GJ12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:58551 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261457AbVFZRFC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:05:02 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
  
  
mark the __init section __devinit.
Splitted up from the Debian kernel patch. 


Signed-off-by: maximilian attems <janitor@sternwelten.at>


diff -aurN a/drivers/ide/pci/cmd640.c b/drivers/ide/pci/cmd640.c
--- a/drivers/ide/pci/cmd640.c	2005-06-06 11:22:29.000000000 -0400
+++ b/drivers/ide/pci/cmd640.c	2005-06-15 22:01:23.000000000 -0400
@@ -278,7 +278,7 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
-static int __init match_pci_cmd640_device (void)
+static int __devinit match_pci_cmd640_device (void)
 {
 	const u8 ven_dev[4] = {0x95, 0x10, 0x40, 0x06};
 	unsigned int i;
@@ -298,7 +298,7 @@
 /*
  * Probe for CMD640x -- pci method 1
  */
-static int __init probe_for_cmd640_pci1 (void)
+static int __devinit probe_for_cmd640_pci1 (void)
 {
 	__get_cmd640_reg = get_cmd640_reg_pci1;
 	__put_cmd640_reg = put_cmd640_reg_pci1;
@@ -314,7 +314,7 @@
 /*
  * Probe for CMD640x -- pci method 2
  */
-static int __init probe_for_cmd640_pci2 (void)
+static int __devinit probe_for_cmd640_pci2 (void)
 {
 	__get_cmd640_reg = get_cmd640_reg_pci2;
 	__put_cmd640_reg = put_cmd640_reg_pci2;
@@ -328,7 +328,7 @@
 /*
  * Probe for CMD640x -- vlb
  */
-static int __init probe_for_cmd640_vlb (void)
+static int __devinit probe_for_cmd640_vlb (void)
 {
 	u8 b;
 
@@ -349,7 +349,7 @@
  *  Returns 1 if an IDE interface/drive exists at 0x170,
  *  Returns 0 otherwise.
  */
-static int __init secondary_port_responding (void)
+static int __devinit secondary_port_responding (void)
 {
 	unsigned long flags;
 
@@ -392,7 +392,7 @@
  * Check whether prefetch is on for a drive,
  * and initialize the unmask flags for safe operation.
  */
-static void __init check_prefetch (unsigned int index)
+static void __devinit check_prefetch (unsigned int index)
 {
 	ide_drive_t *drive = cmd_drives[index];
 	u8 b = get_cmd640_reg(prefetch_regs[index]);
@@ -413,7 +413,7 @@
 /*
  * Figure out which devices we control
  */
-static void __init setup_device_ptrs (void)
+static void __devinit setup_device_ptrs (void)
 {
 	unsigned int i;
 
@@ -495,7 +495,7 @@
 /*
  * This routine retrieves the initial drive timings from the chipset.
  */
-static void __init retrieve_drive_counts (unsigned int index)
+static void __devinit retrieve_drive_counts (unsigned int index)
 {
 	u8 b;
 
@@ -716,7 +716,7 @@
 /*
  * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
  */
-int __init ide_probe_for_cmd640x (void)
+int __devinit ide_probe_for_cmd640x (void)
 {
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	int second_port_toggled = 0;
