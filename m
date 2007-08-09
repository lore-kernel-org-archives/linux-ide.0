From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata-core: support wildcard matching in ata_blacklist_entry
Date: Thu, 9 Aug 2007 15:49:29 -0500
Message-ID: <20070809204929.GA24651@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56600 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbXHIUwm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Aug 2007 16:52:42 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, dmilburn@redhat.com

Support the use of '*' in model_num and model_rev entries
in ata_device_blacklist[].

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: David Milburn <dmilburn@redhat.com>
---

 libata-core.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 60e78be..4603bd9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3796,6 +3796,18 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ }
 };
 
+int strn_pattern_cmp(const char *patt, const char *name, int c)
+{
+	const char *p = strchr(patt, c);
+	int len;
+
+	if (p == NULL)
+		len = strlen(name);
+	else
+		len = p-patt;
+	return strncmp(patt, name, len);
+}
+
 static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
@@ -3806,10 +3818,10 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
 
 	while (ad->model_num) {
-		if (!strcmp(ad->model_num, model_num)) {
+		if (!strn_pattern_cmp(ad->model_num, model_num, '*')) {
 			if (ad->model_rev == NULL)
 				return ad->horkage;
-			if (!strcmp(ad->model_rev, model_rev))
+			if (!strn_pattern_cmp(ad->model_rev, model_rev, '*'))
 				return ad->horkage;
 		}
 		ad++;
