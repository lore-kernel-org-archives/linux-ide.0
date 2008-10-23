From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: get rid of ATA_MAX_QUEUE loop in ata_qc_complete_multiple()
Date: Thu, 23 Oct 2008 13:14:13 +0900
Message-ID: <48FFFA15.8060603@kernel.org>
References: <1224661243-7929-1-git-send-email-jens.axboe@oracle.com> <1224661243-7929-2-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40803 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbYJWEO1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2008 00:14:27 -0400
In-Reply-To: <1224661243-7929-2-git-send-email-jens.axboe@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

Jens Axboe wrote:
> @@ -4811,16 +4811,19 @@ int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active)
>               return -EINVAL;
>       }
>
> -     for (i = 0; i < ATA_MAX_QUEUE; i++) {
> +     while (done_mask) {
>               struct ata_queued_cmd *qc;
> +             unsigned int next = __ffs(done_mask);
>
> -             if (!(done_mask & (1 << i)))
> -                     continue;
> -
> -             if ((qc = ata_qc_from_tag(ap, i))) {
> +             qc = ata_qc_from_tag(ap, i + next);
> +             if (qc) {
>                       ata_qc_complete(qc);
>                       nr_done++;
>               }
> +             if (++next >= ATA_MAX_QUEUE)
> +                     break;
> +             i += next;
> +             done_mask >>= next;

Shouldn't this be...

        i += next + 1;
        if (i >= ATA_MAX_QUEUE)
                break;

or better...

while (done_mask) {
        struct ata_queued_cmd *qc;
        unsigned int next = __ffs(done_mask);

        tag += next;
        if ((qc = ata_qc_from_tag(ap, tag))) {
                ata_qc_complete(qc);
                nr_done++;
        }
        next++;
        tag += next;
        done_mask >>= next;
}

done_mask is guaranteed to be zero at when tag reaches ATA_MAX_QUEUE.

Thanks.

-- 
tejun
