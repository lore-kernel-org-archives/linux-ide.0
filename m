From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv3 2/5] ata: ahci_mvebu: new driver for Marvell Armada
 380 AHCI interfaces
Date: Fri, 25 Apr 2014 20:23:06 -0400
Message-ID: <20140426002306.GJ28159@titan.lakedaemon.net>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397574006-5868-3-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24237 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751156AbaDZAXU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Apr 2014 20:23:20 -0400
Content-Disposition: inline
In-Reply-To: <1397574006-5868-3-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Tejun,

On Tue, Apr 15, 2014 at 05:00:03PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 380 SoC includes two AHCI compatible
> interfaces. However, like all DMA-capable Marvell interface, they
> require special handling to configure MBus windows. Therefore, this
> commit adds a new ahci_mvebu driver, which relies on the
> libahci_platform.c code recently introduced.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
