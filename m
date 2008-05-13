From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv on Orion: CONFIG_SATA_PMP=y needed even when no multiplier
Date: Tue, 13 May 2008 17:12:12 -0400
Message-ID: <482A042C.4050101@rtr.ca>
References: <20080512132840.GA15711@deprecation.cyrius.com> <482866F2.5040901@rtr.ca> <48295533.4080800@gmail.com> <482A037E.4070504@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3747 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759293AbYEMVMN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 May 2008 17:12:13 -0400
In-Reply-To: <482A037E.4070504@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Martin Michlmayr <tbm@cyrius.com>, linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org

Mark Lord wrote:
> Tejun Heo wrote:
>> Mark Lord wrote:
> ..
>>> I suppose we could just always ask for the extra soft-reset here (?)
>>
>> Hmm... sata_mv doesn't do device classification, right?  If so, it 
>> should return -EAGAIN on success to tell EH to perform follow-up SRST.
> ..
> 
> Right now, mv_hardreset() is just a wrapper around sata_link_hardreset(),
> and it just returns whatever it gets back from sata_link_hardreset().
> 
> And sata_link_hardreset() only returns -EAGAIN for hosts that support PMP.
> 
> Should sata_link_hardreset() instead always return -EAGAIN instead of 0 ?
> Because that's essentially what we'd be doing by changing mv_hardreset()
> to do that.
...

Mmm.. or maybe sata_mv should do what sata_std_hardreset() does:

   rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
   return online ? -EAGAIN : rc;

Or, for that matter, perhaps sata_mv should just be calling sata_std_hardreset()
instead of sata_link_hardreset().   Those all got changed around at the same time
that I was working on sata_mv, so I might not have it quite right there (?).

Cheers
