From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Wed, 08 Oct 2008 09:40:54 +0100
Message-ID: <1223455254.3145.143.camel@macbook.infradead.org>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	 <48EA77EF.6080502@genesi-usa.com>
	 <20081006213209.GA13072@oksana.dev.rtsoft.ru> <48EABBD3.1010401@kernel.org>
	 <20081007103723.0224671e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755241AbYJHIl3@vger.kernel.org>
In-Reply-To: <20081007103723.0224671e@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, avorontsov@ru.mvista.com, Matt Sealey <matt@genesi-usa.com>, Jeff Garzik <jgarzik@pobox.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Li Yang <leoli@freescale.com>, Wang Jian <lark@linux.net.cn>
List-Id: linux-ide@vger.kernel.org

On Tue, 2008-10-07 at 10:37 +0100, Alan Cox wrote:
> Zero means no IRQ. Any platform with bits of code left over exposing IRQ
> 0 is already not supported by lots of driver code including libata.

...and must implement some kind of interrupt remapping crap just to work
around this bogus design decision.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
