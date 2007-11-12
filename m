From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: possibly a dumb question about sb600/700
Date: Mon, 12 Nov 2007 14:36:12 +0000
Message-ID: <20071112143612.5be65fc8@the-village.bc.nu>
References: <47381768.2060803@gmail.com>
	<20071112131640.3bf0073c@the-village.bc.nu>
	<4738542A.5050706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:35569 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750801AbXKLOgl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Nov 2007 09:36:41 -0500
In-Reply-To: <4738542A.5050706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: conke.hu@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>

> Alright, then.  I was just worried about the asymmetry.  Oh, this
> _reminds me of another problem regarding enable bits.  There's a system
> (wyse thin client) with pata_amd controller where the enable bit isn't
> set by the BIOS and there's no reliable way to identify the system (no
> DMI).  Do you know how important is the enabled bits test for these
> controllers?

If we ignore the tests we get more problems with 30 second timeouts on
other hardware that has incorrect termination or a port which is simply
not wired on the mainboard.

I bet we can identify the Wyse somehow and I'd rather do that even if it
means looking for magic strings in the BIOS ROM image.

Alan
