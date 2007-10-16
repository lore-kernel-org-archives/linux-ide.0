From: Jeff Garzik <jeff@garzik.org>
Subject: Re: remove blk_queue_max_phys_segments in libata
Date: Tue, 16 Oct 2007 16:15:47 -0400
Message-ID: <47151BF3.4080208@garzik.org>
References: <200710161809.l9GI9YTS008023@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42089 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965482AbXJPUPy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Oct 2007 16:15:54 -0400
In-Reply-To: <200710161809.l9GI9YTS008023@hera.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8889e3c129780cdbe15fed3c366ba3aa3026684d
> Commit:     8889e3c129780cdbe15fed3c366ba3aa3026684d
> Parent:     fd820f405574a30aacf9a859886e173d641f080b
> Author:     FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> AuthorDate: Tue Sep 18 12:16:45 2007 +0200
> Committer:  Jens Axboe <jens.axboe@oracle.com>
> CommitDate: Tue Oct 16 11:24:44 2007 +0200
> 
>     remove blk_queue_max_phys_segments in libata
>     
>     LIBATA_MAX_PRD is the maximum number of DMA scatter/gather elements
>     permitted by the HBA's DMA engine. It's properly set to
>     q->max_hw_segments via the sg_tablesize parameter.
>     
>     libata shouldn't call blk_queue_max_phys_segments. Now LIBATA_MAX_PRD
>     is equal to SCSI_MAX_PHYS_SEGMENTS by default (both is 128), so
>     everything is fine. But if they are changed, some code (like the scsi
>     mid layer, sg chaining, etc) might not work properly.
>     
>     (Addition from Jens) The basic issue is that the physical segment
>     setting is purely a driver issue. And since SCSI is managing the sglist,
>     libata has no business changing the setting. All libata should care
>     about is the hw segment setting.
>     
>     Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
>     Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> ---
>  drivers/ata/libata-scsi.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d63c81e..ba62d53 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -801,8 +801,6 @@ int ata_scsi_slave_config(struct scsi_device *sdev)
>  
>  	ata_scsi_sdev_config(sdev);
>  
> -	blk_queue_max_phys_segments(sdev->request_queue, LIBATA_MAX_PRD);
> -
>  	sdev->manage_start_stop = 1;

As I noted when this first patch was posted...   this line of code 
existed because the difference between hw-segments and phys-segments was 
incredibly difficult to discern.  The names say basically the same thing 
to me, and I could find no documentation explaining the difference?

Does such documentation exist?  If not, can you please explain the 
difference?

Finally, some notification and coordination would have been helpful. 
Commit 6c08772e49622e90d39903e7ff0be1a0f463ac86 appears to have been 
missed, at the very least... or is it actually correct?

Inquiring minds want to know, since I wasn't CC'd or kept in the loop :)

	Jeff


