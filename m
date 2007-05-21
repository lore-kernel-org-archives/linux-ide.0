From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: use_clustering (sht) bit set to 0 in AHCI ?
Date: Mon, 21 May 2007 14:17:26 +0200
Message-ID: <20070521121726.GT14746@kernel.dk>
References: <35f686220704252249y6d4fe0c3y1a772119c7b6657f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:26554 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576AbXEUMSU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 08:18:20 -0400
Content-Disposition: inline
In-Reply-To: <35f686220704252249y6d4fe0c3y1a772119c7b6657f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alok kataria <alokkataria1@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Thu, Apr 26 2007, Alok kataria wrote:
> Hi Jeff,
> 
> I recently got a new AHCI disk, and was using the AHCI-libata driver to run
> this. I noticed that the scattergather lists that were being built for
> the I/O on this device were just of PAGE_SIZE length, even though i
> was doing IO on
> contiguous pages.
> 
> Through a little instrumentation i figured out that the use_clustering
> bit in the ahci_sht (scsi_host_template) is set to zero. Due to which
> we are not putting consecutive bios into one sg in blk_rq_map_sg.
> 
> I tried changing the clustering bit to 1, but encountered a panic at
> the initialization of the disks  during the bootup process, and so
> couldn't entirely get hold of the panic mesg.
> I was wondering, though the max segment size suported with this driver
> is 65536, why was i not able to feed in bigger SG's to this driver.
> 
> I searched on the net and the intel ahci arch doc too but couldn't
> find anything relative to the clustering support for AHCI.
> 
> It would be great help if you could let me know about the possible
> problems with clustering on AHCI  ? why is it off by default in the
> driver ? or anything else that might help.

It's a good question. If you look at the documentation, it states that
ahci supports up to 64k sg entries and each can have a size of up to 4mb
(bits 0 through 21). So as far as I can tell, clustering should work
with a segment size up to those 4mb.

ahci has always had clustering disabled, perhaps Jeff can expand on why?

-- 
Jens Axboe

