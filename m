From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 05/09] sata_mv don't blindly enable IRQs
Date: Sat, 17 May 2008 13:45:38 -0400
Message-ID: <482F19C2.3080100@rtr.ca>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca> <482AE767.8090103@rtr.ca> <482AE817.2020809@rtr.ca> <482F1732.6010109@rtr.ca> <482F18DE.2090102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2639 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbYEQRpk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 13:45:40 -0400
In-Reply-To: <482F18DE.2090102@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
>
> 1) please include a colon (":") or other punctuation after "sata_mv" 
> prefix in subject line.
..

Ahh..  will do, thanks.

> 2) when adding notes like "These five small patches...", we already have 
> a method of doing so:  the "---" separator.  The format of the patch 
> body should be:
> 
> 
>     patch description for kernel changelog
> 
>     signed-off-by: ...
>     ---
>     These five small patches are on top of the four previously
>     posted, so I'm extending the numbering to be xx/09 now.
..

I wondered about that one, and decided that making it prominent at the top
might be best.  But since you're trained to look in the correct place
further down, that's where I'll put it from now on.

Thanks Jeff!

