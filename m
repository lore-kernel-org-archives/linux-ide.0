From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: flushing cache after block io
Date: Thu, 3 May 2007 14:30:03 +0100
Message-ID: <20070503133002.GC21024@flint.arm.linux.org.uk>
References: <97bec2470705010658s48c70ba2pc5310efa533a96ea@mail.gmail.com> <46377D10.9090605@rtr.ca> <97bec2470705030625u1a0117b3h1cd2d46c06ee035e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3734 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031299AbXECNaR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2007 09:30:17 -0400
Content-Disposition: inline
In-Reply-To: <97bec2470705030625u1a0117b3h1cd2d46c06ee035e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bahadir Balban <bahadir.lists@googlemail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Thu, May 03, 2007 at 02:25:44PM +0100, Bahadir Balban wrote:
> On 5/1/07, Mark Lord <liml@rtr.ca> wrote:
> >
> >Russell, didn't you go through all of this pain and fix it
> >a year or two ago?
> >
> >Bahadir, exactly what kernel/version is this with?
> >
> >
> 
> This is on 2.6.19 but I'm unsure if there's a fix in the tree as I
> might be one of the few to try ARM MPCore with a block device.
> Although, filesystems over mtd or nfs work fine without the flushing.

You want to be running something post 2.6.20-rc5 ideally (so 2.6.20).
There's a couple of cache flushing related patches merged between .19
and .20.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
