From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Wed, 25 Jul 2007 12:59:19 -0500
Message-ID: <BBFF5331-A892-41DE-B426-E7993AEC6463@kernel.crashing.org>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53987 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754607AbXGYR6b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Jul 2007 13:58:31 -0400
In-Reply-To: <20070725165318.5331.23795.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org


On Jul 25, 2007, at 11:53 AM, Vitaly Bordug wrote:

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
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

Out of interest is this something that could exist in pata land?  I  
haven't really been following legacy/ide vs pata lately.

- k
