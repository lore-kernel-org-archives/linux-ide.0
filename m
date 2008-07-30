From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: ide pmac breakage
Date: Wed, 30 Jul 2008 10:23:08 +0900
Message-ID: <20080730102308B.fujita.tomonori@lab.ntt.co.jp>
References: <200807291404.46906.bzolnier@gmail.com>
	<200807291645.03382.bzolnier@gmail.com>
	<200807292126.12238.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tama500.ecl.ntt.co.jp ([129.60.39.148]:56867 "EHLO
	tama500.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbYG3Bvw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2008 21:51:52 -0400
In-Reply-To: <200807292126.12238.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: benh@kernel.crashing.org, fujita.tomonori@lab.ntt.co.jp, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Tue, 29 Jul 2008 21:26:11 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Tuesday 29 July 2008, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 29 July 2008, Bartlomiej Zolnierkiewicz wrote:
> > > On Tuesday 29 July 2008, Benjamin Herrenschmidt wrote:
> > > > On Tue, 2008-07-29 at 13:41 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > > > Well, all I do is call into Bart's new helpers to scan for or
> > > > > unregister
> > > > > > devices ...
> > > > > 
> > > > > The switch to these helpers happened _before_ 2.6.26 and it shouldn't
> > > > > bring
> > > > > such behavior change (ditto for new IDE host addition/removal
> > > > > helpers)...
> > > > > 
> > > > > Please try to git-bisect it when you have some time.
> > > > 
> > > > Ok, I will. I worked fine when I last tried your patches. I'll see if I
> > > > can track it down too. Been a bit too busy lately as you can imagine.
> > > > 
> > > > Do you have something that exercise the same code path you can use ?
> > > 
> > > I'll see if I can reproduce it with IDE warm-plug support later...
> > 
> > OK, I reproduced it here with IDE warm-plug support
> > (echo -n "1" > /sys/class/ide_port/ide*/delete_devices)
> > for devices driven by ide-cd.
> > 
> > It is also reproducible under qemu so I'm scripting it
> > into git-bisect run now...
> 
> I WON!!!

Great, seems that I don't need to learn how ide does ref counting. :)

Thanks a lot!
