From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 1/4] fix drive->ready_stat for ATAPI
Date: Sun, 16 Jan 2005 15:01:58 +1100
Message-ID: <1105848118.27411.99.camel@gaston>
References: <Pine.GSO.4.58.0501160207290.29887@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55230 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262415AbVAPEDA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Jan 2005 23:03:00 -0500
In-Reply-To: <Pine.GSO.4.58.0501160207290.29887@mion.elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: list linux-ide <linux-ide@vger.kernel.org>

On Sun, 2005-01-16 at 02:11 +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> ATAPI devices ignore DRDY bit so drive->ready_stat must be set to zero.
> It is currently done by device drivers (including ide-default fake driver)
> but for PMAC driver it is too late as wait_for_ready() may be called during
> probe: probe_hwif()->pmac_ide_dma_check()->pmac_ide_{mdma,udma}_enable()->
> ->pmac_ide_do_setfeature()->wait_for_ready().  Set correct drive->ready_stat
> just after detecting ATAPI device.

Looks good.

Ben.


