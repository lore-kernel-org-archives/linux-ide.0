From: Tony Vroon <chainsaw@gentoo.org>
Subject: [PATCH 2.6.22] Add LED trigger to libata core
Date: Sun, 18 Mar 2007 17:06:05 +0000 (GMT)
Message-ID: <20070318170605.3751D5B80F1@ganymede.vroon.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganymede.vroon.org ([195.66.242.11]:48456 "EHLO
	ganymede.vroon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbXCRRX6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 13:23:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

This duplicates the IDE core LED trigger in the libata core.
I plan to use this by allowing PMU LED control on G5 towers. My test platform 
is a PowerMac 7,3 (Dual G5 2.0GHz, June 2004) with a K2 (sata_svw) controller.

Signed-off-by: Tony Vroon <chainsaw@gentoo.org>

--- linux-2.6/drivers/ata/libata-scsi.c.orig	2007-03-17 22:53:56.000000000 +0000
+++ linux-2.6/drivers/ata/libata-scsi.c	2007-03-17 22:53:15.000000000 +0000
@@ -46,6 +46,7 @@
 #include <linux/libata.h>
 #include <linux/hdreg.h>
 #include <asm/uaccess.h>
+#include <linux/leds.h>
 
 #include "libata.h"
 
@@ -2791,6 +2792,7 @@
 				      struct ata_device *dev)
 {
 	int rc = 0;
+	ledtrig_ide_activity();
 
 	if (unlikely(!scmd->cmd_len)) {
 		ata_dev_printk(dev, KERN_WARNING, "WARNING: zero len CDB\n");
