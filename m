From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/4] libata: READ LOG DMA EXT support can be in either
 page 119 or 120
Date: Tue, 05 May 2015 08:00:03 +0200
Message-ID: <55485C63.6010807@suse.de>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com> <1430790861-30066-3-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39670 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbbEEGAE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 May 2015 02:00:04 -0400
In-Reply-To: <1430790861-30066-3-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org

On 05/05/2015 03:54 AM, Martin K. Petersen wrote:
> Support for the READ/WRITE LOG DMA EXT commands can be signaled eithe=
r
> in page 119 or page 120. We should check both pages.
>=20
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  include/linux/ata.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index b666b773e111..fed36418dd1c 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -704,9 +704,19 @@ static inline bool ata_id_wcache_enabled(const u=
16 *id)
> =20
>  static inline bool ata_id_has_read_log_dma_ext(const u16 *id)
>  {
> +	/* Word 86 must have bit 15 set */
>  	if (!(id[ATA_ID_CFS_ENABLE_2] & (1 << 15)))
>  		return false;
> -	return id[ATA_ID_COMMAND_SET_3] & (1 << 3);
> +
> +	/* READ LOG DMA EXT support can be signaled either from word 119
> +	 * or from word 120. The format is the same for both words: Bit
> +	 * 15 must be cleared, bit 14 set and bit 3 set.
> +	 */
> +	if ((id[ATA_ID_COMMAND_SET_3] & 0xC008) =3D=3D 0x4008 ||
> +	    (id[ATA_ID_COMMAND_SET_4] & 0xC008) =3D=3D 0x4008)
> +		return true;
> +
> +	return false;
>  }
> =20
>  static inline bool ata_id_has_sense_reporting(const u16 *id)
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
