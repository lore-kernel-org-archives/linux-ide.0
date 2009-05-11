From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/4] Series short description
Date: Mon, 11 May 2009 18:25:13 +0100
Message-ID: <20090511182513.5ed7ab9b@lxorguk.ukuu.org.uk>
References: <20090506160612.24191.90737.stgit@t61.ukuu.org.uk>
	<4A085EA7.4070104@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55094 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750754AbZEKRZV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2009 13:25:21 -0400
In-Reply-To: <4A085EA7.4070104@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Mon, 11 May 2009 13:21:43 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > A quick batch of PIIX updates
> > ---
> > 
> > Alan Cox (4):
> >       ata_piix: Remove stale comment
> >       ata_piix: Turn on hotplugging support for older chips
> >       ata_piix: The Sony TZ90 needs the cable type hardcoding
> >       ata_piix: ICH7 does not support correct MWDMA timings
> 
> I guess 1 & 2 are #upstream-fixes material, and 3 & 4 are #upstream ?

I'd say they are all fixes. In terms of urgency #4 hasn't been reported
by anyone it was found when checking errata, #3 is a real problem
encountered by users #2 affects only fairly obscure hardware and isn't a
regression, #1 is a comment.

I've also now confirmed with the Intel hardware folks that there isn't
any reason we can't turn on parallel probing in ata_piix.

Alan
