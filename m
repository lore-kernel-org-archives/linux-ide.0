From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Date: Sat, 7 Jul 2007 21:13:06 +0100
Message-ID: <20070707211306.2ef074cf@the-village.bc.nu>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38211 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753929AbXGGUGs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 16:06:48 -0400
In-Reply-To: <20070707094852.9473.21013.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

On Sat, 07 Jul 2007 13:48:52 +0400
Vitaly Bordug <vitb@kernel.crashing.org> wrote:

> 
> This adds support for MMIO IDE device like CompactFlash 
> in TrueIDE mode.

Really we should be working towards libata support for all new devices.
This looks like a candidate for the existing (or a little enhanced)
pata_platform driver.

> +config BLK_DEV_MMIOIDE
> +	tristate "Memory Mapped IDE support"

Please pick a better description. This isn't a generic option for
enabling MMIO based IDE as you make it sound.


Also we have an accepted match name for ATA platform devices - and adding
another one messes it up irrespective of whether you want libata or
legacy IDE support. If you use the same matches then your platform code,
and everyone elses platform code can work with both drivers, except for
hotpluggability.

Other bugs

- Your remove code releases the resources before the hwif which means it
races another user trying to claim the resource
- Be careful with ide_unregister. It exists and you can call it but its
actually not very safe and there are lots of unfixed races in the IDE
layer if you do


The "should we have a legacy ide driver that matches the libata
pata_platform" question I don't really care about. Its a waste of effort
in many ways but if you've written the code the work is done so why not
use it.

However it needs to be *compatible* so that platform devices can be
claimed by either so the kernel build can pick legacy IDE v libata and
not have to #ifdef all the platform code.

Alan
