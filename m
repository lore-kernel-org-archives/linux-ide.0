From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [PATCH][resend] PCI: fix IDE legacy mode resources
Date: Fri, 28 Sep 2007 12:10:59 +0200
Message-ID: <20070928101059.GA13826@deprecation.cyrius.com>
References: <20070824115559.06250ec0.yoichi_yuasa@tripeaks.co.jp> <20070824161442.GB15305@kroah.com> <20070824173713.2bc20bac@the-village.bc.nu> <20070928084840.GA5542@derision.cyrius.com> <20070928111408.119f0631@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:3911 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756746AbXI1KLQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 06:11:16 -0400
Content-Disposition: inline
In-Reply-To: <20070928111408.119f0631@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, greg@kroah.com, akpm@osdl.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [2007-09-28 11:14]:
> > I need this patch for IDE and PATA to work on my MIPS Cobalt.
> > Yoichi's original patch and explanation can be found at
> > http://lkml.org/lkml/2007/8/23/411
> 
> I've no idea why it hasn't been applied unless nobody is quite sure who
> owns it. As a PCI fix I guess Greg does (and drop it into -mm for
> testing) ?

I was also hoping Jeff would comment on the patch.
-- 
Martin Michlmayr
http://www.cyrius.com/
