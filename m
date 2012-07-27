From: Borislav Petkov <bp@amd64.org>
Subject: Re: AMD SP5100 SATA low perfomance
Date: Fri, 27 Jul 2012 12:25:21 +0200
Message-ID: <20120727102521.GA14445@aftab.osrc.amd.com>
References: <20120724204454.GC5167@liondog.tnic>
 <CAKu2wpTFZNY4nwi47gRPbzaHUFPRfJEZa+GTgO4L=vJ-y+9gCA@mail.gmail.com>
 <20120726100440.GB30717@aftab.osrc.amd.com>
 <CAKu2wpSw-jTMnRkZyDf9aGuNqY7kRp6AUUHKr7CVoo_QXRzj=Q@mail.gmail.com>
 <CAKu2wpQY3=VK-7RZjheRjaYPN2OQxoD=r1qU08DwmjM9xhkxcQ@mail.gmail.com>
 <20120726180854.GD9161@aftab.osrc.amd.com>
 <CAKu2wpThVHc9nAL=xvcPSKcv-cnOFp+Y41CpQyxsqo292FzjRA@mail.gmail.com>
 <CAKu2wpRkHnAdwiwuoyXfS+KrWQ7DBed1yh_K5eSu0o2d0GWJuA@mail.gmail.com>
 <20120727090719.GA13992@aftab.osrc.amd.com>
 <CAKu2wpQe+SR3BSsrf+oNzfok6OdQtBKMeYfTGdNOcc-s-AWjjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from osrc3.amd.com ([217.9.48.20]:46457 "EHLO mail.x86-64.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab2G0KZ1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jul 2012 06:25:27 -0400
Content-Disposition: inline
In-Reply-To: <CAKu2wpQe+SR3BSsrf+oNzfok6OdQtBKMeYfTGdNOcc-s-AWjjQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <brushkoff@gmail.com>
Cc: linux-ide@vger.kernel.org

On Fri, Jul 27, 2012 at 12:22:14PM +0300, Rus V. Brushkoff wrote:
> > "Sh*t" really only begins to describe this. So let me get this
> > correctly: your Hitachi hdds weren't mounted in a very stable manner to
> > the mobo chassis and vibrations from the fan caused them to fail writes
> > and retry a _lot_ leading to the write performance drop?
> 
> The HDD's _was_ mounted very tight and stable, so the FAN vibration is
> propagated to HDD without the problems, next the internal
> accelerometer founds this vibration and lowers all the HDD operations
> ! If I get out the HDD from the case and mechanically isolate it from
> the FAN vibration the speed momentally grows to the max value !
> 
> > And the WD ones don't have a problem with the vibrations?
> 
> The desktop WD do not have this issue as it has much more mass than
> mobile one. As you can see by tests made by me - the mobile WD behaves
> nearly same as Hitachi one - it lowers the HDD operations by -20Mb/s
> value.

So the Hitachi ones are lighter than the WD ones and behave like mobile
hdds in that respect.

Oh well, good to know for next time when buying hdds.

I have one final question. You said:

"The same HDD with another SATA controller (checked with Asus M2NPV and
M5A78 m/b) shows normal write (150Mb/s-300Mb/s) perfomance."

Does that mean that the Hitachi hdd which was performing badly in the
Tyan board, didn't receive vibrations when connected to the Asus mobo
simply because the Asus mobo is in a different chassis which absorbs
vibrations somehow?

All I'm saying is, if you switch mobos and use the same chassis which
generates vibrations, you should be seeing the same performance drop
with the Asus board and this way confirm your findings.

Thanks.

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
GM: Alberto Bozzo
Reg: Dornach, Landkreis Muenchen
HRB Nr. 43632 WEEE Registernr: 129 19551
