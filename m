From: Willy Tarreau <w@1wt.eu>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata) and IDE
Date: Sun, 3 Aug 2008 19:32:54 +0200
Message-ID: <20080803173254.GI615@1wt.eu>
References: <1217779055.4179.10.camel@localhost.localdomain> <20080803173941.314edf33@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:2386 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756889AbYHCReP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 13:34:15 -0400
Content-Disposition: inline
In-Reply-To: <20080803173941.314edf33@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Sun, Aug 03, 2008 at 05:39:41PM +0100, Alan Cox wrote:
> Actually what a material number of embedded systems need is a single
> dumb-as-a-rock CF only PIO driver which doesn't suck in large chunks of
> midlayer code. I'm just not sure that trend will continue as CF is giving
> way to other smaller media.

I bet we'll see CF for a long time, because it is the only cheap
removable media to support IDE emulation and be bootable from an
unmodified PC BIOS. SD is cheaper and will soon provide larger
capacities, but it still requires a separate controller and is
not bootable with standard BIOSes.

Anyway, in my experience, libata supports CF on embedded controllers
pretty well. So maybe we should start marking IDE drivers deprecated
to encourage people to try libata instead and report breakage if any.

The real issue on embedded systems is that the devices names change.
On the one hand, it increases portability across models, because you
don't have to care anymore about hda/hdc/hdd, your CF is always on
sda (major reason why I'm considering a switch BTW). However, for
systems which were used to always see system disk on hdX and data
on sd* (USB, SATA or SCSI), it might take more time to switch due
to automatic numbering.

Regards,
Willy

