From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: [PATCH v4] drivers/block/mtip32xx: Adding new driver mtip32xx
Date: Fri, 9 Sep 2011 10:58:01 +0200
Message-ID: <4E69D519.8070802@fusionio.com>
References: <22A973199D2C2F46933448F6E7990A3002C80026@ntxboimbx31.micron.com> <4E44E782.7090309@fusionio.com> <2A9BE4FF6209B644B6F8EB62DE6AEA1E07663ED4@ntxfrembx01.micron.com> <20110909085433.GA9593@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.fusionio.com ([66.114.96.30]:56124 "EHLO mx1.fusionio.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932943Ab1III6I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Sep 2011 04:58:08 -0400
In-Reply-To: <20110909085433.GA9593@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "Sam Bradshaw (sbradshaw)" <sbradshaw@micron.com>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>

On 2011-09-09 10:54, Christoph Hellwig wrote:
> On Mon, Aug 22, 2011 at 02:28:11PM -0700, Sam Bradshaw (sbradshaw) wrote:
>> New patch for mtip32xx driver based on feedback from
>> Jens Axboe, Christoph Hellwig, and Alan Cox.
> 
> A few comments that need addressing:
> 
>  - the ioctl handler always returns 0 for the BLKFLSBUF ioctl, without
>    doing anything.  Given that the ioctl is supposed to flush all kinds
>    of higher level cached data this is a serious data integrity issue.
>    It must simply do the default -ENOTTY return for it and let the block
>    layer do the right thing.
>  - handling of REQ_FUA / REQ_FLUSH requests is completely broken.
>    There is a weird barrier flag to mtip_hw_submit_io which set the
>    hwardware FUA bit if the FLUSH bit is set on a request.
>    Please take a look at how this should be handled, the
>    Documentation/block/writeback_cache_control.txt file is the canonical
>    resource.  Implementing your driver at the make_request layer
>    unfortunately means you will have to do all the hard work yourself.
>  - also the call to blk_queue_flush(queue, 0); from ->make_request for
>    a non-data request is completely wrong.

I noticed both of these flush/fua problems too and have fixed them up.

>  - the 64-bit case in fill_command_sg will blow up on big endian
>    systems, please use your current 32-bit case unconditionally
>  - mtip_block_getgeo should just use sector_div instead of the ifdef
>    mess.
>  - please check the driver using sparse, and most importantly the
>    optional endianess checking pass of it.  Currently the driver
>    uses plain unsigned int and similar types for little endian
>    hardware structures.  Take a look at Documentation/sparse.txt
>    on how to use it.
>  - the mtip_check_surprise_removal check should be unconditional, not
>    under #ifdef CONFIG_HOTPLUG

In general, the dependency on HOTPLUG_PCI_PCIE is odd as well.

>  - Given that the driver has a single c implementation file all symbols
>    should be marked static, and there should be no prototypes in the
>    header

Sam, would be nice if you could send in patches for the other bugs that
Christoph have pointed out. I already found and fixed the flush parts.

-- 
Jens Axboe

