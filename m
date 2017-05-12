From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 27/36] libata: fix identation on a kernel-doc markup
Date: Fri, 12 May 2017 11:00:10 -0300
Message-ID: <b1edb460b944327b6fddac16e209659a6836385f.1494596071.git.mchehab@s-opensource.com>
References: <cover.1494596071.git.mchehab@s-opensource.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1494596071.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1494596071.git.mchehab@s-opensource.com>
References: <cover.1494596071.git.mchehab@s-opensource.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Sphinx got confused with the markup identation:
	./drivers/ata/libata-scsi.c:3402: ERROR: Unexpected indentation.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/ata/libata-scsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 49ba9834c715..dcd38d9e9804 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3398,9 +3398,10 @@ static size_t ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 trmax,
  *
  * Translate a SCSI WRITE SAME command to be either a DSM TRIM command or
  * an SCT Write Same command.
- * Based on WRITE SAME has the UNMAP flag
- *   When set translate to DSM TRIM
- *   When clear translate to SCT Write Same
+ * Based on WRITE SAME has the UNMAP flag:
+ *
+ *   - When set translate to DSM TRIM
+ *   - When clear translate to SCT Write Same
  */
 static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 {
-- 
2.9.3
