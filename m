From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-eh copy result_tf flags from outgoing tf
Date: Thu, 24 Apr 2008 07:14:07 +0900
Message-ID: <480FB4AF.2060907@gmail.com>
References: <480F9D29.4070603@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:62589 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYDWWOY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 18:14:24 -0400
Received: by yw-out-2324.google.com with SMTP id 5so273382ywh.1
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 15:14:18 -0700 (PDT)
In-Reply-To: <480F9D29.4070603@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Fix mis-reporting of NCQ errors by copying tf->flags to result_tf->flags
> in libata-eh.  This allows ata_gen_ata_sense() to report the failed
> block number correctly to SCSI after a media error during NCQ.
> 
> This patch may also be a candidate for backporting to earlier kernels.
> Without this fix, SCSI will fail I/O on the entire request rather
> than just the bad sector.  That can be bad for a request that was
> merged from many independent read reads from different tasks.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- upstream/drivers/ata/libata-eh.c    2008-04-18 09:31:15.000000000 -0400
> +++ linux/drivers/ata/libata-eh.c    2008-04-23 16:25:38.000000000 -0400
> @@ -1402,6 +1402,7 @@
>     /* we've got the perpetrator, condemn it */
>     qc = __ata_qc_from_tag(ap, tag);
>     memcpy(&qc->result_tf, &tf, sizeof(tf));
> +    qc->result_tf.flags = qc->tf.flags;

Maybe it's better to set ATA_TFLAG_LBA48 | ATA_TFLAG_ISADDR | 
ATA_TFLAG_DEVICE?  After all, all fields are available after that memcpy().

Thanks for fixing this.

-- 
tejun
