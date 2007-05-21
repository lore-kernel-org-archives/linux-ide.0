From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Handle SATA bridges better
Date: Mon, 21 May 2007 17:14:10 +0100
Message-ID: <20070521171410.6920bd3b@the-village.bc.nu>
References: <20070521151332.4ec9ea1d@the-village.bc.nu>
	<4651AB20.7070103@gmail.com>
	<20070521154741.490bcdb6@the-village.bc.nu>
	<4651B23A.40207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55427 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760792AbXEUQLf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 12:11:35 -0400
In-Reply-To: <4651B23A.40207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

> I think host side detection should work as long as the bridge properly
> releases CBLID after IDENTIFY.  Drive side detection seems hopeless
> unless the bridge modifies IDENTIFY data accordingly.  Maybe the best we
> can do here is allowing user to select transfer mode.  :-(

There are far too many systems with this kind of bridge to just dump it
on the user. I'll have a think about doing it only if the controller
hasn't decided the cable is 40 wire. That might work.

> >> Another problem is that there are still codes which interpret ap->cbl ==
> >> ATA_CBL_SATA as SATA host port.  They need to be fixed first before
> >> using ap->cbl for the actual cable type.
> > 
> > I thought we had those all sorted now. A grep shows there is nobody doing
> > conditional checking off the ap->cbl cable in drivers/ata any more. They
> > did in the past - which is this patch got held up - but no longer that I
> > can see.
> 
> Hmm... I was looking at sata_scr_valid().  I think this needs to be
> converted to ATA_FLAG_SATA test too.

Possibly but PATA controllers don't have ->scr_read so its ok as is.
