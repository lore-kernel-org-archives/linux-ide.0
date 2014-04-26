From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv3 3/5] ARM: mvebu: add Device Tree description of AHCI
 interfaces on Armada 38x
Date: Fri, 25 Apr 2014 20:27:58 -0400
Message-ID: <20140426002758.GM28159@titan.lakedaemon.net>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397574006-5868-4-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20539 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbaDZA2N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Apr 2014 20:28:13 -0400
Content-Disposition: inline
In-Reply-To: <1397574006-5868-4-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Tue, Apr 15, 2014 at 05:00:04PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 38x processors contain two AHCI compatible
> interfaces. This commit adds the Device Tree description of those
> interfaces at the SoC level, and also enables them on the Armada 385
> DB platform, which allows access to both interfaces through SATA
> ports.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-385-db.dts |  8 ++++++++
>  arch/arm/boot/dts/armada-38x.dtsi   | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)

Applied to mvebu/dt

thx,

Jason.
