From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH #upstream-fixes] libahci: fix result_tf handling after an
 ATA PIO data-in command
Date: Thu, 14 Oct 2010 18:32:10 -0600
Message-ID: <AANLkTi=FDPbo28+RL8FyY1v8O0kSac=snPMegV0bkz83@mail.gmail.com>
References: <4C9C3878.9010206@teksavvy.com>
	<AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com>
	<4C9C44D0.1030409@teksavvy.com>
	<AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com>
	<4C9CA385.5090709@teksavvy.com>
	<4C9CA673.4090104@teksavvy.com>
	<4C9D33C0.8050900@gmail.com>
	<4CA99BCB.8080904@gmail.com>
	<4CAA0885.8060906@teksavvy.com>
	<4CAA0996.5080403@teksavvy.com>
	<4CAA0F6C.6080609@teksavvy.com>
	<4CAA21F4.5060000@teksavvy.com>
	<4CAA2AA6.2010204@pobox.com>
	<4CAA2C6F.2090603@teksavvy.com>
	<4CAA2E16.4010905@pobox.com>
	<4CAA3033.8030405@teksavvy.com>
	<4CAACEBE.1000104@gmail.com>
	<4CAB30FA.2010508@teksavvy.com>
	<4CAB4CE9.9070709@gmail.com>
	<AANLkTin=QWXcuy6JOi1y26dWH8FG1ji3JewTXu0K=4ri@mail.gmail.com>
	<4CB6C50F.60609@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41962 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab0JOAcK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Oct 2010 20:32:10 -0400
Received: by iwn35 with SMTP id 35so222313iwn.19
        for <linux-ide@vger.kernel.org>; Thu, 14 Oct 2010 17:32:10 -0700 (PDT)
In-Reply-To: <4CB6C50F.60609@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <kernel@teksavvy.com>, Seed <seedrubbish@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

On Thu, Oct 14, 2010 at 2:53 AM, Tejun Heo <tj@kernel.org> wrote:
> ATA devices don't send D2H Reg FIS after an successful ATA PIO data-i=
n
> command. =A0The host is supposed to take the E_Status of the precedin=
g
> PIO Setup FIS. =A0Update ahci_qc_fill_rtf() such that it takes E_Stat=
us
> after a successful ATA PIO data-in command.
>
> Without this patch, result_tf for such a command is filled with the
> content of the previous D2H Reg FIS which belongs to a previous
> command, which can make the command incorrectly seen as failed.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Mark Lord <kernel@teksavvy.com>
> Cc: Robert Hancock <hancockrwd@gmail.com>
> Cc: stable@kernel.org
> ---
> =A0drivers/ata/ahci.h =A0 =A0| =A0 =A01 +
> =A0drivers/ata/libahci.c | =A0 17 ++++++++++++++---
> =A02 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index e5fdeeb..d1a0f5b 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -72,6 +72,7 @@ enum {
> =A0 =A0 =A0 =A0AHCI_CMD_RESET =A0 =A0 =A0 =A0 =A0=3D (1 << 8),
> =A0 =A0 =A0 =A0AHCI_CMD_CLR_BUSY =A0 =A0 =A0 =3D (1 << 10),
>
> + =A0 =A0 =A0 RX_FIS_PIO_SETUP =A0 =A0 =A0 =A0=3D 0x20, /* offset of =
PIO Setup FIS data */
> =A0 =A0 =A0 =A0RX_FIS_D2H_REG =A0 =A0 =A0 =A0 =A0=3D 0x40, /* offset =
of D2H Register FIS data */
> =A0 =A0 =A0 =A0RX_FIS_SDB =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x58, /* off=
set of SDB FIS data */
> =A0 =A0 =A0 =A0RX_FIS_UNK =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x60, /* off=
set of Unknown FIS data */
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 8eea309..0c482a0 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1830,12 +1830,23 @@ static unsigned int ahci_qc_issue(struct ata_=
queued_cmd *qc)
> =A0static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
> =A0{
> =A0 =A0 =A0 =A0struct ahci_port_priv *pp =3D qc->ap->private_data;
> - =A0 =A0 =A0 u8 *d2h_fis =3D pp->rx_fis + RX_FIS_D2H_REG;
> + =A0 =A0 =A0 u8 *rx_fis =3D pp->rx_fis;
>
> =A0 =A0 =A0 =A0if (pp->fbs_enabled)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2h_fis +=3D qc->dev->link->pmp * AHCI_=
RX_FIS_SZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_fis +=3D qc->dev->link->pmp * AHCI_R=
X_FIS_SZ;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* After a successful execution of an ATA PIO data-in=
 command,
> + =A0 =A0 =A0 =A0* the device doesn't send D2H Reg FIS to update the =
TF and
> + =A0 =A0 =A0 =A0* the host should take Status from E_Status of the p=
receding
> + =A0 =A0 =A0 =A0* PIO Setup FIS.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (qc->tf.protocol =3D=3D ATA_PROT_PIO && qc->dma_dir =
=3D=3D DMA_FROM_DEVICE &&
> + =A0 =A0 =A0 =A0 =A0 !(qc->flags & ATA_QCFLAG_FAILED))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qc->result_tf.command =3D (rx_fis + RX_=
=46IS_PIO_SETUP)[15];

Shouldn't we be reading the entire TF from the PIO setup FIS and then
just replacing the command register value with the E_Status field? It
looks like that's the only field in the TF that's being set here.

> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG=
, &qc->result_tf);
>
> - =A0 =A0 =A0 ata_tf_from_fis(d2h_fis, &qc->result_tf);
> =A0 =A0 =A0 =A0return true;
> =A0}
>
>
