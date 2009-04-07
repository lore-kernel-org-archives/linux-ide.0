From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU space
Date: Tue, 7 Apr 2009 10:49:12 +0900
Message-ID: <20090407104905Q.fujita.tomonori@lab.ntt.co.jp>
References: <bug-13001-10286@http.bugzilla.kernel.org/>
	<20090404114559.ce20eb9c.akpm@linux-foundation.org>
	<20090406234816.05242d4e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:43983 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757733AbZDGBvi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 21:51:38 -0400
In-Reply-To: <20090406234816.05242d4e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, optimusgd@gmail.com, x86@kernel.org

On Mon, 6 Apr 2009 23:48:16 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > > Mar 31 20:59:01 rngmhpamd end_request: I/O error, dev sdc, sector 1137
> > > Mar 31 20:59:01 rngmhpamd __ratelimit: 246 callbacks suppressed
> > 
> > Do we have any debugging option for dumping the current PCI DMA
> > allocations, find out where it has all gone?
> 
> Turn on CONFIG_IOMMU_LEAK and CONFIG_IOMMU_DEBUG for a test run.

These options don't tell who leaks dma mappings so possibly it isn't
very helpful.

There is no interesting changes in GART IOMMU between 2.6.28 and
2.6.29 so probably this is a driver bug. It's necessary to find out
which driver leaks dma mappings.
