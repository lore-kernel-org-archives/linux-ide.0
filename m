From: Marc Bevand <bevand_m@epita.fr>
Subject: Re: [PATCH] speed up SATA
Date: Tue, 30 Mar 2004 14:16:56 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <c4bofu$f7s$1@sea.gmane.org>
References: <4066021A.20308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:58520 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263641AbUC3NUM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Mar 2004 08:20:12 -0500
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1B8JA3-0001J7-00
	for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2004 15:20:11 +0200
Received: from 213.41.133.51 ([213.41.133.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2004 15:20:11 +0200
Received: from bevand_m by 213.41.133.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2004 15:20:11 +0200
In-Reply-To: <4066021A.20308@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 
> [...]
> With this simple patch, the max request size goes from 128K to 32MB...
> so you can imagine this will definitely help performance.  Throughput
> goes up.  Interrupts go down.  Fun for the whole family.
> [...]

I have experienced a noticeable improvement concerning the CPU usage
and disk throughput with this patch.

Benchmark specs:

 o read from only 1 disk (sda), or from 2 disks (sda+sdb), with
   1 or 2 instances of "dd if=/dev/sd? of=/dev/null bs=100M".
 o hardware: two Seagate 160GB SATA, on a Silicon Image 3114, on a
   32-bit/33MHz PCI bus, 1GB RAM.
 o software: kernel 2.6.5-rc2-bk6-libata2.

Benchmark datas:

    without the speed-up-sata patch       with the speed-up-sata patch
    reading sda     reading sda+sdb     reading sda     reading sda+sdb
bi      57000             92000             57000             97000
in       1900              2400              1600              1800
cs       1800              3300              1400              1700
sy        11%               20%                9%               16%
us         0%                0%                0%                0%

("bi, in, cs, sy, us" have been reported by vmstat(8))

When reading only from sda, the speed-up-sata patch makes the number of
interrupts/s drop from 1900 to 1600 (CPU usage: 11% to 9%). The throughput
does not improve because 57000 blocks/s is the physical limit of the hardisk.

When reading from both sda and sdb, the improvement is more visible: the
number of interrupts/s goes from 2400 to 1800 (CPU usage: 20% to 16%). But
in this case, the throughput improves from 92000 blocks/s to 97000 blocks/s.
I think I am reaching the physical limit of the PCI bus (theoretically it
would be 133 MB/s or 133000 blocks/s). When setting the PCI latency timer of
the SiI3114 controller to 240 (was 64), I am able to reach 100000 blocks/s.

As other people were complaining that the 32MB max request size might be too
high, I did give a try to 1MB (by replacing "65534" by "2046" in the patch).
There is no visible differences between 32MB and 1MB.

PS: Jeff: "pci_dma_mapping_error()", in libata-core.c from your latest
2.6-libata patch, is an unresolved symbol. I have had to comment it out
to be able to compile the kernel.

-- 
Marc Bevand

