From: Jan Dittmer <jan@jandittmer.de>
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Date: Sun, 20 Oct 2002 16:57:52 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200210201657.52250.jan@jandittmer.de>
References: <200210190241.49618.jan@jandittmer.de> <20021020104601.C8606@ucw.cz> <20021020093818.GC24484@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.whm.tu-harburg.de (qmailr@proxy.whm.tu-harburg.de [134.28.72.5])
	by rztsun.rz.tu-harburg.de (8.9.0/8.8.8) with SMTP id QAA09903
	for <linux-ide@vger.kernel.org>; Sun, 20 Oct 2002 16:56:56 +0200 (MET DST)
In-Reply-To: <20021020093818.GC24484@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

> > > There _may_ be issues with changing depth on the fly. So if you could
> > > just test without fiddling with changing depths that would be great.
> >
> > Ok. No changes in /proc using_tcq after boot, assuming it's enabled
> > automatically (checked that in kernel config0, it works perfectly fine.
>
> Thanks for verifying that! Jan, you appeared to have problems even with
> tcq-per-default enabled and not touching the depth while running io, is
> that correct?

Thats correct. But I couldn't reproduce it, after applying the following 
changeset. But that doesn't seem very related (I got some oops' while playing 
a video). But iirc I always watched a music video when file system corruption 
appeared?!
I'll try tomorrow evening without this change if I can reproduce the 
problem...

jan


--- emufx.c     11 Oct 2002 13:29:36 -0000      1.23
+++ emufx.c     19 Oct 2002 14:29:43 -0000
@@ -413,7 +413,7 @@

        snd_runtime_check(emu, return -EINVAL);
        snd_runtime_check(handler, return -EINVAL);
-       irq = kmalloc(sizeof(*irq), GFP_KERNEL);
+       irq = kmalloc(sizeof(*irq), GFP_ATOMIC);
        if (irq == NULL)
                return -ENOMEM;
        irq->handler = handler;
