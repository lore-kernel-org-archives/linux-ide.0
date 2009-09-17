From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream] libata: Fujitsu AMILO Pa 2510 can't do 64bit DMA
 either
Date: Fri, 18 Sep 2009 08:43:54 +0900
Message-ID: <4AB2C9BA.5040103@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48902 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbZIQXnt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Sep 2009 19:43:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, hhasselm@web.de

This is the third SB600 system which can't do 64bit DMA.  Add it to
blacklist.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Holger Hasselmann <hhasselm@web.de>
Cc: Shane Huang <Shane.Huang@amd.com>
---
This is bad because we can't backport this to -stable and broken 64bit
DMA makes these systems unusable for kernels released without the
following blacklisting.  I think we should disable 64bit DMA for
SB600s in -stable.  Any objections?  Shane?

 drivers/ata/ahci.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d4cd9c2..173a150 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2688,6 +2688,20 @@ static bool ahci_sb600_32bit_only(struct pci_dev *pdev)
 				DMI_MATCH(DMI_BOARD_NAME, "GA-MA69VM-S2"),
 			},
 		},
+		/*
+		 * This laptop can't do 64bit DMA either.  The latest
+		 * BIOS as of this writing (1.10c) doesn't fix the
+		 * problem either.
+		 *
+		 * http://thread.gmane.org/gmane.linux.ide/42716
+		 */
+		{
+			.ident = "Fujitsu AMILO Pa 2510",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pa 2510"),
+			},
+		},
 		{ }
 	};
 	const struct dmi_system_id *match;
