From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][resend] fix IDE legacy mode resources
Date: Fri, 24 Aug 2007 17:37:13 +0100
Message-ID: <20070824173713.2bc20bac@the-village.bc.nu>
References: <20070824115559.06250ec0.yoichi_yuasa@tripeaks.co.jp>
	<20070824161442.GB15305@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49014 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751242AbXHXQ32 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Aug 2007 12:29:28 -0400
In-Reply-To: <20070824161442.GB15305@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>

>>     PCI: Unable to reserve I/O region #1:8@f00001f0 for device 0000:00:09.1
> > 
> > In some architectures, PCI bus regions have the offset from PCI resources.
> > For this reason, pci_setup_device() should set PCI bus regions to dev->resource[]. 
> 
> I thought this patch was rejected in the past as it broke other
> machines.

News to me.

Ths one looks sane and is different to the one Andrew has been fiddling
with to stop broken X servers from crashing.

Alan
