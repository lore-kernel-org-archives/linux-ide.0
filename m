From: Harro Haan <hrhaan@gmail.com>
Subject: Re: [PATCH] pci: imx: enable pcie msi support
Date: Thu, 12 Dec 2013 19:57:29 +0100
Message-ID: <CAB5oZtC_8nuE2E7tj2U8d2KLH4M6Si3uMWSLuT62nywRrSi+7Q@mail.gmail.com>
References: <1386581119-2962-1-git-send-email-richard.zhuhongxing@gmail.com>
	<1386581119-2962-2-git-send-email-richard.zhuhongxing@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:53335 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab3LLS53 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Dec 2013 13:57:29 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so920022oag.14
        for <linux-ide@vger.kernel.org>; Thu, 12 Dec 2013 10:57:29 -0800 (PST)
In-Reply-To: <1386581119-2962-2-git-send-email-richard.zhuhongxing@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, =?UTF-8?Q?J=C3=BCrgen_Beisert?= <jbe@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

Richard,

On 9 December 2013 10:25, Richard Zhu <richard.zhuhongxing@gmail.com> wrote:
> [...]
> +       if (pp->quirks & DW_PCIE_QUIRK_NO_MSI_VEC) {
> +               irq = assign_irq(1, desc, &pos);
> +               set_irq_flags(irq, IRQF_VALID);
> +       } else {
> [...]

Thanks, the above quirk fixes the problem with the MSIX interrupts

> [...]
> +       if (pp->quirks & DW_PCIE_QUIRK_MSI_SELF_EN) {
> +               if ((type == PCI_CAP_ID_MSI) || (type == PCI_CAP_ID_MSIX)) {
> +                       /* Set MSI enable of RC here */
> +                       val = readl(pp->dbi_base + 0x50);
> +                       if ((val & (PCI_MSI_FLAGS_ENABLE << 16)) == 0) {
> +                               val |= PCI_MSI_FLAGS_ENABLE << 16;
> +                               writel(val, pp->dbi_base + 0x50);
> +                       }
> +               }
> +       }
> [...]

Why is it actually needed to change the value from 0x1807005 to 0x1817005?
On the SabreSD the MSI interrupts also work without this change.

Best regards,

Harro
