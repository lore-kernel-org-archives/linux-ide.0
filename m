From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/5] ata: ahci_imx: allow hardware parameters to be
	specified in DT
Date: Mon, 23 Jun 2014 14:39:09 +0100
Message-ID: <20140623133909.GA10978@n2100.arm.linux.org.uk>
References: <E1Wz2u1-0000eI-Py@rmk-PC.arm.linux.org.uk> <4208650.s9DVDPrIZR@amdc1032> <20140623133207.GI32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:39004 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754124AbaFWNjR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2014 09:39:17 -0400
Content-Disposition: inline
In-Reply-To: <20140623133207.GI32514@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Mon, Jun 23, 2014 at 02:32:07PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 23, 2014 at 03:26:11PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Shouldn't all these new properties be documented somewhere in
> > Documentation/devicetree/bindings/ ?
> 
> Shouldn't the existing binding be documented somewhere there?  If someone
> documents the existing implementation, I will happily add to it.  What
> I'm not going to do is to research what the existing bindings are for
> this sucker and do the work that the original submitter should have done
> in the first place.

Let me also point out that these bindings which I'm adding should have
been there right from the very start, before the driver was ever accepted
into mainline.  As the driver stands today, it hard codes the electrical
properties of the Freescale Sabre* boards into the driver, which are
different from the power on defaults of the device - and this is now
something which we're now stuck with since we can't mandate the
properties being present, and the defaults have to be the Sabre*
board values for everything.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
