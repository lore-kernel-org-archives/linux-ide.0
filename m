From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] ahci: Use usleep_range() in ahci_start_port()
Date: Thu, 11 Jan 2018 15:55:51 +0300
Message-ID: <20180111125551.61877-2-mika.westerberg@linux.intel.com>
References: <20180111125551.61877-1-mika.westerberg@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:34897 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932365AbeAKM4Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 11 Jan 2018 07:56:24 -0500
In-Reply-To: <20180111125551.61877-1-mika.westerberg@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-ide@vger.kernel.org

Using msleep(1) may actually sleep much longer than 1 msecs (~20 msecs)
which unnecessarily slows down system startup. Avoid that and use
usleep_range() instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/ata/libahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index a0de7a38430c..27e7daa01ccb 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -871,7 +871,7 @@ static void ahci_start_port(struct ata_port *ap)
 				 * ports to fail the same way.
 				 */
 				if (rc == -EBUSY)
-					msleep(1);
+					usleep_range(1000, 1050);
 				else
 					break;
 			}
-- 
2.15.1

