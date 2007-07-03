From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Tue, 03 Jul 2007 13:32:12 +0100
Message-ID: <468A41CC.6030203@genesi-usa.com>
References: <467C689E.3050800@genesi-usa.com>	<20070623103349.23cad9b7@the-village.bc.nu>	<467CE8FA.2040304@genesi-usa.com>	<20070623105344.3ece6db1@the-village.bc.nu>	<467CF1E6.8000905@genesi-usa.com>	<4689FBCB.90608@gmail.com>	<468A04A0.1020003@genesi-usa.com> <20070703131736.5ddc0b89@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:3256 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbXGCMb1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 08:31:27 -0400
In-Reply-To: <20070703131736.5ddc0b89@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org


Alan Cox wrote:
>> We can't make the controller TRULY legacy since there is not any good way
>> of mapping the IDE/BMDMA registers into the lower kilobyte or so of
>> memory - obviously PPC has no "io address space", it's all memory mapped,
>> so the lower kilobyte of "IO ports" is really the CPU zero page. It's not
>> a good idea to be poking around just there and we never intended that to work.
> 
> The right way to do this IMHO is still to use the PCI quirk side logic.
> Unfortunately to put your legacy ports at different I/O addresses you
> need changes which are still pending to the libata-sff code so that it
> stops using the hardcoded ATA_PRIMARY_FOO bits.

We can't move the IO ports. They're stuck in the PCI BAR.

All we can do is fix the IRQ steering in the "ISA bridge" to report a single
IRQ instead of two.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
