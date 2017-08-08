From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] ata: make ata_port_operations const
Date: Tue, 8 Aug 2017 13:41:41 +0530
Message-ID: <CAOH+1jH8BOpM2ZCBC_i0jwL3_uG04pjmwFAZohbTo-_mauod8A@mail.gmail.com>
References: <1502101922-13313-1-git-send-email-bhumirks@gmail.com>
 <20170807150727.GD4050379@devbig577.frc2.facebook.com> <CAOH+1jEQy3PrExruDLWetVd=iWYX3sf13Ku5G5CUUbJGADsNvw@mail.gmail.com>
 <20170807162920.GA537256@devbig577.frc2.facebook.com> <1502123652.2219.24.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502123652.2219.24.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Tejun Heo <tj@kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Aug 7, 2017 at 10:04 PM, Joe Perches <joe@perches.com> wrote:
> On Mon, 2017-08-07 at 09:29 -0700, Tejun Heo wrote:
>> Hello,
>>
>> On Mon, Aug 07, 2017 at 08:54:21PM +0530, Bhumika Goyal wrote:
>> > I compiled the .o files and checked the size before and after
>> > compilation. After making the structure const, bytes should move from
>> > data to text segment of the memory and this is what happened. So, this
>> > is how I tested it.
>>
>> Ah, I see, so the port_operations is never used directly.  I'm not
>> sure whether it'd be a good idea to selectively pick these and makr
>> them const.  Let's just leave them be.
>
> Why?
>
> Things that are never accessed as other than const should
> be const no?
>

I think it would be better to leave them as in most situations the
ata_port_operations structures cannot be const as they are only used
in the port_ops field of an ata_port_info structure and this field is
not const. Having two ata_port_operations const and others non-const
will cause code inconsistency.

Thanks,
Bhumika

> Why leave unnecessary exposure for muckery?
