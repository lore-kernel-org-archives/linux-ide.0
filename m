From: Mark Lord <liml@rtr.ca>
Subject: Re: [git patches] ide update
Date: Thu, 18 Aug 2005 20:44:57 -0400
Message-ID: <43052B89.8080709@rtr.ca>
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl> <Pine.LNX.4.58.0508181512240.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:56753 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932539AbVHSAo6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 20:44:58 -0400
In-Reply-To: <Pine.LNX.4.58.0508181512240.3412@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Linus Torvalds wrote:
>
> Btw, things like this:
> 
> 	+#define IDEFLOPPY_TICKS_DELAY  HZ/20   /* default delay for ZIP 100 (50ms) */
> 
> are just bugs waiting to happen.

Needs parenthesis: ((HZ)/20)

Or one could just use the msecs_to_jiffies() macro.

Cheers
