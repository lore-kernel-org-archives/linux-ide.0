Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B876C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 16:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhLJQXL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 11:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhLJQXL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 11:23:11 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45739C061746
        for <linux-ide@vger.kernel.org>; Fri, 10 Dec 2021 08:19:36 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s139so13793519oie.13
        for <linux-ide@vger.kernel.org>; Fri, 10 Dec 2021 08:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtF86GLjYRZQZPbIMgtDKxtFXwnHrW+8Xgwewq1m6QM=;
        b=XLJJWRDS6lR/qR99a0BrpWLMCyu8G5RSJ7OatjXKN6kWLZNN7sXM2e9bl004jS5UNz
         cnucHZRtTkeJTQz82l8wXnv0H11Alj9+VCBngxT8QiMwQJlJdj0sdsOJartXCEbd2Gch
         TAkJaaQHUHItLZA2c9F5XwtIOtHTVHoVgPGNen/9gVwcPV5l3oFyT17yz4ITxlnsPJeL
         ON4rwvt8nQfSWJ0x1nRhvept450FXvBaQH5TT2kdjxmXhvAg7LcV7rlR/9bdzQDqs6+M
         thXa0RR6esjrpgpRxQUh+Av5MUtTZ07vOin9bd1WR2Mc3mRlFcUWvb/TbXb7szCiSnix
         TQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtF86GLjYRZQZPbIMgtDKxtFXwnHrW+8Xgwewq1m6QM=;
        b=XP3Yxgvi8GmyyImtXXemUHgPUKPffSGWb58OJTjwhjVF0NvXMvpxhKREk6AMFCwgOh
         SfcZzZ4exNIRiBOyrzlM5sSsrKEzncl4MbaOiqEpUj8F3GTn1Yh6JByLGiy6VvIg90zZ
         UvGnbyUJZ4WBxnhK1lk/jV/LN+gwCHzk2ZyUUGbELtnzwC1ya5b8OFXhUBjIAC60St41
         yH9SNuktFkNsKYm/DUGSvNJpllWiv4ldMrwdTqbsb7pwDJxnA5tom33bLc/DQtEh4L8T
         G58vjhuEJkLxTRZTkc6DaMpiPWKMQpGtrKGbl2HmUoQgkOYff/MkypvZyXR4m9iM3xe5
         ilHg==
X-Gm-Message-State: AOAM530cbO4WBHF2DknjzHbej08awDsjXacFRv1NYBXp0UOGl+ddcfDu
        WyE4BoI5z8ssY/leeCdT1Kptpsz99qdbSiL0ZAY=
X-Google-Smtp-Source: ABdhPJyAmsffyWiZGnzMFtoqdOCKsBVnlBfWsbXJE9AxsbWbRBVCdqMAIOOSa+01Q+d8iEqGe9g833Run1LnpPIQcxg=
X-Received: by 2002:a05:6808:2216:: with SMTP id bd22mr13119138oib.27.1639153175605;
 Fri, 10 Dec 2021 08:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20211210072905.15666-1-hare@suse.de> <20211210072905.15666-29-hare@suse.de>
In-Reply-To: <20211210072905.15666-29-hare@suse.de>
From:   Mikael Pettersson <mikpelinux@gmail.com>
Date:   Fri, 10 Dec 2021 17:19:24 +0100
Message-ID: <CAM43=SNDB1Ka=cE+q6r=ixvX+PFyHtOMWoWVDwVbrykfP3DG3Q@mail.gmail.com>
Subject: Re: [PATCH 28/68] sata_promise: Drop pointless VPRINTK() calls and
 convert the remaining ones
To:     Hannes Reinecke <hare@suse.de>
Cc:     Damien LeMoal <damien.lemoal@wdc.com>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Dec 10, 2021 at 12:09 PM Hannes Reinecke <hare@suse.de> wrote:
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
> +                                    idx, addr, len);

typo: 9x -> 0x

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
