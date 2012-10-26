From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] pata_arasan_cf: declare/use 'qc' and 'ap' variables in arasan_cf_dma_start()
Date: Fri, 26 Oct 2012 09:01:23 +0530
Message-ID: <CAOh2x==5iy4cDvney8uue2V10Ok1m+v5zeRJjqsw4Tk16reMaQ@mail.gmail.com>
References: <201210252108.47085.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43486 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893Ab2JZDbY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2012 23:31:24 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so2652124vcb.19
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2012 20:31:24 -0700 (PDT)
In-Reply-To: <201210252108.47085.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, spear-devel <spear-devel@list.st.com>

On Thu, Oct 25, 2012 at 10:38 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> 'acdev->qc' and 'acdev->qc->ap' expressions are used multiple times in this
> function, so it makes sense to use the local variables for them.
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

> ---
> The patch is atop of the 'upstream' branch of libata-dev.git...
>
>  drivers/ata/pata_arasan_cf.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Index: libata-dev/drivers/ata/pata_arasan_cf.c
> ===================================================================
> --- libata-dev.orig/drivers/ata/pata_arasan_cf.c
> +++ libata-dev/drivers/ata/pata_arasan_cf.c
> @@ -668,13 +668,15 @@ void arasan_cf_error_handler(struct ata_
>
>  static void arasan_cf_dma_start(struct arasan_cf_dev *acdev)
>  {
> +       struct ata_queued_cmd *qc = acdev->qc;
> +       struct ata_port *ap = qc->ap;
>         u32 xfer_ctr = readl(acdev->vbase + XFER_CTR) & ~XFER_DIR_MASK;
> -       u32 write = acdev->qc->tf.flags & ATA_TFLAG_WRITE;
> +       u32 write = qc->tf.flags & ATA_TFLAG_WRITE;
>
>         xfer_ctr |= write ? XFER_WRITE : XFER_READ;
>         writel(xfer_ctr, acdev->vbase + XFER_CTR);
>
> -       acdev->qc->ap->ops->sff_exec_command(acdev->qc->ap, &acdev->qc->tf);
> +       ap->ops->sff_exec_command(ap, &qc->tf);
>         ata_sff_queue_work(&acdev->work);
>  }
>
