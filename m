From: Thomas Evans <tom@23palmer.net>
Subject: Re: libata/sata_sil24 cache alignment problem?
Date: Tue, 12 Feb 2008 18:25:39 -0500
Message-ID: <47B22AF3.2020601@23palmer.net>
References: <20080212180254.GA28237@postdiluvian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:11665 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbYBLXZw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 18:25:52 -0500
In-Reply-To: <20080212180254.GA28237@postdiluvian.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Mason <mason@postdiluvian.org>
Cc: linux-ide@vger.kernel.org

I wonder if this may be what I am seeing with the Si3124 on my Alpha 
based setup.

I'm not sure if Alpha meets all the criteria, but the thing refuses to 
recognize any drivers when they are connected and I see what are 
supposed pci parity failures.

maybe not ...

...tom


Mark Mason wrote:
> Hi All,
>
> I've implemented the Linux PCI support for a new architecture, and
> have run into what appears to be a bug in libata, but I don't
> understand why it wouldn't have been seen on other architectures.
>
> The processor is a Tile64, which is a 64 core, 64 bit VLIW processor
> with non-coherent DMA - DMA transfers bypass the cache, so cache
> coherence must be maintained manually.
>
> I am working with libata v2.0, from Linux 2.6.18, and the sata_sil24
> driver for a Silicon Images SIL3531A chip.
>
> The problem occurs when the drive's model and serial numbers are read
> at startup via ata_dev_read_id().  They are read once on driver
> startup, then when the the error handler first runs it verifies that
> the model and serial numbers match what was read when the driver
> started.
>
> The problem is with the proximity of the private_data and sector_buf
> members of the ata_port struct, and the sector_buf not being cache
> aligned.  ata_qc_issue() calls dma_map_single(), which in my case
> flushes and invalidates the cache for the buffer it's about DMA into
> (ata_port->sector_buf), then calls sil24_qc_issue().
>
> sil24_qc_issue() then dereferences ata_port->private_data, which
> causes the cache line containing it to be read in, bringing part of
> the sector_buf with it, before the DMA transfer has taken place.  The
> Tile64 processor does not have a cache invalidate instruction, only a
> flush/invalidate, so dma_unmap_single() can't invalidate the portion
> of the sector_buf that's been inadvertently read in, and I get a
> serial number and/or model number mismatch, due to part of the buffer
> being stale.
>
> Documentation/DMA-API.txt states that addresses passed to
> dma_map_single() and dma_unmap_single() must be cache aligned for this
> reason.  Both calls to ata_dev_read_id() request DMA into a non
> cache-aligned buffer, but only the second call - via
> ata_dev_same_device() - has a conflict that can cause the cache line
> to be read back in during the very narrow window for which this
> vulnerability exists.
>
> Has anyone else reported a problem like this?  It requires
> non-coherent DMA, and a lack of a cache invalidate instruction, and
> one of the drivers that has this problem (it looks like sata_qstor
> does too, I haven't looked at others), so maybe that doesn't cover
> any other architectures.
>
> I can provide a patch if you're interested.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
