From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata-core: support wildcard matching in ata_blacklist_entry
Date: Wed, 8 Aug 2007 15:20:57 -0500
Message-ID: <20070808202057.GA23314@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48406 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935296AbXHHUYE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Aug 2007 16:24:04 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, dmilburn@redhat.com

Support the use of '*' in model_num and model_rev entries
in ata_device_blacklist[].

CC: alan@lxorguk.ukuu.org.uk
Signed-off-by: David Milburn <dmilburn@redhat.com>
---

 drivers/ata/libata-core.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 60e78be..1c9c208 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3806,10 +3806,17 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
 
 	while (ad->model_num) {
-		if (!strcmp(ad->model_num, model_num)) {
+		char *wc;
+		wc = strchr(ad->model_num, '*');
+		if (!strncmp(ad->model_num, model_num, 
+			     wc ? wc - ad->model_num : 
+			     strlen(ad->model_num))) {
 			if (ad->model_rev == NULL)
 				return ad->horkage;
-			if (!strcmp(ad->model_rev, model_rev))
+			wc = strchr(ad->model_rev, '*');
+			if (!strncmp(ad->model_rev, model_rev,
+				     wc ? wc - ad->model_rev : 
+				     strlen(ad->model_rev)))
 				return ad->horkage;
 		}
 		ad++;



