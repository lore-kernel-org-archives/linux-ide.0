From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ata: pata_pdc2027x: Fix space before '[' error.
Date: Mon, 30 Oct 2017 21:34:19 +0530
Message-ID: <cf960e77d19359d710a768e41aabf2c8dedf2620.1509379256.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, b.zolnierkie@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Fix checkpatch.pl error:
ERROR: space prohibited before open square bracket '['.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ata/pata_pdc2027x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 82bfd51..ffd8d33 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -84,7 +84,7 @@ static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed
  */
 static struct pdc2027x_pio_timing {
 	u8 value0, value1, value2;
-} pdc2027x_pio_timing_tbl [] = {
+} pdc2027x_pio_timing_tbl[] = {
 	{ 0xfb, 0x2b, 0xac }, /* PIO mode 0 */
 	{ 0x46, 0x29, 0xa4 }, /* PIO mode 1 */
 	{ 0x23, 0x26, 0x64 }, /* PIO mode 2 */
@@ -94,7 +94,7 @@ static struct pdc2027x_pio_timing {
 
 static struct pdc2027x_mdma_timing {
 	u8 value0, value1;
-} pdc2027x_mdma_timing_tbl [] = {
+} pdc2027x_mdma_timing_tbl[] = {
 	{ 0xdf, 0x5f }, /* MDMA mode 0 */
 	{ 0x6b, 0x27 }, /* MDMA mode 1 */
 	{ 0x69, 0x25 }, /* MDMA mode 2 */
@@ -102,7 +102,7 @@ static struct pdc2027x_mdma_timing {
 
 static struct pdc2027x_udma_timing {
 	u8 value0, value1, value2;
-} pdc2027x_udma_timing_tbl [] = {
+} pdc2027x_udma_timing_tbl[] = {
 	{ 0x4a, 0x0f, 0xd5 }, /* UDMA mode 0 */
 	{ 0x3a, 0x0a, 0xd0 }, /* UDMA mode 1 */
 	{ 0x2a, 0x07, 0xcd }, /* UDMA mode 2 */
-- 
2.7.4
