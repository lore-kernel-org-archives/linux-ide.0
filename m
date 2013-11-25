From: Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2] ata: Fix acpi_bus_get_device() return value check
Date: Mon, 25 Nov 2013 09:14:55 +0800
Message-ID: <1385342095-16924-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:54846 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab3KYBPf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Nov 2013 20:15:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Yijing Wang <wangyijing@huawei.com>, Hanjun Guo <guohanjun@huawei.com>

Since acpi_bus_get_device() returns plain int and not acpi_status,
ACPI_FAILURE() should not be used for checking its return value.  Fix
that.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>

---
v1->v2: remove the unused variable status found by linux-next kbuild test.

---
 drivers/ata/libata-zpodd.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 68f9e32..88949c6 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -88,15 +88,13 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 static bool odd_can_poweroff(struct ata_device *ata_dev)
 {
 	acpi_handle handle;
-	acpi_status status;
 	struct acpi_device *acpi_dev;
 
 	handle = ata_dev_acpi_handle(ata_dev);
 	if (!handle)
 		return false;
 
-	status = acpi_bus_get_device(handle, &acpi_dev);
-	if (ACPI_FAILURE(status))
+	if (acpi_bus_get_device(handle, &acpi_dev))
 		return false;
 
 	return acpi_device_can_poweroff(acpi_dev);
-- 
1.7.1


