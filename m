From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Single host/multiple hwifs vs. multiple hosts?
Date: Sun, 8 Apr 2012 11:12:44 +0200
Message-ID: <CAMuHMdXKUVU8WWVD_fd4XpB3-scsfrJjOVQ6D1D=jAMmi-qhsQ@mail.gmail.com>
References: <CAMuHMdX1iwCwH+NXF7wP+pTMZzkUiR+DOrjjrVFWmtQUsktC=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55859 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab2DHJMp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Apr 2012 05:12:45 -0400
Received: by wejx9 with SMTP id x9so2149473wej.19
        for <linux-ide@vger.kernel.org>; Sun, 08 Apr 2012 02:12:44 -0700 (PDT)
In-Reply-To: <CAMuHMdX1iwCwH+NXF7wP+pTMZzkUiR+DOrjjrVFWmtQUsktC=w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>

On Sun, Mar 4, 2012 at 13:15, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> I'm wondering what are the differences between adding a single IDE ho=
st with
> multiple hwifs vs. adding a separate IDE host for each hwif?
> Do both ways work?

Does no one know?

Thx again!

> I'm asking because I want to convert the Amiga Buddha IDE driver to t=
he new
> driver model, using Multi Function Devices (many Zorro expansion card=
s contain
> multiple devices):
> =C2=A0- A Catweasel expansion card would have:
> =C2=A0 =C2=A0 =C2=A0* 2 Buddha IDE MFD cells,
> =C2=A0 =C2=A0 =C2=A0* 1 Catweasel floppy MFD cell.
> =C2=A0- A Buddha expansion card would have:
> =C2=A0 =C2=A0 =C2=A0* 3 Buddha IDE MFD cells.
> =C2=A0- An X-Surf expansion card would have:
> =C2=A0 =C2=A0 =C2=A0* 2 Buddha IDE MFD cells,
> =C2=A0 =C2=A0 =C2=A0* 1 8390 Ethernet cell.
> Registering a separate IDE host/hwif for each IDE MFD cell would be e=
asier to
> handle than a single IDE host with multiple IDE hwifs.
>
> Thanks in advance!

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
