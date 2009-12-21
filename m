From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: New equivalent of old ide2= kernel parameter?
Date: Mon, 21 Dec 2009 11:27:30 +0100
Message-ID: <10f740e80912210227h37b3fff5ga935211db161b13e@mail.gmail.com>
References: <10f740e80912140705k206018e5kbacdfb9c299853be@mail.gmail.com>
	 <20091214161730.0857e17e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:32946 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbZLUK1c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2009 05:27:32 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1281719eyd.19
        for <linux-ide@vger.kernel.org>; Mon, 21 Dec 2009 02:27:30 -0800 (PST)
In-Reply-To: <20091214161730.0857e17e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Mon, Dec 14, 2009 at 17:17, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mon, 14 Dec 2009 16:05:15 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> I'm trying to boot from an XUbuntu 9.10 CD on an old Sony VAIO Z600.
>> The special thing about this laptop is that the CD-ROM drive is actually a
>> drive connected to a PCMCIA card.
>
> Nothing special about that.
>
>> With the old ide subsystem, you had to pass `ide2=0x180,0x386' on the
>> kernel command line to make install CDs find the CD-ROM drive. Recent
>> distros use the new ata subsystem, hence this doesn't work anymore.
>>
>> Does there exist an equivalent for the new ata subsystem?
>
> With both the recent old and the current libata your pcmcia or cardbus
> subsystem as appropriate should discover the device. ide=a,b,c won't
> actually work because the kernel pcmica subsystem will re-init the port
> from the BIOS whacky setup to normal PCMCIA/Cardbus.
>
> Not tried this on the Z600 but it is true for several others.
>
> If it doesn't work on the Z600 get more some dmi strings, lspci dumps and
> verify what the pcmcia layer does and we can make it automatic as it
> should be.

I used an older Ubuntu CD that still took ide2= to bootstrap something on
the harddrive, and managed to install Xubuntu 9.10 from that. After the
install the PCMCIA CD-ROM drive is detected fine, so it's not actually a generic
kernel problem, but an issue with the Ubuntu Live CD.

Sorry for the noise...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
