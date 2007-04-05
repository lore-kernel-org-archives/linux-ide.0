From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] add correct interrupt property for pegasos ide
Date: Thu, 5 Apr 2007 10:55:10 +1000
Message-ID: <20070405105510.4376e9ec.sfr@canb.auug.org.au>
References: <20070404111635.GA1855@aepfle.de> <20070404162004.GA3016@aepfle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1169074098=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20070404162004.GA3016@aepfle.de>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Paul Mackeras <paulus@samba.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

--===============1169074098==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__5_Apr_2007_10_55_10_+1000_.M2Aw/SCkC0kq=gy"

--Signature=_Thu__5_Apr_2007_10_55_10_+1000_.M2Aw/SCkC0kq=gy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Olaf,

On Wed, 4 Apr 2007 18:20:04 +0200 Olaf Hering <olaf@aepfle.de> wrote:
>
> -	phandle isa;
> -	u32 isa_ranges[6];
> +	phandle ph;
> +	u32 prop[6];

Juat a small nit:  If you want to rename vairables, please do it in a
separate patch - doing it here just clutters the patch and makes it
harder to see what the real purpose is.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__5_Apr_2007_10_55_10_+1000_.M2Aw/SCkC0kq=gy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGFEjzFdBgD/zoJvwRApDtAJ4+ROT0mxIRGESJARFASESBf2Z48gCePjiV
IedvtAx+hRfI6ovqT1tJvcQ=
=sGbL
-----END PGP SIGNATURE-----

--Signature=_Thu__5_Apr_2007_10_55_10_+1000_.M2Aw/SCkC0kq=gy--

--===============1169074098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============1169074098==--
