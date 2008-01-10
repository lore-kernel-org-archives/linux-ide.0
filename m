From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata-pmp: propagate timeout to host link
Date: Thu, 10 Jan 2008 13:41:23 +0900
Message-ID: <4785A1F3.1090903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:17272 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbYAJElb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 23:41:31 -0500
Received: by rv-out-0910.google.com with SMTP id k20so447276rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 20:41:28 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Timeout on downstream command may indicate transmission problem on
host link.  Propagate timeouts to host link.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f0124a8..74269ed 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1733,11 +1733,15 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		ehc->i.action &= ~ATA_EH_PERDEV_MASK;
 	}
 
-	/* consider speeding down */
+	/* propagate timeout to host link */
+	if ((all_err_mask & AC_ERR_TIMEOUT) && !ata_is_host_link(link))
+		ap->link.eh_context.i.err_mask |= AC_ERR_TIMEOUT;
+
+	/* record error and consider speeding down */
 	dev = ehc->i.dev;
-	if (!dev && ata_link_max_devices(link) == 1 &&
-	    ata_dev_enabled(link->device))
-		dev = link->device;
+	if (!dev && ((ata_link_max_devices(link) == 1 &&
+		      ata_dev_enabled(link->device))))
+	    dev = link->device;
 
 	if (dev)
 		ehc->i.action |= ata_eh_speed_down(dev, is_io, all_err_mask);
@@ -1759,8 +1763,14 @@ void ata_eh_autopsy(struct ata_port *ap)
 {
 	struct ata_link *link;
 
-	__ata_port_for_each_link(link, ap)
+	ata_port_for_each_link(link, ap)
 		ata_eh_link_autopsy(link);
+
+	/* Autopsy of fanout ports can affect host link autopsy.
+	 * Perform host link autopsy last.
+	 */
+	if (ap->nr_pmp_links)
+		ata_eh_link_autopsy(&ap->link);
 }
 
 /**
