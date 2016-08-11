From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v5 2/2] Add support for SCT Write Same
Date: Thu, 11 Aug 2016 16:46:31 +0800
Message-ID: <CAGnHSE=u1fPLVt4h_VxnCqHTx_YgyQhPGoiXgkoVd1jhrAogiw@mail.gmail.com>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
 <1470790829-3793-3-git-send-email-shaun@tancheff.com> <CAGnHSEkJtUH6BkLoNB7v1DkF8ffaUf3RX+m=QzMU0-OmG0ZwFw@mail.gmail.com>
 <CAGnHSEkQXN5+6_OLQZEREWp1+W8kn8=ew=oH52oSsV7CaZwOBQ@mail.gmail.com>
 <CAJVOszAQZ_ukCkdBkkn5_iEPUCQKLBF=o-o0v+U=cWiOgQNSRg@mail.gmail.com>
 <CAGnHSE=EnhLwzfuu4wY=WbsA4PJ5tNfwBqErjLL10ea8d3EiGg@mail.gmail.com> <yq1lh04rs8z.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yq1lh04rs8z.fsf@sermon.lab.mkp.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Shaun Tancheff <shaun.tancheff@seagate.com>, Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>
List-Id: linux-ide@vger.kernel.org

On 11 August 2016 at 09:47, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Tom> so we can at most allow only a 2-block (well, or 3-block) payload.
>
> We tried turning on multi block payloads and it was a massive disaster.
> Many drives reported that they supported 8 block payloads but actually
> didn't. Instead of playing the blacklist game we capped it at a single
> sector.

I don't know, apparently Windows does multi block payloads though (at
least that's how it advertise on the simulated VPD).

What I meant was it will not make a big difference in our case anyway.
Given the 32-bit representation limitation, we could be at best using
a full 2-block payload. So let's not do 2 but 1? Fine :P

>
> Many drives from different vendors were affected by this. So we'd have
> to make multi block payloads an explicit opt-in like we did for
> discard_zeroes_data. However, given that "big" discards are mainly done
> synchronously when creating filesystems, I am not sure there is any real
> benefit to this.
>

Probably. Perhaps it could make a difference upon deletion of some
really big files (though the logical sectors used may not be
continuous anyway).

> --
> Martin K. Petersen      Oracle Linux Engineering
