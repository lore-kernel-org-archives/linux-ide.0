From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [UPDATED][PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Wed, 2 Nov 2005 20:12:30 +0100
Message-ID: <58cb370e0511021112m7c9ecbb0g42e0b7332806252a@mail.gmail.com>
References: <CA45571DE57E1C45BF3552118BA92C9D69BF2F@WDSCEXBECL03.sc.wdc.com>
	 <20051102084917.GM26049@suse.de>
	 <20051102172316.GF2361@deepthought.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.199]:10654 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965180AbVKBTMb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Nov 2005 14:12:31 -0500
Received: by nproxy.gmail.com with SMTP id x37so54951nfc
        for <linux-ide@vger.kernel.org>; Wed, 02 Nov 2005 11:12:30 -0800 (PST)
In-Reply-To: <20051102172316.GF2361@deepthought.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Murray <mmurray@deepthought.org>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org

Hi,

On 11/2/05, Martin Murray <mmurray@deepthought.org> wrote:
>
>     I looked into this yesterday, and it appears that sglists are
> hardcoded to a maximum of 256 sectors or (256*512) 128kb. Specifically,
> ide_build_sglist() in ide-dma.c the lines are as follows:
>
>     if ((rq->flags & REQ_DRIVE_TASKFILE) && rq->nr_sectors > 256)
>         BUG();

Yep.

>     Other than that, as far as I could tell, modifying Mr. Thelin's
> patch to use SG would be straightforward. ide_map_sg() in ide-io.c would
> have to be modified to allocate the scatter gather list, and the
> ide_taskfile_ioctl() in ide-taskfile.c would have to be modified to copy
> to userspace the scatter/gather list instead of the buffer that is

Won't this break existing users of HDIO_DRIVE_TASKFILE ioctl?

Long-term I want to add SG_IO ioctl + "ATA pass-through" support
to IDE driver which will be based on libata code.

A lot of work has already been done by Tejun Heo and me:

* unification of ioctl code-paths
* conversion to use struct ata_taskfile
* conversion to use taskfiles for normal I/O

Unfortunately this work stalled because of lack of
time so patches need refreshing for current kernels.

Next step should be addition of host state machine to IDE driver.

This will be basically enough to start adding "ATA pass-through"
support to IDE driver and deprecating HDIO_DRIVE_* ioctls...

> allocated. I'll happily try this after class unless its incorrect.
>
>     One thing I don't understand is, if Mr. Thelin's code that requests,
> as said, a little over 128k is a DMA command, then shouldn't the kernel
> have bugged? And if it didn't bug, was the data transferred via PIO? Or

I suppose so.

> does the chipset handle the PIO to the drive and dma the result?

This is Virtual DMA mode and is independent
of HDIO_DRIVE_TASKFILE ioctl.

Thanks,
Bartlomiej
