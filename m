From: Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
Date: Fri, 27 May 2005 09:33:08 +0200
Message-ID: <20050527073307.GP1435@suse.de>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050527072046.GN1435@suse.de> <4296CC5C.5000807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:25284 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261939AbVE0HcB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 May 2005 03:32:01 -0400
Content-Disposition: inline
In-Reply-To: <4296CC5C.5000807@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 27 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >I double checked this. If you agree to move the setting of QCFLAG_ACTIVE
> >_after_ successful ap->ops->qc_issue(qc) and clear it _after_
> >__ata_qc_complete(qc) then I can just use that bit and kill
> >ATA_QCFLAG_ACCOUNT.
> >
> >What do you think?
> 
> Fine with me.
> 
> Keep in mind that the attached patch was applied recently...

Yeah, the two hunks from the ncq patch would look like this then. Ok?

Index: drivers/scsi/libata-core.c
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/drivers/scsi/libata-core.c  (mode:100644)
+++ uncommitted/drivers/scsi/libata-core.c  (mode:100644)
@@ -2812,15 +2893,15 @@
 
 	/* call completion callback */
 	rc = qc->complete_fn(qc, drv_stat);
-	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
 	 */
-	if (rc != 0)
+	if (unlikely(rc != 0))
 		return;
 
 	__ata_qc_complete(qc);
+	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	VPRINTK("EXIT\n");
 }
@@ -2884,12 +3026,25 @@
 	ap->ops->qc_prep(qc);
 
 	qc->ap->active_tag = qc->tag;
+
+	rc = ap->ops->qc_issue(qc);
+	if (rc != ATA_QC_ISSUE_OK)
+		goto err_out;
+
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
-	return ap->ops->qc_issue(qc);
+	if (qc->flags & ATA_QCFLAG_NCQ) {
+		assert(ap->ncq_depth < ATA_MAX_QUEUE)
+		ap->ncq_depth++;
+	} else {
+		assert(!ap->depth);
+		ap->depth++;
+	}
 
+	return ATA_QC_ISSUE_OK;
 err_out:
-	return -1;
+	ata_qc_free(qc);
+	return rc;
 }
 
 /**


-- 
Jens Axboe

