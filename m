From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Tue, 06 Dec 2011 13:56:00 -0600
Message-ID: <4EDE7350.4010104@gmail.com>
References: <1322867573.11728.22.camel@pasglop> <20111205161157.GA27550@localhost.localdomain> <alpine.LFD.2.02.1112051236350.2357@xanadu.home> <20111205180253.GB29812@localhost.localdomain> <alpine.LFD.2.02.1112051310150.2357@xanadu.home> <20111205192605.GD29812@localhost.localdomain> <alpine.LFD.2.02.1112051443190.2357@xanadu.home> <20111206093709.GB2274@linaro.org> <20111206104654.GN14542@n2100.arm.linux.org.uk> <20111206113735.GC2274@linaro.org> <20111206114952.GS14542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20111206114952.GS14542@n2100.arm.linux.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Pawel Moll <pawel.moll@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, devicetree-discuss@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Anton Vorontsov <cbouatmailru@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 12/06/2011 05:49 AM, Russell King - ARM Linux wrote:
> On Tue, Dec 06, 2011 at 11:37:35AM +0000, Dave Martin wrote:
>> 1) All OF code and drivers should be migrating to use 0 instead of NO_IRQ
>>    for the no-interrupt case.  Code which receives irq numbers directly
>>    from the OF framework and refers to NO_IRQ, or expects 0 to be a valid
>>    needs to be fixed.
>>
>> 2) Where we hit a problem, board code needs to be adapted to remap HW IRQs
>>    0-15 to different software values.  (This could be done using irq
>>    domains, or not)
> 
> No AMBA driver I'm aware of ever uses an IRQ number 0 or is passed such
> an IRQ number.

The watchdog on VersatileAB is on Linux IRQ0. This is easily fixed with
VIC irqdomain patches which are queued up.

Rob
