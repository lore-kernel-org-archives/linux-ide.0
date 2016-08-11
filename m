From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v5 2/2] Add support for SCT Write Same
Date: Thu, 11 Aug 2016 16:04:06 +0800
Message-ID: <CAGnHSEn9EXvyBMqmS5sPYLcBwKnATcd97oW0PFmYRvUA+CGzxw@mail.gmail.com>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
 <1470790829-3793-3-git-send-email-shaun@tancheff.com> <CAGnHSEkJtUH6BkLoNB7v1DkF8ffaUf3RX+m=QzMU0-OmG0ZwFw@mail.gmail.com>
 <CAGnHSEkQXN5+6_OLQZEREWp1+W8kn8=ew=oH52oSsV7CaZwOBQ@mail.gmail.com>
 <CAJVOszAQZ_ukCkdBkkn5_iEPUCQKLBF=o-o0v+U=cWiOgQNSRg@mail.gmail.com>
 <CAGnHSE=EnhLwzfuu4wY=WbsA4PJ5tNfwBqErjLL10ea8d3EiGg@mail.gmail.com> <CAJVOszCWtwgDY=H4YC4-z4Wau6Wgx6PfPQ_rhPGs7trSHfEtEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35200 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932369AbcHKIEI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2016 04:04:08 -0400
In-Reply-To: <CAJVOszCWtwgDY=H4YC4-z4Wau6Wgx6PfPQ_rhPGs7trSHfEtEQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>, martin.petersen@oracle.com
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>

On 11 August 2016 at 02:29, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>>
>> You are talking about an AF 4Kn drive I suppose? For a 512e drive it
>> should be only ~2G.
>
> I stand corrected. Since all the kernel math is 512 byte sectors you are
> absolutely correct and this isn't an issue at all.
>
> We should report SD_MAX_WS16_BLOCKS when only SCT
> is available and 4194240 when TRIM is available.

Why would you come up with such decision/conclusion? I thought
SD_MAX_WS16_BLOCKS could even be too big for 512e drive (~4G per WRITE
SAME command)?

If 4194240 (~2G per command) isn't too big for SCT Write Same, then we
shoud probably stick with it in both cases (when only SCT Write Same
is available / when TRIM is also available) to maintain consistency.

Also Maximum Write Same Length should be multiplied by the actual
logical sector size of the drive, which would be 4096 in the case of
4Kn drives. (If the kernel isn't doing that, it's simply a bug.)

Therefore, if I haven't missed anything, we'll need to divide
ATA_MAX_TRIM_RNUM by (logical sector size / 512) anyway, otherwise
discard_max_bytes and write_same_max_bytes would overflow with 4Kn
drive (i.e. Maximum Write Same Length needs to be <= 0xffffffff /
4096). 4Kn SSDs may not be a thing on the market yet, but apparently
it's a different story for traditional HDDs, and SCT Write Same isn't
only available on SSDs. The division should not change the current
behaviour on drives with 512-byte logical sectors.

I'll be sending a patch on that.
