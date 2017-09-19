From: Colin King <colin.king@canonical.com>
Subject: [PATCH][V3] libata: make static arrays const, reduces object code size
Date: Tue, 19 Sep 2017 09:39:52 +0100
Message-ID: <20170919083952.5648-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate const arrayis on the stack, instead make them static.
Makes the object code smaller by over 260 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  64864	   5948	   4128	  74940	  124bc	drivers/ata/libata-scsi.o

After:
   text	   data	    bss	    dec	    hex	filename
  64183	   6364	   4128	  74675	  123b3	drivers/ata/libata-scsi.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/libata-scsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 44ba292f2cd7..c3c483fc2145 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2145,7 +2145,7 @@ static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
  */
 static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 {
-	const u8 versions[] = {
+	static const u8 versions[] = {
 		0x00,
 		0x60,	/* SAM-3 (no version claimed) */
 
@@ -2155,7 +2155,7 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 		0x03,
 		0x00	/* SPC-3 (no version claimed) */
 	};
-	const u8 versions_zbc[] = {
+	static const u8 versions_zbc[] = {
 		0x00,
 		0xA0,	/* SAM-5 (no version claimed) */
 
@@ -2227,7 +2227,7 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 static unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf)
 {
 	int num_pages;
-	const u8 pages[] = {
+	static const u8 pages[] = {
 		0x00,	/* page 0x00, this page */
 		0x80,	/* page 0x80, unit serial no page */
 		0x83,	/* page 0x83, device ident page */
@@ -2258,7 +2258,7 @@ static unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf)
  */
 static unsigned int ata_scsiop_inq_80(struct ata_scsi_args *args, u8 *rbuf)
 {
-	const u8 hdr[] = {
+	static const u8 hdr[] = {
 		0,
 		0x80,			/* this page code */
 		0,
@@ -2580,7 +2580,7 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 {
 	struct ata_device *dev = args->dev;
 	u8 *scsicmd = args->cmd->cmnd, *p = rbuf;
-	const u8 sat_blk_desc[] = {
+	static const u8 sat_blk_desc[] = {
 		0, 0, 0, 0,	/* number of blocks: sat unspecified */
 		0,
 		0, 0x2, 0x0	/* block length: 512 bytes */
-- 
2.14.1
