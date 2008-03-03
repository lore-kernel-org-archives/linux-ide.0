From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] block: fix residual byte count handling
Date: Mon, 03 Mar 2008 23:22:46 +0900
Message-ID: <47CC09B6.6090709@gmail.com>
References: <47CBFF6F.4060301@gmail.com>	<20080303225024J.tomof@acm.org>	<47CC036C.2060902@gmail.com> <20080303230121M.tomof@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20080303230121M.tomof@acm.org>
Sender: linux-scsi-owner@vger.kernel.org
To: FUJITA Tomonori <tomof@acm.org>
Cc: fujita.tomonori@lab.ntt.co.jp, jens.axboe@oracle.com, James.Bottomley@HansenPartnership.com, efault@gmx.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

FUJITA Tomonori wrote:
>> At the end of blk_rq_map_user() together with data_len / extra_len
>> mangling or were you talking about James' original patch?
> 
> With my patch, at the end of blk_rq_map_user, we have:
> 
> 	if (len & queue_dma_alignment(q)) {
> 		unsigned int pad_len = (queue_dma_alignment(q) & ~len) + 1;
> 
> 		rq->extra_len += pad_len;
> 	}
> 
> 
> So no change as compared with 2.6.24?

Oh.. you killed sg list manipulation.  Many controllers do allow odd
bytes as the last sg entry but not all.  Also, if you append drain
buffer after it, it ends up with unaligned sg entry in the middle and
rq->data_len + rq->extra_len will overrun the sg entry after the drain
page which is really dangerous.

-- 
tejun
