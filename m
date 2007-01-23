From: Tejun Heo <htejun@gmail.com>
Subject: Re: PATA ATAPI detection debug
Date: Tue, 23 Jan 2007 15:30:03 +0900
Message-ID: <45B5AB6B.5070903@gmail.com>
References: <45AB36B0.2050702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:53340 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933073AbXAWGaL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jan 2007 01:30:11 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1595686wxd
        for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 22:30:11 -0800 (PST)
In-Reply-To: <45AB36B0.2050702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: ahaas@airmail.net, fragabr@gmail.com, j.taimr@chello.nl, ben@atomnet.co.uk, acb@h2h.de, tkrah@fachschaft.imn.htwk-leipzig.de, sero4linux@freenet.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello, all.
> 
> Many people have been reporting libata PATA ATAPI detection problem.  In
> many but not all cases, the ATAPI device was occupying the slave slot
> while a disk drive occupies the master slot.  Based on that and J.
> Taimr's nullify freeze on via fix, I made a cocktail patch which
> contained four different fixes and it seemed to have fixed the problem
> for (at least) several people, but the reports are not all consistent.
> 
> The attached patches contain the same four fixes but has a selector
> parameter to enable each fix separately.  Both are equivalent but using
> 2.6.20-rc5 is recommended to rule out detection problems fixed by
> polling IDENTIFY.
> 
> If your libata driver is compiled into the kernel, add
> 'libata.debug_cocktail=N' to your kernel parameter.  If you compile
> libata.ko as module, add 'debug_cocktail=N' module parameter to the
> module parameter.  e.g. 'modprobe libata.ko debug_cocktail=1'.

Daniel Fraga and Sero's cases are different issue while I can't
determine whether J. Taimr's case is limted on via chipset.  So, I need
more input to proceed.

*Please* test and report the results.

Thanks.

-- 
tejun
