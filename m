From: Aggrwal Poonam-B10812 <B10812@freescale.com>
Subject: RE: [PATCH] ATA: Add FSL sata v2 controller support
Date: Mon, 17 Jan 2011 11:58:19 +0000
Message-ID: <45903308677306428B6EE7E6FF5A520408654D@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
 <4D342C6E.6000608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:29557
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751790Ab1AQL6t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jan 2011 06:58:49 -0500
In-Reply-To: <4D342C6E.6000608@ru.mvista.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>, Xu Lei-B33228 <B33228@freescale.com>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, Gala Kumar-B11780 <B11780@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



> -----Original Message-----
> From: linuxppc-dev-bounces+poonam.aggrwal=freescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-
> bounces+poonam.aggrwal=freescale.com@lists.ozlabs.org] On Behalf Of
> Sergei Shtylyov
> Sent: Monday, January 17, 2011 5:18 PM
> To: Xu Lei-B33228
> Cc: jgarzik@pobox.com; Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org;
> linux-ide@vger.kernel.org
> Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
> 
> Hello.
> 
> On 17-01-2011 10:10, Xulei wrote:
> 
> > In FSL sata v2 block, the snoop bit of PRDT Word3 description
> > information is at bit28 instead of bit22.
> 
> > This patch adds FSL sata v2 probe and resolve this difference.
> 
> > Signed-off-by: Xulei <B33228@freescale.com>
> 
>     AFAIK, full name is required.
> 
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> [...]
> 
> > diff --git a/arch/powerpc/boot/dts/p1022ds.dts
> > b/arch/powerpc/boot/dts/p1022ds.dts
> > index 2bbecbb..9ad41dd 100644
> > --- a/arch/powerpc/boot/dts/p1022ds.dts
> > +++ b/arch/powerpc/boot/dts/p1022ds.dts
> > @@ -475,14 +475,14 @@
> >   		};
> >
> >   		sata@18000 {
> > -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
> > +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";

Can we fix this compatibity at run time by u-boot?

> >   			reg =<0x18000 0x1000>;
> >   			cell-index =<1>;
> >   			interrupts =<74 0x2>;
> >   		};
> >
> >   		sata@19000 {
> > -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
> > +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
> >   			reg =<0x19000 0x1000>;
> >   			cell-index =<2>;
> >   			interrupts =<41 0x2>;
> 
>     Please put this into the separate patch and push thru the PPC tree.
> 
> > diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c index
> > b0214d0..a56399a 100644
> > --- a/drivers/ata/sata_fsl.c
> > +++ b/drivers/ata/sata_fsl.c
> [...]
> > @@ -417,7 +420,8 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd
> > *qc)
> >
> >   	if (qc->flags&  ATA_QCFLAG_DMAMAP)
> >   		num_prde = sata_fsl_fill_sg(qc, (void *)cd,
> > -					&ttl_dwords, cd_paddr);
> > +					&ttl_dwords, cd_paddr,
> > +					    host_priv->data_snoop);
> 
>     Please align these lines uniformly.
> 
> WBR, Sergei
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


