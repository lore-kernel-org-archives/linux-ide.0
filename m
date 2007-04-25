From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 0/3] hotplug polling, respin
Date: Wed, 25 Apr 2007 00:30:37 -0700
Message-ID: <20070425073037.GF7846@curie-int.orbis-terrarum.net>
References: <20070425062538.GU7810@curie-int.orbis-terrarum.net> <462EFE59.2090501@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:41816 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423266AbXDYHaZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 03:30:25 -0400
Content-Disposition: inline
In-Reply-To: <462EFE59.2090501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2007 at 04:08:09PM +0900, Tejun Heo wrote:
> > The last submission of this
> > (http://thread.gmane.org/gmane.linux.ide/13467) already had a tentative
> > ACK, pending a link power-saving patchset, that I can't find more
> > details on.
> Yeap, the implementation is ACKed but interface to userland is NACKed.
> We need sysfs nodes for ATA devices to do userland interface properly.
> I'm working hard to get there.
I'm not sure I follow you here. The only bit of 'userspace' interface I
see in this series is hotplug_polling_interval. What other userspace
bits are in question?

> Thanks a lot for taking care of these patches.  A lot of people have
> been asking for patches for newer kernels and I couldn't find time to
> update them.
As always, it starts with scratching your own itch. My Fusion 500P works
like a charm with the SIL 3132 that I have - the previous scanning issue
where it took forever doing 15 scans (1;1,2;1,2,3;1,2,3,4;1,2,3,4,5)
instead of just 5 seems to have gone away, but the sluggish performance
remains (the sil24 seeming to not do SATA2 speed stuff, did you hear
back from SIL?).

As a gauge of interest in the PMP stuff, I'm presently getting about 3
emails a week asking for work on it.

> Jeff, can we make a page for PMP patches in linux-ata.org?  It would be
> a much better place to direct people to.
I'd host a git tree, but I don't have sufficient stable bandwidth.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGLwOdPpIsIjIzwiwRAmHpAJ9rJeFyK3dHUq1c/rO4bYzHAD7LmgCg00fc
wRphxX9rk94cj34Wo11Za4c=
=6W23
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
