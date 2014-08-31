From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] ahci: ahci_p5wdh_workaround - constify DMI table
Date: Sun, 31 Aug 2014 10:57:09 +0200
Message-ID: <1409475429-11356-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36815 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbaHaI5V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Aug 2014 04:57:21 -0400
Received: by mail-wg0-f48.google.com with SMTP id n12so3948835wgh.19
        for <linux-ide@vger.kernel.org>; Sun, 31 Aug 2014 01:57:20 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

The DMI table does not need to be written to, make it r/o.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/ata/ahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a29f8012fb08..c880699a7d0b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -780,7 +780,7 @@ static void ahci_pci_print_info(struct ata_host *host)
  */
 static void ahci_p5wdh_workaround(struct ata_host *host)
 {
-	static struct dmi_system_id sysids[] = {
+	static const struct dmi_system_id sysids[] = {
 		{
 			.ident = "P5W DH Deluxe",
 			.matches = {
-- 
1.7.10.4

