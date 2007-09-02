From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/4] ide: make ide_rate_filter() also respect PIO and
 SW/MW DMA mode masks
Date: Sun, 02 Sep 2007 23:11:07 +0400
Message-ID: <46DB0ACB.2080704@ru.mvista.com>
References: <200709022306.16560.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:54370 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751094AbXIBTIU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 15:08:20 -0400
In-Reply-To: <200709022306.16560.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

> Make ide_rate_filter() also respect PIO/SWDMA/MWDMA mode masks.  While at it,
> make the udma_filter() method calls take precedence over using the mode masks.
> 
> ---
> This version doesn't use explicit UltraDMA masks, so converting them to the
> ATA_UDMA* is left for another, global patch.

    Argh, ignore the above sentense.

> This patch against the current
> Linus' tree and unfortunately I was able to only compile test it since that
> tree gives MODPOST warning and dies early on bootup.

    This is still so. I'll try to test it whenever I have enought time...

MBR, Sergei
