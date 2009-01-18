From: Frans Pop <elendil@planet.nl>
Subject: Re: [git patches] libata hibernation fixes
Date: Sun, 18 Jan 2009 11:20:07 +0100
Message-ID: <200901181120.08992.elendil@planet.nl>
References: <20081104062734.GA4420@havoc.gtf.org> <495D7DC9.8070101@kernel.org> <49698739.6010003@garzik.org> <49698739.6010003@garzik.org> <200901111343.49901.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933379AbZARKU3@vger.kernel.org>
In-reply-To: <200901111343.49901.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: jeff@garzik.org, tj@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Rafael J. Wysocki wrote:
> There is a name conflict with a change applied after this patchset ha=
d
> been created. =C2=A0The appended patch fixes it for me.
[...]
> @@ -483,7 +483,7 @@ const struct dmi_system_id *dmi_first_match(const=
 struct dmi_system_id *list)
>         const struct dmi_system_id *d;=20
>=20
>         for (d =3D list; d->ident; d++)
> -               if (dmi_match(d))
> +               if (dmi_matches(d))
>                         return d;

I get two warnings when compiling your patch with this correction on to=
p:
drivers/firmware/dmi_scan.c: In function =E2=80=98dmi_first_match=E2=80=
=99:
drivers/firmware/dmi_scan.c:488: warning: return discards qualifiers fr=
om pointer target type
drivers/firmware/dmi_scan.c:483: warning: unused variable =E2=80=98i=E2=
=80=99

The second is trivial, but the first is beyond me :-/

Cheers,
=46JP
