From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/Review] libata driver for Apple "macio" pata
Date: Sat, 02 Aug 2008 08:43:37 +1000
Message-ID: <1217630617.11188.533.camel@pasglop>
References: <1217581709.11188.489.camel@pasglop>
	 <4892DE7C.2040708@gmail.com> <1217588203.11188.507.camel@pasglop>
	 <20080801165804.GA21906@devserv.devel.redhat.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41873 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761087AbYHAWn4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 18:43:56 -0400
In-Reply-To: <20080801165804.GA21906@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: Tejun Heo <htejun@gmail.com>, list linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Fri, 2008-08-01 at 12:58 -0400, Alan Cox wrote:
> > I know and I believe it should still be ok ... As I said, the chipset
> > should use the PIO field in the register for PIO transfers. And if the
> > above unknown bit is set, I suspect it's just going to increase the
> > setup time a bit or something like that, which won't hurt other than
> > perfs.
> 
> What I do with some other drivers is set the PIO mode in the pio mode function
> but defer DMA timing setup to bmdma_start/stop methods. Some chips need this
> in the PC world and that works nicely.

That would work too I suppose. I already need to tweak the DMA mode in
dbmda_start because of a need on one of the variants of the cell to add
60ns to the setup time on UDMA reads. However, the search for timing is
a bit of overhead I would have been happy to avoid there :-)

Oh well, we'll see how things go, but in this area, I think my current
code will work just fine.

> > The reason is that I can only have 64K-4K per transfer (I don't think I
> > can do 64K per DBDMA entry). So the above routine can potentially
> > breakup, in the worst case scenario, the table into twice as many
> > entries if they are all 64K precisely.
> 
> See ata_sff_dumb_qc_prep - we have PC chips with the same bug!

Yes well, this is an added bug of alignment restrictions which I don't
have (ie, you can't cross 64K boundaries, I'm pretty sure I can :-)

Anyway, setting the max segment size in the new dma params is what I
need to do here.

Cheers,
Ben.

> --
>    "Engineers are 'small children' when it comes to product warning labels"
> 					-- John Duino
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

