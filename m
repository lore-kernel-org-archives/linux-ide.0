From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ata: fix Marvell SATA driver dependencies
Date: Wed, 26 Mar 2014 18:12:31 +0100
Message-ID: <4852939.9jMb8Bv2x2@amdc1032>
References: <5138028.BSQbEP7RRB@amdc1032> <20140326162302.GG25349@lunn.ch>
 <20140326165904.70de238d@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36703 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbaCZRN5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Mar 2014 13:13:57 -0400
In-reply-to: <20140326165904.70de238d@alan.etchedpixels.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


Hi,

On Wednesday, March 26, 2014 04:59:04 PM One Thousand Gnomes wrote:
> On Wed, 26 Mar 2014 17:23:02 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > On Wed, Mar 26, 2014 at 05:19:02PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > Make sata_mv host driver depend on PCI || ARCH_KIRKWOOD || ARCH_MVEBU ||
> > > ARCH_ORION5X config options as Marvell SATA support covers both Marvell
> > > PCI devices and Marvell Kirkwood, Armada 370/XP and Orion5x SoCs (for
> > > non-PCI devices the driver to work requires suitable device tree node to
> > > be defined).  Additionally allow the driver build if COMPILE_TEST config
> > > option is set.
> > 
> > Hi Bartlomiej
> > 
> > I _think_ there are a few powerpc platforms which can also make use of
> > this driver
> 
> The hardware can show up in just about anything so I think this patch
> should be dropped

In theory maybe but in practice it for sure won't show up if the vendor
has its own SATA solution and at least in the ARM world it seems frequent
to have its own AHCI variant nowadays.  Moreover even if the new usage
shows up it is not enough to enable driver for it to make it work as
you also need to add a node describing your SATA MV variant to your SoC
device tree file (which requires updating kernel source anyway).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

