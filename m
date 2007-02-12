From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: The 5th bar of ide controller at legacy mode
Date: Mon, 12 Feb 2007 12:56:46 +0000
Message-ID: <20070212125646.61263751@localhost.localdomain>
References: <1171244453.15989.389.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56550 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964892AbXBLMnM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2007 07:43:12 -0500
In-Reply-To: <1171244453.15989.389.camel@ymzhang>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: linux-ide@vger.kernel.org, fedora-ia64-list <fedora-ia64-list@redhat.com>

O> 0x0000000000000000 0x00000000000003ff 0x0000000000000200
> 0x0000000000000000 0x0000000000000000 0x0000000000000000
> 
> The 5th bar is incorrect. BIOS initiates ide controllers.

You appear to have a 5th BAR allocated at address 0 with a length of
0x400. 

> failure, but ide-cd/piix is smarter to recall pci_enable_device_bars
> directly with parameter bars=(1<<4), so only 0~4th bar resources are checked.

the old IDE code deals only with SFF interfaces in simple modes, and hand
does all the handling for BAR 0-3 because of old PCI layer flaws and
weaknesses.

> So my question is: should ata/ata_piix also need to recall pci_enable_device_bars
> with parameter bars=(1<<4) if pci_enable_device fails like what ide-cd/piix does?

Your platform code or BIOS is buggy. PPC people had a similar problem.
Zero is not currently taken as "unallocated" by the PCI layer and, while
Linus suggested it could be, Dave Woodhouse and others pointed out there
are systems which legitimately use address 0 on the PCI in this way.

Sounds like you need to fix up after your firmware in your boot code,
perhaps with an arch specific pci header quirk.

Alan
