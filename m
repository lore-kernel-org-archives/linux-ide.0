From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] ide dma_timer_expiry, then hard lockup
Date: Thu, 21 Jun 2007 22:41:02 +0100
Message-ID: <20070621224102.1ae04397@the-village.bc.nu>
References: <20070618175713.GD5836@austin.ibm.com>
	<4677FFF1.2010308@ru.mvista.com>
	<20070619164854.GR5836@austin.ibm.com>
	<200706192043.40298.bzolnier@gmail.com>
	<46783777.10607@ru.mvista.com>
	<20070620162845.GY5836@austin.ibm.com>
	<20070620180123.642316ae@the-village.bc.nu>
	<467ABC4D.5010004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55220 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755140AbXFUVf6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jun 2007 17:35:58 -0400
In-Reply-To: <467ABC4D.5010004@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Linas Vepstas <linas@austin.ibm.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Stuart_Hayes@dell.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > queue ? You are overestimating IDE ;)
> 
>     He's not -- there is queued commands support since ATA[PI]-5. I'm not sure 
> why but Linux decided not to support it.

Almost no hardware supports it and the functionality is really really
ugly to use when it works at all - NCQ is rather more elegant.

Alan
