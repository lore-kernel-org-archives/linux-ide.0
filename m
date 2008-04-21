From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv errata function
Date: Mon, 21 Apr 2008 09:35:03 -0400
Message-ID: <480C9807.3070404@rtr.ca>
References: <3908ea640804210542s4e1e8403tfec4a99816b5d148@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3994 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933377AbYDUNfD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 09:35:03 -0400
In-Reply-To: <3908ea640804210542s4e1e8403tfec4a99816b5d148@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sylver Bruneau <sylver.bruneau@googlemail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Sylver Bruneau wrote:
> Hello,
> during my analysis of some recent patches [1] from Marvell for several
> ARM based (88f5182 & 88f5281) NAS devices, i've found that some
> errata stuff are a little bit different from what is done in sata_mv.c
>  mainline code.
> 
> I don't know if there is a reason for the code not to be the same, but
> I think that it could be useful to bring that to you.
> 
> Here are the facts ...
> First, the fix value for phyMode 3 is a little bit different :
>  while sata_mv.c is applying a
>         tmp &= ~0x7F800000;
> the patch from Marvell (check _fixPhyParams function in
> arch/arm/mach-feroceon/Board
> /SATA/CoreDriver/mvSata.c file) is applying a
>         regVal &= ~0x7F900000;
> 
> The fix value for phyMode 4 is also different for GEN IIE (6042 &
> 7042) devices :
> in Marvell patch, there is an additional fix for this case (where nothing
> seems to be done for this in sata_mv.c) :
>         /* phy mode 4 register of Gen IIE devices has some restriction */
>          if (pAdapter->sataAdapterGeneration >= MV_SATA_GEN_IIE)
>         {
>             phyMode4Value &= ~0x5DE3FFFC;
>             phyMode4Value |= MV_BIT2;
>         }
> 
> I understand that what is done in this function is not well documented,
>  but as it's what is done by Marvell in their patches, do you think that it
> should be merged in sata_mv.c ?
> 
> If so, I will post a proper patch to add this !
..

Thanks, Sylver.

I am currently working on sata_mv on behalf of Marvell,
and a full errata overhaul is in the works for the next
2-3 weeks here.  So those bits will get fixed by me as
part of this effort.

But I will keep your description above in my inbox as a reminder
to double-check those specific items, just in case it differs from
the detailed errata information Marvell has provided to me (under NDA).

Thanks again.

Mark
