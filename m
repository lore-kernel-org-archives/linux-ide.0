From: "Bahadir Balban" <bahadir.lists@googlemail.com>
Subject: flushing cache after block io
Date: Tue, 1 May 2007 14:58:55 +0100
Message-ID: <97bec2470705010658s48c70ba2pc5310efa533a96ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:50328 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423555AbXEAN65 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 09:58:57 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2224526nzf
        for <linux-ide@vger.kernel.org>; Tue, 01 May 2007 06:58:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

On an ARM core with write-allocate writeback cache, there can be cache
inconsistencies when an executable file is read from a block device
into memory.

On a compact flash block device driver, I got around this problem by
flushing the caches for the pages that bio buffers use on every bio
read. E.g.

cflash_read_sectors(dev, sect_begin, nsect, buf);
flush_icache_range(buf, buf + nsect*512);

Now I have the same problem with a ATA harddisk connected with a
PDC20269 controller. The question is where would be the best
high-level place to put these flushes so that it works regardless of
what block IO driver is used?


Thanks,
Bahadir
