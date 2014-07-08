From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH v2 1/2] libata: introduce ata_host_set_queue_depth()
Date: Tue, 8 Jul 2014 10:41:02 +0800
Message-ID: <20140708024102.GA29746@pek-khao-d1.corp.ad.wrs.com>
References: <1404628121-8158-1-git-send-email-haokexin@gmail.com>
 <1404628121-8158-2-git-send-email-haokexin@gmail.com>
 <CAPcyv4gLb6i5PSi9_uxHv-UQA8-w=a55eOP1GtkXmvTzY5P+7A@mail.gmail.com>
 <20140707200610.GA1283@mtj.dyndns.org>
 <CAPcyv4jNXtjn4p0MKa0fFkuGGLNs4iyFNaaufGKJWFHa65jBZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:41117 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbaGHClJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2014 22:41:09 -0400
Received: by mail-pd0-f171.google.com with SMTP id fp1so6349633pdb.2
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2014 19:41:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPcyv4jNXtjn4p0MKa0fFkuGGLNs4iyFNaaufGKJWFHa65jBZA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2014 at 01:56:59PM -0700, Dan Williams wrote:
> On Mon, Jul 7, 2014 at 1:06 PM, Tejun Heo <tj@kernel.org> wrote:
> > On Mon, Jul 07, 2014 at 11:19:25AM -0700, Dan Williams wrote:
> > Given how inefficient the test_and_set bit is, I don't think a single
> > moduls matters.  Plus, we don't even need modulus there.  We can
> > simply use >=3D max_depth.
>=20
> True, sounds good.

OK, will change.

Thanks,
Kevin

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJTu1o+AAoJEJNY7TDerrFxXpoH/1CGyy+e6BHIQcZSU492YnEl
xJl91dcqEhQXrhrZzMHjM7QTFotC+1W/cwwvTPNU+1yx4tC+wUkodxU6yZTo+FHa
lnxMVf+QwUJ5d1rFe6YIkCZZK8GnJYb/Kn+KcUtw9Ot57ulkgeh7SoRY356kaHrv
YhD67FFSAQh3CLAzYLbVanoAP1wc6LalsLUz69v8IvhXzaaO6+UzAINyNv7hIJOw
Ib8AhDgjGskEmp47tBvPMyW5j/xb2iPoCMLyCdLtWS8LI9B8G18Or5eKHyIS2H2U
MJBFErj/GqnQg3N4KFHAnSB1+1SAh77j9QrAuuByQ7l+OkdhQImf8F7pxx9F6PI=
=SWoA
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
