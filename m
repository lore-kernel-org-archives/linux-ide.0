From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2 -rt] ide: workaround buggy hardware issues with
 preemptable hardirqs
Date: Sat, 28 Jun 2008 10:15:35 +0100
Message-ID: <20080628101535.54f20794@lxorguk.ukuu.org.uk>
References: <20080623234037.GA6793@polina.dev.rtsoft.ru>
	<20080623235141.GB17297@elte.hu>
	<20080624000016.GA12547@polina.dev.rtsoft.ru>
	<20080625123431.GA25452@polina.dev.rtsoft.ru>
	<20080628005436.GA1956@polina.dev.rtsoft.ru>
	<20080628010928.GA4248@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53121 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756072AbYF1Jil (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jun 2008 05:38:41 -0400
In-Reply-To: <20080628010928.GA4248@polina.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Daniel Walker <dwalker@mvista.com>

> Though, from a brief glance there is nothing much useful for this ULi
> chip. The only thing I gathered is that IDE controller does not provide
> any means of configuring its IRQs behaviour, so it is indeed ULi's bridge
> problems. It doesn't change anything, just another data point...

Legacy mode - Int line, edge
Native mode - PCI, level

Standard for IDE controllers
