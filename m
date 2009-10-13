From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 1/1] sata_mv: Prevent PIO commands to be defered too long
	if traffic in progress.
Date: Mon, 12 Oct 2009 18:44:36 -0700
Message-ID: <da824cf30910121844s7dddfffxcf983d8801b6bfad@mail.gmail.com>
References: <1255387440-13313-1-git-send-email-gwendal@google.com>
	 <1255387440-13313-2-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:17224 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016AbZJMBpq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Oct 2009 21:45:46 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id n9D1icXj012219
	for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2009 18:44:38 -0700
Received: from pzk17 (pzk17.prod.google.com [10.243.19.145])
	by zps37.corp.google.com with ESMTP id n9D1iaSB012784
	for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2009 18:44:36 -0700
Received: by pzk17 with SMTP id 17so3469287pzk.6
        for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2009 18:44:36 -0700 (PDT)
In-Reply-To: <1255387440-13313-2-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: mlord@pobox.com, linux-ide@vger.kernel.org

On Mon, Oct 12, 2009 at 3:44 PM, Gwendal Grignou <gwendal@google.com> w=
rote:
> Use excl_link when non NCQ commands are defered, to be sure they are =
processed
> as soon as outstanding commands are completed. It prevents some comma=
nds to be
> defered indifinitely when using a port multiplier.
>
> Signed-off-by: Gwendal Grignou <gwendal@google.com>

Reviewed-by: Grant Grundler <grundler@google.com>

thanks,
grant

> ---
> =C2=A0drivers/ata/sata_mv.c | =C2=A0 29 +++++++++++++++++++++++++++--
> =C2=A01 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 17f9ff9..6f5093b 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -1382,6 +1382,25 @@ static int mv_qc_defer(struct ata_queued_cmd *=
qc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ATA_DEF=
ER_PORT;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* PIO commands need exclusive link: no other =
commands [DMA or PIO]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* can run concurrently.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* set excl_link when we want to send a P=
IO command in DMA mode
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* or a non-NCQ command in NCQ mode.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* When we receive a command from that li=
nk, and there are no
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* outstanding commands, mark a flag to c=
lear excl_link and let
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* the command go through.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (unlikely(ap->excl_link)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (link =3D=3D ap=
->excl_link) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (ap->nr_active_links)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ATA_DEFER_PORT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 qc->flags |=3D ATA_QCFLAG_CLEAR_EXCL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return ATA_DEFER_PORT;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If the port is completely idle, then al=
low the new qc.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> @@ -1395,8 +1414,14 @@ static int mv_qc_defer(struct ata_queued_cmd *=
qc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * doesn't allow it.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((pp->pp_flags & MV_PP_FLAG_EDMA_EN) &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pp->pp_flags & MV_PP_FLAG_NCQ_E=
N) && ata_is_ncq(qc->tf.protocol))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pp->pp_flags & MV_PP_FLAG_NCQ_E=
N)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ata_is_ncq(qc-=
>tf.protocol))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ap->excl_link =3D link;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return ATA_DEFER_PORT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ATA_DEFER_PORT;
> =C2=A0}
> --
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
