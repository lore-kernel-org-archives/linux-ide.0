From: Dan Hollis <goemon@anime.net>
Subject: Re: kernel 2.6.6 amd8111 dma bugs
Date: Tue, 1 Jun 2004 13:05:51 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0406011253290.30069-100000@sasami.anime.net>
References: <20040529074245.GQ20657@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sasami.anime.net ([207.109.251.120]:4759 "EHLO sasami.anime.net")
	by vger.kernel.org with ESMTP id S265198AbUFAUGB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jun 2004 16:06:01 -0400
In-Reply-To: <20040529074245.GQ20657@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org

On Sat, 29 May 2004, Jens Axboe wrote:
> On Fri, May 28 2004, Dan Hollis wrote:
> > replies to email as i'm not subscribed to the list.
> > There seem to be regular dma timeouts:
> > hdc: dma_timer_expiry: dma status == 0x24
> > hdc: DMA interrupt recovery
> > hdc: lost interrupt
> > hda: dma_timer_expiry: dma status == 0x24
> > hda: DMA interrupt recovery
> > hda: lost interrupt
> > Hardware:
> > Opteron 140, Tyan Tomcat K8S (S2850)
> Try disabling ACPI (in .config or boot acpi=off iirc)

Nope. acpi=off in kernel commandline, still get them.

hdc: dma_timer_expiry: dma status == 0x24
hdc: DMA interrupt recovery
hdc: lost interrupt

Anything else I should try?

-Dan

