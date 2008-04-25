From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: libata: functions with definition should not be extern
Date: Thu, 24 Apr 2008 18:37:34 -0700
Message-ID: <1209087454.20088.11.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:64173 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424AbYDYBhm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 21:37:42 -0400
Received: by el-out-1112.google.com with SMTP id n30so1337789elf.21
        for <linux-ide@vger.kernel.org>; Thu, 24 Apr 2008 18:37:41 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide <linux-ide@vger.kernel.org>

Noticed by sparse
drivers/ata/libata-core.c:3380:12: warning: function 'ata_wait_after_reset' with external linkage has definition

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b0b00af..fe5c88b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3377,7 +3377,7 @@ int ata_wait_ready(struct ata_link *link, unsigned long deadline,
  *	RETURNS:
  *	0 if @linke is ready before @deadline; otherwise, -errno.
  */
-extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
+int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link))
 {
 	msleep(ATA_WAIT_AFTER_RESET_MSECS);
-- 
1.5.5.1.270.g89765



