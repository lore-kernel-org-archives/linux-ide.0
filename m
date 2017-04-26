From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/3] ide-pm: always pass 0 error to
 __blk_end_request_all
Date: Wed, 26 Apr 2017 12:32:49 +0200
Message-ID: <1767347.L1Lf3WVO5M@amdc3058>
References: <20170426073422.14511-1-hch@lst.de>
        <20170426073422.14511-3-hch@lst.de>
        <CGME20170426103252epcas5p3bc9c0b51b48b89310bb456cd5f6dd390@epcas5p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-reply-to: <20170426073422.14511-3-hch@lst.de>
Sender: linux-scsi-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday, April 26, 2017 09:34:21 AM Christoph Hellwig wrote:
> ide_pm_execute_rq exectures a PM request synchronously, and in the failure
> case where it calls __blk_end_request_all it never checks the error field
> passed to the end_io callback, so don't bother setting it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
