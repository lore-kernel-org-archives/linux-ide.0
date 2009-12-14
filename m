From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: New equivalent of old ide2= kernel parameter?
Date: Mon, 14 Dec 2009 16:05:15 +0100
Message-ID: <10f740e80912140705k206018e5kbacdfb9c299853be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:64735 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757480AbZLNPFR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Dec 2009 10:05:17 -0500
Received: by ewy19 with SMTP id 19so3471824ewy.21
        for <linux-ide@vger.kernel.org>; Mon, 14 Dec 2009 07:05:15 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm trying to boot from an XUbuntu 9.10 CD on an old Sony VAIO Z600.
The special thing about this laptop is that the CD-ROM drive is actually a
drive connected to a PCMCIA card.

With the old ide subsystem, you had to pass `ide2=0x180,0x386' on the
kernel command line to make install CDs find the CD-ROM drive. Recent
distros use the new ata subsystem, hence this doesn't work anymore.

Does there exist an equivalent for the new ata subsystem?

Thanks in advance!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
