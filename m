From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ide: Fix ata_id_has_dword_io to return DWORD I/O support
 properly
Date: Thu, 18 Dec 2008 12:08:10 -0500
Message-ID: <494A837A.50801@garzik.org>
References: <494A5BBF.8000807@inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58176 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666AbYLRRIQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Dec 2008 12:08:16 -0500
In-Reply-To: <494A5BBF.8000807@inf.tu-dresden.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mario Schwalbe <schwalbe@inf.tu-dresden.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Mario Schwalbe wrote:
> This patch fixes ata_id_has_dword_io to return 1 (supported) if
> the drive is compliant to ATA2 or newer and evaluates the config
> word for older drives.
> 
> Signed-off-by: Mario Schwalbe <schwalbe@inf.tu-dresden.de>
> ---
>  include/linux/ata.h |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index a53318b..d0d6a9c 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -700,12 +700,12 @@ static inline int ata_id_has_tpm(const u16 *id)
> 
>  static inline int ata_id_has_dword_io(const u16 *id)
>  {
> -	/* ATA 8 reuses this flag for "trusted" computing */
> -	if (ata_id_major_version(id) > 7)
> -		return 0;
> -	if (id[ATA_ID_DWORD_IO] & (1 << 0))
> -		return 1;
> -	return 0;
> +	/* This flag is defined up to ATA1 and deprecated since then
> +	   (ATA 8 reuses this flag for "trusted" computing). */
> +	if (ata_id_major_version(id) <= 1)
> +		return (id[ATA_ID_DWORD_IO] & (1 << 0)) != 0;
> +	/* later revision drives support DWORD I/O just fine */
> +	return 1;


This seems like a risky assumption...

	Jeff


