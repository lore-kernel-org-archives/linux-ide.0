From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: fix PMP initialization
Date: Thu, 15 Oct 2009 23:37:32 +0900
Message-ID: <4AD733AC.4020808@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41382 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757047AbZJOOia (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Oct 2009 10:38:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, ethanhsiao@jmicron.com, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Commit 842faa6c1a1d6faddf3377948e5cf214812c6c90 fixed error handling
during attach by not committing detected device class to dev->class
while attaching a new device.  However, this change missed the PMP
class check in the configuration loop causing a new PMP device to go
through ata_dev_configure() as if it were an ATA or ATAPI device.

As PMP device doesn't have a regular IDENTIFY data, this makes
ata_dev_configure() tries to configure a PMP device using an invalid
data.  For the most part, it wasn't too harmful and went unnoticed but
this ends up clearing dev->flags which may have ATA_DFLAG_AN set by
sata_pmp_attach().  This means that SATA_PMP_FEAT_NOTIFY ends up being
disabled on PMPs and on PMPs which honor the flag breaks hotplug
support.

This problem was discovered and reported by Ethan Hsiao.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Ethan Hsiao <ethanhsiao@jmicron.com>
Cc: stable@kernel.org
---
 drivers/ata/libata-eh.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0a97822..bba2ae5 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2981,12 +2981,14 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	 * device detection messages backwards.
 	 */
 	ata_for_each_dev(dev, link, ALL) {
-		if (!(new_mask & (1 << dev->devno)) ||
-		    dev->class == ATA_DEV_PMP)
+		if (!(new_mask & (1 << dev->devno)))
 			continue;

 		dev->class = ehc->classes[dev->devno];

+		if (dev->class == ATA_DEV_PMP)
+			continue;
+
 		ehc->i.flags |= ATA_EHI_PRINTINFO;
 		rc = ata_dev_configure(dev);
 		ehc->i.flags &= ~ATA_EHI_PRINTINFO;
