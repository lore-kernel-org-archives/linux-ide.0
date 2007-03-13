From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP	drive
Date: Tue, 13 Mar 2007 13:42:31 +0000
Message-ID: <20070313134231.3d1a0263@lxorguk.ukuu.org.uk>
References: <45F6964D0200002D000156EC@emea5-mh.id5.novell.com>
	<45F695B8.5030006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41459 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753240AbXCMMlF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 08:41:05 -0400
In-Reply-To: <45F695B8.5030006@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Stanislav Brabec <sbrabec@novell.com>, jeff@garzik.org, bzolnier@gmail.com, paul@paulbristow.net, linux-ide@vger.kernel.org

> It seems ide-floppy needs some special handlings in interrupt handling
> too like delaying data transfer by several ticks after device indicates
> readiness.  Apart from separate high level driver, we might have to
> modify libata HSM implementation if we're gonna support these devices.

The data transfer delay may well be down to the DMA bug

> Can someone more knowledgeable explain what needs to be done differently
> from standard ATAPI for these devices?

In theory not a lot if anything. I don't have a ZIP drive but have got an
old Iomega Clik! PCMCIA drive somewhere if you need an ide-floppy device
Tejun.

Alan
