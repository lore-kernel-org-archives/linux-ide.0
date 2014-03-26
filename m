From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: fix Marvell SATA driver dependencies
Date: Wed, 26 Mar 2014 16:59:04 +0000
Message-ID: <20140326165904.70de238d@alan.etchedpixels.co.uk>
References: <5138028.BSQbEP7RRB@amdc1032>
	<20140326162302.GG25349@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50584 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920AbaCZQ75 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Mar 2014 12:59:57 -0400
In-Reply-To: <20140326162302.GG25349@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, 26 Mar 2014 17:23:02 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Mar 26, 2014 at 05:19:02PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Make sata_mv host driver depend on PCI || ARCH_KIRKWOOD || ARCH_MVEBU ||
> > ARCH_ORION5X config options as Marvell SATA support covers both Marvell
> > PCI devices and Marvell Kirkwood, Armada 370/XP and Orion5x SoCs (for
> > non-PCI devices the driver to work requires suitable device tree node to
> > be defined).  Additionally allow the driver build if COMPILE_TEST config
> > option is set.
> 
> Hi Bartlomiej
> 
> I _think_ there are a few powerpc platforms which can also make use of
> this driver

The hardware can show up in just about anything so I think this patch
should be dropped
