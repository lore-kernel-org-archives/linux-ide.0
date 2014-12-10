From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly
 return zeroes after TRIM
Date: Wed, 10 Dec 2014 23:34:39 +0300
Message-ID: <1418243679.8310.13.camel@HansenPartnership.com>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
	 <20141204170611.GB2995@htj.dyndns.org> <yq14mtahmil.fsf@sermon.lab.mkp.net>
	 <20141205145148.GI4080@htj.dyndns.org>
	 <1418184578.2121.3.camel@HansenPartnership.com>
	 <20141210142927.GA6294@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44714 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932527AbaLJUep (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Dec 2014 15:34:45 -0500
In-Reply-To: <20141210142927.GA6294@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

On Wed, 2014-12-10 at 09:29 -0500, Tejun Heo wrote:
> Hello,
> 
> On Wed, Dec 10, 2014 at 07:09:38AM +0300, James Bottomley wrote:
> > Conversely, drives that return random junk after a trim cause
> > verification failures, so we just elect not to transmit trim down to
> > them from the RAID layer.
> 
> I see.  Thanks for the explanation.  I suppose the current raid
> implementations' metadata handling on partially built devices isn't
> developed enough to simply mark those trimmed blocks as unsynced?

We do have a log, which could be used for RAID-1 for this purpose, but
it doesn't seem to be much used in practise.  It takes extra space which
most admins don't account for.

For RAID-2+ or erasure codes this won't work because a bad block read
corrupts the stripe: the really subtle failure here is that you trim a
stripe and then partially write it, the RMW you do for parity will be an
incorrect partial syndrome because it's based on junk rather than the
syndrome of the other blocks and the corruption wouldn't be detected
until you get an actual disk failure (meaning everything will look fine
until that crucial day you need your data protection mechanism to work).
We could cope with this with an even more subtle logging mechanism,
where we only trim stripes and then log trimmed stripes and insist on
full instead of partial writes so we get back to a known syndrome, but
that's introducing a lot of subtlety into the logging code ...

James


