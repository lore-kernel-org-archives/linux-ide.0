From: Tejun Heo <tj@kernel.org>
Subject: Re: [v1 2/3] ata: ahci_platform: enable imx6q ahci sata support
Date: Mon, 17 Jun 2013 11:27:19 -0700
Message-ID: <CAOS58YM+ih4vLD8v5u08FS0JMcrwYNHo31zOmDd5VAed+NKbtg@mail.gmail.com>
References: <1371462767-16630-1-git-send-email-r65037@freescale.com>
	<1371462767-16630-3-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:61902 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab3FQS1U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jun 2013 14:27:20 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so3049526pbc.32
        for <linux-ide@vger.kernel.org>; Mon, 17 Jun 2013 11:27:19 -0700 (PDT)
In-Reply-To: <1371462767-16630-3-git-send-email-r65037@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, Richard Zhu <r65037@freescale.com>

On Mon, Jun 17, 2013 at 2:52 AM, Richard Zhu
<richard.zhuhongxing@gmail.com> wrote:
> imx6q contains the Synopsys AHCI SATA controller which shares
> ahci_platform driver with other controllers.
>
> This patch updates the DT compatible list for ahci_platform,
> and enable the imx6q ahci sata support.
>
> Signed-off-by: Richard Zhu <r65037@freescale.com>

I suppose this better be routed with the rest of the series through
the arch tree?  If not, please let me know.

Acked-by: Tejun Heo <tj@kernel.org>

There probably will be a merge conflict but it's gonna be very
trivial, so no worries.

Thanks.

--
tejun
