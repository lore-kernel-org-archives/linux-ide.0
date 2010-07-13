From: Mark Lord <kernel@teksavvy.com>
Subject: Re: If I have a single bad sector, how many failed reads should
 simple dd report?
Date: Tue, 13 Jul 2010 15:07:17 -0400
Message-ID: <4C3CB965.7050909@teksavvy.com>
References: <AANLkTil2Zfhpkq24qrCoHZVx1vlbIPTcDMrZ508yODta@mail.gmail.com>	 <AANLkTimWfp4mLF9DCpxtnnUQsYQ08gXmh491EfhARe1x@mail.gmail.com>	 <4C37CA99.1040104@teksavvy.com>  <4C37CBB8.1040909@teksavvy.com> <1278771271.2911.18.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:24632 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751167Ab0GMTHV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jul 2010 15:07:21 -0400
In-Reply-To: <1278771271.2911.18.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

On 10/07/10 10:14 AM, James Bottomley wrote:
..
> The check is redundant:  scsi_decide_disposition is where we check for
> retries or error handling.  If you look, it already picks out your three
> cases and returns success for them (meaning pass straight through).  in
> sd_done() MEDIUM_ERROR means complete immediately.
..
> This one's in the wrong place.  Normal MEDIUM_ERRORS complete above
> this.
>
> I also don't think the skip is right.  We're supposed to communicate to
> block what we've done, and all we have to do that with is good bytes.
> If we skip over a bad sector and try to complete the rest, we've lost
> the error position.
..

No, on 2.6.27, those patches work exactly as they should.
Failing (to the block layer) the bad sector(s), and successfully reading all others.

Try it.  It works.
But horribly out of date for the newer kernels,
which is why it's not in your patch queue from me.  :)

Cheers
