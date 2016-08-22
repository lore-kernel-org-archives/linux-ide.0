From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v6 2/4] Add support for SCT Write Same
Date: Mon, 22 Aug 2016 17:07:52 -0500
Message-ID: <CAJVOszAHcuyLoSJwmKvK5vgM8aLqfQJsaw=Vx7K66wMEaqmu_A@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-3-shaun@tancheff.com>
 <CAGnHSE=KijjA8ZBhNBQZH-5CeC1w4vu8wWob4Mm9tTKVNSL_GQ@mail.gmail.com>
 <CAJVOszBPL4LM8MYMyrmnfFBqqdV6E3OCpShn12KKFv8E+tSL8Q@mail.gmail.com> <CAGnHSEnZe0iipr2hO=QDSq6s7+5JoevXvPNes=WP7gwToFzHsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGnHSEnZe0iipr2hO=QDSq6s7+5JoevXvPNes=WP7gwToFzHsw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>
List-Id: linux-ide@vger.kernel.org

On Mon, Aug 22, 2016 at 3:14 PM, Tom Yan <tom.ty89@gmail.com> wrote:
> On 23 August 2016 at 03:43, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>>
>> Why would we enforce upper level limits on something that doesn't
>> have any?
>
> If we advertise a limit in our SATL, it makes sense that we should
> make sure the behaviour is consistent when we issue a write same
> through the block layer / ioctl and when we issue a SCSI Write Same
> command directly (e.g. with sg_write_same). IMHO that's pretty much
> why SBC would mandate such behaviour as well.

Breaking would be advertising a limit that is too high and failing.
Advertising a lower limit and succeeding may not be ideal for all
possible use cases, but it's not breaking behaviour.

>>
>> If the upper level, or SG_IO, chooses to set a timeout of 10 hours and
>> wipe a whole disk it should be free to do so.
>>
>
> That's why I said, "if you are going to advertise an Maximum Write Same Length".

-- 
Shaun Tancheff
