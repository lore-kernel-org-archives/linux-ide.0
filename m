From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata_check_status_mmio exception kernel panic
Date: Sat, 4 Apr 2009 17:00:36 +0100
Message-ID: <20090404170036.7d4d33a2@lxorguk.ukuu.org.uk>
References: <3fb94e50903312006y12717b8dh7dd7769f3f5b1dda@mail.gmail.com>
	<49D64DE0.8060400@sutus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40931 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752195AbZDDQDE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Apr 2009 12:03:04 -0400
In-Reply-To: <49D64DE0.8060400@sutus.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dustin Harrison <d.harrison@sutus.com>
Cc: Sagar Borikar <sagar.borikar@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>

> port freeze during an interrupt while DMA is active causes a bus error 
> to be thrown when the ata_check_status call fires.  I cannot reproduce 
> this on x86.  I assume it handles the taskfile read error differently.

I hit this problem with the HPT343 (which locks the bus if you do this).
For other devices where you get a PCI abort it is usually the case that
x86 platforms ignore them while on many other platforms they produce
exceptions.

In general I think we need to be sure all the core code paths stop DMA
before poking in the taskfile (other than the basic IRQ check which we
can't avoid)

Alan
