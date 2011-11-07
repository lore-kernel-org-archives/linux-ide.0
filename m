From: Valdis.Kletnieks@vt.edu
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 07 Nov 2011 02:52:17 -0500
Message-ID: <22879.1320652337@turing-police.cc.vt.edu>
References: <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com> <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com> <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com> <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com> <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com> <7v62j1gitn.fsf@alter.siamese.dyndns.org> <7vvcr1f38j.fsf@alter.siamese.dyndns.org> <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com> <20111104145908.GA3903@thunk.org>
            <CA+55aFw6JJDkkSJnp=X4cQuibXMHVBgbQ99iPqEbd7p_7J=VfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1320652337_7081P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: Your message of "Fri, 04 Nov 2011 08:14:52 PDT."
             <CA+55aFw6JJDkkSJnp=X4cQuibXMHVBgbQ99iPqEbd7p_7J=VfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ted Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>, Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

--==_Exmh_1320652337_7081P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 04 Nov 2011 08:14:52 PDT, Linus Torvalds said:
> On Fri, Nov 4, 2011 at 7:59 AM, Ted Ts'o <tytso=40mit.edu> wrote:
> > Note that a repository format change will break a bunch of other
> > things as well, including references in commit descriptions (=22This
> > fixes a regression introduced in commit 42DEADBEEF=22)

> No they won't. Not if you do it right. It's easy enough to
> automatically replace the SHA1's in the description, the same way we
> replace everything else.

OK.. I'll bite.  How do you disambiguate a '42deadbeef' in the changelog =
part
of a commit as being a commit ID, as opposed to being an address in a tra=
ceback
or something similar? Yes, I know you only change the ones that actually =
map to
a commit ID, but I'd not be surprised if by now we've got enough commits =
and
stack tracebacks in the git history that we'll birthday-paradox ourselves=
 into
a false-positive in an automatic replacement.

(And it's OK to say =22the 3 stack tracebacks in changelogs we just mangl=
ed can
just go jump=22, but it does need at least a few seconds consideration..)=



--==_Exmh_1320652337_7081P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFOt44xcC3lWbTT17ARAqdSAKD8BKeDESG5NM0dZXjFR9OMibTRYgCfZP8A
6Xk6cPcaVy+tbJOahk+ING8=
=/1pP
-----END PGP SIGNATURE-----

--==_Exmh_1320652337_7081P--
