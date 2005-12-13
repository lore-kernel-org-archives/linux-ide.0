From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tp_smapi conflict with IDE, hdaps
Date: Tue, 13 Dec 2005 16:16:15 +0000
Message-ID: <1134490575.11732.104.camel@localhost.localdomain>
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
	 <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
	 <1134488305.11732.74.camel@localhost.localdomain>
	 <41840b750512130804s32fe543xa11933f681973281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932279AbVLNKW6@vger.kernel.org>
In-Reply-To: <41840b750512130804s32fe543xa11933f681973281@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>, Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Maw, 2005-12-13 at 18:04 +0200, Shem Multinymous wrote:
> > What else does that code do, what else might it confuse, what rules and
> > locking are hidden in the windows driver that are unknown. Want to risk
> > everyones data for that ?
> 
> We already take that risk to some degree, since the SMAPI BIOS is also
> invoked by the ACPI DSDT and by external events.

But the ACPI DSDT is OS independant in theory and in practice to a fair
extent. It can't make assumptions about windows drivers.

> > HDAPS doesn't need it btw.
> 
> It's not implemented yet, but I gather it's necessary for preventing
> the disk from spinning back up as the laptop slides off the table.
> Maybe I missed some subsequent discussion?

HDAPS wants to be able to talk with the IDE/libata layer to request it
to hold off requests, thats very different to "gee I wonder what the
bios did"

> You write "command" values into IO ports 0x1610 and 0x161F and, in
> some cases, read some results from ports 0x1610-0x161F. Throughout
> that, you inspect various bits (whose meaning we don't understand) in
> the status port 0x1604. The details of the commands, scheduling and
> status bits differ between the drivers. I don't think a full-blown
> ownership and expansion infrastructure is necessary, or even possible
> without better understanding.

Ok


> Thanks for the pointers. I guess the minimal approach is probably
> ideal here; are there any such dumb drivers lying around?

Its probably easier to write than go find one


I mean you need


tp_hw_init() {
   if (not a thinkpad) return -ENODEV
   request_region(...)
   return 0
}

tp_hw_exit() {
   release_region(...)
}

EXPORT_SYMBOL_GPL(tp_hw_lock); 
EXPORT_SYMBOL_GPL(tp_hw_unlock);

tp_hw_lock() {
    down(&tp_sem);
}

tp_hw_unlock() {
    up(&tp_sem);
}

/* And perhaps if the port varies by machine */

EXPORT_SYMBOL_GPL(tp_hw_addr);

tp_hw_addr() {
    return 0x1600;
}

It can really be that simple
