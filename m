From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
 c pl atform
Date: Thu, 18 May 2006 08:01:34 -0400
Message-ID: <446C621E.9060502@emc.com>
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:38767 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751252AbWERLBy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 07:01:54 -0400
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>, Mark Lord <mlord@pobox.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com, Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>, Kumar Gala <galak@kernel.crashing.org>

Mark Lord has been actively working on the sata_mv driver recently,

ric


Zang Roy-r61911 wrote:

>-----Original Message-----
>From: Kumar Gala [mailto:galak@kernel.crashing.org]
>Sent: 2006=E5=B9=B45=E6=9C=8817=E6=97=A5 21:28
>To: Zang Roy-r61911
>Cc: Paul Mackerras; linuxppc-dev list; Alexandre.Bounine@tundra.com; Y=
ang Xin-Xin-r48390
>Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on pow=
erpc pl atform
>
>
>
>On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:
>
> =20
>
>>Fix Marvell SATA driver bugs on PowerPC platform:
>>SATA device can't work for the problem on little-endian mode.
>>U-Boot can't find SATA device after kernel reboots.
>>
>>Signed-off-by: Hongjun cheng	<hong-jun.chen@reescale.com>
>>Signed-off-by: Roy Zang		<tie-fei.zang@freescale.com>
>>
>>   =20
>>
>>>From nobody Mon Sep 17 00:00:00 2001
>>>     =20
>>>
>>From: roy zang <tie-fei.zang@freescale.com>
>>Date: Tue May 16 15:25:23 2006 +0800
>>Subject: [PATCH] Fix bugs on powerpc platform for mv sata driver
>>   =20
>>
>
>This needs to go to Jeff Garzik as SATA driver maintainer.
>
>- kumar
>
> =20
>
>> drivers/scsi/sata_mv.c |   10 +++++++++-
>> 1 files changed, 9 insertions(+), 1 deletions(-)
>>
>>d82ac19d259f8487a31105eaf844a93cbd9008e8
>>diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
>>index d5fdcb9..4166422 100644
>>--- a/drivers/scsi/sata_mv.c
>>+++ b/drivers/scsi/sata_mv.c
>>@@ -1032,6 +1032,9 @@ static inline void mv_crqb_pack_cmd(u16
>> {
>> 	*cmdw =3D data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
>> 		(last ? CRQB_CMD_LAST : 0);
>>+#ifdef CONFIG_PPC
>>+	*cmdw =3D cpu_to_le16(*cmdw);
>>+#endif
>> }
>>
>> /**
>>@@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>> static void mv5_enable_leds(struct mv_host_priv *hpriv, void =20
>>__iomem *mmio)
>> {
>> 	u32 tmp;
>>-
>>+#ifndef CONFIG_PPC
>> 	writel(0, mmio + MV_GPIO_PORT_CTL);
>>+#endif
>>
>> 	/* FIXME: handle MV_HP_ERRATA_50XXB2 errata */
>>
>> 	tmp =3D readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);
>>+#ifdef CONFIG_PPC
>>+	tmp &=3D ~(1 << 0);
>>+#else=09
>> 	tmp |=3D ~(1 << 0);
>>+#endif
>> 	writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
>> }
>>
>>--=20
>>1.3.0
>>_______________________________________________
>>Linuxppc-dev mailing list
>>Linuxppc-dev@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>   =20
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel=
" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
> =20
>
