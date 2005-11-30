From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Crash when inserting media bay CD with 2.6.15-rc3
Date: Thu, 01 Dec 2005 09:39:29 +1100
Message-ID: <1133390370.16726.82.camel@gaston>
References: <1133329478.16726.65.camel@gaston>
	 <58cb370e0511300012p2f703ec0wd5ea054d5b7403d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:2236 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751178AbVK3WqF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2005 17:46:05 -0500
In-Reply-To: <58cb370e0511300012p2f703ec0wd5ea054d5b7403d6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Wed, 2005-11-30 at 09:12 +0100, Bartlomiej Zolnierkiewicz wrote:

> > For your information, the media bay driver, when detecting an IDE
> > device, first waits for the BUSY bit to clear (historical reasons: the
> > IDE driver used not to do it before I fixed it and I never udpated the
> > mediabay driver) and then does:
> >
> > ide_init_hwif_ports(&hw, (unsigned long) bay->cd_base, (unsigned long) 0, NULL);
> > hw.irq = bay->cd_irq;
> > hw.chipset = ide_pmac;
> > bay->cd_index = ide_register_hw(&hw, NULL);
> 
> mediabay driver allocates hw_regs_t hw from the stack but doesn't
> clear it before usage (hw->dev was added recently)?

Ah yes, the hw_regs_t in the past was only used temporarily,
ide_register_hw just copied it. I'll have to dig in there and figure out
how things changed. Thanks.

Ben.


