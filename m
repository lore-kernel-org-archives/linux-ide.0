From: Jan Dittmer <jan@jandittmer.de>
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Date: Tue, 22 Oct 2002 22:16:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200210222216.56633.jan@jandittmer.de>
References: <200210190241.49618.jan@jandittmer.de> <20021020104601.C8606@ucw.cz> <20021020093818.GC24484@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021020093818.GC24484@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-ide@vger.kernel.org

> > > There _may_ be issues with changing depth on the fly. So if you could
> > > just test without fiddling with changing depths that would be great.
> >
> > Ok. No changes in /proc using_tcq after boot, assuming it's enabled
> > automatically (checked that in kernel config0, it works perfectly fine.
>
> Thanks for verifying that! Jan, you appeared to have problems even with
> tcq-per-default enabled and not touching the depth while running io, is
> that correct?

Okay tested it for roughly a day, doing some heavy I/O. Seems to work fine. 
Didn't dare to change setting though. Had yet no time to test it with an 
older kernel.

ds666:/nfshome/jdittmer# cat /proc/ide/hda/settings | grep -i tcq
using_tcq               1               0               32              rw

jan
