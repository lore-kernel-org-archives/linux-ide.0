From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 18/19] ide: add ide_use_fast_pio() helper
Date: Fri, 12 Jan 2007 15:16:29 +0000
Message-ID: <20070112151629.00c17327@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	<20070112042800.28794.95095.sendpatchset@localhost.localdomain>
	<20070112100836.58738dbc@localhost.localdomain>
	<58cb370e0701120600pc65b237w4865c9637fc1b6e6@mail.gmail.com>
	<20070112143037.7d5bf10f@localhost.localdomain>
	<58cb370e0701120643l5274bd5bn9d9f3661808a455c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43041 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750918AbXALPFF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 10:05:05 -0500
In-Reply-To: <58cb370e0701120643l5274bd5bn9d9f3661808a455c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> It seems that it821x_tune_chipset() is buggy since it sends SET FEATURES
> command even when in smart mode.  Shouldn't there be "don't tune" flag
> in it812x_fixups() to tell it821x_tune_chipset() to not send SET FEATURES
> commands?

It's itdev->smart but falls through to ide_config_drive_speed while it
should probably just copy bits of the code from it. Thats all fixed in
the libata driver which allows chip specific mode setup.

