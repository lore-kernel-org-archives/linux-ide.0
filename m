From: Jiri Slaby <jslaby@suse.cz>
Subject: [RFC 1/3] ata: Documentation, fix function names
Date: Fri, 14 Jun 2019 09:11:38 +0200
Message-ID: <20190614071140.6233-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

ata_qc_prep no longer exists, there are ata_bmdma_qc_prep and
ata_bmdma_dumb_qc_prep instead. And most drivers do not use them, so
reword the paragraph.

ata_qc_issue_prot was renamed to ata_sff_qc_issue. ->tf_load is now
->sff_tf_load. Fix them.

And fix spelling supercede -> supersede.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
---
 Documentation/driver-api/libata.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-api/libata.rst
index 70e180e6b93d..c2ee38098e85 100644
--- a/Documentation/driver-api/libata.rst
+++ b/Documentation/driver-api/libata.rst
@@ -254,19 +254,19 @@ High-level taskfile hooks
     int (*qc_issue) (struct ata_queued_cmd *qc);
 
 
-Higher-level hooks, these two hooks can potentially supercede several of
+Higher-level hooks, these two hooks can potentially supersede several of
 the above taskfile/DMA engine hooks. ``->qc_prep`` is called after the
 buffers have been DMA-mapped, and is typically used to populate the
-hardware's DMA scatter-gather table. Most drivers use the standard
-:c:func:`ata_qc_prep` helper function, but more advanced drivers roll their
-own.
+hardware's DMA scatter-gather table. Some drivers use the standard
+:c:func:`ata_bmdma_qc_prep` and :c:func:`ata_bmdma_dumb_qc_prep` helper
+functions, but more advanced drivers roll their own.
 
 ``->qc_issue`` is used to make a command active, once the hardware and S/G
 tables have been prepared. IDE BMDMA drivers use the helper function
-:c:func:`ata_qc_issue_prot` for taskfile protocol-based dispatch. More
+:c:func:`ata_sff_qc_issue` for taskfile protocol-based dispatch. More
 advanced drivers implement their own ``->qc_issue``.
 
-:c:func:`ata_qc_issue_prot` calls ``->tf_load()``, ``->bmdma_setup()``, and
+:c:func:`ata_sff_qc_issue` calls ``->sff_tf_load()``, ``->bmdma_setup()``, and
 ``->bmdma_start()`` as necessary to initiate a transfer.
 
 Exception and probe handling (EH)
-- 
2.22.0
