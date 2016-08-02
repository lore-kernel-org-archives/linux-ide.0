From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0249/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:53:10 +0800
Message-ID: <20160802105310.30339-1-baolex.ni@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:28976 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755858AbcHBLgZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2016 07:36:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net, linux@roeck-us.net, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aduggan@synaptics.com, dianders@chromium.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/ide/ide-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-sysfs.c b/drivers/ide/ide-sysfs.c
index 84a6a9e..a210338a 100644
--- a/drivers/ide/ide-sysfs.c
+++ b/drivers/ide/ide-sysfs.c
@@ -65,9 +65,9 @@ static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 	ide_drive_t *drive = to_ide_device(dev);
 	return sprintf(buf, "%s\n", (char *)&drive->id[ATA_ID_SERNO]);
 }
-static DEVICE_ATTR(serial, 0400, serial_show, NULL);
+static DEVICE_ATTR(serial, S_IRUSR, serial_show, NULL);
 
-static DEVICE_ATTR(unload_heads, 0644, ide_park_show, ide_park_store);
+static DEVICE_ATTR(unload_heads, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, ide_park_show, ide_park_store);
 
 static struct attribute *ide_attrs[] = {
 	&dev_attr_media.attr,
-- 
2.9.2

