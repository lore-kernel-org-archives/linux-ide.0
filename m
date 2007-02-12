From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Fedora-ia64-list] Re: The 5th bar of ide controller at legacy
 mode
Date: Mon, 12 Feb 2007 19:24:01 +0000
Message-ID: <20070212192401.59b35794@localhost.localdomain>
References: <20070212125646.61263751@localhost.localdomain>
	<617E1C2C70743745A92448908E030B2A011E7BEC@scsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53418 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965289AbXBLTKg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2007 14:10:36 -0500
In-Reply-To: <617E1C2C70743745A92448908E030B2A011E7BEC@scsmsx411.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: ia64 Fedora Core Development <fedora-ia64-list@redhat.com>, "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>, linux-ide@vger.kernel.org

> Which sounds sort of plausible ... but perhaps that's because I have
> not idea what a "Class code programming model" is.  Does that make
> any sense?

I think they are talking about BAR0 to 3 which are special, not BAR5
which the ia64 kernel code has somehow ended up assigned at I/O address
zero. Now whether that is a BIOS/Linux confusion, a BIOS mis-setup or
something weird that happened post BIOS to OS handover I don't know.

I know a similar PPC problem was really about the firmware assigning it
to zero to mean "not assigned" and the OS interpreting that as Bus
address 0, assigned.

Alan
