From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA suspend-to-ram patch - merge?
Date: Wed, 21 Sep 2005 23:14:41 -0400
Message-ID: <433221A1.5000600@pobox.com>
References: <433104E0.4090308@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:3496 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030195AbVIVDOu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2005 23:14:50 -0400
In-Reply-To: <433104E0.4090308@triplehelix.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joshua Kwan <joshk@triplehelix.org>
Cc: axboe@suse.de, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Joshua Kwan wrote:
> Is Jens' patch still relevant? If so, should it be rediffed and merged
> into mainline? It doesn't seem to cause any weird side-effects.
> 
> More importantly, I would be inclined to properly rediff Jens' patch and
> merge it into Debian 2.6.12 kernel sources if there aren't any such
> side-effects, since it benefits everyone using SATA and suspend-to-ram
> (that is, users of relatively modern laptops.)

Jens' patch is technical correct for SATA, but really we want to do more 
stuff at the SCSI layer (see James Bottomley's response to Jens' patch).

Unfortunately, this also implies that we have to figure out which SCSI 
devices are available to be power-managed, and which SCSI devices are on 
a shared bus that should never be suspended.

So currently we are in limbo...

	Jeff


