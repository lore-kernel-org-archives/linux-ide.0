From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] sata_sil24: Use memory barriers before issuing commands
Date: Fri, 25 Jun 2010 19:32:22 -0700
Message-ID: <AANLkTimdHs25zHe8DJUaOOo7wYW14Ds4c2ORaSBhRxSg@mail.gmail.com>
References: <20100610145706.15588.4562.stgit@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:22907 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab0FZCc1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 22:32:27 -0400
In-Reply-To: <20100610145706.15588.4562.stgit@e102109-lin.cambridge.arm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Colin Tuckley <colin.tuckley@arm.com>

On Thu, Jun 10, 2010 at 7:57 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> The data in the cmd_block buffers may reach the main memory after the
> writel() to the device ports.

"ia-64 Linux Kernel" (mosberger and eranian) uses exactly this sequence
as an example for wmb() on page 303.

I'm curious about the system that exposed this problem. I believe wmb()=
 fixes
 an issue not exposed on most machines. Can any general comments be
made about cache coherency, memory ordering (weak?), instruction orderi=
ng
 (super scalar?), etc. ?

The explanation above is a bit short (most people won't understand it).


> This patch introduces two calls to wmb() to ensure the relative order=
ing.

And as Tejun asked, the comment where wmb() gets used should clearly
explain which host memory writes are targetted by the wmb().

thanks,
grant

>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Colin Tuckley <colin.tuckley@arm.com>
> Cc: Tejun Heo <tj@kernel.org>
> ---
> =C2=A0drivers/ata/sata_sil24.c | =C2=A0 =C2=A02 ++
> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index e925051..6392fdb 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -622,6 +622,7 @@ static int sil24_exec_polled_cmd(struct ata_port =
*ap, int pmp,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_enabled =3D readl(port + PORT_IRQ_ENAB=
LE_SET);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(PORT_IRQ_COMPLETE | PORT_IRQ_ERROR,=
 port + PORT_IRQ_ENABLE_CLR);
>
> + =C2=A0 =C2=A0 =C2=A0 wmb();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0writel((u32)paddr, port + PORT_CMD_ACTIVAT=
E);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0writel((u64)paddr >> 32, port + PORT_CMD_A=
CTIVATE + 4);
>
> @@ -895,6 +896,7 @@ static unsigned int sil24_qc_issue(struct ata_que=
ued_cmd *qc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0paddr =3D pp->cmd_block_dma + tag * sizeof=
(*pp->cmd_block);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0activate =3D port + PORT_CMD_ACTIVATE + ta=
g * 8;
>
> + =C2=A0 =C2=A0 =C2=A0 wmb();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0writel((u32)paddr, activate);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0writel((u64)paddr >> 32, activate + 4);
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
