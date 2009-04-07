From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU space
Date: Tue, 7 Apr 2009 17:43:29 +0900
Message-ID: <20090407174351C.fujita.tomonori@lab.ntt.co.jp>
References: <20090407104905Q.fujita.tomonori@lab.ntt.co.jp>
	<db2b43030904062205q283f64fal395e61f985a8108b@mail.gmail.com>
	<20090407173841V.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:43475 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbZDGIpq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 04:45:46 -0400
In-Reply-To: <20090407173841V.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: fujita.tomonori@lab.ntt.co.jp
Cc: optimusgd@gmail.com, alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org, linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, x86@kernel.org

On Tue, 7 Apr 2009 17:38:30 +0900
FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:

> > I can't turn on CONFIG_IOMMU_LEAK and CONFIG_IOMMU_DEBUG because
> > 2.6.26.1 not have such options in .config. Maybe git kernel have this
> > options?
> 
> 2.6.26.1 has these options. Probably you don't enable
> DEBUG_KERNEL. But the feature is not much useful, as I said.

Wait, you use 2.6.29, right?
