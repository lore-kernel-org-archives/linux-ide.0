From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] ata: Don't require newlines for link_power_management_policy
Date: Tue, 17 Nov 2009 11:09:03 -0500
Message-ID: <1258474143-3020-1-git-send-email-mjg@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58111 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbZKQQKS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 11:10:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, Matthew Garrett <mjg@redhat.com>

sysfs attributes shouldn't require newlines. Make it possible to set the
link power management policy without a trailing newline.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/ata/libata-scsi.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b4ee28d..512a3ee 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -154,8 +154,7 @@ static ssize_t ata_scsi_lpm_put(struct device *dev,
 	 */
 	for (i = 1; i < ARRAY_SIZE(link_pm_policy); i++) {
 		const int len = strlen(link_pm_policy[i].name);
-		if (strncmp(link_pm_policy[i].name, buf, len) == 0 &&
-		   buf[len] == '\n') {
+		if (strncmp(link_pm_policy[i].name, buf, len) == 0) {
 			policy = link_pm_policy[i].value;
 			break;
 		}
-- 
1.6.5.2

