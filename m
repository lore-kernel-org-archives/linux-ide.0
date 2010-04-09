From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Thu, 8 Apr 2010 23:22:10 -0300
Message-ID: <4bbe8f84.1502be0a.0f89.0f16@mx.google.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
 <20100408144525.2f3f5718@lxorguk.ukuu.org.uk>
 <4bbdde49.e302be0a.3106.0220@mx.google.com>
 <20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
 <4bbde1ea.c701be0a.60ec.0270@mx.google.com>
 <20100408150920.5689564b@lxorguk.ukuu.org.uk>
 <4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
 <4BBE6CA6.1010808@gmail.com>
 <4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
 <n2x51f3faa71004081909la494824ds60fcb5d26b53027a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38624 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab0DICXC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 22:23:02 -0400
Received: by gwb19 with SMTP id 19so1537488gwb.19
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 19:23:01 -0700 (PDT)
In-Reply-To: <n2x51f3faa71004081909la494824ds60fcb5d26b53027a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Thu, 8 Apr 2010 20:09:29 -0600
Robert Hancock <hancockrwd@gmail.com> wrote:

> Think you meant sata_nv or something there, forcedeth is the network
> driver :-) In that case that's not really legacy mode though, it's

	Oh yeah, sorry for my confusion ;) sata_nv. ;)

> some chipset-specific enhanced mode like SWNCQ or ADMA in the NVIDIA
> case, or the newer Silicon Image controllers which support the fancy
> features with an entirely different interface from AHCI. In the case
> of Intel controllers, though, IDE mode is basically the same as a PATA
> controller with no real SATA-specific features (NCQ, 64-bit DMA,
> hotplug, etc.)

	Very interesting and thanks again for the excellent explanation
Robert!

	Ps: I imagine how many people are running their servers or
desktop computers using the legacy PIIX driver, just because the BIOS
setting is wrong (IDE instead of AHCI). In my case I just ignored the
"RAID mode" option because I don't ever use RAID.

	Don't you think it would be nice to add a warning message
when the kernel detects  AHCI capable system like ICH10 and the kernel
is misconfigured using the legacy PIIX driver? It could be
something like that: "AHCI capable chipset: use ahci driver instead".

	Ps2: sorry sending 2 times (forget to send to the list)

-- 
