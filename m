From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Sat, 3 Nov 2012 16:48:19 +0000
Message-ID: <20121103164819.14c71bb5@pyramind.ukuu.org.uk>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
	<20121020120047.GC17563@liondog.tnic>
	<50841CFC.2030802@talktalk.net>
	<20121021165756.GA20642@liondog.tnic>
	<50856AA8.1000607@talktalk.net>
	<20121022202734.GA16169@liondog.tnic>
	<20121023110549.06f9c2e8@pyramind.ukuu.org.uk>
	<20121023101751.GA24656@liondog.tnic>
	<5087B4CA.1030502@talktalk.net>
	<20121024115746.3d41fce7@pyramind.ukuu.org.uk>
	<20121103042635.GA21829@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37663 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943Ab2KCQnW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Nov 2012 12:43:22 -0400
In-Reply-To: <20121103042635.GA21829@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: phillip.wood@dunelm.org.uk, phillip.wood@talktalk.net, "Anton V. Boyarshinov" <boyarsh@altlinux.org>, bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Sat, 3 Nov 2012 05:26:35 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Oct 24, 2012 at 11:57:46AM +0100, Alan Cox wrote:
> > Which is an ATA layer bug - adev->dma_mode should never be called
> > without a DMA mode in normal use.
> 
> Ok, it looks like this would take a while to fix.

So a 30 second glance says that the problem is that you seem to have
dma_mode uninitialised as zero which is bogus.

That means either ata_acpi_gtm_xfermask broke (it should have set the
bits to 0xFF if no mode is found), ata_dma_enabled is broken, or
pacpi_qc_issue got called before pacpi_port_start (which seems wildly
unlikely)

Needs someone to go and dump the relevant values in the right places and
see what is breaking in the pata_acpi setup logic.

Alan

