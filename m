From: Tejun Heo <htejun@gmail.com>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Mon, 25 Feb 2008 14:20:58 +0900
Message-ID: <47C2503A.7040308@gmail.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca> <47BFAC06.5030805@rtr.ca> <47C116D4.1090600@gmail.com> <47C248C8.9090409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:13667 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974AbYBYFVH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Feb 2008 00:21:07 -0500
Received: by wr-out-0506.google.com with SMTP id c48so2164226wra.23
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 21:21:04 -0800 (PST)
In-Reply-To: <47C248C8.9090409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
> No, the quickest solution for sata_mv, the one I apparently will now be
> using,
> is to just clone about 250 lines of reset/debouce/probe code from
> libata-core
> and change perhaps five lines of it to work around this issue plus some
> chipset errata.
> 
> What I was thinking of, before, is the SATA specification which details
> use of bits in the SCR to select a PMP port.  Pretty much exactly as
> this chipset does it, except in the SCR rather than a proprieary port.
> 
> But no big deal.  I can clone code and not bother you any more.
> In fact, some of the cloned code was already in sata_mv, and I removed
> it this past week in my local working copy.  I'll just restore that,
> along with another big blob so that we can select pm port where needed.
> 
> What a shame.

The order is somewhat reversed here and I can understand why you're
frustrated but I'm just trying to make things look right in long term,
so feel free to bother me. :-) For temporary solution, I'm okay either
way.  I'll clean things up later when the necessary core changes are made.

* Adding ->pmp_select or ->scr_pmp_rw or whatever callback to work
around the current problem.

* Duplicate code in sata_mv.

Whichever way you go, can you please mark where it's different and why?

Thanks.

-- 
tejun
