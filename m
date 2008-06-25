From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -rt] ide: fix interrupts processing issue with
 preempt-able hardirqs
Date: Wed, 25 Jun 2008 15:32:12 +0100
Message-ID: <20080625153212.611c3766@lxorguk.ukuu.org.uk>
References: <20080623234037.GA6793@polina.dev.rtsoft.ru>
	<20080623235141.GB17297@elte.hu>
	<20080624000016.GA12547@polina.dev.rtsoft.ru>
	<20080625123431.GA25452@polina.dev.rtsoft.ru>
	<486244FF.8060805@ru.mvista.com>
	<20080625142249.GA21630@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37231 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750758AbYFYOwU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jun 2008 10:52:20 -0400
In-Reply-To: <20080625142249.GA21630@polina.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Daniel Walker <dwalker@mvista.com>

> Note: I don't have any specifications on that ULi bridge, neither I have
> any schematics for that board (so far, let's hope). So I can't say
> exactly how things are inter-connected or what these PCI quirks are
> actually doing (despite few comments in them).

So you don't for example know if the bridge is correctly configured for
that device to be edge or level triggered ?

Alan
