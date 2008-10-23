From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/2] libata: get rid of ATA_MAX_QUEUE loop in ata_qc_complete_multiple()
Date: Thu, 23 Oct 2008 15:40:18 +0200
Message-ID: <20081023134017.GA22217@kernel.dk>
References: <1224661243-7929-1-git-send-email-jens.axboe@oracle.com> <1224661243-7929-2-git-send-email-jens.axboe@oracle.com> <48FFFA15.8060603@kernel.org> <20081023064357.GT22217@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756996AbYJWNmp@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081023064357.GT22217@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org
List-Id: linux-ide@vger.kernel.org

On Thu, Oct 23 2008, Jens Axboe wrote:
> On Thu, Oct 23 2008, Tejun Heo wrote:
> > while (done_mask) {
> >         struct ata_queued_cmd *qc;
> >         unsigned int next = __ffs(done_mask);
> > 
> >         tag += next;
> >         if ((qc = ata_qc_from_tag(ap, tag))) {
> >                 ata_qc_complete(qc);
> >                 nr_done++;
> >         }
> >         next++;
> >         tag += next;
> >         done_mask >>= next;
> > }
> 
> That doesn't work (you're adding next to tag twice), it needs a little
> tweak:
> 
> while (done_mask) {
>         struct ata_queued_cmd *qc;
>         unsigned int next = __ffs(done_mask);
> 
>         if ((qc = ata_qc_from_tag(ap, tag + next))) {
>                 ata_qc_complete(qc);
>                 nr_done++;
>         }
>         next++;
>         tag += next;
>         done_mask >>= next;
> }
> 
> and I think it should work. Not tested yet :-)

Pondered some more, and it can't work. The problem is that if we
complete tag 31, we attempt to shift done_mask down by 32 bits. On a
32-bit arch, that's not defined. So we DO need a check like the existing
one, or something similar.

So I don't think we need to make changes to this patch either, at least
unless one of you can come up with a better check that avoids a branch.

-- 
Jens Axboe
