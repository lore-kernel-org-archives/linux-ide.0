From: Mark Lord <liml@rtr.ca>
Subject: Re: flushing cache after block io
Date: Tue, 01 May 2007 13:46:56 -0400
Message-ID: <46377D10.9090605@rtr.ca>
References: <97bec2470705010658s48c70ba2pc5310efa533a96ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4057 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755124AbXEARq7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 May 2007 13:46:59 -0400
In-Reply-To: <97bec2470705010658s48c70ba2pc5310efa533a96ea@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bahadir Balban <bahadir.lists@googlemail.com>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org


Bahadir Balban wrote:
> On an ARM core with write-allocate writeback cache, there can be cache
> inconsistencies when an executable file is read from a block device
> into memory.
> 
> On a compact flash block device driver, I got around this problem by
> flushing the caches for the pages that bio buffers use on every bio
> read. E.g.
> 
> cflash_read_sectors(dev, sect_begin, nsect, buf);
> flush_icache_range(buf, buf + nsect*512);
> 
> Now I have the same problem with a ATA harddisk connected with a
> PDC20269 controller. The question is where would be the best
> high-level place to put these flushes so that it works regardless of
> what block IO driver is used?

Russell, didn't you go through all of this pain and fix it
a year or two ago?

Bahadir, exactly what kernel/version is this with?


