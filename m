From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2.6.26-rc2 1/3] sata_promise: fix irq clearing buglets
Date: Tue, 20 May 2008 10:48:51 +0200
Message-ID: <18482.36979.487666.133247@harpo.it.uu.se>
References: <200805171647.m4HGlZFW015961@harpo.it.uu.se>
	<4831F488.9070802@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:61144 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756120AbYETItE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 May 2008 04:49:04 -0400
In-Reply-To: <4831F488.9070802@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Jeff Garzik writes:
 > Mikael Pettersson wrote:
 > > This patch fixes two bugs in sata_promise's irq status clearing paths:
 > > 1. When clearing the irq status for a specific port, the driver
 > >    read the global SEQMASK register. This is wrong because that
 > >    clears the irq status for _all_ ports.
 > > 2. pdc_thaw() incorrectly added the PDC_INT_SEQMASK host register
 > >    offset to a per-port ata engine base address. This resulted in
 > >    it reading the unrelated PDC_PKT_SUBMIT register, which did not
 > >    have the desired irq status clearing effect.
 > > 
 > > In both cases the fix is to read from the port's Command/Status
 > > register. This also matches what Promise's own driver does.
 > > 
 > > Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
 > > ---
 > >  drivers/ata/sata_promise.c |    7 +++----
 > >  1 file changed, 3 insertions(+), 4 deletions(-)
 > 
 > is sata_sx4 similarly affected?

For issue 2, pdc_thaw(), the answer is No since that's
a sata_promise only thing I added as part of new-EH.

For ->irq_clear() I'll have to check. I'll do that
this evening and let you know tomorrow.

/Mikael
