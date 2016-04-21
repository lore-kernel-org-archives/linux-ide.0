From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 08/23] ata: sata_dwc_460ex: don't call ata_sff_qc_issue() on DMA commands
Date: Thu, 21 Apr 2016 21:15:29 +0300
Message-ID: <1461262544-115408-9-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

ata_sff_qc_issue() can't handle DMA commands and thus we have to avoid it for
them. Do call ata_bmdma_qc_issue() instead for this case.

Suggested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 038e5fb..845c35d 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1061,10 +1061,12 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 			__func__, tag, qc->ap->link.sactive, sactive);
 
 		ap->ops->sff_tf_load(ap, &qc->tf);
-		sata_dwc_exec_command_by_tag(ap, &qc->tf, qc->tag,
+		sata_dwc_exec_command_by_tag(ap, &qc->tf, tag,
 					     SATA_DWC_CMD_ISSUED_PEND);
+	} else if (ata_is_dma(qc->tf.protocol)) {
+		return ata_bmdma_qc_issue(qc);
 	} else {
-		ata_sff_qc_issue(qc);
+		return ata_sff_qc_issue(qc);
 	}
 	return 0;
 }
-- 
2.8.0.rc3
