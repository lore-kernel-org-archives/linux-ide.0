From: Jens Axboe <axboe@suse.de>
Subject: Re: kernel 2.6.6 amd8111 dma bugs
Date: Sat, 29 May 2004 09:42:45 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040529074245.GQ20657@suse.de>
References: <Pine.LNX.4.44.0405281511020.1326-100000@sasami.anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:59604 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263807AbUE2Hmu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 May 2004 03:42:50 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405281511020.1326-100000@sasami.anime.net>
List-Id: linux-ide@vger.kernel.org
To: Dan Hollis <goemon@anime.net>
Cc: linux-ide@vger.kernel.org

On Fri, May 28 2004, Dan Hollis wrote:
> replies to email as i'm not subscribed to the list.
> 
> There seem to be regular dma timeouts:
> 
> hdc: dma_timer_expiry: dma status == 0x24
> hdc: DMA interrupt recovery
> hdc: lost interrupt
> hda: dma_timer_expiry: dma status == 0x24
> hda: DMA interrupt recovery
> hda: lost interrupt
> 
> Hardware:
> 
> Opteron 140, Tyan Tomcat K8S (S2850)

Try disabling ACPI (in .config or boot acpi=off iirc)

-- 
Jens Axboe

