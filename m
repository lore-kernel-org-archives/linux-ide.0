From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/2] libata: get rid of ATA_MAX_QUEUE loop in ata_qc_complete_multiple()
Date: Thu, 23 Oct 2008 08:43:57 +0200
Message-ID: <20081023064357.GT22217@kernel.dk>
References: <1224661243-7929-1-git-send-email-jens.axboe@oracle.com> <1224661243-7929-2-git-send-email-jens.axboe@oracle.com> <48FFFA15.8060603@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:51824 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756007AbYJWGoz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2008 02:44:55 -0400
Content-Disposition: inline
In-Reply-To: <48FFFA15.8060603@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

On Thu, Oct 23 2008, Tejun Heo wrote:
> while (done_mask) {
>         struct ata_queued_cmd *qc;
>         unsigned int next = __ffs(done_mask);
> 
>         tag += next;
>         if ((qc = ata_qc_from_tag(ap, tag))) {
>                 ata_qc_complete(qc);
>                 nr_done++;
>         }
>         next++;
>         tag += next;
>         done_mask >>= next;
> }

That doesn't work (you're adding next to tag twice), it needs a little
tweak:

while (done_mask) {
        struct ata_queued_cmd *qc;
        unsigned int next = __ffs(done_mask);

        if ((qc = ata_qc_from_tag(ap, tag + next))) {
                ata_qc_complete(qc);
                nr_done++;
        }
        next++;
        tag += next;
        done_mask >>= next;
}

and I think it should work. Not tested yet :-)

-- 
Jens Axboe

