From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Thu, 04 Dec 2014 21:13:22 -0500
Message-ID: <yq14mtahmil.fsf@sermon.lab.mkp.net>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
	<20141204170611.GB2995@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42247 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbaLECN2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2014 21:13:28 -0500
In-Reply-To: <20141204170611.GB2995@htj.dyndns.org> (Tejun Heo's message of
	"Thu, 4 Dec 2014 12:06:11 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

>>>>> "Tejun" == Tejun Heo <tj@kernel.org> writes:

Tejun> Generally, I'm extremely skeptical about whitelists.

Me too. Unfortunately, in this case the blacklist is essentially
unbounded whereas the whitelist is small.

Tejun> If there's something on the horizon which would solve the
Tejun> identification problem and we only have to worry about the
Tejun> current batch of devices, whitelisting can be useful but
Tejun> otherwise I'm not sure this is a good idea.

There isn't :( The only saving grace is that SSDs are gravitating
towards NVMe and other non-ATA interfaces.

Tejun> It's very difficult to keep them meaningfully up-to-date and
Tejun> often just ends up bit rotting after the initial flurry of
Tejun> updates,

I'm well aware that this adds another truckload of ongoing pain to my
plate. Several of us discussed this issue at conferences this fall and
the consensus was that whitelisting is the only way to go about it.

I've already tightened up things in SCSI so we now prefer WRITE SAME
which does give hard guarantees unlike UNMAP. But because we use WRITE
SAME in the libata SATL it is imperative that we change our internal
flagging to be equally restrictive.

Tejun> If there currently is no way of properly indicating this feature,
Tejun> let's please disable it unconditionally.

Well, we recently disabled discard support in MD RAID5/6 to avoid
corruption. There currently is a manual override and that may be good
enough.

I just feel bad about disabling the feature for the many existing users
(and there are quite a few) that are using well-behaved drives in their
RAID deployments. And the filesystem folks have been begging for the
zeroout discard variant that I posted a few weeks ago. So the users are
there. I'm just trying to accommodate them the best I can given the lame
spec.

-- 
Martin K. Petersen	Oracle Linux Engineering
