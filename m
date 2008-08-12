From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [2.6.26.*] boot problem (ahci/irq related?)
Date: Tue, 12 Aug 2008 09:05:05 +0200
Message-ID: <20080812070505.GX9038@one.firstfloor.org>
References: <8db1092f0808111312x3baf819bxbb05030c05693065@mail.gmail.com> <20080811202731.GB2916@elte.hu> <20080811210140.GW9038@one.firstfloor.org> <8db1092f0808112250y6b52a4ben879d83deda6496ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:51611 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbYHLHD7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 03:03:59 -0400
Content-Disposition: inline
In-Reply-To: <8db1092f0808112250y6b52a4ben879d83deda6496ce@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yhlu.kernel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, hancockr@shaw.ca

On Tue, Aug 12, 2008 at 07:50:09AM +0200, Maciej Rutecki wrote:
> 2008/8/11 Andi Kleen <andi@firstfloor.org>:
> [...]
> >
> > You can verify this by booting with pci=nommconf. If it works
> > then it's likely that.
> >
> [...]
> 
> It doesn't help

Then mmconfig is not the problem. Must be something else.

In the worst case you can always bisect I guess.

-Andi
