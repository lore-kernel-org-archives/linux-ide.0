From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/4] ata: ahci_mvebu: new driver for Marvell Armada 380
 AHCI interfaces
Date: Mon, 7 Apr 2014 23:43:36 +0200
Message-ID: <20140407234336.6305681b@skate>
References: <1396882664-19297-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1396882664-19297-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<2819007.7Vym3v6BRo@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50222 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753119AbaDGVnl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2014 17:43:41 -0400
In-Reply-To: <2819007.7Vym3v6BRo@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

Dear Bartlomiej Zolnierkiewicz,

On Mon, 07 Apr 2014 19:50:06 +0200, Bartlomiej Zolnierkiewicz wrote:

> > +static struct platform_driver ahci_mvebu_driver = {
> > +	.probe = ahci_mvebu_probe,
> > +	.remove = ata_platform_remove_one,
> > +	.driver = {
> > +		.name = "ahci-mvebu",
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = ahci_mvebu_of_match,
> 
> Why is the Power Management support missing from this driver?

Because as of today, the only platform that can use this driver is the
Armada 38x, and we don't yet have suspend/resume support for this
platform: we haven't written yet the suspend to RAM code for it. And I
wanted to avoid adding suspend/resume code that I'm not able to test.

So my plan is to get back to PM support once we have working suspend to
RAM support on Armada 38x.

> > +MODULE_DESCRIPTION("Marvell EBU AHCI SATA driver");
> > +MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:ahci_mv");
> 
> platform:ahci_mvebu ?

Indeed, thanks for spotting.

> Otherwise it looks good.

Thanks for the review!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
