From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: remove broken SW/MW DMA
 support
Date: Fri, 16 Feb 2007 16:39:44 +0300
Message-ID: <45D5B420.7040509@ru.mvista.com>
References: <200702080858.l188wjmG008432@harpo.it.uu.se> <17877.33048.23816.692749@alkaid.it.uu.se> <45D5AD8B.1060702@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:50582 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964840AbXBPNjx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 08:39:53 -0500
In-Reply-To: <45D5AD8B.1060702@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, bzolnier@gmail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello.

Sergei Shtylyov wrote:

>    The intent of the patch was exactly to *remove* broken DMA support 
> until it's fixed (which requires more work).  It only worked by chance 
> -- because MWDMA2 timings are the same as of PIO4.  Have patience please.

    You may also consider switching to the libata driver -- Alan said he fixed 
DMA support there after I frisrt reported the breakage (however, I' still not 
seeing it fixed in the mainline)...

>> /Mikael

WBR, Sergei
