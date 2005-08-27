From: Pavel Machek <pavel@suse.cz>
Subject: Re: PATCH: ide: ide-disk freeze support for hdaps
Date: Sat, 27 Aug 2005 14:34:08 +0200
Message-ID: <20050827123408.GD1109@openzaurus.ucw.cz>
References: <253818670508250708a9075a0@mail.gmail.com> <58cb370e0508250859701ea571@mail.gmail.com> <253818670508252204b22e8c2@mail.gmail.com> <20050826065515.GQ4018@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751645AbVH0Tbt@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050826065515.GQ4018@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Yani Ioannou <yani.ioannou@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jon Escombe <lists@dresco.co.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alejandro Bonilla Beeche <abonilla@linuxwireless.org>, linux-kernel <linux-kernel@vger.kernel.org>, hdaps devel <hdaps-devel@lists.sourceforge.net>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi!

> > > Please make the interface accept number of seconds (as suggested by Jens)
> > > and remove this module parameter. This way interface will be more flexible
> > > and cleaner.  I really don't see any advantage in doing "echo 1 > ..." instead
> > > of "echo x > ..." (Pavel, please explain).
> > 
> > Either way is pretty easy enough to implement. Note though that I'd
> > expect the userspace app should thaw the device when danger is out of
> > the way (the timeout is mainly there to ensure that the queue isn't
> > frozen forever, and should probably be higher). Personally I don't
> > have too much of an opinion either way though... what's the consensus?
> > :).
> 
> Yes please, I don't understand why you would want a 0/1 interface
> instead, when the timer-seconds method gives you the exact same ability
> plus a way to control when to unfreeze...

Well, with my power-managment hat on:

we probably want "freeze" functionality to be generic; it makes sense
for other devices, too.

"My battery is so low I can not use wifi any more" => userspace
freezes wifi.

Now, having this kind of timeout in all the cases looks pretty ugly to my eyes.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
