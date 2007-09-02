From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CF as IDE on ICH6M using libata
Date: Sun, 2 Sep 2007 15:04:23 +0100
Message-ID: <20070902150423.75687a98@the-village.bc.nu>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50714 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756154AbXIBNzr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 09:55:47 -0400
In-Reply-To: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eddie Hung <eddie.hung@gmail.com>
Cc: linux-ide@vger.kernel.org

O> - MDMA is not really supported, hence why it is so slow - if I can
> disable mdma and tell it to use single word PIO4, then I might get a
> reasonable 15Mb/s - however extensive searching has shown me that
> libata doesn't allow a user to set the xfer mode?

libata automatically picks the best mode for the device. Right now it
doesn't allow hand hacking this. I've got some patches (which I think I
sent in for the latest -mm) which allow you to specify that pata dma
doesn't occur for certain classes of device.

> - UDMA is not detected for some reason, even if it is supported by the
> card and by the controller (is there any way to force that to be
> enabled, regardless of whether it is detected or not?)
> - Even more worryingly for me, is that Windows also resorts to using
> Multiword DMA 2, and it is frightfully slow (which is a big
> disappointment - seeing as another X41 user (who is undoubtedly using
> windows!) has reported success!) - I am currently trying to get in
> touch with this user
> - I bought a card which is too fast for its own good - if only it
> could only support PIO, then I might not be in this mess! =)

If MWDMA2 is also very slow that is suprising. Is Windows in fact
dropping back to PIO as well ? A lot of CF cards support MWDMA, very few
UDMA. To complicate things many CF convertors do not support MWDMA, quite
a few are electrically inadequate for UDMA (I guess being defined long
before anyone thought about UDMA and CF).

Finally to completely screw you most SATA/PATA convertors don't support
anything but a few UDMA modes and PIO.

Alan
