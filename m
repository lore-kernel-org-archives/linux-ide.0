From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/4] libata: Expose TRIM capability in sysfs
Date: Tue, 05 May 2015 07:54:03 +0200
Message-ID: <55485AFB.6050302@suse.de>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com> <1430790861-30066-2-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38791 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256AbbEEFyF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 May 2015 01:54:05 -0400
In-Reply-To: <1430790861-30066-2-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org

On 05/05/2015 03:54 AM, Martin K. Petersen wrote:
> Create a sysfs "trim" attribute for each ata_device that displays
> whether DSM TRIM is "unsupported", "unqueued", "forced_unqueued"
> (blacklisted) or "queued".
>=20
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  Documentation/ABI/testing/sysfs-ata | 11 +++++++++++
>  drivers/ata/libata-transport.c      | 22 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-ata b/Documentation/ABI/=
testing/sysfs-ata
> index 0a932155cbba..9231daef3813 100644
> --- a/Documentation/ABI/testing/sysfs-ata
> +++ b/Documentation/ABI/testing/sysfs-ata
> @@ -90,6 +90,17 @@ gscr
>  	130:	SATA_PMP_GSCR_SII_GPIO
>  	Only valid if the device is a PM.
> =20
> +trim
> +
> +	Shows the DSM TRIM mode currently used by the device. Valid
> +	values are:
> +	unsupported:		Drive does not support DSM TRIM
> +	unqueued:		Drive supports unqueued DSM TRIM only
> +	queued:			Drive supports queued DSM TRIM
> +	forced_unqueued:	Drive's unqueued DSM support is known to be
> +				buggy and only unqueued TRIM commands
> +				are sent
> +
>  spdn_cnt
> =20
>  	Number of time libata decided to lower the speed of link due to err=
ors.
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-tran=
sport.c
> index 3227b7c8a05f..d6c37bcd416d 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -560,6 +560,27 @@ show_ata_dev_gscr(struct device *dev,
> =20
>  static DEVICE_ATTR(gscr, S_IRUGO, show_ata_dev_gscr, NULL);
> =20
> +static ssize_t
> +show_ata_dev_trim(struct device *dev,
> +		  struct device_attribute *attr, char *buf)
> +{
> +	struct ata_device *ata_dev =3D transport_class_to_dev(dev);
> +	unsigned char *mode;
> +
> +	if (!ata_id_has_trim(ata_dev->id))
> +		mode =3D "unsupported";
> +	else if (ata_dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
> +			mode =3D "forced_unqueued";
> +	else if (ata_fpdma_dsm_supported(ata_dev))
> +		mode =3D "queued";
> +	else
> +		mode =3D "unqueued";
> +
> +	return snprintf(buf, 20, "%s\n", mode);
> +}
> +
> +static DEVICE_ATTR(trim, S_IRUGO, show_ata_dev_trim, NULL);
> +
>  static DECLARE_TRANSPORT_CLASS(ata_dev_class,
>  			       "ata_device", NULL, NULL, NULL);
> =20
> @@ -733,6 +754,7 @@ struct scsi_transport_template *ata_attach_transp=
ort(void)
>  	SETUP_DEV_ATTRIBUTE(ering);
>  	SETUP_DEV_ATTRIBUTE(id);
>  	SETUP_DEV_ATTRIBUTE(gscr);
> +	SETUP_DEV_ATTRIBUTE(trim);
>  	BUG_ON(count > ATA_DEV_ATTRS);
>  	i->dev_attrs[count] =3D NULL;
> =20
>=20
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
