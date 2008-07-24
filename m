From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall back
Date: Thu, 24 Jul 2008 16:24:17 +0100
Message-ID: <20080724152417.GP26938@trinity.fluff.org>
References: <20080723144227.253944199@fluff.org> <20080723163216.7477be06@lxorguk.ukuu.org.uk> <20080723190433.GB26938@trinity.fluff.org> <20080723201349.33226d58@lxorguk.ukuu.org.uk> <20080724112637.GG26938@trinity.fluff.org> <20080724121450.7c30bc61@lxorguk.ukuu.org.uk> <20080724115000.GJ26938@trinity.fluff.org> <20080724125823.727e96db@lxorguk.ukuu.org.uk> <20080724135203.GM26938@trinity.fluff.org> <20080724153338.646a8182@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:51268 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbYGXPYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 11:24:19 -0400
Content-Disposition: inline
In-Reply-To: <20080724153338.646a8182@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

On Thu, Jul 24, 2008 at 03:33:38PM +0100, Alan Cox wrote:
> > Ok, so this controller is not performing to the IRQ portion of the PCI
> > IDE specification, but is this any reason to force it back into legacy
> > mode?
> 
> Well the obvious reason to do that is that is what the BIOS guide says
> and what the standards expect. Given that legacy mode has no performance
> impact at all as it just changes the IRQ interpretation and the port
> mapping rules it seems silly not to do that

I've changed drivers/ata/pata_ali.c to change the mode back to compatibility
mode, but libata-sff.c is still trying to use the pci configuration BARs
to map the control registers. If the copy of the "PCI IDE Controller
Specification, Revision 1.0" [1] is to be belived, the values in the PCI BARs
should be ignored.

[1] http://suif.stanford.edu/~csapuntz/specs/pciide.ps
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

