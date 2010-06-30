From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Wed, 30 Jun 2010 20:31:38 +0200
Message-ID: <20100630183138.GA11036@liondog.tnic>
References: <20100617080726.GA13713@liondog.tnic>
 <20100617150008.16a5e653@cpc>
 <20100618074510.GD32368@liondog.tnic>
 <20100619005045.2173fcce@cpc>
 <20100619100511.GA31429@liondog.tnic>
 <20100619132708.030fe408@cpc>
 <20100623080200.GB5010@liondog.tnic>
 <20100625185846.72171be0@cpc>
 <20100630065426.GA1857@liondog.tnic>
 <20100630200254.45ab84d1@cpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40527 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575Ab0F3Sbo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jun 2010 14:31:44 -0400
Content-Disposition: inline
In-Reply-To: <20100630200254.45ab84d1@cpc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans Mueller <hans42mueller@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

From: Hans Mueller <hans42mueller@googlemail.com>
Date: Wed, Jun 30, 2010 at 08:02:54PM +0200

> On Wed, 30 Jun 2010 08:54:26 +0200
> Borislav Petkov <bp@alien8.de> wrote:
> 
> > Is your nick a pluggable card [...]
> No sorry, it's an onboard card.
> Furthermore, I don't know how to change the IRQ using linux. (Or rather
> if it's possible at all)
> I didn't find a possibility in my board's bios to change the IRQ
> mappings, too.

Ok, first you can try something which is real easy: I see you have an
ide2 and ide3 channels each having their own irq line. You could move
the cdrom connector to the other ide controller and test again.

Alternatively, if you have a spare PCI NIC, you can insert it into one
of the PCI slots after having disabled the onboard NIC in the BIOS. Just
for testing purposes, to see whether "unsharing" the IRQ line fixes the
issue.

Thanks.

-- 
Regards/Gruss,
    Boris.
