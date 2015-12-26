From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] IDE-ACPI: Delete unnecessary null pointer checks in
 ide_get_dev_handle()
Date: Sat, 26 Dec 2015 11:17:35 +0100
Message-ID: <567E693F.4040909@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <567E6799.5070802@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:63281 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbbLZKRt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Dec 2015 05:17:49 -0500
In-Reply-To: <567E6799.5070802@users.sourceforge.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 26 Dec 2015 10:33:48 +0100

The variable "dinfo" will contain an appropropriate pointer after a call
of the acpi_get_object_info() function succeeded.
Thus remove two safety checks.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ide/ide-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 319b754..b6b2111 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -148,14 +148,14 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 		DEBPRINT("get_object_info for device failed\n");
 		return -ENODEV;
 	}
-	if (dinfo && (dinfo->valid & ACPI_VALID_ADR) &&
+	if ((dinfo->valid & ACPI_VALID_ADR) &&
 	    dinfo->address == addr) {
 		*pcidevfn = addr;
 		*handle = dev_handle;
 	} else {
 		DEBPRINT("get_object_info for device has wrong "
 			" address: %llu, should be %u\n",
-			dinfo ? (unsigned long long)dinfo->address : -1ULL,
+			(unsigned long long)dinfo->address,
 			(unsigned int)addr);
 		ret = -ENODEV;
 		goto free_info;
-- 
2.6.3

