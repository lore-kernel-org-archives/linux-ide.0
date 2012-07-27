From: "Rus V. Brushkoff" <brushkoff@gmail.com>
Subject: Re: AMD SP5100 SATA low perfomance
Date: Fri, 27 Jul 2012 14:17:35 +0300
Message-ID: <CAKu2wpTM-dJzf8b0PtTfHhOoEwnrJAWmvrtuvG-VZQqvEHj6YQ@mail.gmail.com>
References: <20120724204454.GC5167@liondog.tnic> <CAKu2wpTFZNY4nwi47gRPbzaHUFPRfJEZa+GTgO4L=vJ-y+9gCA@mail.gmail.com>
 <20120726100440.GB30717@aftab.osrc.amd.com> <CAKu2wpSw-jTMnRkZyDf9aGuNqY7kRp6AUUHKr7CVoo_QXRzj=Q@mail.gmail.com>
 <CAKu2wpQY3=VK-7RZjheRjaYPN2OQxoD=r1qU08DwmjM9xhkxcQ@mail.gmail.com>
 <20120726180854.GD9161@aftab.osrc.amd.com> <CAKu2wpThVHc9nAL=xvcPSKcv-cnOFp+Y41CpQyxsqo292FzjRA@mail.gmail.com>
 <CAKu2wpRkHnAdwiwuoyXfS+KrWQ7DBed1yh_K5eSu0o2d0GWJuA@mail.gmail.com>
 <20120727090719.GA13992@aftab.osrc.amd.com> <CAKu2wpQe+SR3BSsrf+oNzfok6OdQtBKMeYfTGdNOcc-s-AWjjQ@mail.gmail.com>
 <20120727102521.GA14445@aftab.osrc.amd.com> <CAKu2wpRzPfakZB20OPs37+YoR8MXsvZjvSZo+6V_WWKVX0iYKQ@mail.gmail.com>
 <5012740E.7040507@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60803 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab2G0LSR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2012 07:18:17 -0400
Received: by lbbgm6 with SMTP id gm6so2150180lbb.19
        for <linux-ide@vger.kernel.org>; Fri, 27 Jul 2012 04:18:15 -0700 (PDT)
In-Reply-To: <5012740E.7040507@mrc-lmb.cam.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Cc: Borislav Petkov <bp@amd64.org>, linux-ide@vger.kernel.org

>> Yes, these Hitachi is lighter and more sensitive to vibrations - even
>> hanging on wires is sufficient for twice perfomance drop - the whole
>> vibro silence is requred for it to reach the max speed. I think this
>> is mostly the hardware design flaw of this particular model - will
>> return all of them.
>
> Well, you said that the 2.5" WD drives showed the same symptoms, so I
> don't see how you conclude the problem is Hitachi-specific. It seems
> more likely to be an interaction between some (or all) 2.5" drives and
> the particular case/fan combination.

The WD drives dropped perfomance by 20Mb/s but Hitachi by factor 5, I
think this is big difference.

>
> How are the 2.5" drives mounted in the cases?

Using the stock Tyan GT14 tight alluminium HDD mount case.

>
> Perhaps it would be fixable by using low-vibration fans or fan mounting
> kits. Perhaps mounting the drives on a lump of solid metal to bring them
> up to the same mass as a 3.5" drive would fix it. Perhaps resilient
> mounting of the drives would fix it. Perhaps a stiffer/heavier case
> would fix it.

 Tested, probed, tried - do not work with this model. These Hitachi
drives are too light (nearly 90 gr) and do not like even the lowest
vibration. This is the worst vibrate-sensitive drives I ever saw. The
worst thing that the allowable vibration level is different for each
drive - I've tested 5 drives of the same model - each shows different
perfomance drop from the same vibration level - write speed varied
from 0.7Mb/s to 30Mb/sec, while no-vibration level is 116-120Mb/sec.

> Now that you know the problem is hardware-related, the same symptoms
> should show up using Windows (or any other OS). So maybe Hitachi (and WD
> and the case and fan manufacturers) might now be interested in finding a
> better cure, or at least warning potential customers.

Hitachi Technical Support Center (one Niko Levenetz) refused to help
me from the very start leaving me with this problematic drive problem
alone. Seems like they do not bother at all about supporting their
products for end users. I will never buy the Hitachi drives again not
because they are not work (this can be fixed at least) but because of
refusing to support end users. F*ck you Hitachi ! (c) Linus ;)

-- 
Rus
