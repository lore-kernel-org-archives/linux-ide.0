From: Stefan Lippers-Hollmann <s.L-H@gmx.de>
Subject: Re: [PATCH #upstream-fixes,-stable] libata: make sure port is thawed when skipping resets
Date: Wed, 4 Mar 2009 21:24:33 +0100
Message-ID: <200903042124.35498.s.L-H@gmx.de>
References: <49AE26D2.7020102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:53258 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753023AbZCDUYk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Mar 2009 15:24:40 -0500
In-Reply-To: <49AE26D2.7020102@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hi

On Mittwoch, 4. M=C3=A4rz 2009, Tejun Heo wrote:
> When SCR access is available and the link is offline, softreset is
> skipped as it only wastes time and some controllers don't respond ver=
y
> well.  However, the skip path forgot to thaw the port, which not only
> blocks further event notification from the port but also causes
> repeated EH invocations on the same event on drivers which rely on
> ->thaw() to clear events if the IRQ is shared with another device or
> port.
>=20
> This problem has always been there but is uncovered by recent sata_nv
> nf2/3 change which dropped hardreset support while maintaining SCR
> access.  nf2/3 doesn't clear hotplug event mask from the interrupt
> handler but relies on ->thaw() to clear them.  When the hardreset was
> there, the reset action was never skipped and the port was always
> thawed but, with the hardreset gone, ->prereset() determines that
> there's no need for softreset and both ->softreset() and ->thaw() are
> skipped.  This leads to stuck hotplug event in the IRQ status registe=
r
> triggering hotplug event whenever IRQ is delieverd on the same IRQ.
> As the controller shares the same IRQ for both ports, this happens on
> every IO if one port is occpupied and the other isn't.
>=20
> This patch fixes the problem by making sure that the port is thawed o=
n
> reset-skip path.
>=20
> bko#11615 reports this problem.

Sorry that I didn't notice the bugzilla entry earlier, this patch indee=
d=20
fixes the problem for me (tested on top of 2.6.29-rc7 and 2.6.28.7).

Thank you a lot
	Stefan Lippers-Hollmann
--=20

> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Robert Hancock <hancockrwd@gmail.com>
> Reported-by: Dan Andresan <danyer@gmail.com>
> Reported-by: Arne Woerner <arne_woerner@yahoo.com>
> Reported-by: Stefan Lippers-Hollmann <s.L-H@gmx.de>
> ---
> Heh.... this is one convoluted failure case.  The only two drivers
> which have SCR access but doesn't use hardrest are sata_uli and
> sata_nv at this point.  sata_uli doesn't have PHY event or any other
> sticky events, so sata_nv became the one to get hit by this.
> Hopefully, this will put an end to sata_nv reset fiasco.
>=20
> Thanks.
>=20
>  drivers/ata/libata-eh.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index ce2ef04..02d47b2 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2423,11 +2423,14 @@ int ata_eh_reset(struct ata_link *link, int c=
lassify,
>  		}
> =20
>  		/* prereset() might have cleared ATA_EH_RESET.  If so,
> -		 * bang classes and return.
> +		 * bang classes, thaw and return.
>  		 */
>  		if (reset && !(ehc->i.action & ATA_EH_RESET)) {
>  			ata_for_each_dev(dev, link, ALL)
>  				classes[dev->devno] =3D ATA_DEV_NONE;
> +			if ((ap->pflags & ATA_PFLAG_FROZEN) &&
> +			    ata_is_host_link(link))
> +				ata_eh_thaw_port(ap);
>  			rc =3D 0;
>  			goto out;
>  		}
>=20


