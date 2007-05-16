From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Wed, 16 May 2007 22:12:30 +1000
Message-ID: <1179317550.32247.220.camel@localhost.localdomain>
References: <20070516002204.B4AF6DDEC2@ozlabs.org>
	 <20070516120521.GA28020@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44589 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756779AbXEPMMj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 May 2007 08:12:39 -0400
In-Reply-To: <20070516120521.GA28020@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: jgarzik@pobox.com, Linux IDE <linux-ide@vger.kernel.org>

On Wed, 2007-05-16 at 08:05 -0400, Alan Cox wrote:
> On Wed, May 16, 2007 at 10:21:34AM +1000, Benjamin Herrenschmidt wrote:
> > This patch adds MMIO support to the pata_sil680 for taskfile IOs,
> > based on what the old siimage does.
> > 
> > I haven't bothered changing the chip setup stuff from PCI config
> > cycles to MMIO though (siimage does it), I don't think it matters,
> > I've only adapted it to use MMIO for taskfile accesses.
> > 
> > I've tested it on a Cell blade and it seems to work fine.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 
> All we need now is >4GB support and its perfection ..

Sorry, I have an iommu :-)

Ben.

