From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 4/5] libata: support the ata host which implements a
 queue depth less than 32
Date: Fri, 4 Jul 2014 14:46:46 +0800
Message-ID: <20140704064646.GA15828@pek-khao-d1.corp.ad.wrs.com>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
 <1404389382-27298-5-git-send-email-haokexin@gmail.com>
 <20140703134717.GA16191@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:47980 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbaGDGq4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jul 2014 02:46:56 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so1512637pac.11
        for <linux-ide@vger.kernel.org>; Thu, 03 Jul 2014 23:46:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140703134717.GA16191@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 09:47:17AM -0400, Tejun Heo wrote:
> On Thu, Jul 03, 2014 at 08:09:41PM +0800, Kevin Hao wrote:
> > The sata on fsl mpc8315e is broken after the commit 8a4aeec8d2d6
> > ("libata/ahci: accommodate tag ordered controllers"). The reason is
> > that the ata controller on this SoC only implement a queue depth of
> > 16. When issuing the commands in tag order, all the commands in tag
> > 16 ~ 17 are mapped to tag 0 unconditionally and then causes the sata
> > malfunction. It makes no senses to use a 32 queue in software while
> > the hardware has less queue depth. This patch provides the function
> > for libata to adjust the queue depth for a host controller.
>=20
> ATA_TAG_INTERNAL is an internal way of marking an EH command and
> doesn't actually get used as a command tag.  After all, EH doesn't
> issue any tagged command.  We can use tag 32 for it but have been
> using 31 for it for historical reasons, so the only necessary part is
> updating the tag allocator to wrap according to the max number of tags
> supported by the controller.=20

Sorry I didn't quite follow. In some cases, we still need to iterate all
the commands in the queue (including the internal command). For example,
in drivers/ata/sata_fsl.c:
    static void sata_fsl_host_intr(struct ata_port *ap)
        	/* Workaround for data length mismatch errata */
        	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
        		for (tag =3D 0; tag < ATA_MAX_QUEUE; tag++) {

Since the fsl sata only support a 16 command queue, if we put the internal
command to ata_port->qcmd[16 - 1], we can easily change the above code to:
    static void sata_fsl_host_intr(struct ata_port *ap)
        	/* Workaround for data length mismatch errata */
        	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
        		for (tag =3D 0; tag < 16; tag++) {

But if we still put the internal command to ata_port->qcmd[31], it will
make it more complicated to iterate all the commands.

There are also several iterations of the command queue just like the above
codes in drivers/ata/libata-eh.c. They should suffer the same issue.
Did I miss something?

Thanks,
Kevin

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJTtk3WAAoJEJNY7TDerrFxYcgH+QEr0gTDwARpx0r3mbNS5O4W
zWXDbaWX1FELe4Z6QJVeL33MCvxa/CeOB73CWeSpnKOMMUZn/6nLWShgBNR2KT83
Pg+RsTXFZ66Elr92mbZbwHygUEp4E0jAyphRcV4QRQEnbwZY5BcZAxjP0PnWtnp+
ewczTbH8HXt7+rA+z5ZZMdHDqtXzPZmDWSTScw3XkeCfPVqtszVJWVvnYwcyooD7
NTOhdF26sZ22poEE0u5tsgX6sOF4mbOia1uqTqA0aDM1rN/e6DmBsS9FDzcNlGUP
YqishuGNwUW/6aeLHHYEQ9e2Uz2D+2M7RI/hqS5m22qH/chNJQt0pbl73yqRBTw=
=hh3j
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
