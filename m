From: Shem Multinymous <multinymous@gmail.com>
Subject: Re: tp_smapi conflict with IDE, hdaps
Date: Tue, 13 Dec 2005 18:04:37 +0200
Message-ID: <41840b750512130804s32fe543xa11933f681973281@mail.gmail.com>
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
	 <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
	 <1134488305.11732.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:27753 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932338AbVLMQEj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Dec 2005 11:04:39 -0500
Received: by zproxy.gmail.com with SMTP id 34so1758284nzf
        for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2005 08:04:38 -0800 (PST)
In-Reply-To: <1134488305.11732.74.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>, Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org

Hi,

On 12/13/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Sounds like it needs someone with an ATA bus analyser, or of course
> someone from IBM to be helpful

(I wonder which is more implausible...)


> > > Trying to arbitrate libata access with unknown bios behaviour isn't going to have a
> > > sane resolution.
> >
> > Why? BTW, isn't this similar to the queue freeze functionality needed
> > by the disk park part of the ThinkPad HDAPS?
>
> What else does that code do, what else might it confuse, what rules and
> locking are hidden in the windows driver that are unknown. Want to risk
> everyones data for that ?

We already take that risk to some degree, since the SMAPI BIOS is also
invoked by the ACPI DSDT and by external events.


> HDAPS doesn't need it btw.

It's not implemented yet, but I gather it's necessary for preventing
the disk from spinning back up as the laptop slides off the table.
Maybe I missed some subsequent discussion?


> > We don't understand the controller interface sufficiently well to
> > fully abstract it (no specs, and the two conflicting drivers do things
> > somewhat differently), so for now the low-level driver may only handle
> > locking... Is there an easier way to just share a mutex?
>
> Yes but that isn't neccessarily the right thing to do. You want the
> abstraction for the resource ownership and expansion. Can you summarize
> the two drivers interaction with the ports ?

You write "command" values into IO ports 0x1610 and 0x161F and, in
some cases, read some results from ports 0x1610-0x161F. Throughout
that, you inspect various bits (whose meaning we don't understand) in
the status port 0x1604. The details of the commands, scheduling and
status bits differ between the drivers. I don't think a full-blown
ownership and expansion infrastructure is necessary, or even possible
without better understanding.


> One large scale example is the i2c bus code which has to deal with
> multiple devices on multiple busses all being used by multiple people at
> the same time.
>
> Another is I2O where the I2O core code owns the I2O controller and the
> detail for it and is used by various device drivers on top. That one is
> fairly high level however and not exactly minimal.
>
> It may well be that in your case the 'core' module can only identify the
> ports, claim them, release them on unload and provide 'lock' and
> 'unlock' functions and the base address.

Thanks for the pointers. I guess the minimal approach is probably
ideal here; are there any such dumb drivers lying around?

  Shem
