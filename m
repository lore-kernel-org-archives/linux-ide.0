From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Bart's efforts?
Date: Sat, 3 Nov 2007 16:41:19 +0100 (MET)
Message-ID: <200711031541.lA3FfJ6h006120@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:41251 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbXKCPlm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2007 11:41:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk, greg.freemyer@gmail.com
Cc: linux-ide@vger.kernel.org

On Sat, 3 Nov 2007 14:10:22 +0000, Alan Cox wrote:
> > My question is if the drivers/ide infrastructure is slowly moving in
> > the direction of being leverageable by libata when/if it moves out of
> > scsi.  Or does the drivers/ide code simply have the wrong kind of
> > plumbing for libata to ever use.
> 
> I don't think there is anything useful in old IDE that isn't in the new.

For semi-modern machines that might be true. However:

1) there's no libata replacement for the IDE pmac driver
2) pata_pdc202xx_old can't do UDMA on my 440BX PIII box
3) pata_legacy doesn't release io/irq combinations for failed
   probes, causing conflicts with drivers loaded later on

(Not a complaint, just a reminder that rm -rf drivers/ide/
isn't an option yet.)
