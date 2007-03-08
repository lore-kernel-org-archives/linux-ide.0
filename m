From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH]: libata-core: Add support for ATA_HORKAGE_DIAGNOSTIC
Date: Thu, 8 Mar 2007 23:18:04 +0000
Message-ID: <20070308231804.110f76a0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55743 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030715AbXCHWN7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:13:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

If we find the device has broken diagnostics then don't report this if we
expect it to. Needed for the Gigabyte i-RAM.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-core.c linux-2.6.21-rc3-mm2/drivers/ata/libata-core.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-core.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/libata-core.c	2007-03-08 16:02:52.000000000 +0000
@@ -1751,7 +1765,7 @@
 		/* Let the user know. We don't want to disallow opens for
 		   rescue purposes, or in case the vendor is just a blithering
 		   idiot */
-                if (print_info) {
+                if (print_info && !(ata_device_blacklisted(dev) & ATA_HORKAGE_DIAGNOSTIC)) {
 			ata_dev_printk(dev, KERN_WARNING,
 "Drive reports diagnostics failure. This may indicate a drive\n");
 			ata_dev_printk(dev, KERN_WARNING,

