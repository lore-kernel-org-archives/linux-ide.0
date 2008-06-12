From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: CDC_PLAY_AUDIO check in cdrom_count_tracks() and other oddities
Date: Thu, 12 Jun 2008 20:47:42 +0200
Message-ID: <20080612184742.GQ20851@kernel.dk>
References: <48509D40.2060901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:10791 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754157AbYFLSrp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jun 2008 14:47:45 -0400
Content-Disposition: inline
In-Reply-To: <48509D40.2060901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On Thu, Jun 12 2008, Tejun Heo wrote:
> Hello, Jens.
> 
> I'm tracking down a bug where HAL doesn't mount media automatically.
> It turned out that CDROM_DISC_STATUS wasn't reporting correct disc
> type which was caused by CDC_PLAY_AUDIO check failure at the top of
> cdrom_count_tracks().
> 
> I've went through MMC-3 but couldn't find anything which associates
> play audio capability with READ_TOC.  READ_TOC was mandatory command,
> so according to MMC-3, there's no reason to avoid issuing READ_TOC on
> !CDC_PLAY_AUDIO.  Is there something I don't know?

That check predates me :-)

I can't imagine drives NOT having READ_TOC, so I don't think it's a
problem to remove the depedency on CDC_PLAY_AUDIO.

-- 
Jens Axboe

