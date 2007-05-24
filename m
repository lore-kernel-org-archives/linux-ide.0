From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 20:08:50 +1000
Message-ID: <1180001330.32247.1058.camel@localhost.localdomain>
References: <20070515061239.611A2DDEE9@ozlabs.org>
	 <1179209697.32247.153.camel@localhost.localdomain>
	 <20070523144217.5abd9fdf@the-village.bc.nu>
	 <1179960518.32247.948.camel@localhost.localdomain>
	 <20070524003123.77b9c81c@the-village.bc.nu> <46552A63.4080002@pobox.com>
	 <20070524093316.GB10777@devserv.devel.redhat.com>
	 <4655611E.6050805@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45285 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665AbXEXKJD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 06:09:03 -0400
In-Reply-To: <4655611E.6050805@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, 2007-05-24 at 05:55 -0400, Jeff Garzik wrote:
> Alan Cox wrote:
> > On Thu, May 24, 2007 at 02:02:11AM -0400, Jeff Garzik wrote:
> >> Ben's patch got merged because it does not change the status quo.  This 
> > 
> > Yes it does - Thats PATA and now
> > PATA + MMIO so the problem case.
> 
> hmmm, true.

I think Jeff is right. I was not completley sure about the 400ns case in
ata_pause but I think it's a good idea to use mmio_flush hook there.

The only thing that I'm wondering about a bit is that ata_pause so far
uses read of altstatus which _is_ a taskfile register. It's my
understanding that we should avoid doing so in that case.

So my patch will use the new mmio_flush hook instead, however, that
means that PIO and SATA controllers will have NULL there, thus no read.
We will have to be careful just in case something actually manages to
regress because of the loss of that read. (with IDE, anything is
possible !)


Cheers,
Ben.

