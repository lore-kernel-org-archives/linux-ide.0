From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] remove no longer needed AMIGA/MAC hacks from IDE resource
 handling code
Date: Wed, 17 Mar 2004 10:24:36 +0100 (MET)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.58.0403171024040.21104@waterleaf.sonytel.be>
References: <200403162320.19774.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:13265 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261234AbUCQJYl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2004 04:24:41 -0500
In-Reply-To: <200403162320.19774.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Tue, 16 Mar 2004, Bartlomiej Zolnierkiewicz wrote:
> Now when you've fixed macide.c what do you think about this patch?
>
> Regards,
> Bartlomiej
>
>
> [IDE] remove no longer needed AMIGA/MAC hacks from resource handling code
>
> Nowadays buddha.c, gayle.c and macide.c handle resources themselves.

Looks fine, since hwif->mmio is always 2 for us.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
