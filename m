From: Colin King <colin.king@canonical.com>
Subject: [PATCH][V2] libata: make const arrays static, reduces object code size
Date: Mon, 18 Sep 2017 14:32:19 +0100
Message-ID: <20170918133219.31293-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38448 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbdIRNca (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 18 Sep 2017 09:32:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Mark Fasheh <mfasheh@versity.com>, Joel Becker <jlbec@evilplan.org>, Andrew Morton <akpm@linux-foundation.org>, piaojun <piaojun@huawei.com>, linux-ide@vger.kernel.org, ocfs2-devel@oss.oracle.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate const arrays on the stack, instead make them static.
Makes the object code smaller by over 260 bytes:

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/libata-scsi.c  | 10 +++++-----
 fs/ocfs2/dlm/dlmrecovery.c |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

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
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 74407c6dd592..31a61e8e0152 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -1129,7 +1129,6 @@ static int dlm_send_mig_lockres_msg(struct dlm_ctxt *dlm,
 		(mres->num_locks * sizeof(struct dlm_migratable_lock));
 
 	/* add an all-done flag if we reached the last lock */
-	orig_flags = mres->flags;
 	BUG_ON(total_locks > mres_total_locks);
 	if (total_locks == mres_total_locks)
 		mres->flags |= DLM_MRES_ALL_DONE;
-- 
2.14.1

