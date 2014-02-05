From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [Patch v4 1/3] drivers: phy: Make NULL a valid phy reference
Date: Wed, 5 Feb 2014 00:52:32 -0500
Message-ID: <20140205055232.GR8533@titan.lakedaemon.net>
References: <1391535193-24165-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:27630 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750720AbaBEFwi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Feb 2014 00:52:38 -0500
Content-Disposition: inline
In-Reply-To: <1391535193-24165-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: tj@kernel.org, kishon@ti.com, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org

On Tue, Feb 04, 2014 at 06:33:11PM +0100, Andrew Lunn wrote:
> The common clock framework considers NULL a valid clock
> reference. This makes handling optional clocks simple, in that if the
> optional clock is not available, a NULL reference can be used in the
> place of a real clock, simplifying the clock consumer.
> 
> Extend this concept to the phy consumer API. A NULL can be passed to
> the release calls, the phy_init() and phy_exit() calls, and
> phy_power_on() and phy_power_off() and a NOP is performed.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> v2
>  No change.
> v4
>  combine !phy and IS_ERR().
>  Add Tested-by
> ---
>  Documentation/phy.txt  |  6 ++++++
>  drivers/phy/phy-core.c | 17 ++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)

Whole series applied to mvebu/phy_ata-fixes with Kishon's Acks.

thx,

Jason.
