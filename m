From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] IDE-ACPI: One function call less in ide_get_dev_handle()
 after error detection
Date: Sat, 26 Dec 2015 11:15:42 +0100
Message-ID: <567E68CE.7030503@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <567E6799.5070802@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:50154 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbbLZKPu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Dec 2015 05:15:50 -0500
In-Reply-To: <567E6799.5070802@users.sourceforge.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 26 Dec 2015 10:01:36 +0100

The kfree() function was called in two cases by the
ide_get_dev_handle() function during error handling
even if the passed variable "dinfo" contained a null pointer.

* Let us return directly if a call of the function "ACPI_HANDLE"
  or "acpi_get_object_info" failed.

* Delete the explicit initialisation for the variables "dinfo" and "ret"
  at the beginning then.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ide/ide-acpi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index b694099..319b754 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -126,8 +126,8 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 	u64 addr;
 	acpi_handle dev_handle;
 	acpi_status status;
-	struct acpi_device_info	*dinfo = NULL;
-	int ret = -ENODEV;
+	struct acpi_device_info	*dinfo;
+	int ret;
 
 	bus = pdev->bus->number;
 	devnum = PCI_SLOT(pdev->devfn);
@@ -140,13 +140,13 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 	dev_handle = ACPI_HANDLE(dev);
 	if (!dev_handle) {
 		DEBPRINT("no acpi handle for device\n");
-		goto err;
+		return -ENODEV;
 	}
 
 	status = acpi_get_object_info(dev_handle, &dinfo);
 	if (ACPI_FAILURE(status)) {
 		DEBPRINT("get_object_info for device failed\n");
-		goto err;
+		return -ENODEV;
 	}
 	if (dinfo && (dinfo->valid & ACPI_VALID_ADR) &&
 	    dinfo->address == addr) {
@@ -157,13 +157,14 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 			" address: %llu, should be %u\n",
 			dinfo ? (unsigned long long)dinfo->address : -1ULL,
 			(unsigned int)addr);
-		goto err;
+		ret = -ENODEV;
+		goto free_info;
 	}
 
 	DEBPRINT("for dev=0x%x.%x, addr=0x%llx, *handle=0x%p\n",
 		 devnum, func, (unsigned long long)addr, *handle);
 	ret = 0;
-err:
+free_info:
 	kfree(dinfo);
 	return ret;
 }
-- 
2.6.3

