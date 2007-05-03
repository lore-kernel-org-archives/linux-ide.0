From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: flushing cache after block io
Date: Thu, 3 May 2007 14:23:28 +0100
Message-ID: <20070503132327.GB21024@flint.arm.linux.org.uk>
References: <97bec2470705010658s48c70ba2pc5310efa533a96ea@mail.gmail.com> <46377D10.9090605@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3193 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059AbXECNXh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2007 09:23:37 -0400
Content-Disposition: inline
In-Reply-To: <46377D10.9090605@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Bahadir Balban <bahadir.lists@googlemail.com>, linux-ide@vger.kernel.org

On Tue, May 01, 2007 at 01:46:56PM -0400, Mark Lord wrote:
> 
> Bahadir Balban wrote:
> >On an ARM core with write-allocate writeback cache, there can be cache
> >inconsistencies when an executable file is read from a block device
> >into memory.
> >
> >On a compact flash block device driver, I got around this problem by
> >flushing the caches for the pages that bio buffers use on every bio
> >read. E.g.
> >
> >cflash_read_sectors(dev, sect_begin, nsect, buf);
> >flush_icache_range(buf, buf + nsect*512);
> >
> >Now I have the same problem with a ATA harddisk connected with a
> >PDC20269 controller. The question is where would be the best
> >high-level place to put these flushes so that it works regardless of
> >what block IO driver is used?
> 
> Russell, didn't you go through all of this pain and fix it
> a year or two ago?

I thought so.

> Bahadir, exactly what kernel/version is this with?

Bahadir must be using an old kernel.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
