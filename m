From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/20] dtc2278: ->io_32bit setting don't have to be
 identical for master/slave
Date: Sun, 9 Dec 2007 23:07:36 +0000
Message-ID: <20071209230736.2cdb6e44@the-village.bc.nu>
References: <200712092208.58494.bzolnier@gmail.com>
	<20071209222736.1c4ba88c@the-village.bc.nu>
	<200712100015.15735.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37510 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751021AbXLIXNA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 18:13:00 -0500
In-Reply-To: <200712100015.15735.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

> There is absolutely no hardware setup done by IDE subsystem or dtc2278
> host driver when ->io_32bit setting is changed and since ->io_32bit setting

So ?

The original author went to great trouble to specifically enforce the
behaviour in question and probably did so for a reason. Would it not be
far safer to fix it by keeping that enforcement and fixing where it is
lost than removing it - especially if you cannot test the hardware ?

> is only ever checked per drive / PIO transfer so this is currently purely
> a software limitation (moreover HDIO_DRIVE_CMD and HDIO_DRIVE_TASKFILE
> ioctls force 16-bit I/O anyway).
> 
> [ I also haven't noticed anything related to this requirement in Winbond
>   W83759A datasheet (though I have only quickly skimmed through it)... ]

Nothing in the sheet AFAIK but the DTC is a close relative not the actual
winbond
