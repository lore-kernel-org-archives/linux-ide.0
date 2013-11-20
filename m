From: Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 3/4] ata: Fix acpi_bus_get_device() return value check
Date: Wed, 20 Nov 2013 17:28:25 +0800
Message-ID: <1384939706-6292-4-git-send-email-wangyijing@huawei.com>
References: <1384939706-6292-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:8375 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab3KTJaW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Nov 2013 04:30:22 -0500
In-Reply-To: <1384939706-6292-1-git-send-email-wangyijing@huawei.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Yijing Wang <wangyijing@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Since acpi_bus_get_device() returns plain int and not acpi_status,
ACPI_FAILURE() should not be used for checking its return value.  Fix
that.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/libata-zpodd.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 68f9e32..3d9f82d 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -95,8 +95,7 @@ static bool odd_can_poweroff(struct ata_device *ata_dev)
 	if (!handle)
 		return false;
 
-	status = acpi_bus_get_device(handle, &acpi_dev);
-	if (ACPI_FAILURE(status))
+	if (acpi_bus_get_device(handle, &acpi_dev))
 		return false;
 
 	return acpi_device_can_poweroff(acpi_dev);
-- 
1.7.1


