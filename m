From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Commit 6856ebbf3e46c8184cec15f59d6436692f85d8ba causes libsas
	panic on SATA DVD
Date: Sun, 13 Apr 2008 17:36:05 -0500
Message-ID: <1208126165.4707.66.camel@localhost.localdomain>
References: <1208125145.4707.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:56673 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752367AbYDMWgJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Apr 2008 18:36:09 -0400
In-Reply-To: <1208125145.4707.63.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

On Sun, 2008-04-13 at 17:19 -0500, James Bottomley wrote:
> This patch:
> 
> commit 6856ebbf3e46c8184cec15f59d6436692f85d8ba
> Author: Tejun Heo <htejun@gmail.com>
> Date:   Mon Apr 7 22:47:20 2008 +0900
> 
>     libata: replace tf_read with qc_fill_rtf for non-SFF drivers
> 
> Takes away our libsas port_ops->sff_tf_read
> 
> However, as soon as we get into atapi_request_sense() we hit
> 
> #ifdef CONFIG_ATA_SFF
> 	ap->ops->sff_tf_read(ap, &qc->tf);
> #endif
> 
> And panic.
> 
> atapi_request_sense seems to be unavoidable if we hit an AC_ERR_DEV in
> atapi_qc_complete
> 
> How is this supposed to work?

This is the patch that fixes the panic for me.  It looks like this was
just an oversight in the conversion to qc_fill_rtf.

James

---

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b195d82..8b72c64 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2390,9 +2390,7 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 	/* FIXME: is this needed? */
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 
-#ifdef CONFIG_ATA_SFF
-	ap->ops->sff_tf_read(ap, &qc->tf);
-#endif
+	ap->ops->qc_fill_rtf(qc);
 
 	/* fill these in, for the case where they are -not- overwritten */
 	cmd->sense_buffer[0] = 0x70;


