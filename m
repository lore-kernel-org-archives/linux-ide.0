From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC] m68k/bitops: Make bitmap data pointer of atomic ops volatile
Date: Tue, 7 Jun 2011 13:22:29 +0200
Message-ID: <201106071322.29884.arnd@arndb.de>
References: <1307390873-29687-1-git-send-email-geert@linux-m68k.org> <201106062211.15247.arnd@arndb.de> <BANLkTin8XNA+ocdjUhtzVOQNxOGFsYa1mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49893 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab1FGLWj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Jun 2011 07:22:39 -0400
In-Reply-To: <BANLkTin8XNA+ocdjUhtzVOQNxOGFsYa1mA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday 07 June 2011, Geert Uytterhoeven wrote:
> You mean the host_busy variable in the IDE code?
> That would also apply to context_flag in the DRM code:
>=20
> drivers/gpu/drm/drm_context.c:233: warning: passing argument 2 of
> =E2=80=98__constant_test_and_set_bit=E2=80=99 discards qualifiers fro=
m pointer target
> type
> drivers/gpu/drm/drm_context.c:233: warning: passing argument 2 of
> =E2=80=98__generic_test_and_set_bit=E2=80=99 discards qualifiers from=
 pointer target
> type

Yes, that fits the same category.

> > is wrong, though. It probably doesn't hurt to do both.
>=20
> asm-generic/bitops/atomic.h has the volatiles everywhere. That's why
> I'm wondering.

I guess what happened is that some variables are traditionally marked
as volatile although they shouldn't be, and most architectures have
adapted their bitops to make the warnings go away. If you see more
warnings of that kind, it's probably fine to just do the same on m68k.
The volatile modifier doesn't really hurt in this case.

	Arnd
