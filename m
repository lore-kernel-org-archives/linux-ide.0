From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [RFT PATCH] mips: lemote2f_defconfig: convert to use libata PATA
 drivers
Date: Wed, 7 Oct 2015 20:40:00 +0300
Message-ID: <20151007173959.GC26187@blackmetal.musicnaut.iki.fi>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
 <1442245918-27631-6-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442245918-27631-6-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Huacai Chen <chenhc@lemote.com>
List-Id: linux-ide@vger.kernel.org

Hi,

On Mon, Sep 14, 2015 at 05:51:47PM +0200, Bartlomiej Zolnierkiewicz wrote:
> IDE subsystem has been deprecated since 2009 and the majority
> (if not all) of Linux distributions have switched to use
> libata for ATA support exclusively.  However there are still
> some users (mostly old or/and embedded non-x86 systems) that
> have not converted from using IDE subsystem to libata PATA
> drivers.  This doesn't seem to be good thing in the long-term
> for Linux as while there is less and less PATA systems left
> in use:
> 
> * testing efforts are divided between two subsystems
> 
> * having duplicate drivers for same hardware confuses users
> 
> This patch converts lemote2f_defconfig to use libata PATA
> drivers.
> 
> PS This platform uses CS5536 chipset which (due to historical
> reasons) has basic support in AMD/nVidia PATA host driver and
> full support in a newer CS5536 PATA one (pata_cs5536).  Thus
> most likely this platform should switch to using the latter
> host driver.
> 
> Cc: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Maybe too late but:

	Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

I also tested PATA_CS5536 and that works too, but it gives a slightly
slower disk (27MB/s vs 33MB/s)...

A.
