From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] ahci: remove pmp link online check in FBS EH
Date: Sat, 8 Jun 2013 16:00:16 +0800
Message-ID: <1370678416-2133-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Yu Liu <liuyu.ac@gmail.com>, linux-ide@vger.kernel.org, stable@vger.kernel.org, Shane Huang <shane.huang@amd.com>
List-Id: linux-ide@vger.kernel.org

ata_link_online() check in ahci_error_intr() is unnecessary, it should
be removed otherwise may lead to lockup with FBS enabled PMP.
http://marc.info/?l=linux-ide&m=137050421603272&w=2

Reported-by: Yu Liu <liuyu.ac@gmail.com>
Signed-off-by: Shane Huang <shane.huang@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/ata/libahci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index a70ff15..7b9bdd8 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1560,8 +1560,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 		u32 fbs = readl(port_mmio + PORT_FBS);
 		int pmp = fbs >> PORT_FBS_DWE_OFFSET;
 
-		if ((fbs & PORT_FBS_SDE) && (pmp < ap->nr_pmp_links) &&
-		    ata_link_online(&ap->pmp_link[pmp])) {
+		if ((fbs & PORT_FBS_SDE) && (pmp < ap->nr_pmp_links)) {
 			link = &ap->pmp_link[pmp];
 			fbs_need_dec = true;
 		}
-- 
1.8.1.2
