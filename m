From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly
 return zeroes after TRIM
Date: Wed, 10 Dec 2014 07:09:38 +0300
Message-ID: <1418184578.2121.3.camel@HansenPartnership.com>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
	 <20141204170611.GB2995@htj.dyndns.org> <yq14mtahmil.fsf@sermon.lab.mkp.net>
	 <20141205145148.GI4080@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41309 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755226AbaLJEJn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Dec 2014 23:09:43 -0500
In-Reply-To: <20141205145148.GI4080@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

On Fri, 2014-12-05 at 09:51 -0500, Tejun Heo wrote:
> > I just feel bad about disabling the feature for the many existing users
> > (and there are quite a few) that are using well-behaved drives in their
> > RAID deployments. And the filesystem folks have been begging for the
> > zeroout discard variant that I posted a few weeks ago. So the users are
> > there. I'm just trying to accommodate them the best I can given the lame
> > spec.
> 
> Can you please explain further the practical gains of using trims

It's for RAID devices.  We'd like to trim RAID devices simply by sending
the trim down to every component.  If we actually have to translate trim
to a write it would damage performance (and defeat the purpose of
helping the SSD FTL reuse blocks).  However, RAID requires that the
redundancy verification of the array components matches otherwise a
verify of the RAID fails.  This means we have to have a guarantee what
the verify read of a trimmed block of a RAID component will return.  So
for RAID-1, we just need both trimmed components to return the same data
(we don't actually care what it is, just that it be mirrored); for
RAID-5 we need zeros on every trimmed component, because zero^zero =
zero.

Conversely, drives that return random junk after a trim cause
verification failures, so we just elect not to transmit trim down to
them from the RAID layer.

James


