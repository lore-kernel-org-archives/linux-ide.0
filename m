From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: SATA PMP for 2.6.20
Date: Mon, 5 Feb 2007 10:42:51 -0800
Message-ID: <20070205184251.GT23455@curie-int.orbis-terrarum.net>
References: <e532144c0702050923p3f699325k7fd805550508ba06@mail.gmail.com> <45C76B00.4070806@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UsbkURXZxe2ekgES"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:32781 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933329AbXBEStT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 13:49:19 -0500
Content-Disposition: inline
In-Reply-To: <45C76B00.4070806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: John Eckhart <jweckhart@gmail.com>, linux-ide@vger.kernel.org


--UsbkURXZxe2ekgES
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2007 at 02:36:00AM +0900, Tejun Heo wrote:
> John Eckhart wrote:
> > Tejun,
> >    Is there any update to the PMP support you have posted on your site
> > for 2.6.19 or 2.6.20 kernels? I have an SI controller and PMP card and
> > would like to try them out using the latest kernels. I was also
> > considering forward porting your patches if necessary, but don't want to
> > duplicate any work if you or someone else has already completed this.
> No not yet from me.  Forward-porting will be a lot of work.  I think
> somebody did it already, searching...  eeek, can't find it at the
> moment.  ISTR the message was posted to linux-ide, you'll have to search
> yourself.  :-P
I did it for 2.6.20-rc2:
http://dev.gentoo.org/~robbat2/libata-development/

The original message id with instructions is:
<20061228113446.GI28939@curie-int.orbis-terrarum.net>

There are 5 sets of patches in total of Tejun's work, named the same as
Tejun's branches:
hp_poll
vt8261_ahci
link
pmp_prep
pmp

I do have it in my git tree, so I should be able to rebase against
2.6.20 and export again.

Is there an actual merge plan for this stuff, esp. the hp_poll and
ata_link stuff?

--=20
Robin Hugh Johnson
Gentoo Linux Developer
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--UsbkURXZxe2ekgES
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFFx3qrPpIsIjIzwiwRAi0LAJ9WwXyys/T4w0z5Rl0fldBnoRBaSgCdGhaL
UTijfogzNrPJuHYkuATYmvM=
=mRVg
-----END PGP SIGNATURE-----

--UsbkURXZxe2ekgES--
