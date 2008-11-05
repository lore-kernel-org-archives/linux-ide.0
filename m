From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #hibern_regress] libata: add missing dummy dmi_first_match()
Date: Wed, 05 Nov 2008 23:58:02 +0900
Message-ID: <4911B47A.2010409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54350 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139AbYKEO6b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Nov 2008 09:58:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Dummy dmi_first_match() definition for !CONFIG_DMI is missing.  Add it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/dmi.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index 6e20820..dbce0ce 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -51,6 +51,8 @@ extern int dmi_walk(void (*decode)(const struct dmi_header *));
 #else
 
 static inline int dmi_check_system(const struct dmi_system_id *list) { return 0; }
+static inline const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *list)
+	{ return NULL; }
 static inline const char * dmi_get_system_info(int field) { return NULL; }
 static inline const struct dmi_device * dmi_find_device(int type, const char *name,
 	const struct dmi_device *from) { return NULL; }
