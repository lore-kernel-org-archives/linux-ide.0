From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH/RFC] m68k/bitops: Make bitmap data pointer of atomic
 ops volatile
Date: Tue, 7 Jun 2011 14:35:00 +0100
Message-ID: <20110607133500.GX29924@decadent.org.uk>
References: <1307390873-29687-1-git-send-email-geert@linux-m68k.org>
 <201106062211.15247.arnd@arndb.de>
 <BANLkTin8XNA+ocdjUhtzVOQNxOGFsYa1mA@mail.gmail.com>
 <201106071322.29884.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201106071322.29884.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jun 07, 2011 at 01:22:29PM +0200, Arnd Bergmann wrote:
> On Tuesday 07 June 2011, Geert Uytterhoeven wrote:
> > You mean the host_busy variable in the IDE code?
> > That would also apply to context_flag in the DRM code:
> >=20
> > drivers/gpu/drm/drm_context.c:233: warning: passing argument 2 of
> > =E2=80=98__constant_test_and_set_bit=E2=80=99 discards qualifiers f=
rom pointer target
> > type
> > drivers/gpu/drm/drm_context.c:233: warning: passing argument 2 of
> > =E2=80=98__generic_test_and_set_bit=E2=80=99 discards qualifiers fr=
om pointer target
> > type
>=20
> Yes, that fits the same category.
>=20
> > > is wrong, though. It probably doesn't hurt to do both.
> >=20
> > asm-generic/bitops/atomic.h has the volatiles everywhere. That's wh=
y
> > I'm wondering.
>=20
> I guess what happened is that some variables are traditionally marked
> as volatile although they shouldn't be, and most architectures have
> adapted their bitops to make the warnings go away. If you see more
> warnings of that kind, it's probably fine to just do the same on m68k=
=2E
> The volatile modifier doesn't really hurt in this case.
=20
These operations are required to be atomic and therefore they
must be suitable for use with volatile-qualified variables.

Ben.

--=20
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                              - Albert =
Camus
