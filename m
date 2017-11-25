From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] pata_pdc2027x : make pdc2027x_*_timing structures const
Date: Sat, 25 Nov 2017 16:47:35 +0530
Message-ID: <568091f7b46ee8c9f15ae5cbfe0b76d3a8c47022.1511608541.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42873 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdKYLRq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 25 Nov 2017 06:17:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org, sergei.shtylyov@cogentembedded.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Make these pdc2027x_*_timing structures const as it is never modified.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ata/pata_pdc2027x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index d1e8b63..141bf81 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -82,7 +82,7 @@ static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed
  * is issued to the device. However, if the controller clock is 133MHz,
  * the following tables must be used.
  */
-static struct pdc2027x_pio_timing {
+static const struct pdc2027x_pio_timing {
 	u8 value0, value1, value2;
 } pdc2027x_pio_timing_tbl[] = {
 	{ 0xfb, 0x2b, 0xac }, /* PIO mode 0 */
@@ -92,7 +92,7 @@ static struct pdc2027x_pio_timing {
 	{ 0x23, 0x09, 0x25 }, /* PIO mode 4, IORDY on, Prefetch off */
 };
 
-static struct pdc2027x_mdma_timing {
+static const struct pdc2027x_mdma_timing {
 	u8 value0, value1;
 } pdc2027x_mdma_timing_tbl[] = {
 	{ 0xdf, 0x5f }, /* MDMA mode 0 */
@@ -100,7 +100,7 @@ static struct pdc2027x_mdma_timing {
 	{ 0x69, 0x25 }, /* MDMA mode 2 */
 };
 
-static struct pdc2027x_udma_timing {
+static const struct pdc2027x_udma_timing {
 	u8 value0, value1, value2;
 } pdc2027x_udma_timing_tbl[] = {
 	{ 0x4a, 0x0f, 0xd5 }, /* UDMA mode 0 */
-- 
2.7.4

