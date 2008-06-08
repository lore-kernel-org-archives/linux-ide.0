From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] swarm: use struct ide_port_info
Date: Sun, 8 Jun 2008 19:36:01 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0806081934090.15673@cliff.in.clinika.pl>
References: <200806082010.35429.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirk.serum.com.pl ([213.77.9.205]:61609 "EHLO serum.com.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754019AbYFHSgK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Jun 2008 14:36:10 -0400
In-Reply-To: <200806082010.35429.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 8 Jun 2008, Bartlomiej Zolnierkiewicz wrote:

> Convert the driver to use struct ide_port_info.
> 
> There should be no functional changes caused by this patch.
> 
> Cc: Maciej W. Rozycki <macro@linux-mips.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

 Verified to work correctly on my system, thanks.

> +	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,

 You could have saved one <Tab> here. ;)

  Maciej
