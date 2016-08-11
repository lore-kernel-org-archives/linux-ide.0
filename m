From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v5 2/2] Add support for SCT Write Same
Date: Wed, 10 Aug 2016 21:47:40 -0400
Message-ID: <yq1lh04rs8z.fsf@sermon.lab.mkp.net>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
	<1470790829-3793-3-git-send-email-shaun@tancheff.com>
	<CAGnHSEkJtUH6BkLoNB7v1DkF8ffaUf3RX+m=QzMU0-OmG0ZwFw@mail.gmail.com>
	<CAGnHSEkQXN5+6_OLQZEREWp1+W8kn8=ew=oH52oSsV7CaZwOBQ@mail.gmail.com>
	<CAJVOszAQZ_ukCkdBkkn5_iEPUCQKLBF=o-o0v+U=cWiOgQNSRg@mail.gmail.com>
	<CAGnHSE=EnhLwzfuu4wY=WbsA4PJ5tNfwBqErjLL10ea8d3EiGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:30429 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbcHKBry (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2016 21:47:54 -0400
In-Reply-To: <CAGnHSE=EnhLwzfuu4wY=WbsA4PJ5tNfwBqErjLL10ea8d3EiGg@mail.gmail.com>
	(Tom Yan's message of "Wed, 10 Aug 2016 16:50:50 +0000")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun.tancheff@seagate.com>, Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>

>>>>> "Tom" == Tom Yan <tom.ty89@gmail.com> writes:

Tom> Well that is actually the minimum. Modern SSDs often support more
Tom> than one-block payload (e.g. 8, 16...).  It's just our SCSI disk
Tom> driver statically limit it to the minimum. Though it allows only
Tom> 0xffffffff / 512 = 8388607 (SD_MAX_WS16_BLOCKS) blocks per WRITE
Tom> SAME (16) command anyway,

Yes, because that's the biggest command we can express in the block
layer.

Tom> so we can at most allow only a 2-block (well, or 3-block) payload.

We tried turning on multi block payloads and it was a massive disaster.
Many drives reported that they supported 8 block payloads but actually
didn't. Instead of playing the blacklist game we capped it at a single
sector.

Many drives from different vendors were affected by this. So we'd have
to make multi block payloads an explicit opt-in like we did for
discard_zeroes_data. However, given that "big" discards are mainly done
synchronously when creating filesystems, I am not sure there is any real
benefit to this.

-- 
Martin K. Petersen	Oracle Linux Engineering
