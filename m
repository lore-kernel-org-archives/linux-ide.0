From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/8] alim15x3: PIO fallback fix
Date: Sat, 18 Aug 2007 23:26:11 +0400
Message-ID: <46C747D3.3040106@ru.mvista.com>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain> <46C6F90E.203@ru.mvista.com> <200708182118.23591.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:57928 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757377AbXHRTXr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 15:23:47 -0400
In-Reply-To: <200708182118.23591.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>[PATCH] alim15x3: PIO fallback fix

>>>If DMA tuning fails always set the best PIO mode.

>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>>Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>    Oh, it's belated now. :-/

> a bit ;)

    Kept deferring the reviews until I've totally forgotten. ;-)

>>    BTW, I'm going to hack on this driver since I've acquired a board with 
>>M1543C chip (that one for which there was an urgent bug that I had to fix some 
>>weeks ago :-)...
> 
> 
> Cool, this driver still have much room for an improvement i.e. it lacks proper
> MWDMA support and would greatly benefit from using ide_timing_compute()...

    Oh, that can be said about alomost all DMA-capable chip drivers except 
AMD/VIA.  So, don't hold your breath -- the first things on my agenda is 
fixing PIO timings (address setup being wrongly accounted for again) and 
adding the claimed MWDMA support per se.

> Bart

WBR, Sergei
