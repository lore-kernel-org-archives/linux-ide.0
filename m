From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
Date: Fri, 30 Jun 2006 11:03:23 +0100
Message-ID: <1151661803.31392.1.camel@localhost.localdomain>
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net>
	 <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org>
	 <449E5445.60008@free.fr>  <44A4CE21.30009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4252 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932231AbWF3JsR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 05:48:17 -0400
In-Reply-To: <44A4CE21.30009@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: matthieu castet <castet.matthieu@free.fr>, Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>, Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>

Ar Gwe, 2006-06-30 am 15:09 +0800, ysgrifennodd Albert Lee:
> If it is the problem of the specific ATAPI device, all controllers
> should be affected, not only VIA. So, strange not seeing the problem on
> Promise.

That may be because of the way the chips handle buffering of interrupt
delivery and readahead/writebehind. I have two traces on the ALi
chipsets that look like the delayed response problem.


