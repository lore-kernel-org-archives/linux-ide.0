From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] sata_promise: new EH conversion for 20619 chips
Date: Wed, 7 Feb 2007 21:58:32 +0100
Message-ID: <17866.15736.332271.928733@alkaid.it.uu.se>
References: <200702042144.l14LisBO003772@harpo.it.uu.se>
	<45C8F0FE.90201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:36560 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030600AbXBGU6w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Feb 2007 15:58:52 -0500
In-Reply-To: <45C8F0FE.90201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Jeff Garzik writes:
 > Mikael Pettersson wrote:
 > > This patch updates the sata_promise driver to use new-style
 > > libata error handling for 20619 (TX4000) chips. sata_promise
 > > already uses new EH for the other chips it supports, so the
 > > patch is quite simple:
 > > 
 > > * remove ->phy_reset and ->eng_timeout ops from pdc_pata_ops,
 > >   and instead bind ->freeze, ->thaw, ->error_handler, and
 > >   ->post_internal_cmd to existing new EH functions
 > > * drop ATA_FLAG_SRST from board_20619's flags
 > > * remove now unused pdc_pata_phy_reset() and pdc_eng_timeout()
 > > * pdc_pata_cbl_detect() is now unused, but it contains a cable
 > >   detection procedure that I don't think is mentioned in public
 > >   documentation, so for now I just wrapped it with #if 0/#endif
 > > 
 > > Tested on a TX4000 with both modern working disks and old/quirky
 > > disks. Also used a CD-RW drive to test reading and writing CDs.
 > > 
 > > Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
 > 
 > The lack of cable detection definitely sounds like a bug...?
 > 
 > The standard procedure is to set ap->cbl in your 'prereset' EH hook, as 
 > is done in drivers/ata/pata_sil680.c.

Indeed. Scratch this patch. I'm sending a fix to correct this error,
and will do a revised 20619 new EH patch in a couple of days when I
have access to a TX4000 card again.

BTW, the PATA cable detection procedure matches Promise's drivers,
but the bit it checks is not described in the pdf documents.

/Mikael
