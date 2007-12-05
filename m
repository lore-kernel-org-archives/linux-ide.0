From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Wed, 5 Dec 2007 14:46:49 +0000
Message-ID: <20071205144649.4bca7a3c@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468202627-git-send-email-htejun@gmail.com>
	<4755ABB3.6030907@garzik.org>
	<4755FB90.50505@gmail.com>
	<20071205124713.4d31c5e7@the-village.bc.nu>
	<4756A1AE.4010205@gmail.com>
	<20071205140119.532c1eb4@the-village.bc.nu>
	<4756B415.404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46053 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751531AbXLEO5N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 09:57:13 -0500
In-Reply-To: <4756B415.404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Mikael Pettersson <mikpe@it.uu.se>

> It eventually has to end up in -rc.  If not for 2.6.25-rc1 is too early,
> we can put it in #testing and put it into #upstream later.

Nobody cares about libata git trees. If you want some initial test
coverage put it in -mm.

> primarily worried about.  Command type dependent quick fallback might
> help but ancient controllers are more likely to bring the whole machine
> down when a DMA transaction goes south.

Quite the reverse in my experience - the dumber the controller the more
likely that ATAPI DMA and LBA48 and other stuff just works anyway.

Alan
