From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [git patches] libata hibernation fixes
Date: Sun, 18 Jan 2009 21:25:03 +0100
Message-ID: <200901182125.04060.rjw@sisk.pl>
References: <20081104062734.GA4420@havoc.gtf.org> <200901111343.49901.rjw@sisk.pl> <200901181120.08992.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58917 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbZARUZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Jan 2009 15:25:28 -0500
In-Reply-To: <200901181120.08992.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: jeff@garzik.org, tj@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 18 January 2009, Frans Pop wrote:
> Rafael J. Wysocki wrote:
> > There is a name conflict with a change applied after this patchset =
had
> > been created.  The appended patch fixes it for me.
> [...]
> > @@ -483,7 +483,7 @@ const struct dmi_system_id *dmi_first_match(con=
st struct dmi_system_id *list)
> >         const struct dmi_system_id *d;=20
> >=20
> >         for (d =3D list; d->ident; d++)
> > -               if (dmi_match(d))
> > +               if (dmi_matches(d))
> >                         return d;
>=20
> I get two warnings when compiling your patch with this correction on =
top:

Hm, there were more patches than one, so I'm not sure.  When I apply al=
l of
them, I don't see these error, but perhaps I should resend the entire s=
eries.
Will do tomorrow.

> drivers/firmware/dmi_scan.c: In function =E2=80=98dmi_first_match=E2=80=
=99:
> drivers/firmware/dmi_scan.c:488: warning: return discards qualifiers =
from pointer target type
> drivers/firmware/dmi_scan.c:483: warning: unused variable =E2=80=98i=E2=
=80=99
>=20
> The second is trivial, but the first is beyond me :-/

Thanks,
Rafael
