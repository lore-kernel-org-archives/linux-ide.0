From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Wed, 25 Jul 2007 21:37:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0707252130090.6234@poirot.grange>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45912 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763206AbXGYTha (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Jul 2007 15:37:30 -0400
In-Reply-To: <20070725165318.5331.23795.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

On Wed, 25 Jul 2007, Vitaly Bordug wrote:

> 
> This is now very similar to pata_platform.c, they both use
> same platform data structure and same resources.
> 
> To achieve that, byte_lanes_swapping platform data variable
> and platform specified iops removed from that driver. It's fine,
> since those were never used anyway.
> 
> pata_platform and ide_platform are carrying same driver names,
> to easily switch between these drivers, without need to touch
> platform code.

Why? There's a drivers/ide/arm/ide_arm.c IDe driver that some platforms 
(not in the mainline) hack to access, e.g., CF cards in true-IDE mode. 
About a month ago I submitted a patch to arm-linux-kernel switching that 
driver to using platform-device. I got a reply, that it's not worth it now 
that IDE is slowly becoming obsolete, and the pata_platform serves the 
perpose perfectly well. I found this argument reasonable, I had the same 
doubt, just wanted to double-check. So, why do we now need a new legacy 
(a/drivers/ide/legacy/ide_platform.c) driver when a "modern" driver 
exists?

Thanks
Guennadi
---
Guennadi Liakhovetski
