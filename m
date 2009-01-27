From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Tue, 27 Jan 2009 14:29:51 +0300
Message-ID: <497EF02F.4060109@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com> <20090126190801.7d198246@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:27610 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752462AbZA0L35 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 06:29:57 -0500
In-Reply-To: <20090126190801.7d198246@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Hello.

Alan Cox wrote:

> This patch keeps the version checks but incorporates the other suggestions
> Sergei made including a better ata version check for the usual case where
> we want to know "is version >= x" rather than "what version do you
> support".
>
> Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
>   
[...]
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 88c2428..c17b62a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2212,7 +2212,7 @@ retry:
>  		 * Note that ATA4 says lba is mandatory so the second check
>  		 * shoud never trigger.
>  		 */
> -		if (ata_id_major_version(id) < 4 || !ata_id_has_lba(id)) {
> +		if (!ata_id_has_version(id, 4) || !ata_id_has_lba(id)) {
>  			err_mask = ata_dev_init_params(dev, id[3], id[6]);
>  			if (err_mask) {
>  				rc = -EIO;
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index a53318b..e35d8de 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -675,6 +675,13 @@ static inline unsigned int ata_id_major_version(const u16 *id)
>  	return mver;
>  }
>  
> +static inline int ata_id_has_version(const u16 *id, int v)
> +{
> +	if (id[ATA_ID_MAJOR_VER] == 0xFFFF)
> +		return 0;
> +	return (id[ATA_ID_MAJOR_VER] & (1 << v)) ? 1 : 0;
> +}
> + 
>   
> @@ -691,7 +698,7 @@ static inline int ata_id_is_sata(const u16 *id)
>  static inline int ata_id_has_tpm(const u16 *id)
>  {
>  	/* The TPM bits are only valid on ATA8 */
> -	if (ata_id_major_version(id) < 8)
> +	if (!ata_id_has_version(id, 8))
>  		return 0;

   Note that this is not equivalent to the old code which didn't require 
the bit v to be set, just some bits above it.

MBR, Sergei


