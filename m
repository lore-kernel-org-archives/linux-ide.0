From: Dan Hollis <goemon@anime.net>
Subject: Re: kernel 2.6.6 amd8111 dma bugs
Date: Mon, 14 Jun 2004 17:34:57 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0406141732090.6744-100000@sasami.anime.net>
References: <40BE85FA.7000902@clanhk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sasami.anime.net ([207.109.251.120]:30107 "EHLO
	sasami.anime.net") by vger.kernel.org with ESMTP id S264885AbUFOAfC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jun 2004 20:35:02 -0400
In-Reply-To: <40BE85FA.7000902@clanhk.org>
List-Id: linux-ide@vger.kernel.org
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org

On Wed, 2 Jun 2004, J. Ryan Earl wrote:
> Jens Axboe wrote:
> >On Fri, May 28 2004, Dan Hollis wrote:
> >>replies to email as i'm not subscribed to the list.
> >>There seem to be regular dma timeouts:
> >>hdc: dma_timer_expiry: dma status == 0x24
> >>hdc: DMA interrupt recovery
> >>hdc: lost interrupt
> >>hda: dma_timer_expiry: dma status == 0x24
> >>hda: DMA interrupt recovery
> >>hda: lost interrupt
> >>Hardware:
> >>Opteron 140, Tyan Tomcat K8S (S2850)
> >Try disabling ACPI (in .config or boot acpi=off iirc)
> I had that problem, but not with ACPI, only when I forced APIC on.  It 
> was on the VIA controller which uses the same driver.

Turns out it was apic and not acpi at all. Booting with ACPI but noapic 
and I no longer get any dma errors.

Is the bug in the linux apic code or a hardware flaw in the opteron cpu? 
Or something else?

-Dan

