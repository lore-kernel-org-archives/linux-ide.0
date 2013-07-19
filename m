From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] ide: replace strict_strtol() with kstrtol()
Date: Fri, 19 Jul 2013 16:01:26 +0900
Message-ID: <000b01ce844d$c9735490$5c59fdb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:29094 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab3GSHB2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jul 2013 03:01:28 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQ600L7L8SNYDU0@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Fri, 19 Jul 2013 16:01:27 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

The usage of strict_strtol() is not preferred, because
strict_strtol() is obsolete. Thus, kstrtol() should be
used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ide/ide-park.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-park.c b/drivers/ide/ide-park.c
index 6ab9ab2..f41558a 100644
--- a/drivers/ide/ide-park.c
+++ b/drivers/ide/ide-park.c
@@ -116,8 +116,10 @@ ssize_t ide_park_store(struct device *dev, struct device_attribute *attr,
 	long int input;
 	int rc;
 
-	rc = strict_strtol(buf, 10, &input);
-	if (rc || input < -2)
+	rc = kstrtol(buf, 10, &input);
+	if (rc)
+		return rc;
+	if (input < -2)
 		return -EINVAL;
 	if (input > MAX_PARK_TIMEOUT) {
 		input = MAX_PARK_TIMEOUT;
-- 
1.7.10.4


