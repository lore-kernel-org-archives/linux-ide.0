From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_cmd64x broken in 2.6.33-rc1 on sparc64
Date: Sun, 20 Dec 2009 00:37:01 +0000
Message-ID: <20091220003701.7c5a0257@lxorguk.ukuu.org.uk>
References: <alpine.SOC.1.00.0912200017540.17801@math.ut.ee>
	<4B2D54AC.3080509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54437 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754565AbZLTAfX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2009 19:35:23 -0500
In-Reply-To: <4B2D54AC.3080509@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Meelis Roos <mroos@linux.ee>, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

> > mice: PS/2 mouse device common for all mice
> > ------------[ cut here ]------------
> > WARNING: at drivers/ata/pata_cmd64x.c:268 cmd64x_bmdma_stop+0x3c/0x60()

Which version of the cmd64x patch got applied ?

> Does backing out the following commit fix things?
> 
> 	commit d43744390e460dce6626fb8de2c02a24ff650005
> 	Author: Alan Cox <alan@linux.intel.com>
> 	Date:   Mon Nov 30 13:22:54 2009 +0000
> 
> 	    pata_cmd64x: implement serialization as per notes
> 
> Although quite unlikely, commit f0353813afe784330622596ff141e7525ccd99de 
> may also change things.  Try backing that out, if backing out the first 
> commit (d43744...) fails to improve behavior.

I'll take a look at this after new year but it looks like the old version
ended up in the libata tree without the additional fixes, if so its
pretty trivial to sort out (see Bartlomiej response to the original and
the follow up thread plus fixes)
