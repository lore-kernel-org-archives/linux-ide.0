From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] pci_get_legacy_ide_irq()
Date: Wed, 20 Oct 2004 09:31:39 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1098228698.5755.1.camel@gaston>
References: <1098169487.15029.58.camel@gaston>
	 <58cb370e041019102572b83e37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:13466 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270128AbUJSXgi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Oct 2004 19:36:38 -0400
In-Reply-To: <58cb370e041019102572b83e37@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>

On Wed, 2004-10-20 at 03:25, Bartlomiej Zolnierkiewicz wrote:

> This won't be ever executed unless
> * you teach IDE driver about NO_IRQ
> or
> * NO_IRQ is 0

Right. I need to fix IDE driver for NO_IRQ too, good point.

Ben.


