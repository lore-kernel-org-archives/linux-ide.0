From: Ryan Power <rpower@sysreset.com>
Subject: [PATCH 2.6.22.1] libata: Adjust libata to ignore errors after
  spinup
Date: Sun, 15 Jul 2007 21:28:39 -0600
Message-ID: <6.2.0.14.2.20070715210841.02fcab90@linux.sysreset.com>
References: <6.2.0.14.2.20070713000748.031a2660@linux.sysreset.com>
 <469775E0.2000609@rtr.ca>
 <6.2.0.14.2.20070713184231.02db2d20@linux.sysreset.com>
 <46982875.60503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.sysreset.com ([209.97.229.250]:10577 "EHLO sysreset"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759629AbXGPD2s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Jul 2007 23:28:48 -0400
In-Reply-To: <46982875.60503@rtr.ca>
References: <6.2.0.14.2.20070713000748.031a2660@linux.sysreset.com>
 <469775E0.2000609@rtr.ca>
 <6.2.0.14.2.20070713184231.02db2d20@linux.sysreset.com>
 <46982875.60503@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org

From: Ryan Power <rpower@sysreset.com>

Adjust libata to ignore errors after spinup

This patch is to ignore errors from the spinup attempt if the drive is
in the "standby id" state.

Signed-off-by: Ryan Power <rpower@sysreset.com>

---

Index: drivers.new/ata/libata-core.c
--- drivers/ata/libata-core.c   2007-07-10 12:56:30.000000000 -0600
+++ drivers.new/ata/libata-core.c       2007-07-15 01:58:49.000000000 -0600
@@ -1750,7 +1750,7 @@ int ata_dev_read_id(struct ata_device *d
                 tf.protocol = ATA_PROT_NODATA;
                 tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
                 err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, 
NULL, 0);
-               if (err_mask) {
+               if (err_mask && id[2] != 0x738c) {
                         rc = -EIO;
                         reason = "SPINUP failed";
                         goto err_out;


