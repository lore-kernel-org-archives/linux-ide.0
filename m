From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Mon, 21 Jan 2008 17:27:15 +0000
Message-ID: <20080121172715.0e3e5e4d@lxorguk.ukuu.org.uk>
References: <200801140019.20668.g.chulkov@jacobs-university.de>
	<20080115025435.1e21b703.akpm@linux-foundation.org>
	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>
	<4794501E.90306@gmail.com>
	<20080121130256.2443d7c1@lxorguk.ukuu.org.uk>
	<47949AA4.9090601@gmail.com>
	<20080121141425.45aa9c61@lxorguk.ukuu.org.uk>
	<4794ACAF.70505@gmail.com>
	<20080121164744.2f7d0ed1@lxorguk.ukuu.org.uk>
	<4794D020.4060204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753921AbYAUR3g@vger.kernel.org>
In-Reply-To: <4794D020.4060204@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>
List-Id: linux-ide@vger.kernel.org

> I still don't think it's worth the trouble.  There's currently only one
> reported device which forgets to raise IRQ on media error.  The behavior

Most people wouldn't realise what is going on.

> > Old IDE says it works for PATA. For SATA I can see it might need more
> > care and you might simply not be able to get the info.
> 
> Old IDE often locks up the machine hard after timeouts.  I'm all for

The code paths are racy - it didn't use to in 2.4 (except for the promise
drain bug)

> gathering more info but benefit vs. risk equation just doesn't look good
> here.  Why take risk for a rare device which forgets to raise IRQ on
> media error?  If such behavior is wide spread among PATA drives && we
> can verify that TF register access after timeout is safe for PATA
> controllers, sure, but currently we aren't sure about either.

We lose IRQs in lots of other cases. Promise PATA is particularly bad at
forgetting to give us the completion interrupt.

Alan
