From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU space
Date: Tue, 7 Apr 2009 17:38:30 +0900
Message-ID: <20090407173841V.fujita.tomonori@lab.ntt.co.jp>
References: <20090406234816.05242d4e@lxorguk.ukuu.org.uk>
	<20090407104905Q.fujita.tomonori@lab.ntt.co.jp>
	<db2b43030904062205q283f64fal395e61f985a8108b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:51731 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbZDGIks (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 04:40:48 -0400
In-Reply-To: <db2b43030904062205q283f64fal395e61f985a8108b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: optimusgd@gmail.com
Cc: fujita.tomonori@lab.ntt.co.jp, alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org, linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, x86@kernel.org

> I can't turn on CONFIG_IOMMU_LEAK and CONFIG_IOMMU_DEBUG because
> 2.6.26.1 not have such options in .config. Maybe git kernel have this
> options?

2.6.26.1 has these options. Probably you don't enable
DEBUG_KERNEL. But the feature is not much useful, as I said.


> Bug triggered when i try mount sata drive on sata_nv and usb
> hdd on echi_hcd. In all other cases i have no problem.

One of them might cause you problem. As I wrote in the previous mail,
we need to know which driver is bad.

1. build a kernel without usb storage or any nics. Then do lots of
I/Os for minutes to see if sata_nv is fine.

2. if sata_ntv seems to be fine, build a kernel without any nics (I
guess your box can't boot without sata_nv). Then do lots of I/Os for
usb storage.

3. If the both is fine, you could have other bad driver (might be nic).
