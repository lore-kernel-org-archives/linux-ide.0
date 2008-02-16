From: Martin Michlmayr <tbm@cyrius.com>
Subject: [PATCH] sata_mv: Define module alias for platform device
Date: Sat, 16 Feb 2008 18:15:27 +0100
Message-ID: <20080216171527.GA2552@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:2697 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755223AbYBPRPg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Feb 2008 12:15:36 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

The sata_mv driver can be loaded as a platform device, as is done by
various Orion (ARM) based devices.  The driver needs to define a module
alias for the platform driver so udev will load it automatically.
Tested with Debian on a QNAP TS-209.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3198,6 +3198,7 @@ MODULE_DESCRIPTION("SCSI low-level driver for Marvell SATA controllers");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS("platform:sata_mv");
 
 #ifdef CONFIG_PCI
 module_param(msi, int, 0444);

-- 
Martin Michlmayr
http://www.cyrius.com/
