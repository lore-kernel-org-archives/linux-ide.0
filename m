From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AHCI: using bios after linux
Date: Fri, 12 Oct 2007 17:27:49 +0100
Message-ID: <20071012172749.33def229@the-village.bc.nu>
References: <20071012154058.BEDDF47008A@web2mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51031 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760687AbXJLQZe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Oct 2007 12:25:34 -0400
In-Reply-To: <20071012154058.BEDDF47008A@web2mail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: msundius@u1.netgate.com
Cc: linux-ide@vger.kernel.org, msundius@sundius.com

> return to real mode after Linux). This proprietary code makes use of the BIOS
> disk calls via int13. In short we need to the BIOS Int13 after Linux.

Thats tricky. Linux does preserve the BIOS page.

> I been looking though your archives and reading the AHCI spec. It seems clear
> that the hardware has at least some state contained within it; I'm wondering if
> there is any hope of putting the chip back to a known state that the BIOS will
> be able to handle. 

You want the chip docs for the specific AHCI controller you need to work
with. For the Intel ones at least yo've got a chance to reconfigure them.
However you will need to know what the BIOS expects.

You may well also find that if you use a BIOS that supports AHCI (and can
set the controller to AHCI) you can use INT13 to talk to the controller
in AHCI mode.

I don't think its a good idea, and I would be tempted to try and remove
that set of calls and fire them via an application in Linux before
calling kexec, but in theory yes you can probably put the device back
into legacy mode.

Alan
