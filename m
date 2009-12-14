From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New equivalent of old ide2= kernel parameter?
Date: Mon, 14 Dec 2009 16:17:30 +0000
Message-ID: <20091214161730.0857e17e@lxorguk.ukuu.org.uk>
References: <10f740e80912140705k206018e5kbacdfb9c299853be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33227 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757691AbZLNQQm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Dec 2009 11:16:42 -0500
In-Reply-To: <10f740e80912140705k206018e5kbacdfb9c299853be@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org

On Mon, 14 Dec 2009 16:05:15 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> I'm trying to boot from an XUbuntu 9.10 CD on an old Sony VAIO Z600.
> The special thing about this laptop is that the CD-ROM drive is actually a
> drive connected to a PCMCIA card.

Nothing special about that.

> With the old ide subsystem, you had to pass `ide2=0x180,0x386' on the
> kernel command line to make install CDs find the CD-ROM drive. Recent
> distros use the new ata subsystem, hence this doesn't work anymore.
> 
> Does there exist an equivalent for the new ata subsystem?

With both the recent old and the current libata your pcmcia or cardbus
subsystem as appropriate should discover the device. ide=a,b,c won't
actually work because the kernel pcmica subsystem will re-init the port
from the BIOS whacky setup to normal PCMCIA/Cardbus.

Not tried this on the Z600 but it is true for several others.

If it doesn't work on the Z600 get more some dmi strings, lspci dumps and
verify what the pcmcia layer does and we can make it automatic as it
should be.

Alan
