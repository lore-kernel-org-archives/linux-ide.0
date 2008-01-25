From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-io: set REQ_FAILED when drive is dead
Date: Fri, 25 Jan 2008 22:06:09 +0100
Message-ID: <200801252206.09972.bzolnier@gmail.com>
References: <20080124203738.GA2176@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:16004 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbYAYVkG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 16:40:06 -0500
Received: by mu-out-0910.google.com with SMTP id i10so846829mue.5
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2008 13:40:04 -0800 (PST)
In-Reply-To: <20080124203738.GA2176@redhat.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aristeu Rozanski <arozansk@redhat.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Thursday 24 January 2008, Aristeu Rozanski wrote:
> Currently it's possible to ide-cd to set an incorrect blocksize by
> reading garbage if the drive is dead:
> 
> ide_cd_probe()
>  -> cdrom_read_toc()
>      -> cdrom_read_capacity()
>          -> cdrom_queue_packet_command()
>              -> ide_do_drive_cmd()
>                  -> ide_do_request()
>                      -> start_request()
> 
> on start_request():
> 
>         /* bail early if we've exceeded max_failures */
>         if (drive->max_failures && (drive->failures > drive->max_failures)) {
>                 goto kill_rq;
>         }
> (...)
> kill_rq:
>         ide_kill_rq(drive, rq);
>         return ide_stopped;
> 
> ide_kill_rq() and the next calls won't set REQ_FAILED on rq->cmd_flags and thus
> cdrom_queue_packet_command() won't return an error. then:
> 
>         stat = cdrom_queue_packet_command(drive, &req);
>         if (stat == 0) {
>                 *capacity = 1 + be32_to_cpu(capbuf.lba);
>                 *sectors_per_frame =
>                         be32_to_cpu(capbuf.blocklen) >> SECTOR_BITS;
>         }
> 
> cdrom_read_capacity() ends believing capbuf is valid but in fact it's just
> uninitialized data. back to cdrom_read_toc():
> 
>         /* Try to get the total cdrom capacity and sector size. */
>         stat = cdrom_read_capacity(drive, &toc->capacity, &sectors_per_frame,
>                                    sense);
>         if (stat)
>                 toc->capacity = 0x1fffff;
> 
>         set_capacity(info->disk, toc->capacity * sectors_per_frame);
>         /* Save a private copy of te TOC capacity for error handling */
>         drive->probed_capacity = toc->capacity * sectors_per_frame;
> 
>         blk_queue_hardsect_size(drive->queue,
>                                 sectors_per_frame << SECTOR_BITS);
> 
> that will set drive->queue->hardsect_size to be the random value.
> hardsect_size is used to calculate inode->i_blkbits. later on, on a read
> path:
> 
> void create_empty_buffers(struct page *page,
>                         unsigned long blocksize, unsigned long b_state)
> {       
>         struct buffer_head *bh, *head, *tail;
> 
>         head = alloc_page_buffers(page, blocksize, 1);
>         bh = head;
>         do {    
>                 bh->b_state |= b_state;
>                 tail = bh;
>                 bh = bh->b_this_page;
>         } while (bh);
>         tail->b_this_page = head;
> 
> alloc_page_buffers() will return NULL if blocksize > 4096. blocksize is
> calculed based on inode->i_blkbits. that will trigger a null
> dereference on create_empty_buffers().
> 
> Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>

thanks, applied

> ---
>  drivers/ide/ide-io.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linus-2.6.orig/drivers/ide/ide-io.c	2007-12-18 07:54:59.000000000 -0500
> +++ linus-2.6/drivers/ide/ide-io.c	2008-01-24 14:48:29.000000000 -0500
> @@ -1003,6 +1003,7 @@ static ide_startstop_t start_request (id
>  
>  	/* bail early if we've exceeded max_failures */
>  	if (drive->max_failures && (drive->failures > drive->max_failures)) {
> +		rq->cmd_flags |= REQ_FAILED;
>  		goto kill_rq;
>  	}
>  
