From: Rafael =?iso-8859-2?q?=C1vila_de_Esp=EDndola?=
	<rafael.espindola@gmail.com>
Subject: Re: unable to set udma >= 3 on ich5 on 2.6.11
Date: Tue, 21 Jun 2005 22:50:52 -0300
Message-ID: <200506212251.27168.rafael.espindola@gmail.com>
References: <564d96fb05062005064283caaf@mail.gmail.com> <pan.2005.06.21.17.50.40.495619@ree.hu>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1675351.WnOWAeMnIJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:61763 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262507AbVFVBvr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jun 2005 21:51:47 -0400
Received: by wproxy.gmail.com with SMTP id 68so46948wri
        for <linux-ide@vger.kernel.org>; Tue, 21 Jun 2005 18:51:47 -0700 (PDT)
In-Reply-To: <pan.2005.06.21.17.50.40.495619@ree.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Balazs Ree <ree@ree.hu>
Cc: linux-ide@vger.kernel.org

--nextPart1675351.WnOWAeMnIJ
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Em Tue 21 Jun 2005 14:50, Balazs Ree escreveu:
> Just a blind guess... you might
> want to try to set the kernel parameter CONFIG_IDEDMA_IVB (IGNORE
> word93 Validation BITS). I had this problem recently and this was
> the one that solved it. But I am not an expert so pardon me if I said
> something stupid.
It worked!
Thanks.

What is to blame? ICH5? If so, Is there a  black list were I could add it?

Rafael

--nextPart1675351.WnOWAeMnIJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCuMQfLlrfGJ8JUHwRAhMJAJ9n38YyHbwZmN078+3ZDDsJivJSMQCeL+OP
G3HwSNmVROmmgpTVR24Fpss=
=S/1g
-----END PGP SIGNATURE-----

--nextPart1675351.WnOWAeMnIJ--
