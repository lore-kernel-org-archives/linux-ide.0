From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.33-rc2 pata_macio fails to detect PMac G3 CD-drive
Date: Tue, 12 Jan 2010 11:35:30 +1100
Message-ID: <1263256530.724.166.camel@pasglop>
References: <19254.17766.674348.933702@pilspetsen.it.uu.se>
	 <1263186759.724.132.camel@pasglop>  <4B4ACCDD.8040803@kernel.org>
	 <1263202866.724.134.camel@pasglop>  <4B4BC3CE.8010102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38207 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505Ab0ALAhY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jan 2010 19:37:24 -0500
In-Reply-To: <4B4BC3CE.8010102@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

On Tue, 2010-01-12 at 09:35 +0900, Tejun Heo wrote:
> 
> I think the only solution then is to disable the IRQ from the PIC.
> We'll probably need to generalize there a bit as it seems there are
> odd cases where we fall into IRQ storm but for now I think adding
> special case code with sufficient comment should do it.

I'll cook up a patch for pata_macio that keeps the irq disabled
until the first taskfile is fired. We don't share interrupts on
those guys so it shouldn't be a big deal, we'll see if it helps
with Mikael's problem.

For the more "generic" case, I think you are stuffed when shared
interrupts enter the picture. We'll see if you still get reports
of such interrupt storms, when they happen ...

Cheers,
Ben.


