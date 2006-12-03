From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
Date: Sun, 03 Dec 2006 15:16:07 +0100
Message-ID: <1165155367.3233.220.camel@laptopd505.fenrus.org>
References: <200612010958.kB19wGbg002454@alkaid.it.uu.se>
	 <4572CA7A.6010103@gmail.com> <4572CB2B.8050406@garzik.org>
	 <4572CEE7.502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:56279 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S936703AbWLCOQl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 09:16:41 -0500
In-Reply-To: <4572CEE7.502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


> But, having those flushes won't hurt either.  What was the conclusion of
> mmio <-> spinlock sync discussion?  I always feel kind of uncomfortable
> about readl() flushes.  I think they're too subtle.

those are orthogonal!
The posting flushes have nothing to do with spinlock-vs-mmio; that
discussion was about the CPU, while posting flushes are about the
chipset / bridges / etc....

> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

