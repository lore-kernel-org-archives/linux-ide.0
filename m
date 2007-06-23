From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/6] qd65xx: fix PIO mode selection
Date: Sat, 23 Jun 2007 20:42:21 +0100
Message-ID: <20070623204221.27f52df1@the-village.bc.nu>
References: <200706232002.07091.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46271 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754403AbXFWTg2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 15:36:28 -0400
In-Reply-To: <200706232002.07091.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, 23 Jun 2007 20:02:07 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> 
> PIO4 is a maximum PIO mode supported by a driver.  Using "255" as a max_mode
> argument to ide_get_best_pio_mode() could result in wrong timings being used
> by a driver (for "pio" equal to 5) or OOPS (for "pio" values > 5 && < 255).

The qdi6580 driver is somewhat hosed. The libata one worked on the single
VLB test case we managed to rig up.  Registers are in VLB clocks (usually
33MHz). I need to fix the failed single channel test case then persuade
the VLB using nutter to test again 8)

Registers you need are:

2 * timing:
	bit 0-3 active in VLB clocks (whacky as its 17 - bitvalue)
	bit 4-7 recover (15 - value) [don't use < 2 ]

3
	bit 0 Pri/Sec enabled
	bit 1 Primary enabled only
	bit 2-6 write as 1 
	bit 7 - Prefetch/Postwrite (ATA disk only) [this is global]


The timing stuff is a bit whacko:

If both channels are in use then timing source 0 is channel 0, timing
source 1 is channel 1. If single channel is in use then timing source 0
is channel 0 primary, and timing source 1 is channel 0 slave

Possibly we should just drop support as I know of only one user and thats
purely to test the code

Alan
