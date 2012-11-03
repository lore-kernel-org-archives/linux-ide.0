From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Sat, 3 Nov 2012 05:26:35 +0100
Message-ID: <20121103042635.GA21829@liondog.tnic>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:49183 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893Ab2KCE0k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2012 00:26:40 -0400
Content-Disposition: inline
In-Reply-To: <20121024115746.3d41fce7@pyramind.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: phillip.wood@dunelm.org.uk, phillip.wood@talktalk.net, "Anton V. Boyarshinov" <boyarsh@altlinux.org>, bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Wed, Oct 24, 2012 at 11:57:46AM +0100, Alan Cox wrote:
> Which is an ATA layer bug - adev->dma_mode should never be called
> without a DMA mode in normal use.

Ok, it looks like this would take a while to fix.

Alan, what is your suggestion for a proper fix, uncomment XFER_PIO_SLOW
and drop to it with a big warning that ACPI is giving botched
information on those chips and people should try using the
platform-specific driver if they want better/optimal speeds?

Thanks.

-- 
Regards/Gruss,
    Boris.
