From: Jens Axboe <axboe@suse.de>
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Date: Sun, 20 Oct 2002 11:38:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021020093818.GC24484@suse.de>
References: <200210190241.49618.jan@jandittmer.de> <20021019091518.GG871@suse.de> <20021019222403.B3018@ucw.cz> <20021019230434.A800@ucw.cz> <20021020003834.GJ871@suse.de> <20021020104601.C8606@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20021020104601.C8606@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jan Dittmer <jan@jandittmer.de>, Linux Kernel List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Oct 20 2002, Vojtech Pavlik wrote:
> On Sun, Oct 20, 2002 at 02:38:34AM +0200, Jens Axboe wrote:
> > On Sat, Oct 19 2002, Vojtech Pavlik wrote:
> > > On Sat, Oct 19, 2002 at 10:24:03PM +0200, Vojtech Pavlik wrote:
> > > 
> > > > > It's not an oops, and it's not causes by TCQ either. The above is simply
> > > > > a reminder to fix the ide init sequence, because it's probe sequence
> > > > > tries to use drive->disk before it has been set up. That is worked
> > > > > around, but stack is dumped for good measure. So you can feel
> > > > > comfortable using 2.5.44 regardless.
> > > > > 
> > > > > But I'm curious about TCQ on your system, since another VIA user
> > > > > reported problems. Does it appear to work for you?
> > > > 
> > > > It definitely works on my VIA just fine.
> > > 
> > > Famous last words. I tried to play with the /proc using_tcq setting and
> > > got a filesystem corruption immediately.
> > 
> > There _may_ be issues with changing depth on the fly. So if you could
> > just test without fiddling with changing depths that would be great.
> 
> Ok. No changes in /proc using_tcq after boot, assuming it's enabled
> automatically (checked that in kernel config0, it works perfectly fine.

Thanks for verifying that! Jan, you appeared to have problems even with
tcq-per-default enabled and not touching the depth while running io, is
that correct?

-- 
Jens Axboe
