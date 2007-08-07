From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Tue, 7 Aug 2007 23:12:24 +0100
Message-ID: <20070807231224.56390a53@the-village.bc.nu>
References: <20070807054250.GQ13674@htj.dyndns.org>
	<20070807162529.1781b21c@the-village.bc.nu>
	<46B89177.2040209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56496 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S938105AbXHGWFr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 18:05:47 -0400
In-Reply-To: <46B89177.2040209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net, lcapitulino@mandriva.com.br

> Well, it's what the ide driver does.  BTW, according to the spec, we
> need to test bit 14 and 15 of word 87 before trusting any value the
> device reports in words 85-87 and 120, which libata currently doesn't
> do.  Are we leaving this out intentionally (for broken devices) or just
> did we just miss it?

Much of our testing was short checks on validity bits [although thats
really all paranoia]. Fixed in my tree and also made the hpa check match
drivers/ide and check both.

Verified the rest, fixed the dword_io check.


Think our flush_cache handling is still buggy in both old and new IDE btw.

