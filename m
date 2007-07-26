From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Thu, 26 Jul 2007 21:28:00 +0200
Message-ID: <200707262128.00777.bzolnier@gmail.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:62760 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936091AbXGZT7o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:44 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591339ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:44 -0700 (PDT)
In-Reply-To: <20070725165318.5331.23795.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org


Hi,

On Wednesday 25 July 2007, Vitaly Bordug wrote:
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

Looks really good, thanks for working on this.

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

applied but it would be also nice to fix minor issues found by Sergei
(please just send a new version of the patch and I will replace this
version with the newer one in my tree)

patch #2/2 also looks fine and when issues raised by Sergei gets
addressed it will be merged

Thanks,
Bart
