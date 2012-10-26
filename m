From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] ide: use %*ph to print small buffers
Date: Fri, 26 Oct 2012 16:44:07 +0300
Message-ID: <1351259047-19327-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53800 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932948Ab2JZNoT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Oct 2012 09:44:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ide/ide-acpi.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index f1a6796b..b768f46 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -310,10 +310,7 @@ static int do_drive_set_taskfiles(ide_drive_t *drive,
 		u8 *gtf = (u8 *)(gtf_address + ix * REGS_PER_GTF);
 		struct ide_cmd cmd;
 
-		DEBPRINT("(0x1f1-1f7): "
-			 "hex: %02x %02x %02x %02x %02x %02x %02x\n",
-			 gtf[0], gtf[1], gtf[2],
-			 gtf[3], gtf[4], gtf[5], gtf[6]);
+		DEBPRINT("(0x1f1-1f7): hex: %7ph\n", gtf);
 
 		if (!ide_acpigtf) {
 			DEBPRINT("_GTF execution disabled\n");
-- 
1.7.10.4

