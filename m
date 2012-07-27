From: Borislav Petkov <bp@amd64.org>
Subject: Re: AMD SP5100 SATA low perfomance
Date: Fri, 27 Jul 2012 11:07:19 +0200
Message-ID: <20120727090719.GA13992@aftab.osrc.amd.com>
References: <CAKu2wpS-9T+jeab4HoBozuxa-7LPVCL3+3JZok-QkTHs6CNksA@mail.gmail.com>
 <20120724204454.GC5167@liondog.tnic>
 <CAKu2wpTFZNY4nwi47gRPbzaHUFPRfJEZa+GTgO4L=vJ-y+9gCA@mail.gmail.com>
 <20120726100440.GB30717@aftab.osrc.amd.com>
 <CAKu2wpSw-jTMnRkZyDf9aGuNqY7kRp6AUUHKr7CVoo_QXRzj=Q@mail.gmail.com>
 <CAKu2wpQY3=VK-7RZjheRjaYPN2OQxoD=r1qU08DwmjM9xhkxcQ@mail.gmail.com>
 <20120726180854.GD9161@aftab.osrc.amd.com>
 <CAKu2wpThVHc9nAL=xvcPSKcv-cnOFp+Y41CpQyxsqo292FzjRA@mail.gmail.com>
 <CAKu2wpRkHnAdwiwuoyXfS+KrWQ7DBed1yh_K5eSu0o2d0GWJuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from osrc3.amd.com ([217.9.48.20]:46182 "EHLO mail.x86-64.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751735Ab2G0JHZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jul 2012 05:07:25 -0400
Content-Disposition: inline
In-Reply-To: <CAKu2wpRkHnAdwiwuoyXfS+KrWQ7DBed1yh_K5eSu0o2d0GWJuA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <brushkoff@gmail.com>
Cc: linux-ide@vger.kernel.org

On Fri, Jul 27, 2012 at 11:23:56AM +0300, Rus V. Brushkoff wrote:
> Hello,
> 
> You will laugh, but I've found the issue. These particular drives do
> not like the fan vibration and lowering the spin speed ;) Sh*t ...

"Sh*t" really only begins to describe this. So let me get this
correctly: your Hitachi hdds weren't mounted in a very stable manner to
the mobo chassis and vibrations from the fan caused them to fail writes
and retry a _lot_ leading to the write performance drop?

And the WD ones don't have a problem with the vibrations?

Wow! Looks like some idiot was saving on production material/design to
make the drives cheaper. Talk about a major serious FAIL.

:-)

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
GM: Alberto Bozzo
Reg: Dornach, Landkreis Muenchen
HRB Nr. 43632 WEEE Registernr: 129 19551
