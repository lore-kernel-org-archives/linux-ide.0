From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/4] Phy: DT binding documentation for Marvell MVEBU
 SATA phy.
Date: Thu, 19 Dec 2013 22:21:15 -0500
Message-ID: <20131220032115.GD2609@titan.lakedaemon.net>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27204 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab3LTDV0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Dec 2013 22:21:26 -0500
Content-Disposition: inline
In-Reply-To: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: kishon@ti.com, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

On Tue, Dec 17, 2013 at 09:21:49PM +0100, Andrew Lunn wrote:
> Describe the binding for the Marvell MVEBU SATA phy. This driver
> can be used at least with Kirkwood, Dove and maybe others.
> Additionally, update the SATA binding with the properties to link
> to the phy nodes.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v1->v2:
> Correct #phy-cells
> Correct number after @ to match first reg address.
> Rename to phy-mvebu.txt
> 
> v2->v3:
> Renamed to mvebu-phy.txt
> Use "port0", "port1" instead of "0", "1"
> ---
>  Documentation/devicetree/bindings/ata/marvell.txt  |  6 ++++++
>  .../devicetree/bindings/phy/mvebu-phy.txt          | 22 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mvebu-phy.txt

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
