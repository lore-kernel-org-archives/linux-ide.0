From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/4] libata: Fall back to unqueued READ LOG EXT if the
 DMA variant fails
Date: Tue, 05 May 2015 08:00:53 +0200
Message-ID: <55485C95.1010608@suse.de>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com> <1430790861-30066-4-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39787 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbbEEGAy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 May 2015 02:00:54 -0400
In-Reply-To: <1430790861-30066-4-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org

On 05/05/2015 03:54 AM, Martin K. Petersen wrote:
> Some devices advertise support for the READ/WRITE LOG DMA EXT command=
s
> but fail when we try to issue them. This can lead to queued TRIM bein=
g
> unintentionally disabled since the relevant feature flag is located i=
n a
> general purpose log page.
>=20
> Fall back to unqueued READ LOG EXT if the DMA variant fails while
> reading a log page.
>=20
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  drivers/ata/libata-eh.c | 12 +++++++++++-
>  include/linux/libata.h  |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 07f41be38fbe..2893563d0537 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1507,13 +1507,17 @@ unsigned int ata_read_log_page(struct ata_dev=
ice *dev, u8 log,
>  {
>  	struct ata_taskfile tf;
>  	unsigned int err_mask;
> +	bool dma =3D false;
> =20
>  	DPRINTK("read log page - log 0x%x, page 0x%x\n", log, page);
> =20
> +retry:
>  	ata_tf_init(dev, &tf);
> -	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id)) {
> +	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&
> +	    !(dev->horkage & ATA_HORKAGE_NO_NCQ_LOG)) {
>  		tf.command =3D ATA_CMD_READ_LOG_DMA_EXT;
>  		tf.protocol =3D ATA_PROT_DMA;
> +		dma =3D true;
>  	} else {
>  		tf.command =3D ATA_CMD_READ_LOG_EXT;
>  		tf.protocol =3D ATA_PROT_PIO;
> @@ -1527,6 +1531,12 @@ unsigned int ata_read_log_page(struct ata_devi=
ce *dev, u8 log,
>  	err_mask =3D ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
>  				     buf, sectors * ATA_SECT_SIZE, 0);
> =20
> +	if (err_mask && dma) {
> +		dev->horkage |=3D ATA_HORKAGE_NO_NCQ_LOG;
> +		ata_dev_warn(dev, "READ LOG DMA EXT failed, trying unqueued\n");
> +		goto retry;
> +	}
> +
>  	DPRINTK("EXIT, err_mask=3D%x\n", err_mask);
>  	return err_mask;
>  }
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 8dad4a307bb8..c3ef58014b33 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -424,6 +424,7 @@ enum {
>  	ATA_HORKAGE_NOLPM	=3D (1 << 20),	/* don't use LPM */
>  	ATA_HORKAGE_WD_BROKEN_LPM =3D (1 << 21),	/* some WDs have broken LP=
M */
>  	ATA_HORKAGE_ZERO_AFTER_TRIM =3D (1 << 22),/* guarantees zero after =
trim */
> +	ATA_HORKAGE_NO_NCQ_LOG	=3D (1 << 23),	/* don't use NCQ for log read=
 */
> =20
>  	 /* DMA mask for user DMA control: User visible values; DO NOT
>  	    renumber */
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
