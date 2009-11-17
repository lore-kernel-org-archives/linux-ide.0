From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: Clean up hard coded array size calculation.
Date: Mon, 16 Nov 2009 22:17:55 -0500
Message-ID: <4B0215E3.2020400@pobox.com>
References: <1257708657-1232-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754127AbZKQDRz@vger.kernel.org>
In-Reply-To: <1257708657-1232-1-git-send-email-tfransosi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
Cc: mlord@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 11/08/2009 02:30 PM, Thiago Farina wrote:
> Use ARRAY_SIZE macro of kernel api instead.
>
> Signed-off-by: Thiago Farina<tfransosi@gmail.com>
> ---
>   drivers/ata/sata_mv.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 6f5093b..a8a7be0 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2217,7 +2217,7 @@ static unsigned int mv_qc_issue_fis(struct ata_queued_cmd *qc)
>   	int err = 0;
>
>   	ata_tf_to_fis(&qc->tf, link->pmp, 1, (void *)fis);
> -	err = mv_send_fis(ap, fis, sizeof(fis) / sizeof(fis[0]));
> +	err = mv_send_fis(ap, fis, ARRAY_SIZE(fis));
>   	if (err)

applied
