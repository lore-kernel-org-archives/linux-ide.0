From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: Peculiar out-of-sync boot log lines
Date: Thu, 29 Nov 2007 14:51:11 -0500
Message-ID: <1196365871.6473.107.camel@perihelion>
References: <20071129193728.2f1c237e@linuxamd.linicks.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933619AbXK2Twk@vger.kernel.org>
In-Reply-To: <20071129193728.2f1c237e@linuxamd.linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Warne <nick@ukfsn.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org


On Thu, 2007-11-29 at 19:37 +0000, Nick Warne wrote:
> Hi all,
> 
> 2.6.23.9
> 
> I have noticed after applying Bart's patch to word93 blacklist my new
> DVD drive:
> 
> http://lkml.org/lkml/2007/10/23/475
> 
> I see now in logs (look at the hdd line:
> 
> [dmesg]
> hdc: 39876480 sectors (20416 MB) w/2048KiB Cache, CHS=39560/16/63,
> UDMA(66)
> hdc: cache flushes not supported
>  hdc: hdc1
> hdd: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache<7>hdd:
> skipping word 93 validity check
> , UDMA(66)
> Uniform CD-ROM driver Revision: 3.20

Only very early in boot are you guaranteed for things to execute
sequentially, and for logs to look nice and pretty.

Jon.
