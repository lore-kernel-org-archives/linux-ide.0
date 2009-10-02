From: Tim Blechmann <tim@klingt.org>
Subject: Re: 2.6.31-rc5 regression: hd don't show up
Date: Fri, 02 Oct 2009 09:30:21 +0200
Message-ID: <4AC5AC0D.9020901@klingt.org>
References: <h63737$b2a$1@ger.gmane.org> <4A852BC0.1090404@kernel.org> <4A8559D7.6090405@klingt.org> <4A8774E5.4070609@kernel.org> <4A87D9FC.9070408@klingt.org> <4A96460F.3020600@kernel.org> <4A965E3B.3000808@klingt.org> <4A966F7D.60707@kernel.org> <4A97B9C0.9090003@klingt.org> <4A9B7E1E.8060909@kernel.org> <4A9DAF78.4070703@klingt.org> <4A9DD6D9.50407@kernel.org> <4A9E371A.5040208@klingt.org> <4A9FCD8C.6010107@kernel.org> <4AA18F57.8030107@klingt.org> <4AA1ACF8.7030101@kernel.org> <4AA6C569.9090901@klingt.org> <4AB04B39.7030907@kernel.org> <4AB079FC.6000906@kernel.org> <4AB09562.3010501@klingt.org> <4AB0D34A.2010502@kernel.org> <4ABC44FE.5050904@kernel.org> <4ABC7543.90407@klingt.org> <4ABC7714.2030709@kernel.org> <4ABCADE2.1020300@klingt.org> <4ABCC3DB.1000202@kernel.org> <4AC58D9C.60103
 06@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0EEBA1ED7AD80A082CB339A9"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.klingt.org ([86.59.21.178]:60121 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbZJBHbV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Oct 2009 03:31:21 -0400
In-Reply-To: <4AC58D9C.6010306@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0EEBA1ED7AD80A082CB339A9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2009 07:20 AM, Tejun Heo wrote:
> Tejun Heo wrote:
>> Tim Blechmann wrote:
>>>>>>>>> Can you please try the attached patch and report the result?  T=
he bug
>>>>>>>>> shouldn't happen now and for cases where it would have happened=
,
>>>>>>>>> libata will report "link online but device misclassified" and r=
etry.
>>>>>>>> this patch cannot be applied onto stable-2.6.31/master ... e.g. =
the
>>>>>>>> first chunk is already in there ....
>>>>>>> Eh... the first chunk was for the current devel branch.  Here's a=

>>>>>>> version without that one.
>>>>>> Ping.
>>>>> i haven't run into any further issues with this patch ... so i some=
how
>>>>> guess, it solved the problem ...
>>>> In your boot logs, do you ever see messages like "link online but
>>>> device misclassified, retrying"?
>>> i didn't really pay attention to it ... at my currently running syste=
m,
>>> it doesn't show up ... but i will keep my eyes open ...
>>
>> Can you please reboot several times and see whether that happens?  The=

>> bug is quite obscure and I wanna be sure before pushing it upstream.
>=20
> Ping?

since i have this kernel running, i didn't see any of these messages,
still, my hds always showed up ...
not sure, if this is related to your patch or if the buggy behavior,
just didn't occur ...

tim

--=20
tim@klingt.org
http://tim.klingt.org

Every word is like an unnecessary stain on silence and nothingness
  Samuel Beckett


--------------enig0EEBA1ED7AD80A082CB339A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrFrBAACgkQdL+4qsZfVssgMQCgiQSGkksKNdB/TeA2ZbF2iher
p98AnAyyARcuIUZgmcfDplIKrnL5N0qz
=PLTY
-----END PGP SIGNATURE-----

--------------enig0EEBA1ED7AD80A082CB339A9--
