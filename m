From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Implementing NVMHCI...
Date: Sat, 11 Apr 2009 20:32:46 +0100
Message-ID: <20090411203246.513a0892@lxorguk.ukuu.org.uk>
References: <49E0D47B.9070205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39322 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753930AbZDKTdn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Apr 2009 15:33:43 -0400
In-Reply-To: <49E0D47B.9070205@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>

> 	  The spec describes the sector size as
> 	  "512, 1k, 2k, 4k, 8k, etc."   It will be interesting to reach
> 	  "etc" territory.

Over 4K will be fun.

> - ahci.c becomes a tiny stub with a pci_device_id match table,
>    calling functions in libahci.c.

It needs to a be a little bit bigger because of the folks wanting to do
non PCI AHCI, so you need a little bit of PCI wrapping etc

>    With a brand new command set, might as well avoid SCSI completely IMO,
>    and create a brand new block device.

Providing we allow for the (inevitable ;)) joys of NVHCI over SAS etc 8)


Alan
