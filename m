From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch] ata: libata: add per device private data
Date: Mon, 24 Sep 2007 16:23:14 -0700
Message-ID: <20070924162314.408ece21.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8422 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757935AbXIXX2G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Sep 2007 19:28:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Allow host controllers to store private data per device.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 include/linux/libata.h |    3 +++
 1 file changed, 3 insertions(+)

Index: libata-dev/include/linux/libata.h
===================================================================
--- libata-dev.orig/include/linux/libata.h	2007-09-24 16:13:33.000000000 -0700
+++ libata-dev/include/linux/libata.h	2007-09-24 16:15:24.000000000 -0700
@@ -474,6 +474,9 @@ struct ata_device {
 	/* error history */
 	struct ata_ering	ering;
 	int			spdn_cnt;
+
+	/* controller driver per device private data */
+	void 			*private_data;
 };
 
 /* Offset into struct ata_device.  Fields above it are maintained
