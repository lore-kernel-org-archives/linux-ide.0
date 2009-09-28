From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ide-iops: fix for drive side 80-wire cable detection
 failure f	or IBM-DJNA-371350 HD
Date: Sun, 27 Sep 2009 20:26:13 -0400
Message-ID: <4AC002A5.3090705@garzik.org>
References: <20090927.193419.17010.1@webmail21.vgs.untd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [207.36.208.214] ([207.36.208.214]:41434 "EHLO mail.dvmed.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbZI1A1K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Sep 2009 20:27:10 -0400
In-Reply-To: <20090927.193419.17010.1@webmail21.vgs.untd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Gavlick <mgavl69@juno.com>
Cc: linux-ide@vger.kernel.org, davem@davemloft.net

On 09/27/2009 07:34 PM, Michael Gavlick wrote:
>    The IDE driver complains about an 80-wire cable detection failure and falls back to UDMA/33 for the old IBM-DJNA-371350 Rev. J7NOA30K HD even though it is an UDMA/66 HD.
>
> Kernel Message:
> "hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> hdb: drive side 80-wire cable detection failed, limiting max speed to UDMA33
> hdb: UDMA/33 mode selected"
>
>    This patch disables the word 93 validity check in /drivers/ide/ide-iops.c for this particular hardware by adding it to the buggy firmware ivb_list.
>
> diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
> index 6cc6c83..6d6f78f 100644
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -218,6 +218,7 @@ static const struct drive_list_entry ivb_list[] = {
>   	{ "TSSTcorp CDDVDW SH-S202H"	, "SB00"	},
>   	{ "TSSTcorp CDDVDW SH-S202H"	, "SB01"	},
>   	{ "SAMSUNG SP0822N"		, "WA100-10"	},
> +        { "IBM-DJNA-371350"             , "J7NOA30K"    },
>   	{ NULL				, NULL		}

Would you create the libata version of this patch, too, please?

We are [very slowly] migrating away from the old-IDE driver.

	Jeff




