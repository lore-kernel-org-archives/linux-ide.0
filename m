From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/62] ata: remove the second argument of k[un]map_atomic()
Date: Sun, 27 Nov 2011 13:40:00 -0500
Message-ID: <4ED28400.9090501@pobox.com>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com> <1322371662-26166-11-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33252 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab1K0SkG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Nov 2011 13:40:06 -0500
In-Reply-To: <1322371662-26166-11-git-send-email-amwang@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cong Wang <amwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org

On 11/27/2011 12:26 AM, Cong Wang wrote:
> Signed-off-by: Cong Wang<amwang@redhat.com>
> ---
>   drivers/ata/libata-sff.c |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 4cadfa2..8469cb5 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -720,13 +720,13 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>
>   		/* FIXME: use a bounce buffer */
>   		local_irq_save(flags);
> -		buf = kmap_atomic(page, KM_IRQ0);
> +		buf = kmap_atomic(page);
>
>   		/* do the actual data transfer */
>   		ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
>   				       do_write);
>
> -		kunmap_atomic(buf, KM_IRQ0);
> +		kunmap_atomic(buf);
>   		local_irq_restore(flags);
>   	} else {
>   		buf = page_address(page);
> @@ -865,13 +865,13 @@ next_sg:
>
>   		/* FIXME: use bounce buffer */
>   		local_irq_save(flags);
> -		buf = kmap_atomic(page, KM_IRQ0);
> +		buf = kmap_atomic(page);
>
>   		/* do the actual data transfer */
>   		consumed = ap->ops->sff_data_xfer(dev,  buf + offset,
>   								count, rw);
>
> -		kunmap_atomic(buf, KM_IRQ0);
> +		kunmap_atomic(buf);
>   		local_irq_restore(flags);
>   	} else {

Acked-by: Jeff Garzik <jgarzik@redhat.com>



