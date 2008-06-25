From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -rt] ide: fix interrupts processing issue with
 preempt-able hardirqs
Date: Wed, 25 Jun 2008 13:32:57 +0100
Message-ID: <20080625133257.7677258d@lxorguk.ukuu.org.uk>
References: <20080623234037.GA6793@polina.dev.rtsoft.ru>
	<20080623235141.GB17297@elte.hu>
	<20080624000016.GA12547@polina.dev.rtsoft.ru>
	<20080625123431.GA25452@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47775 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754433AbYFYMwF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jun 2008 08:52:05 -0400
In-Reply-To: <20080625123431.GA25452@polina.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Daniel Walker <dwalker@mvista.com>

> The bug, as I see it, in the alim15x3 (ULi M5228) hardware: for some
> reason it does not hold IRQ line, but rises it for some short period
> of time (while the drive itself rises and holds it correctly -- I'm
> seeing it via oscilloscope).

Are you sure the kernel isn't touching the status register and so
clearing the IRQ condition at the controller ?
