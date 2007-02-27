From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: really bad performance with ICH7 SATA controller
Date: Tue, 27 Feb 2007 12:33:32 +0000
Message-ID: <20070227123332.32b3c161@lxorguk.ukuu.org.uk>
References: <200702270837.42583.baeckham@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56116 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750785AbXB0L33 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Feb 2007 06:29:29 -0500
In-Reply-To: <200702270837.42583.baeckham@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Baeckham <baeckham@gmx.net>
Cc: linux-ide@vger.kernel.org

> Some output from dmesg:
> ...
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ide0: I/O resource 0x1F0-0x1F7 not free.
> ide0: ports already in use, skipping probe
> Probing IDE interface ide1...
> hdd: TSSTcorpCD/DVDW SN-S082D, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hdd: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache

You have one of the awkward IDE setups. If you build a kernel with just
libata support and not old IDE your CD should appear
as /dev/scd{something} and run fast.

Alternatively you can do this using a boot option (combined_mode=libata)


Alan
