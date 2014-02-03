From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 3/3] ata: sata_mv: Fix probe failures with optional phys
Date: Mon, 3 Feb 2014 18:23:38 +0100
Message-ID: <20140203172338.GF8038@lunn.ch>
References: <0140131114857.GC26148@htj.dyndns.org>
 <1391264157-2112-1-git-send-email-andrew@lunn.ch>
 <1391264157-2112-3-git-send-email-andrew@lunn.ch>
 <20140203160315.GB30250@htj.dyndns.org>
 <52EFC21E.7030902@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:50405 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896AbaBCRXy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Feb 2014 12:23:54 -0500
Content-Disposition: inline
In-Reply-To: <52EFC21E.7030902@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew@lunn.ch>, kishon@ti.com, linux-ide@vger.kernel.org

> I have just tested it on both Armada 370 and Armada XP and it failed
> at the end of the mv_platform_probe function while trying to do a
> clk_put on the clocks on the second port.

That is odd

drivers/clk/clkdev.c_
void clk_put(struct clk *clk)
{
	__clk_put(clk);
}

and arch/arm/include/asm/clkdev.h

#define __clk_put(clk)  do { } while (0)

How can that cause a crash.

However, PC is at __clk_put+0x1c/0x8c

0x8c is a lot of instructions for what should be NOP.

Could you please take a look at this.

> Indeed the devm_phy_optional_get failed on the 1st port, so the clock
> of the second port was not allocated. What I don't get is why the
> IS_ERR check don't work here.

Remember that NULL is not an error. I'm assuming it is somehow
dereferencing NULL.

	 Andrew
