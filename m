From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] ide-tape: fix misprint in failure handling in idetape_init()
Date: Sat, 30 Apr 2016 01:11:12 +0300
Message-ID: <1461967872-14968-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:60976 "EHLO mail.ispras.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693AbcD2WMN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Apr 2016 18:12:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

If driver_register() failed there is no sense to call driver_unregister().
unregister_chrdev() should be called here.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/ide/ide-tape.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 12fa04997dcc..9ecf4e35adcd 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2052,12 +2052,12 @@ static int __init idetape_init(void)
 
 	error = driver_register(&idetape_driver.gen_driver);
 	if (error)
-		goto out_free_driver;
+		goto out_free_chrdev;
 
 	return 0;
 
-out_free_driver:
-	driver_unregister(&idetape_driver.gen_driver);
+out_free_chrdev:
+	unregister_chrdev(IDETAPE_MAJOR, "ht");
 out_free_class:
 	class_destroy(idetape_sysfs_class);
 out:
-- 
1.9.1

