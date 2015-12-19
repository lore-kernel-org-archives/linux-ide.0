From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Sat, 19 Dec 2015 18:56:57 +0200
Message-ID: <CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<5672F77F.4010306@candw.ms>
	<yw1xfuz1c5xy.fsf@unicorn.mansr.com>
	<567302E8.5050303@candw.ms>
	<yw1x7fkcdi2a.fsf@unicorn.mansr.com>
	<5673061A.4070700@candw.ms>
	<yw1x37v0df86.fsf@unicorn.mansr.com>
	<56732C04.9040100@candw.ms>
	<yw1xvb7wbowu.fsf@unicorn.mansr.com>
	<5673F277.2050607@candw.ms>
	<yw1xegekarp9.fsf@unicorn.mansr.com>
	<1450441395.30729.203.camel@linux.intel.com>
	<yw1x37uzc45t.fsf@unicorn.mansr.com>
	<5674271B.9090308@candw.ms>
	<yw1xtwnfad4y.fsf@unicorn.mansr.com>
	<56745BA4.1090607@candw.ms>
	<yw1xpoy39yl1.fsf@unicorn.mansr.com>
	<56748D85.4060108@candw.ms>
	<yw1xlh8r9wkm.fsf@unicorn.mansr.com>
	<CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
	<567541EE.9010308@candw.ms>
	<yw1x60zua1ld.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34634 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbbLSQ46 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2015 11:56:58 -0500
In-Reply-To: <yw1x60zua1ld.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Julian Margetson <runaway@candw.ms>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Dec 19, 2015 at 5:40 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.co=
m> wrote:

> OK, I've found something.  The dma setup errors are benign, caused by
> the driver calling dmaengine_prep_slave_sg() even for non-dma
> operations.

I suppose the following is a quick fix to avoid preparing descriptor
for non-DMA operations (not tested anyhow)

a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1041,6 +1041,9 @@ static void sata_dwc_qc_prep_by_tag(struct
ata_queued_cmd *qc, u8 tag)
                __func__, ap->port_no, get_dma_dir_descript(qc->dma_dir=
),
                 qc->n_elem);

+       if (!is_slave_direction(qc->dma_dir))
+               return;
+
        desc =3D dma_dwc_xfer_setup(qc);
        if (!desc) {
                dev_err(ap->dev, "%s: dma_dwc_xfer_setup returns NULL\n=
",

> The real error is the lock recursion that's reported
> later.  I wasn't seeing it since I was running a UP non-preempt kerne=
l.
> With lock debugging enabled, I get the same error.  This patch should
> fix it.

> -       spin_lock_irqsave(&ap->host->lock, flags);
>         hsdevp->cmd_issued[tag] =3D cmd_issued;
> -       spin_unlock_irqrestore(&ap->host->lock, flags);

> +

This will create a second empty line, though I don't care it is so mino=
r.

--=20
With Best Regards,
Andy Shevchenko
