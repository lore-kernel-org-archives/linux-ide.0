From: "Rus V. Brushkoff" <brushkoff@gmail.com>
Subject: Re: AMD SP5100 SATA low perfomance
Date: Fri, 27 Jul 2012 13:39:26 +0300
Message-ID: <CAKu2wpRzPfakZB20OPs37+YoR8MXsvZjvSZo+6V_WWKVX0iYKQ@mail.gmail.com>
References: <20120724204454.GC5167@liondog.tnic> <CAKu2wpTFZNY4nwi47gRPbzaHUFPRfJEZa+GTgO4L=vJ-y+9gCA@mail.gmail.com>
 <20120726100440.GB30717@aftab.osrc.amd.com> <CAKu2wpSw-jTMnRkZyDf9aGuNqY7kRp6AUUHKr7CVoo_QXRzj=Q@mail.gmail.com>
 <CAKu2wpQY3=VK-7RZjheRjaYPN2OQxoD=r1qU08DwmjM9xhkxcQ@mail.gmail.com>
 <20120726180854.GD9161@aftab.osrc.amd.com> <CAKu2wpThVHc9nAL=xvcPSKcv-cnOFp+Y41CpQyxsqo292FzjRA@mail.gmail.com>
 <CAKu2wpRkHnAdwiwuoyXfS+KrWQ7DBed1yh_K5eSu0o2d0GWJuA@mail.gmail.com>
 <20120727090719.GA13992@aftab.osrc.amd.com> <CAKu2wpQe+SR3BSsrf+oNzfok6OdQtBKMeYfTGdNOcc-s-AWjjQ@mail.gmail.com>
 <20120727102521.GA14445@aftab.osrc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59980 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab2G0KkI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2012 06:40:08 -0400
Received: by lbbgm6 with SMTP id gm6so2131861lbb.19
        for <linux-ide@vger.kernel.org>; Fri, 27 Jul 2012 03:40:07 -0700 (PDT)
In-Reply-To: <20120727102521.GA14445@aftab.osrc.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@amd64.org>
Cc: linux-ide@vger.kernel.org

> So the Hitachi ones are lighter than the WD ones and behave like mobile
> hdds in that respect.

Yes, these Hitachi is lighter and more sensitive to vibrations - even
hanging on wires is sufficient for twice perfomance drop - the whole
vibro silence is requred for it to reach the max speed. I think this
is mostly the hardware design flaw of this particular model - will
return all of them.

> "The same HDD with another SATA controller (checked with Asus M2NPV and
> M5A78 m/b) shows normal write (150Mb/s-300Mb/s) perfomance."
>
> Does that mean that the Hitachi hdd which was performing badly in the
> Tyan board, didn't receive vibrations when connected to the Asus mobo
> simply because the Asus mobo is in a different chassis which absorbs
> vibrations somehow?

 Yes, as the Asus mobo as the "working good" S8005GM2NR one has the
different chassis that has very small vibration, so for tests I did
not put the HDD inside - it was simply laying on chassis surface -
this is why connecting the same HDD shows the normal perfomance.

> All I'm saying is, if you switch mobos and use the same chassis which
> generates vibrations, you should be seeing the same performance drop
> with the Asus board and this way confirm your findings.

 Sure. I've made the simple test - took out the HDD from the vibrating
case - run dd and see the 100Mb/s perfomance. Next simply puted the
HDD on the vibrating 1U case surface and run the dd test again - the
perfomance immediatly dropped to 20Mb/s. This is constantly
reproducable ;) These HDD is unusable where the fans exists - seems
like everywhere ;)

-- 
Rus
