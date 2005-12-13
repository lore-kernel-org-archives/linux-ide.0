From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tp_smapi conflict with IDE, hdaps
Date: Tue, 13 Dec 2005 15:38:25 +0000
Message-ID: <1134488305.11732.74.camel@localhost.localdomain>
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
	 <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751015AbVLMPjA@vger.kernel.org>
In-Reply-To: <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>, Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Maw, 2005-12-13 at 17:29 +0200, Shem Multinymous wrote:
> Sure, that would be ideal. But how? You can't get that from the SMAPI
> BIOS - it's totally opaque. You just write a constant to port 0xB2,
> which triggers an SMI; the BIOS merrily does its thing in SMM and
> returns; you see the final results in the CPU registers.

Sounds like it needs someone with an ATA bus analyser, or of course
someone from IBM to be helpful

> The thing is, there *is* a working interface, which is also used by
> the Windows drivers...

And the BIOS and driver hackers for IBM wrote both bits and had all the
source and made them aware of each other. We don't have that luxury.

> > Trying to arbitrate libata access with unknown bios behaviour isn't going to have a
> > sane resolution.
> 
> Why? BTW, isn't this similar to the queue freeze functionality needed
> by the disk park part of the ThinkPad HDAPS?

What else does that code do, what else might it confuse, what rules and
locking are hidden in the windows driver that are unknown. Want to risk
everyones data for that ?

HDAPS doesn't need it btw.

> We don't understand the controller interface sufficiently well to
> fully abstract it (no specs, and the two conflicting drivers do things
> somewhat differently), so for now the low-level driver may only handle
> locking... Is there an easier way to just share a mutex?

Yes but that isn't neccessarily the right thing to do. You want the
abstraction for the resource ownership and expansion. Can you summarize
the two drivers interaction with the ports ?

> Anyway, can you point out a minimal example (or two) of such low-level
> drivers in the current kernel, so I can imitate the recommended
> interface convention?

One large scale example is the i2c bus code which has to deal with
multiple devices on multiple busses all being used by multiple people at
the same time.

Another is I2O where the I2O core code owns the I2O controller and the
detail for it and is used by various device drivers on top. That one is
fairly high level however and not exactly minimal.

It may well be that in your case the 'core' module can only identify the
ports, claim them, release them on unload and provide 'lock' and
'unlock' functions and the base address.
