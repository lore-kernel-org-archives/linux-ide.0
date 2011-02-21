From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/20] ata_piix: unify code for programming PIO and
 MWDMA timings
Date: Mon, 21 Feb 2011 12:00:15 +0000
Message-ID: <20110221120015.22cc3fb2@lxorguk.ukuu.org.uk>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122346.19110.8441.sendpatchset@linux-mhg7.site>
	<4D6118DC.80505@ru.mvista.com>
	<20110220185958.364df4cc@lxorguk.ukuu.org.uk>
	<4D617CC8.3020108@ru.mvista.com>
	<20110220210731.0c774fa7@lxorguk.ukuu.org.uk>
	<4D624EBD.4080400@ru.mvista.com>
	<4D625238.6040503@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59231 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755428Ab1BUL6k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Feb 2011 06:58:40 -0500
In-Reply-To: <4D625238.6040503@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > Don't think they say anything on this matter but I can't imagine that IORDY
> > matters for DMA.
> 
>     What it says is that IORDY enable bit has no effect when the fast timing 
> bit is cleared. That's from ICH IDE PRM (29860004.pdf).

Ok thats the detail I missed - cool.
