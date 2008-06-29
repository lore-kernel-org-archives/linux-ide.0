From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2 -rt] ide: workaround buggy hardware issues with
 preemptable hardirqs
Date: Sun, 29 Jun 2008 13:49:43 +0100
Message-ID: <20080629134943.19b94bd2@lxorguk.ukuu.org.uk>
References: <20080623234037.GA6793@polina.dev.rtsoft.ru>
	<20080623235141.GB17297@elte.hu>
	<20080624000016.GA12547@polina.dev.rtsoft.ru>
	<20080625123431.GA25452@polina.dev.rtsoft.ru>
	<20080628005436.GA1956@polina.dev.rtsoft.ru>
	<20080628101431.0b64d6c2@lxorguk.ukuu.org.uk>
	<486615E2.3080802@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34249 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754841AbYF2NKF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 09:10:05 -0400
In-Reply-To: <486615E2.3080802@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: avorontsov@ru.mvista.com, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Daniel Walker <dwalker@mvista.com>

>    His boot log shows the native mode.

Then the bridge is misprogrammed

>    What's IDEIRT, some ISA bridge register? And why should one set 
> [A]PIC to level mode for legacy mode IDE? :-O

You need an NDA and then they'll send you the data sheet for the bridges
and other logic. It's all programmable.

"He has an OpenPIC, it's PowerPC SoC, so no ELCR either"

Really - he's using a designed for PC ISA bridge etc.. he might have all
sorts of stuff on it.

Alan
