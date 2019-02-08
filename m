From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v2] ata: add Buddha PATA controller driver
Date: Fri, 8 Feb 2019 12:38:02 +0100
Message-ID: <420634d6-c14f-8380-0980-548fc4740474@physik.fu-berlin.de>
References: <CGME20190207122046eucas1p12d098289e0370252d341ccfed66b8295@eucas1p1.samsung.com>
 <6924b9b1-6c38-2639-a824-f2d765abe437@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6924b9b1-6c38-2639-a824-f2d765abe437@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jens Axboe <axboe@kernel.dk>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi!

On 2/7/19 1:20 PM, Bartlomiej Zolnierkiewicz wrote:
> Add Buddha PATA controller driver. It enables libata support for
> the Buddha, Catweasel and X-Surf expansion boards on the Zorro
> expansion bus.
> 
> Module removal is currently unsupported (the old IDE's buddha
> driver also doesn't support it).
> 
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2:
> - added Tested-by from John

It's a bit confusing, but my primary name is Adrian, despite being
the third one. So if this ends in a changelog, please change this
to "- added Tested-by from Adrian".

> - enhanced patch description
> 
> Jens, please consider merging for v5.1.
Yes, that would be fantastic. We're working on addressing the module unload
issue later. Michael has tried adding the appropriate function but we still
ran into issues when trying to unload the driver.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
