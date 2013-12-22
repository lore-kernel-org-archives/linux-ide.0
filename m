From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 4/4] Phy: Add DT nodes on kirkwood and Dove for the
 SATA PHY
Date: Sun, 22 Dec 2013 12:21:49 -0500
Message-ID: <20131222172149.GJ2609@titan.lakedaemon.net>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
 <1387311713-1926-4-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54458 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754018Ab3LVRWA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Dec 2013 12:22:00 -0500
Content-Disposition: inline
In-Reply-To: <1387311713-1926-4-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: kishon@ti.com, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

On Tue, Dec 17, 2013 at 09:21:52PM +0100, Andrew Lunn wrote:
> Add nodes for the two SATA PHYs on kirkwood.
> Add node for the one SATA PHY on Dove.
> Add pHandles to the PHYs in the sata nodes.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v1->v2:
> sata_phy@... ->sata-phy@
> value after '@' matching the first address in the reg.
> 
> v2->v3:
> "0" -> "port0", etc.
> kirkewood -> kirkwood
> ---
>  arch/arm/boot/dts/dove.dtsi          | 11 +++++++++++
>  arch/arm/boot/dts/kirkwood-6281.dtsi |  2 ++
>  arch/arm/boot/dts/kirkwood-6282.dtsi |  2 ++
>  arch/arm/boot/dts/kirkwood.dtsi      | 18 ++++++++++++++++++
>  4 files changed, 33 insertions(+)

Applied to mvebu/dt with Kishon's Ack.

Please double check me, I had to shuffle dove.dtsi since I recently
sorted the nodes under the ocp bus.

thx,

Jason.
