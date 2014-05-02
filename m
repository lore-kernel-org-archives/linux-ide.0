From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv3 2/5] ata: ahci_mvebu: new driver for Marvell Armada
 380 AHCI interfaces
Date: Fri, 2 May 2014 17:33:29 +0200
Message-ID: <20140502173329.25287270@skate>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1397574006-5868-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<20140502152237.GE10204@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57237 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751318AbaEBPdg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2014 11:33:36 -0400
In-Reply-To: <20140502152237.GE10204@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Dear Tejun Heo,

On Fri, 2 May 2014 11:22:37 -0400, Tejun Heo wrote:
> On Tue, Apr 15, 2014 at 05:00:03PM +0200, Thomas Petazzoni wrote:
> > The Marvell Armada 380 SoC includes two AHCI compatible
> > interfaces. However, like all DMA-capable Marvell interface, they
> > require special handling to configure MBus windows. Therefore, this
> > commit adds a new ahci_mvebu driver, which relies on the
> > libahci_platform.c code recently introduced.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> How should this be routed?  Can I pick up just this one and apply it
> to libata/for-3.16?

Yes. And I believe you should also take PATCH 1 in the series, which
updates the Device Tree binding documentation for the AHCI driver. Both
patches have received a Acked-by from Jason Cooper, the maintainer of
the mvebu platforms.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
