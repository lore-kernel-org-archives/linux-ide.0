From: Jan Dittmer <jan@jandittmer.de>
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Date: Sat, 19 Oct 2002 17:39:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200210191739.36187.jan@jandittmer.de>
References: <200210190241.49618.jan@jandittmer.de> <200210191124.34977.jan@jandittmer.de> <20021019092406.GI871@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021019092406.GI871@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Still when enabling tcq via 'echo using_tcq:8 > /proc/ide/hda/settings'  doing 
a simple 'bk clone' of the 2.5 repository will frag the newly created files 
uttlery. Lots of unconnected inodes and illegal directory entries on reboot. 
Filesystem is ext2. Enabling tcq and doing light work, watching movies, using 
mozilla, ... seems to work fine - but my home directory is on nfs, so it's no 
real test for my system disk.
When disabling tcq after boot, nothing of this happens.
Increasing the queue size to 32 seems to speed things up (no reliable numbers 
here). Complete system info at http://lx.sfhq.hn.org/. 
Can I somehow debug tcq?

jan


On Saturday 19 October 2002 11:24, you wrote:
> On Sat, Oct 19 2002, Jan Dittmer wrote:
> > > But I'm curious about TCQ on your system, since another VIA user
> > > reported problems. Does it appear to work for you?
> >
> > Actually that was me, I think. It now seems to work without any
> > corruption on
>
> Oh :)
>
> > 2.5.44bk. I don't know what caused it last time. Perhaps it was really my
> > harddisk dying - but I never experienced such problems with 2.4.x .
> > So I guess it's okay now. I'll try re-enable tcq now...
>
> Thanks for testing!
