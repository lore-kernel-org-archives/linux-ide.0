From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: be less of a drama queen on empty
 data commands
Date: Mon, 23 Aug 2010 11:27:27 +0200
Message-ID: <4C723EFF.4030201@kernel.org>
References: <4C71C645.8050007@stud.tu-ilmenau.de> <4C723C65.6080303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35345 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab0HWJcl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2010 05:32:41 -0400
In-Reply-To: <4C723C65.6080303@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: stefan.huebner@stud.tu-ilmenau.de, linux-ide@vger.kernel.org

ata_qc_issue() BUG_ON()s on data commands w/o data, which may be
submitted via SG_IO.  Be less of a drama queen and just trigger
WARN_ON_ONCE() and fail the command with AC_ERR_SYSTEM.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Stefan H=FCbner <stefan.huebner@stud.tu-ilmenau.de>
---
 drivers/ata/libata-core.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7ef7c4f..c035b3d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5111,15 +5111,18 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	qc->flags |=3D ATA_QCFLAG_ACTIVE;
 	ap->qc_active |=3D 1 << qc->tag;

-	/* We guarantee to LLDs that they will have at least one
+	/*
+	 * We guarantee to LLDs that they will have at least one
 	 * non-zero sg if the command is a data command.
 	 */
-	BUG_ON(ata_is_data(prot) && (!qc->sg || !qc->n_elem || !qc->nbytes));
+	if (WARN_ON_ONCE(ata_is_data(prot) &&
+			 (!qc->sg || !qc->n_elem || !qc->nbytes)))
+		goto sys_err;

 	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
 				 (ap->flags & ATA_FLAG_PIO_DMA)))
 		if (ata_sg_setup(qc))
-			goto sg_err;
+			goto sys_err;

 	/* if device is sleeping, schedule reset and abort the link */
 	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
@@ -5136,7 +5139,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 		goto err;
 	return;

-sg_err:
+sys_err:
 	qc->err_mask |=3D AC_ERR_SYSTEM;
 err:
 	ata_qc_complete(qc);
