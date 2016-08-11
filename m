From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v5 2/2] Add support for SCT Write Same
Date: Wed, 10 Aug 2016 21:33:51 -0400
Message-ID: <yq1popgrsw0.fsf@sermon.lab.mkp.net>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
	<1470790829-3793-3-git-send-email-shaun@tancheff.com>
	<CAGnHSEkJtUH6BkLoNB7v1DkF8ffaUf3RX+m=QzMU0-OmG0ZwFw@mail.gmail.com>
	<CAGnHSEkQXN5+6_OLQZEREWp1+W8kn8=ew=oH52oSsV7CaZwOBQ@mail.gmail.com>
	<CAJVOszAQZ_ukCkdBkkn5_iEPUCQKLBF=o-o0v+U=cWiOgQNSRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27339 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbcHKBeG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2016 21:34:06 -0400
In-Reply-To: <CAJVOszAQZ_ukCkdBkkn5_iEPUCQKLBF=o-o0v+U=cWiOgQNSRg@mail.gmail.com>
	(Shaun Tancheff's message of "Wed, 10 Aug 2016 09:34:53 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Tom Yan <tom.ty89@gmail.com>, Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>

>>>>> "Shaun" == Shaun Tancheff <shaun.tancheff@seagate.com> writes:

Shaun,

Shaun> You are correct in that we can advertise the larger limit in
Shaun> ata_scsi_dev_config() when only SCT write same is supported
Shaun> rather than fall back to WS10.

I deliberately capped WRITE SAME to 64K blocks unless otherwise reported
by the device because:

        a) Several older drives supported the WRITE SAME(16) command but
        ignored the upper bytes of the transfer length effectively
        turning it into a WRITE SAME(10).

        b) 64K blocks was the sweet spot for older drives as well, a
        size commonly used by RAID array firmwares that were the only
        commonplace users of the WRITE SAME family.

Shaun> I really am not sure what would be considered the correct
Shaun> solution though. I believe that the WRITE SAME defaults are
Shaun> currently being chosen around physical limits.

Lacking a solid reporting facility in the spec, I suggest you just leave
it unset and let the SCSI defaults apply.

Shaun> I think we can also bump the command timeout for WRITE SAME?

The default WRITE SAME timeout is 120s.

-- 
Martin K. Petersen	Oracle Linux Engineering
