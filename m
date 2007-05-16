From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Wed, 16 May 2007 08:05:21 -0400
Message-ID: <20070516120521.GA28020@devserv.devel.redhat.com>
References: <20070516002204.B4AF6DDEC2@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54682 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756600AbXEPMF1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 May 2007 08:05:27 -0400
Content-Disposition: inline
In-Reply-To: <20070516002204.B4AF6DDEC2@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: jgarzik@pobox.com, Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

On Wed, May 16, 2007 at 10:21:34AM +1000, Benjamin Herrenschmidt wrote:
> This patch adds MMIO support to the pata_sil680 for taskfile IOs,
> based on what the old siimage does.
> 
> I haven't bothered changing the chip setup stuff from PCI config
> cycles to MMIO though (siimage does it), I don't think it matters,
> I've only adapted it to use MMIO for taskfile accesses.
> 
> I've tested it on a Cell blade and it seems to work fine.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Alan Cox <alan@redhat.com>

All we need now is >4GB support and its perfection ..

