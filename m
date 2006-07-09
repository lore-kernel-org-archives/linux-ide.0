From: David Lloyd <dmlloyd@flurg.com>
Subject: Re: Alan's PATA patch vs. Gentoo-ized sata_promise
Date: Sat, 8 Jul 2006 21:00:49 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0607082059590.8571@ultros>
References: <Pine.LNX.4.64.0607081230350.9190@ultros>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound1.mail.tds.net ([216.170.230.91]:5843 "EHLO
	outbound1.mail.tds.net") by vger.kernel.org with ESMTP
	id S1161042AbWGICAx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 22:00:53 -0400
Received: from outaamta02.mail.tds.net (outaamta02.mail.tds.net [216.170.230.32])
	by outbound1.mail.tds.net (8.13.6/8.13.4) with ESMTP id k6920q0R015339
	for <linux-ide@vger.kernel.org>; Sat, 8 Jul 2006 21:00:52 -0500
Received: from localhost ([216.165.189.42]) by outaamta02.mail.tds.net
          with ESMTP
          id <20060709020051.IPWU22195.outaamta02.mail.tds.net@localhost>
          for <linux-ide@vger.kernel.org>; Sat, 8 Jul 2006 21:00:51 -0500
In-Reply-To: <Pine.LNX.4.64.0607081230350.9190@ultros>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sat, 8 Jul 2006, David Lloyd wrote:

> I have a gentoo 2.6.16 kernel (which includes the changes to support 
> pata+sata in promise_sata), and I applied alan's pata patch over it.
>
> Initial results are great, except for one problem: the sata_promise 
> controller acts as if it is no longer DMA-capable, reporting the 
> following on detection:
>
> sata_promise PATA port found
> ata1: SATA max PIO4 cmd 0xF8804200 ctl 0xF8804238 bmdma 0x0 irq 16
> ata2: SATA max PIO4 cmd 0xF8804280 ctl 0xF88042B8 bmdma 0x0 irq 16
> ata3: PATA max PIO4 cmd 0xF8804300 ctl 0xF8804338 bmdma 0x0 irq 16

Ok, figured out where the PIO thing was coming from at least.  On 
(roughly) line 4703 there's a chunk of code like this:

    /* Tidy up if we have no bus master base
       Not sure this is the right spot to do it */
    if (ap->ioaddr.bmdma_addr == 0) {
            ap->udma_mask = 0;
            ap->mwdma_mask = 0;
    }

This bit of code ate my DMA.  I commented out the udma_mask one and 
everything works great.

- DML
