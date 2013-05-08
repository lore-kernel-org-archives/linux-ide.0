From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linx-next: inclusion request for libata for-next branch
Date: Wed, 8 May 2013 10:13:17 +1000
Message-ID: <20130508101317.f90ccd595f2092b52c2e09ec@canb.auug.org.au>
References: <20130507172501.GC5531@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__8_May_2013_10_13_17_+1000_VBrUufoptShg84sP"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20130507172501.GC5531@mtj.dyndns.org>
Sender: linux-next-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-next@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

--Signature=_Wed__8_May_2013_10_13_17_+1000_VBrUufoptShg84sP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Tue, 7 May 2013 10:25:01 -0700 Tejun Heo <tj@kernel.org> wrote:
>
> I'm undertaking the maintenance of libata now and just set up a new
> libata tree.  Can you please include following git branch into
> linux-next?
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-next

I have replaced Jeff's tree with yours.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Wed__8_May_2013_10_13_17_+1000_VBrUufoptShg84sP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRiZidAAoJEECxmPOUX5FErUAP/11Ubn+nsQiRALTdrUqBzscU
F4c4JcjP8khTFJBKkhu9TLDl0I1omN/jgNeaTCXrlEovO2fjzoizq83uINZySheq
/574EDqHgtnl5UFNQqUYf78GiaJ8pTAutrCfNTnGihIZH7mo5Ya2PfSp5V+772xn
r4Y8eQt57ro2c56E8OSXvIPMPwilE6CfUpu6g33OwTl21GCnnYlJ1gW52jIcpfjQ
fJSHAuNbNvaknHsu3NjJbxvDRAytXsqu4qiJdWIxL2/OkpX94dUfWf27g7+wCPvu
+J17c8+tPAjDGPSIxu/+ROOfZiUxt3v2ilSBu1rEO4o/Ar6AUinFNjPVAOmMwTiO
wZC+dAIpuPBcrfJOTIfX1+VdHnEo+MI3hkfwnlZJRRGsMXXCD4d7bts910Km51le
ldEMilli3OYZYpz4xMdVAD7dGialweHgeGuq9MtZ1wku7iVoC9arR7OP2GARF85s
KBhTG1J4Hyo/+I7ftnEdt79c8sc+7f5shmkii8UvfTwZKCoQS70/kc0wJrQZ3bn4
4EhQc+pn30hz1TzxryCRmGm3HS49ALhVZdBFm+U7rVmqQU4nPivw/liwmWK8Gqpz
Tj+SelKDVY1sM359hInrsmF2rAnigQIE7UxNOCwZ187xfMF1nM2c52QUZU0p1FF+
X88VFUavaepXPPgQzNNs
=f+g9
-----END PGP SIGNATURE-----

--Signature=_Wed__8_May_2013_10_13_17_+1000_VBrUufoptShg84sP--
