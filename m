From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
Date: Wed, 06 Dec 2006 18:38:12 +0900
Message-ID: <45768F84.7090707@gmail.com>
References: <200612010958.kB19wGbg002454@alkaid.it.uu.se>	 <4572CA7A.6010103@gmail.com> <4572CB2B.8050406@garzik.org>	 <4572CEE7.502@gmail.com> <1165155367.3233.220.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:34352 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760377AbWLFJiT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2006 04:38:19 -0500
Received: by wx-out-0506.google.com with SMTP id h27so157893wxd
        for <linux-ide@vger.kernel.org>; Wed, 06 Dec 2006 01:38:18 -0800 (PST)
In-Reply-To: <1165155367.3233.220.camel@laptopd505.fenrus.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jeff@garzik.org>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> But, having those flushes won't hurt either.  What was the conclusion of
>> mmio <-> spinlock sync discussion?  I always feel kind of uncomfortable
>> about readl() flushes.  I think they're too subtle.
> 
> those are orthogonal!
> The posting flushes have nothing to do with spinlock-vs-mmio; that
> discussion was about the CPU, while posting flushes are about the
> chipset / bridges / etc....

The problem is that it's not clear what those posting flushes actually
achieve.  Do they achieve IRQ disabling on completion?  Hardly, IRQ can
use whole different channel anyway.

And, as for spinlock/IO ordering, libata currently depends on IO
instructions not leaking outside of spinlock (ordering-wise).  We have
posting flushes at several places and some of them clearly make sense
(e.g. timed wait) but some others aren't that clear while majority of
places just don't do anything about ordering other than wrapping them
inside spinlock.

So, I don't really know.  Do we have to add mmiowb() before every
spin_unlock after IO?  Or, do we have to do explicit flushes everytime?
 Or, is it something to be taken care of in the upper layer?

-- 
tejun
