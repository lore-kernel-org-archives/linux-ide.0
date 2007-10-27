From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH-RFC] (was: Re: Sata Sil3512 bug?;  Promise SATA300 TX4)
Date: Sat, 27 Oct 2007 16:53:27 +0200 (MEST)
Message-ID: <200710271453.l9RErRj9020770@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:58513 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbXJ0Oxy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Oct 2007 10:53:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, screwdriver@lxnt.info
Cc: MisterE2002@zonnet.nl, benh@kernel.crashing.org, htejun@gmail.com, jeff@garzik.org, jgarzik@pobox.com

On Sat, 27 Oct 2007 17:24:32 +0400, Alexander Sabourenkov wrote:
> There appears to be a hardware bug in that it chokes on scatterlist
> if the last item is larger than 164 bytes.
> 
> The patch that follows fixes my problem on 2.6.22.
> 
> I can't think of a way to avoid second pass over scatterlist without
> duplicating code (ata_qc_prep() and ata_fill_sg() from libata-core.c).
> 
> 
> --- a/drivers/ata/sata_promise.c	2007-07-09 03:32:17.000000000 +0400
> +++ b/drivers/ata/sata_promise.c	2007-10-27 17:20:03.000000000 +0400

Interesting, but can you please give more background information?
I.e., how did you determine the existence of this bug?

And please cc: the sata_promise maintainer on sata_promise patches.
(Hint: that's me)

And please choose a Subject: that makes it absolutely clear what
the post is about. "Sata Sil3512 bug" doesn't exactly sound like
something the sata_promise maintainer needs to look at.

Meanwhile I'll check the Promise driver(s) to see if there's
something about SG table formatting restrictions there.

/Mikael
