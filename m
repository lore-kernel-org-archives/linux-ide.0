From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/22] libata-sff: clear IRQ from ata_sff_error_handler() only when necessary
Date: Tue, 21 Oct 2008 18:17:42 +0900
Message-ID: <1224580680-13698-5-git-send-email-tj@kernel.org>
References: <1224580680-13698-1-git-send-email-tj@kernel.org>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1224580680-13698-1-git-send-email-tj@kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

Clearing IRQ from ata_sff_error_handler() is necessary only when the
port is gonna be thawed before performing EH actions and some
controllers don't like being accessed after certain fail modes until
they're reset.  Clear IRQ iff the port is being thawed.  Also, remove
unnecessary ata_sff_sync() while at it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 4b47394..b9fb068 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2119,11 +2119,13 @@ void ata_sff_error_handler(struct ata_port *ap)
 		}
 
 		ap->ops->bmdma_stop(qc);
-	}
 
-	ata_sff_sync(ap);		/* FIXME: We don't need this */
-	ap->ops->sff_check_status(ap);
-	ap->ops->sff_irq_clear(ap);
+		/* if we're gonna thaw, make sure IRQ is clear */
+		if (thaw) {
+			ap->ops->sff_check_status(ap);
+			ap->ops->sff_irq_clear(ap);
+		}
+	}
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-- 
1.5.4.5

