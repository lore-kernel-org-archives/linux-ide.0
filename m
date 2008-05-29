From: Pradeep Singh Rautela <rautelap@gmail.com>
Subject: [PATCH v2.6.26-rc4] ata: Convert deprecated static spinlock_t lock
	instance to static DEFINE_SPINLOCK(lock)
Date: Thu, 29 May 2008 23:28:14 +0530
Message-ID: <20080529175814.GB4926@kernelpanic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:12829 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbYE2R63 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 13:58:29 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2734223wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 29 May 2008 10:58:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, jgarzik@pobox.com

Replace deprecated static spinlock_t instance to static DEFINE_SPINLOCK(lock).

Signed-off-by: Pradeep Singh <rautelap@gmail.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3c89f20..cc816ca 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5403,7 +5403,7 @@ static void ata_host_stop(struct device *gendev, void *res)
  */
 static void ata_finalize_port_ops(struct ata_port_operations *ops)
 {
-	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	static DEFINE_SPINLOCK(lock);
 	const struct ata_port_operations *cur;
 	void **begin = (void **)ops;
 	void **end = (void **)&ops->inherits;
-- 
1.5.5.1

