From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] cs5536: define dma_sff_read_status() method
Date: Mon, 4 May 2009 14:59:06 -0700
Message-ID: <20090504215906.GC31248@kroah.com>
References: <200904072003.40866.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:60306 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362AbZEDWEs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 May 2009 18:04:48 -0400
Content-Disposition: inline
In-Reply-To: <200904072003.40866.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, stable@kernel.org

On Tue, Apr 07, 2009 at 08:03:40PM +0400, Sergei Shtylyov wrote:
> The driver somehow got merged with the initializer for the dma_sff_read_status()
> method missing which caused kernel panic on bootup.
> 
> This should fix the kernel.org bug #13026...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> This patch is against the recent Linus' tree.
> It should go into 2.6.29-stable as the driver was merged/broken in 2.6.29 time.

It doesn't apply to the 2.6.29-stable tree at all.

Care to redo your patch to apply there?

thanks,

greg k-h
