From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] drivers/ata: PATA driver for Celleb
Date: Fri, 12 Jan 2007 08:36:39 +1100
Message-ID: <1168551400.22458.419.camel@localhost.localdomain>
References: <200701110853.l0B8roEl018444@toshiba.co.jp>
	 <200701111025.04927.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:34909 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbXAKVg5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Jan 2007 16:36:57 -0500
In-Reply-To: <200701111025.04927.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Akira Iguchi <akira2.iguchi@toshiba.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, paulus@samba.org


> Actually, an even stronger reason to use an abstraction is the
> fact that this is not really a PCI device and you therefore
> don't use readl/writel, but rather in_be32/out_be32.
> 
> If you think the code gets better by using the low-level calls,
> then it would be good if you also do the patch to implement them.
> 
> My feeling about your driver is that the amount of code duplication
> is far too much, and it should better be based on generalizing the
> existing libata code to deal with whatever you need to handle
> differently.

I've been having a quick look at it since at least another driver has a
similar issue (needing to replace the taskfile accessors for individual
register accesses). Right now, you can only re-implement the whole reset
handling, you can't have it just use different register accessors. I
think that's a waste.

Best way might be to have a hook for individual register access... the
reset code basically needs the control register and the LBA for the
signature (and status but there's already a hook for it).

Ben.


