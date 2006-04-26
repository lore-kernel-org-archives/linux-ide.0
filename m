From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Subject: RE: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
Date: Wed, 26 Apr 2006 10:46:53 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7011B260D@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:2261 "EHLO
	ecstlaurent8.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S932459AbWDZOr2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Apr 2006 10:47:28 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Heflin <rheflin@atipa.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Is your OS installed either sda or sdb?

Because I get this type of message using a single disk... On which my F=
C5 stands...

I'll give it a try tonight and see if I can cause the problem manually =
but I doubt I'll be able to stop the system from hanging...  Unless my =
bug is not related.

- vin

-----Message d'origine-----
De : Roger Heflin [mailto:rheflin@atipa.com]=20
Envoy=E9 : 26 avril 2006 10:42
=C0 : Fortier,Vincent [Montreal]
Cc : Linux-Kernel; linux-ide@vger.kernel.org
Objet : Re: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2

=46ortier,Vincent [Montreal] wrote:
> I think I might be having the "same type of bug" or something related=
 using sata_via?
> Bug opened at bugzilla:=20
> http://bugzilla.kernel.org/show_bug.cgi?id=3D6317
>=20
> This started appearing with 2.6.16.  It often does it using only one =
SATA HD.  It does not do it at every boot but often starts doing it aft=
er a little while (a few hours...) and finally hanging my PC.
>=20
> - vin
>=20
>

I can duplicate my problem everything, and I can make it stop a will.

doing "dd if=3D/dev/sda of=3D/dev/null bs=3D64k &"

and then

        "dd if=3D/dev/sdb of=3D/dev/null bs=3D64k &"

will cause the problem within a couple of seconds.

Doing "kill %1 %2" (assuming the dd's are %1 and %2) will stop the mach=
ine from hanging on disk io within 30-60 seconds.

Once it hangs it does not appear to do any disk io until the offending =
processes are killed.

                               Roger

