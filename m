From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ata: sata_mv: remove a redundant assignment to pointer ehi
Date: Mon, 16 Oct 2017 12:00:11 +0100
Message-ID: <20171016110011.11048-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer ehi is being assigned to a value that is never read
and is redundant.  Clean up the code and move the ehi declaration
and initialization to the code block where it is used. Cleans up
clang warning: Value stored to 'ehi' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/sata_mv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 3b2246dded74..dbb62b508213 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2478,20 +2478,18 @@ static unsigned int mv_get_err_pmp_map(struct ata_port *ap)
 
 static void mv_pmp_eh_prep(struct ata_port *ap, unsigned int pmp_map)
 {
-	struct ata_eh_info *ehi;
 	unsigned int pmp;
 
 	/*
 	 * Initialize EH info for PMPs which saw device errors
 	 */
-	ehi = &ap->link.eh_info;
 	for (pmp = 0; pmp_map != 0; pmp++) {
 		unsigned int this_pmp = (1 << pmp);
 		if (pmp_map & this_pmp) {
 			struct ata_link *link = &ap->pmp_link[pmp];
+			struct ata_eh_info *ehi = &link->eh_info;
 
 			pmp_map &= ~this_pmp;
-			ehi = &link->eh_info;
 			ata_ehi_clear_desc(ehi);
 			ata_ehi_push_desc(ehi, "dev err");
 			ehi->err_mask |= AC_ERR_DEV;
-- 
2.14.1
