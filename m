From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 2/4] Add support for SCT Write Same
Date: Tue, 23 Aug 2016 07:57:50 +0000
Message-ID: <CAGnHSEmDrgH7MrQ0bviJ62VV4r2dASpp9pSxFO_RAmPrfkATsg@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-3-shaun@tancheff.com>
 <CAGnHSE=KijjA8ZBhNBQZH-5CeC1w4vu8wWob4Mm9tTKVNSL_GQ@mail.gmail.com>
 <CAJVOszBPL4LM8MYMyrmnfFBqqdV6E3OCpShn12KKFv8E+tSL8Q@mail.gmail.com>
 <CAGnHSEnZe0iipr2hO=QDSq6s7+5JoevXvPNes=WP7gwToFzHsw@mail.gmail.com>
 <CAJVOszAHcuyLoSJwmKvK5vgM8aLqfQJsaw=Vx7K66wMEaqmu_A@mail.gmail.com>
 <CAGnHSEm5Ur-7eCj-_mJsTeDwxhkGHPERAodebDS7rRg0AvGn3Q@mail.gmail.com>
 <CAJVOszC_MfPtGTR05p=qSHjY_wu4ziMMAqgra7Pu0tQYoxa-Kg@mail.gmail.com>
 <CAGnHSEmLq0qcg8_LZBCqFYJohZORBSe58SSjC3sK7cCf=0g9EQ@mail.gmail.com> <CAJVOszCU63Dahdu6ZoKGgbWwwma=Mq5zji4j8ya=57NCwFUB_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJVOszCU63Dahdu6ZoKGgbWwwma=Mq5zji4j8ya=57NCwFUB_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>
List-Id: linux-ide@vger.kernel.org

Hmm,

On 22 August 2016 at 18:00, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>
> Timeout for WS is 120 seconds so we should be fine there.
>
> The number to look for is the:
>    Max. Sustained Transfer Rate OD (MB/s): 190 8TB (180 5TB)
>
> Which means the above drives should complete a 2G write in
> about 10 to 11 seconds.
>
> If these were 4Kn drives and we allowed a 16G max then it
> would be 80-90 seconds, assuming the write speed didn't
> get any better.
>
> So holding the maximum to around 2G is probably the best
> overall, in my opinion.
>
> --
> Shaun Tancheff

On 23 August 2016 at 06:11, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>
> I had thought the conclusion was leave b0 as is and let the WS10 limit
> take effect per Martin.

If that's your final call then you do not need to add the check for
SCT Write Same. (But please make sure that the check for TRIM does not
go away)

> --
> Shaun Tancheff
