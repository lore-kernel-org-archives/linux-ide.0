From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] libata: implement per-dev xfer masks
Date: Mon, 13 Mar 2006 11:41:10 +0000
Message-ID: <1142250070.25773.11.camel@localhost.localdomain>
References: <11421469551948-git-send-email-htejun@gmail.com>
	 <1142170646.18565.3.camel@localhost.localdomain>
	 <20060313061221.GA29476@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35714 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751243AbWCMLfp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 06:35:45 -0500
In-Reply-To: <20060313061221.GA29476@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Llu, 2006-03-13 at 15:12 +0900, Tejun Heo wrote:
> callback can be added later when merging PATA code.  One concern I
> have about the originally proposed ->mode_filter(ap, dev, mask, shift)
> interface is that if a LLDD wants to reject all UDMA and limit some of
> MWDMA, there is no way to do so.  I think it's better and easier to
> filter all mode masks at once.


The current code is called three times once for PIO once for MWDMA and
once for UDMA (since we don't do SWDMA yet). Doing it as one seems
sensible enough, it just didn't fit how the old code worked.


I also agree strongly we need ap-> and dev-> masks in the same format
throughout libata and the drivers or there are going to be disasters

