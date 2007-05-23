From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] ata: pata_platform: Disable prereset logic.
Date: Wed, 23 May 2007 17:30:26 +0900
Message-ID: <20070523083026.GA29851@linux-sh.org>
References: <20070523064408.GA29593@linux-sh.org> <4653F62C.4070700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:46343 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200AbXEWIbS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 May 2007 04:31:18 -0400
Content-Disposition: inline
In-Reply-To: <4653F62C.4070700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 23, 2007 at 10:07:08AM +0200, Tejun Heo wrote:
> Paul Mundt wrote:
> > On a number of boards the current prereset logic seems to misbehave:
> > 
> > scsi0 : pata_platform
> > ata1: PATA max PIO0 cmd 0xb06001f0 ctl 0xb06003f6 bmdma 0x00000000 irq 0
> > ata1: device not ready (errno=-19), forcing hardreset
> > ata1: BUG: prereset() requested invalid reset type
> > 
> > This triggers when there is no card inserted in the slot.
> > 
> > Simply disabling the prereset gets rid of this, and doesn't seem to cause
> > any problems for either PCMCIA or CF cards when they're actually present.
> 
> NACK.  The BUG printking needs fixing but you can't just kill
> prereset().  Did it work properly on 2.6.21.1?  Can you modify
> ata_wait_ready() such that it prints out the status value while waiting?
> 
ata_wait_ready() works fine, it reports 0xff immediately (and this is
what I would expect when there is no card inserted).

The board that exhibits this behaviour wasn't supported in the older
kernels, I can backport and test if it will be useful, though.
