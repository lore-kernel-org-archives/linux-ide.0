From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
Date: Sun, 25 Jun 2006 11:15:49 +0200
Message-ID: <449E5445.60008@free.fr>
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1-g19.free.fr ([212.27.42.27]:42975 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S932144AbWFYJPv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jun 2006 05:15:51 -0400
In-Reply-To: <449DBFFD.2010700@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> Data point #3 (or #0...):
> 
> This appears to be a _device_ that sends its interrupt early.
> 
> If that is the case, the device may appear on any controller, not just 
> VIA, and we would have to handle it globally via a device special-case 
> in libata-core.
> 

For the record, the cdrom writer that need this quirk on pata via, works 
on pata sil680.
But 3 microsecond is very short, and the problem could be hidden by the 
controller, or other stuffs.


