From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] pata_amd: fix and improve cable detection
Date: Sat, 3 Nov 2007 00:10:18 +0000
Message-ID: <20071103001018.5a71bfd3@the-village.bc.nu>
References: <472B402A.4030009@gmail.com>
	<472B4078.90009@gmail.com>
	<472B40B0.6010702@gmail.com>
	<20071102154406.7596b384@the-village.bc.nu>
	<472BA318.7010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35246 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762964AbXKCAJG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 20:09:06 -0400
In-Reply-To: <472BA318.7010406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> all we can use is how the BIOS configured it.  I suppose BIOS does it by
> issuing trial commands which I don't think adding to libata is a good idea.

The BIOS does it by asking the hardware somehow. I traced one or two
BIOSes that far. The info is there but its not documented in the
slightest so only ACPI makes it visible via the BIOS.

> 
> Can you please lemme know what you don't like about the current
> implementation or what other approach you have in mind?  I don't like
> Nvidia PATA either but there are a lot of people using it out there.

We seem to be able to trust the drives and BIOS ACPI data for Nvidia (at
least what I have seen), so I guess we should simply declare the cable
type unknown, 80 wire if ACPI says it is and then do the drive detect
side ?

Alan
