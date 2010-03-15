From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 15 Mar 2010 03:26:22 +0100
Message-ID: <201003150326.22262.vda.linux@googlemail.com>
References: <4B947393.2050002@kernel.org> <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com> <4B9D8BB2.1010507@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:61066 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759431Ab0COC0a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Mar 2010 22:26:30 -0400
In-Reply-To: <4B9D8BB2.1010507@zytor.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

On Monday 15 March 2010 02:21, H. Peter Anvin wrote:
> On 03/10/2010 01:14 AM, Denys Vlasenko wrote:
> >
> > 63s/255h is more or less "standard" now.
> >
> > Alignment issues can be solved by picking a good multiple of
> > _heads_ or _cylinders_:
> >
> > For first partition, pick the start at 8th head:
> >
> > cyl 0 head 1 sector 1: LBA sector 63) - bad
> > cyl 0 head 8 sector 1: LBA sector 8*63) - good (4k aligned)
> >
> > For any other partition, pick start cylinder which is a multiple of 8:
> >
> > cyl 8*x head 0 sector 1: LBA sector 8*x*255*63 - good (4k aligned)
> >
> > This will actually work well for *any* geometry, not only for 63s/255h.
> 
> Yes, but it does squat for a flash disk that wants, say, 256K alignment.

4K makes sense. 256K not so much.

256K alignment is hard to swallow for a lot of reasons anyway.
Unless the filesystem packs small files into blocks a-la reiserfs,
256K block filesystems will be very inefficient for a typical
storage scenarios.

It looks like flash storage manufacturers just have to bite
the bullet and develop smarter algorithms that combine wear
leveling, block remapping and such and make their internal
preference for huge continuous aligned writes nearly invisible
from the outside - just like hard disks which do not expose
their zoned recording, variable sector counts etc.

Such algorithms aren't trivial, but they are possible.
Whoever will incorporate them in their products,
delivers a significantly better user experience.

I just played with ubuntu installation on an usb stick.
Yes, it works. Soft of. Write performance is abysmal.
I would pay x2 or x3 for the same sized stick if it
would perform better.

-- 
vda
