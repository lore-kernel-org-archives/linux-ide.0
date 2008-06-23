From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt] ide: fix interrupts processing issue with
	preempt-able hardirqs
Date: Tue, 24 Jun 2008 01:51:41 +0200
Message-ID: <20080623235141.GB17297@elte.hu>
References: <20080623234037.GA6793@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:58542 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbYFWXwB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jun 2008 19:52:01 -0400
Content-Disposition: inline
In-Reply-To: <20080623234037.GA6793@polina.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>


* Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> IDE interrupt handler relies on the fact that, if necessary, hardirqs 
> will re-trigger on ISR exit. With fully preemtable IRQs this seems to 
> be not true, since if hardirq thread is currently running, and the 
> same IRQ raised again, then this IRQ will be simply lost.

actually no, that should not happen - if -rt loses an IRQ then something 
broke in the threaded IRQ code. It's supposed to be a drop-in, 
compatible IRQ flow with no driver changes needed.

( also, please do not Cc: mainline maintainers to RFC -rt patches, let
  the -rt maintainers sort out the need for any patch propagation - once 
  the patches are sufficiently cooked. Thanks. )

	Ingo
