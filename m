From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/09] sata_mv don't blindly enable IRQs
Date: Sat, 17 May 2008 13:41:50 -0400
Message-ID: <482F18DE.2090102@pobox.com>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca> <482AE767.8090103@rtr.ca> <482AE817.2020809@rtr.ca> <482F1732.6010109@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40503 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318AbYEQRl7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 13:41:59 -0400
In-Reply-To: <482F1732.6010109@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> These five small patches are on top of the four previously posted,
> so I'm extending the numbering to be xx/09 now:
> 
> -----snip-----
> 
> Part one of simplifying/fixing handling of the main_irq_mask register
> to resolve unexpected interrupt issues observed in 2.6.26-rc*.
> 
> Don't blindly enable port IRQs at host init time.
> Instead, enable only the bits that we want,
> which in this case is simply the PCI_ERR bit.
> 
> The per-port bits can wait until the ports are reset/probed for devices.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

Two process notes for future use:

1) please include a colon (":") or other punctuation after "sata_mv" 
prefix in subject line.

2) when adding notes like "These five small patches...", we already have 
a method of doing so:  the "---" separator.  The format of the patch 
body should be:


	patch description for kernel changelog

	signed-off-by: ...
	---
	These five small patches are on top of the four previously
	posted, so I'm extending the numbering to be xx/09 now.


Both of these details are documented in Documentation/SubmittingPatches 
and http://linux.yyz.us/patch-format.html

OTOH, your numbering behavior -- extending the patch numbering as you've 
done here, when the first patchset is not yet applied to git -- is quite 
useful and should be emulated by others :)

Tejun sometimes simply posts a new patchseries, noting that that 
patchseries is dependent upon a previous series.  That's fine, too.

Thanks,

	Jeff



