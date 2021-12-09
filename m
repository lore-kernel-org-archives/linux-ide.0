Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3298C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 06:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhLIGRP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhLIGRO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 01:17:14 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BADC061746
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 22:13:42 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id n66so7310013oia.9
        for <linux-ide@vger.kernel.org>; Wed, 08 Dec 2021 22:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbqdeED7RJas5FGblDaLMY0Os04QZ9kz7lWTY080yvY=;
        b=pLWYvAO8lbqZxpQP3bqz6ZkZuOwc+ttH6+J7NLXSy2QfJRo2L8Llkwnhi8g+0oRfoT
         KwLwLdU6GcTeCevgob58AyUt2bEPSihBZ4vRsxyYFOZ7J5xBuK4A/GZuVD9aIoBeOw+W
         xP7ZshYuh46fBEOX89NhMVKW6JYp2QC/mcMTh/N/7sdNhRB5KQPnwSXzEe1lbqKnKDBP
         yFT13k/tBhcYFVCHRWWy+W8VSGBAm2+EzN5/1Pwyk/Xb/QMJHiCZEVCNo3viqjD71J7l
         KedXsvuvkt5XWJ65wDnZ+KB1+/H1F3qPkiZ/5/T5FOcMg8jgfj+vAKxuStElH+lVwpLH
         qK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbqdeED7RJas5FGblDaLMY0Os04QZ9kz7lWTY080yvY=;
        b=S9Z2Xf6GSyQtNfr/N9bKi+h6b6e+JqHtii0WtrBwudWntrtBmrA4Tz4Dgg+5R/ocKs
         2J5GcrJaA7hUezKrGWecpf/KEtUhaJu2OCFyTRa6US5edF1KOnFFtbLUKaeUoSQik3hL
         zOI4JIO8ficWZ7DdCtkZzUBC4yRpR5RygybMy+wYUELCl84pPs6DOEmNF14eafHrTU83
         Ih3bsptTCr4cjMev6d0+9r2zlQ28nIR2/NJ67Ah8MnsvaFbwNgktxom2QQefLv/XRrTP
         LcmpEqvJnXXIZf1lFqCwOqcdMXoC7ANw+OHQPOA8IREDbt6wuTgAQZpPw3muW1pIa687
         SfGA==
X-Gm-Message-State: AOAM530o+fSvVBrnDWtkOzN0sq3AVFBw4VJ5yVMykLwmxLpY2fd2YLxN
        WLZDhs7Iam+X3wSk+iIYCdGW1UuhQXc2CueCZUoFiXQW
X-Google-Smtp-Source: ABdhPJxybvsOwgLGNVc1GblzijtvhaY6p63xoZId8Qw+HeOQqGizntqGfQPjDt6R8sNNDapfb9tXcOaLZpc9wp2Qowg=
X-Received: by 2002:a05:6808:2216:: with SMTP id bd22mr3925037oib.27.1639030421239;
 Wed, 08 Dec 2021 22:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20211208163255.114660-1-hare@suse.de> <20211208163255.114660-36-hare@suse.de>
In-Reply-To: <20211208163255.114660-36-hare@suse.de>
From:   Mikael Pettersson <mikpelinux@gmail.com>
Date:   Thu, 9 Dec 2021 07:13:30 +0100
Message-ID: <CAM43=SNbV37kmKVnjmheH9UKtd_uhZKXthsEcjUbCTNRXEN-ig@mail.gmail.com>
Subject: Re: [PATCH 35/73] sata_promise: Drop pointless VPRINTK() calls and
 convert the remaining ones
To:     Hannes Reinecke <hare@suse.de>
Cc:     Damien LeMoal <damien.lemoal@wdc.com>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Dec 8, 2021 at 9:36 PM Hannes Reinecke <hare@suse.de> wrote:
>
> Drop pointless VPRINTK() calls for entering and existing interrupt
> routines and convert the remaining calls to dev_dbg().
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/sata_promise.c | 31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
> index 7815da8ef9e5..1059beae8720 100644
> --- a/drivers/ata/sata_promise.c
> +++ b/drivers/ata/sata_promise.c
> @@ -596,7 +596,8 @@ static void pdc_fill_sg(struct ata_queued_cmd *qc)
>
>                         prd[idx].addr = cpu_to_le32(addr);
>                         prd[idx].flags_len = cpu_to_le32(len & 0xffff);
> -                       VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
> +                       ata_port_dbg(ap, "PRD[%u] = (9x%X, 0x%X)\n",

typo: 9x -> 0x
LGTM otherwise

> +                                    idx, addr, len);
>
>                         idx++;
>                         sg_len -= len;
> @@ -609,17 +610,16 @@ static void pdc_fill_sg(struct ata_queued_cmd *qc)
>         if (len > SG_COUNT_ASIC_BUG) {
>                 u32 addr;
>
> -               VPRINTK("Splitting last PRD.\n");
> -
>                 addr = le32_to_cpu(prd[idx - 1].addr);
>                 prd[idx - 1].flags_len = cpu_to_le32(len - SG_COUNT_ASIC_BUG);
> -               VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx - 1, addr, SG_COUNT_ASIC_BUG);
> +               ata_port_dbg(ap, "PRD[%u] = (0x%X, 0x%X)\n",
> +                            idx - 1, addr, SG_COUNT_ASIC_BUG);
>
>                 addr = addr + len - SG_COUNT_ASIC_BUG;
>                 len = SG_COUNT_ASIC_BUG;
>                 prd[idx].addr = cpu_to_le32(addr);
>                 prd[idx].flags_len = cpu_to_le32(len);
> -               VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
> +               ata_port_dbg(ap, "PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
>
>                 idx++;
>         }
> @@ -632,8 +632,6 @@ static enum ata_completion_errors pdc_qc_prep(struct ata_queued_cmd *qc)
>         struct pdc_port_priv *pp = qc->ap->private_data;
>         unsigned int i;
>
> -       VPRINTK("ENTER\n");
> -
>         switch (qc->tf.protocol) {
>         case ATA_PROT_DMA:
>                 pdc_fill_sg(qc);
> @@ -922,12 +920,8 @@ static irqreturn_t pdc_interrupt(int irq, void *dev_instance)
>         u32 hotplug_status;
>         int is_sataii_tx4;
>
> -       VPRINTK("ENTER\n");
> -
> -       if (!host || !host->iomap[PDC_MMIO_BAR]) {
> -               VPRINTK("QUICK EXIT\n");
> +       if (!host || !host->iomap[PDC_MMIO_BAR])
>                 return IRQ_NONE;
> -       }
>
>         host_mmio = host->iomap[PDC_MMIO_BAR];
>
> @@ -946,23 +940,18 @@ static irqreturn_t pdc_interrupt(int irq, void *dev_instance)
>         /* reading should also clear interrupts */
>         mask = readl(host_mmio + PDC_INT_SEQMASK);
>
> -       if (mask == 0xffffffff && hotplug_status == 0) {
> -               VPRINTK("QUICK EXIT 2\n");
> +       if (mask == 0xffffffff && hotplug_status == 0)
>                 goto done_irq;
> -       }
>
>         mask &= 0xffff;         /* only 16 SEQIDs possible */
> -       if (mask == 0 && hotplug_status == 0) {
> -               VPRINTK("QUICK EXIT 3\n");
> +       if (mask == 0 && hotplug_status == 0)
>                 goto done_irq;
> -       }
>
>         writel(mask, host_mmio + PDC_INT_SEQMASK);
>
>         is_sataii_tx4 = pdc_is_sataii_tx4(host->ports[0]->flags);
>
>         for (i = 0; i < host->n_ports; i++) {
> -               VPRINTK("port %u\n", i);
>                 ap = host->ports[i];
>
>                 /* check for a plug or unplug event */
> @@ -989,8 +978,6 @@ static irqreturn_t pdc_interrupt(int irq, void *dev_instance)
>                 }
>         }
>
> -       VPRINTK("EXIT\n");
> -
>  done_irq:
>         spin_unlock(&host->lock);
>         return IRQ_RETVAL(handled);
> @@ -1005,8 +992,6 @@ static void pdc_packet_start(struct ata_queued_cmd *qc)
>         unsigned int port_no = ap->port_no;
>         u8 seq = (u8) (port_no + 1);
>
> -       VPRINTK("ENTER, ap %p\n", ap);
> -
>         writel(0x00000001, host_mmio + (seq * 4));
>         readl(host_mmio + (seq * 4));   /* flush */
>
> --
> 2.29.2
>
