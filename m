From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add ATA_CMD_DSM to ata_get_cmd_descript
Date: Wed, 14 Jul 2010 03:51:51 -0400
Message-ID: <4C3D6C97.3010506@garzik.org>
References: <20100705154454U.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46281 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0GNHvy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jul 2010 03:51:54 -0400
Received: by gxk23 with SMTP id 23so3663839gxk.19
        for <linux-ide@vger.kernel.org>; Wed, 14 Jul 2010 00:51:54 -0700 (PDT)
In-Reply-To: <20100705154454U.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On 07/05/2010 02:45 AM, FUJITA Tomonori wrote:
> Why isn't ATA_CMD_DSM in ata_get_cmd_descript()?
>
> =
> From: FUJITA Tomonori<fujita.tomonori@lab.ntt.co.jp>
> Subject: [PATCH] libata: add ATA_CMD_DSM to ata_get_cmd_descript
>
> Signed-off-by: FUJITA Tomonori<fujita.tomonori@lab.ntt.co.jp>
> ---
>   drivers/ata/libata-eh.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index f77a673..697474b 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2214,6 +2214,7 @@ const char *ata_get_cmd_descript(u8 command)
>   		{ ATA_CMD_SMART,		"SMART" },
>   		{ ATA_CMD_MEDIA_LOCK,		"DOOR LOCK" },
>   		{ ATA_CMD_MEDIA_UNLOCK,		"DOOR UNLOCK" },
> +		{ ATA_CMD_DSM,			"DATA SET MANAGEMENT" },
>   		{ ATA_CMD_CHK_MED_CRD_TYP, 	"CHECK MEDIA CARD TYPE" },

applied


