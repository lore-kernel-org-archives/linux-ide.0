From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: So, is there support for IDE devices that have no IRQ?
Date: Thu, 25 Mar 2004 14:21:02 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1080184862.1149.59.camel@gaston>
References: <20040324232905.GA11286@buici.com>
	 <200403250104.10142.bzolnier@elka.pw.edu.pl>
	 <20040325014423.GA9860@buici.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:21381 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263150AbUCYDVf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Mar 2004 22:21:35 -0500
In-Reply-To: <20040325014423.GA9860@buici.com>
List-Id: linux-ide@vger.kernel.org
To: Marc Singer <elf@buici.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

On Thu, 2004-03-25 at 12:44, Marc Singer wrote:
> On Thu, Mar 25, 2004 at 01:04:10AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Probing code uses polling but actual NODATA/PIO/DMA handlers require IRQ
> > so it needs much effort to make it work.
> 
> Well, I'm thinking that I can emulate the irq by using a timer.  A bad
> hack, but it ought to work as long as I can get the timing correct.
> This is for a compact flash interface.

Well, before doing such a big pile of shit, you should think seriously
about making the HW person (provided it's not you) regret deeply his
mistake :) Seriously, not wiring the IRQ line is _DUMB_ at best

Ben.


