From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Tue, 3 Jul 2007 13:17:36 +0100
Message-ID: <20070703131736.5ddc0b89@the-village.bc.nu>
References: <467C689E.3050800@genesi-usa.com>
	<20070623103349.23cad9b7@the-village.bc.nu>
	<467CE8FA.2040304@genesi-usa.com>
	<20070623105344.3ece6db1@the-village.bc.nu>
	<467CF1E6.8000905@genesi-usa.com>
	<4689FBCB.90608@gmail.com>
	<468A04A0.1020003@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41738 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759991AbXGCMLV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 08:11:21 -0400
In-Reply-To: <468A04A0.1020003@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> We can't make the controller TRULY legacy since there is not any good way
> of mapping the IDE/BMDMA registers into the lower kilobyte or so of
> memory - obviously PPC has no "io address space", it's all memory mapped,
> so the lower kilobyte of "IO ports" is really the CPU zero page. It's not
> a good idea to be poking around just there and we never intended that to work.

The right way to do this IMHO is still to use the PCI quirk side logic.
Unfortunately to put your legacy ports at different I/O addresses you
need changes which are still pending to the libata-sff code so that it
stops using the hardcoded ATA_PRIMARY_FOO bits.

Alan
