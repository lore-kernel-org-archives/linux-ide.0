Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713412F0C73;
	Wed, 13 Aug 2025 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126680; cv=none; b=jro1OdRSI/LBVfH1OjG1AdtDYoqmDvLVn63gkM92kvhTEodV/acBjOBlZTsnc7jGazuK0lIz67aQFbPQIMCOxqq1oIlNDw7AzF4ct8i7hAnLBsHcAhJKym01Akc1kVtgfMqJQL3uwqLdrYWOwndWSprEqL9OEmRfTFwcL2T7WA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126680; c=relaxed/simple;
	bh=fhWSqsUD+JLrZzRCCQ6qojOKpaAlQUZp/KhpHgxbrA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmRYElZHK5q/wGQzlV3a/+On6GCCpSv6leywF0lh7HehXkZh2uNw4FqC8BJ2jGct28x46goCMcoCJWRn9SnN8wbd9LfwTl0sj/BSzCKB3Ntgjc5x3WsW8aVWU0g8Mjy9J/KHhi6dLQk6ludiIKwKF7xr3xfdndCQHUQ3arqF++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGyxdG3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGyxdG3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C04EC4CEEB;
	Wed, 13 Aug 2025 23:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755126680;
	bh=fhWSqsUD+JLrZzRCCQ6qojOKpaAlQUZp/KhpHgxbrA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oGyxdG3yG0UZJZywEx6I+R9WUZL9yYoTABpPK33iSHBo21fNhuWwTD4dpvnfzlt42
	 722zJO1LPgsbnjR33usSiVHPY2luAHm2wQnXY7nlMoYmfcIiLtYi8XkuYypVcWOpCP
	 zUL51VCiOwfXwt2/p3Z5lF4faxS8y6KdbYd59E3Y5gdeeTKCg6HRIRbpsRwn5qUj3a
	 RzbS9y8yPXtF8vKLiuWJjIfx5pBfMLxcK00SXf4Hw7UPAighjlomqUcuzCIawNsESP
	 WWAjV2r5W6TyBLr0muQGXlLNuHq/Eb/X95sU9nUaJBqRxnT6RkQTqTDyXbmPt4TEM6
	 MUmBwvKeRNVOw==
Message-ID: <9dde49e5-4368-402f-8cc2-797ac08c0e8a@kernel.org>
Date: Thu, 14 Aug 2025 08:08:37 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "ata: libata-scsi: Improve CDL control"
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813204648.1285197-1-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250813204648.1285197-1-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 5:46 AM, Igor Pylypiv wrote:
> This reverts commit 17e897a456752ec9c2d7afb3d9baf268b442451b.

A full revert is not nice. See below.

Also please change the patch title to:

ata: libata-scsi: Fix CDL control

Or similar.

And do not send the patch to stable@vger.kernel.org. It will be picked up if
you add the Fixes tag (see below).

> 
> The extra checks for the ATA_DFLAG_CDL_ENABLED flag prevent SET FEATURES
> command from being issued to a drive when NCQ commands are active.
> 
> ata_mselect_control_ata_feature() sets / clears the ATA_DFLAG_CDL_ENABLED
> flag during the translation of MODE SELECT to SET FEATURES. If SET FEATURES
> gets deferred due to outstanding NCQ commands, the original MODE SELECT
> command will be re-queued. When the re-queued MODE SELECT goes through
> the ata_mselect_control_ata_feature() translation again, SET FEATURES
> will not be issued because ATA_DFLAG_CDL_ENABLED has been already set or
> cleared by the initial translation of MODE SELECT.
> 
> The ATA_DFLAG_CDL_ENABLED checks in ata_mselect_control_ata_feature()
> are safe to remove because scsi_cdl_enable() implements a similar logic
> that avoids enabling CDL if it has been already enabled.
> 

Please add "Fixes: 17e897a45675 ("ata: libata-scsi: Improve CDL control") here.

> Cc: stable@vger.kernel.org
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 57f674f51b0c..856eabfd5a17 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3904,27 +3904,17 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
>  	/* Check cdl_ctrl */
>  	switch (buf[0] & 0x03) {
>  	case 0:
> -		/* Disable CDL if it is enabled */
> -		if (!(dev->flags & ATA_DFLAG_CDL_ENABLED))
> -			return 0;
> -		ata_dev_dbg(dev, "Disabling CDL\n");

Please keep this debug message and move it below the comment.

> +		/* Disable CDL */
>  		cdl_action = 0;
>  		dev->flags &= ~ATA_DFLAG_CDL_ENABLED;
>  		break;
>  	case 0x02:
> -		/*
> -		 * Enable CDL if not already enabled. Since this is mutually
> -		 * exclusive with NCQ priority, allow this only if NCQ priority
> -		 * is disabled.
> -		 */
> -		if (dev->flags & ATA_DFLAG_CDL_ENABLED)
> -			return 0;
> +		/* Enable CDL T2A/T2B: NCQ priority must be disabled */

T2A/T2B is for SCSI, not ATA. So let's not mention that. I prefer that the
comment keeps the "mutually exclusive" mention, so something like:

		*
		* Enable CDL. Since this is mutually exclusive with the NCQ
		* priority feature set, allow this only if NCQ priority is
		* disabled.
		*/

>  		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) {
>  			ata_dev_err(dev,
>  				"NCQ priority must be disabled to enable CDL\n");
>  			return -EINVAL;
>  		}
> -		ata_dev_dbg(dev, "Enabling CDL\n");

And please keep this debug message.

>  		cdl_action = 1;
>  		dev->flags |= ATA_DFLAG_CDL_ENABLED;
>  		break;


-- 
Damien Le Moal
Western Digital Research
