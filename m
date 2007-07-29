From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream] libata: implement and use
 ata_port_desc() to report port configuration
Date: Sun, 29 Jul 2007 18:55:32 +0100
Message-ID: <20070729185532.180daea3@the-village.bc.nu>
References: <20070729103421.GG22374@htj.dyndns.org>
	<20070729143106.446924ba@the-village.bc.nu>
	<46ACAC2D.8050307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59841 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761287AbXG2Rs2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 13:48:28 -0400
In-Reply-To: <46ACAC2D.8050307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> > Looks as sane an approach. Some obvious errors in the conversion but
> > simply wrong types I/O v MMIO etc not flaws in the proposal
> 
> Care to point out?

I didn't save it but it was things like HPT3x3 seemed to be claiming to
be MMIO - trivial stuff we can clean up in a merge.

> 
> > Unfortunately there is one big horror you've left unconverted - the status
> > address printing in ata_wait_... That is why I ended up going the way I
> > did.
> 
> The only thing I can find is DPRINTK in ata_wait_idle() which can and
> should simply be converted to ata_port_printk("abnormal Status 0x%x\n",
> status).  After all some controller don't even have Status register (FIS
> based ones, ahci, sil24).

That is probably very sensible yes.
