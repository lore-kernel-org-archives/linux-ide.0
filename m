From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] PNP: ide: constify pnp_device_id
Date: Wed, 16 Aug 2017 10:24:32 +0530
Message-ID: <60c34272432b3411cd5d55728c62481e133f32a6.1502859040.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38215 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdHPEyq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Aug 2017 00:54:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

pnp_device_id are not supposed to change at runtime. All functions
working with pnp_device_id provided by <linux/pnp.h> work with
const pnp_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ide/ide-pnp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-pnp.c b/drivers/ide/ide-pnp.c
index f5f2b62..859ddab 100644
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -22,7 +22,7 @@
 #define DRV_NAME "ide-pnp"
 
 /* Add your devices here :)) */
-static struct pnp_device_id idepnp_devices[] = {
+static const struct pnp_device_id idepnp_devices[] = {
 	/* Generic ESDI/IDE/ATA compatible hard disk controller */
 	{.id = "PNP0600", .driver_data = 0},
 	{.id = ""}
-- 
2.7.4

