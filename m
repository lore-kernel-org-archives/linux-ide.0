From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4] ata: fix Marvell SATA driver dependencies
Date: Thu, 27 Mar 2014 10:52:15 -0400
Message-ID: <20140327145215.GB18503@htj.dyndns.org>
References: <13175343.U1fiIXSeHv@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <13175343.U1fiIXSeHv@amdc1032>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Mar 27, 2014 at 02:24:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Make sata_mv host driver depend on PCI || ARCH_DOVE || ARCH_KIRKWOOD ||
> ARCH_MV78XX0 || ARCH_MVEBU || ARCH_ORION5X config options as Marvell
> SATA support covers both Marvell PCI devices and Marvell Dove, Kirkwood,
> MV78xx0, Armada 370/XP and Orion5x SoCs (for non-PCI devices the driver
> to work requires suitable device tree node or platform device to be
> defined).  Additionally allow the driver build if COMPILE_TEST config
> option is set.
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
