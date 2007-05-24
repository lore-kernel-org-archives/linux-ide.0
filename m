From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 20:06:10 +1000
Message-ID: <1180001170.32247.1054.camel@localhost.localdomain>
References: <20070515061239.611A2DDEE9@ozlabs.org>
	 <1179209697.32247.153.camel@localhost.localdomain>
	 <20070523144217.5abd9fdf@the-village.bc.nu>
	 <1179960518.32247.948.camel@localhost.localdomain>
	 <20070524003123.77b9c81c@the-village.bc.nu>  <46552A63.4080002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45271 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755679AbXEXKGU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 06:06:20 -0400
In-Reply-To: <46552A63.4080002@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, 2007-05-24 at 02:02 -0400, Jeff Garzik wrote:
> MMIO has always been like this (libata-core.c):
> 
>          /* software reset.  causes dev0 to be selected */
>          iowrite8(ap->ctl, ioaddr->ctl_addr);
>          udelay(20);     /* FIXME: flush */
>          iowrite8(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
>          udelay(20);     /* FIXME: flush */
>          iowrite8(ap->ctl, ioaddr->ctl_addr);

Yup, one of the things my patch adds is a mmio_flush optional hook that
I added in there just before the udelay's.

> The problem is mainly in finding registers you can read without side 
> effects or confusing the controller which might also be doing in-silicon 
> reset procedures.
> 
> The above is not correct per PCI posting, hence the FIXME, but it works 
> so far for all tested cases.

Yes. For most MMIO controllers, reading the PRD table base address is
probably a good enough way to acheive this.

> The timing is irrelevant for SATA (this merely triggers a FIS to be 
> sent).  Most of PATA is not MMIO, so this problem is avoided.  Thus the 
> potential affected cases are PATA MMIO, which is largely PDC and SiI, IIRC.
> 
> Ben's patch got merged because it does not change the status quo.  This 
> warrants looking at -- its a core problem as shown above -- but it 
> requires thinking and testing on a problematic platform :)  Maybe we can 
> read a PCI config register or innocuous vendor-specific register, for 
> the flush, on the few cases where it matters.

I'm adding a hook for that with a generic sff version that controllers
like sil can use that just reads the dbdma prd table pointer.

Now there is still the question of wether the taskfile read for the
400ns delay in ata_pause is correct or not..

Cheers,
Ben.


