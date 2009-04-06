From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU space
Date: Mon, 6 Apr 2009 23:48:16 +0100
Message-ID: <20090406234816.05242d4e@lxorguk.ukuu.org.uk>
References: <bug-13001-10286@http.bugzilla.kernel.org/>
	<20090404114559.ce20eb9c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44041 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754890AbZDFWtI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Apr 2009 18:49:08 -0400
In-Reply-To: <20090404114559.ce20eb9c.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, optimusgd@gmail.com, x86@kernel.org

> > Mar 31 20:59:01 rngmhpamd end_request: I/O error, dev sdc, sector 1137
> > Mar 31 20:59:01 rngmhpamd __ratelimit: 246 callbacks suppressed
> 
> Do we have any debugging option for dumping the current PCI DMA
> allocations, find out where it has all gone?

Turn on CONFIG_IOMMU_LEAK and CONFIG_IOMMU_DEBUG for a test run.
