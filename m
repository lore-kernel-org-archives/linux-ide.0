From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 13/13] sata_mv use hweight16() for bit counting
Date: Fri, 02 May 2008 14:02:13 -0400
Message-ID: <481B5725.4020506@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <481AB03A.60808@rtr.ca> <481AB070.9050707@rtr.ca> <481AB0A1.3040009@rtr.ca> <481AB0D2.3070103@rtr.ca> <481AB107.701@rtr.ca> <481AB12A.3030102@rtr.ca> <481AB15D.5020201@rtr.ca> <481AB189.3070705@rtr.ca> <481AB1B4.7050508@rtr.ca> <481B55DF.1000208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4790 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758710AbYEBSCO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 14:02:14 -0400
In-Reply-To: <481B55DF.1000208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, Grant Grundler <grundler@google.com>

Mark Lord wrote:
> Some tidying as suggested by Grant Grundler.
> 
> Nuke local bit-counting function from sata_mv in favour of using 
> hweight16().
> Also add a short explanation for the 15msec timeout used when waiting 
> for empty/idle.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> This makes 13 patches now, rather than just 12.
...

NAK that.  I'll repost a V2 of this patch shortly,
with an #include <linux/bitops.h> for cross-platform safety.

Cheers
