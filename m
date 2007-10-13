From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] IDE updates (part 2)
Date: Sat, 13 Oct 2007 23:29:22 +0100
Message-ID: <20071013232922.3ff6a464@the-village.bc.nu>
References: <200710131825.24768.bzolnier@gmail.com>
	<200710132259.53574.bzolnier@gmail.com>
	<20071013224452.71d6f61f@the-village.bc.nu>
	<200710140009.06260.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47912 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757044AbXJMWZK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 18:25:10 -0400
In-Reply-To: <200710140009.06260.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > > 		/* Probably a PCI interface... */
> > > 		for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; ++i)
> > > 			hw->io_ports[i] = data_port + i - IDE_DATA_OFFSET;
> > > 		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;

Ok so in actual fact

- The piece of code above can't be executed anyway
- The ctrl_port argument is not needed ?

Alan
