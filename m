From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/4] ide: make ide_rate_filter() also respect PIO and
 SW/MW DMA mode masks (take 2)
Date: Sat, 08 Sep 2007 16:05:33 +0400
Message-ID: <46E2900D.5010004@ru.mvista.com>
References: <200709022344.18565.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:49200 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751532AbXIHMCc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Sep 2007 08:02:32 -0400
In-Reply-To: <200709022344.18565.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Once I quothed:

> Make ide_rate_filter() also respect PIO/SWDMA/MWDMA mode masks.  While at it,
> make the udma_filter() method calls take precedence over using the mode masks.

    This one not looking to pretty -- I've geve some thought on how to 
beautify all these switch fallthoughs but haven't got something much better 
then uour original approach (AKA Occam's razor :-).

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Farewell!
