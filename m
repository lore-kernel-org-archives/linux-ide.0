From: Zang Roy-R61911 <R61911@freescale.com>
Subject: RE: [PATCH] ATA: Add FSL sata v2 controller support
Date: Tue, 18 Jan 2011 03:01:24 +0000
Message-ID: <2239AC579C7D3646A720227A37E0268109001B@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
 <4D342C6E.6000608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:8893
	"EHLO AM1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753444Ab1ARDBu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jan 2011 22:01:50 -0500
In-Reply-To: <4D342C6E.6000608@ru.mvista.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>, Xu Lei-B33228 <B33228@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Gala Kumar-B11780 <B11780@freescale.com>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> Sent: Monday, January 17, 2011 19:48 PM
> To: Xu Lei-B33228
> Cc: linuxppc-dev@lists.ozlabs.org; Gala Kumar-B11780; jgarzik@pobox.com;
> linux-ide@vger.kernel.org; Zang Roy-R61911
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
[snip]

> > diff --git a/arch/powerpc/boot/dts/p1022ds.dts
> b/arch/powerpc/boot/dts/p1022ds.dts
> > index 2bbecbb..9ad41dd 100644
> > --- a/arch/powerpc/boot/dts/p1022ds.dts
> > +++ b/arch/powerpc/boot/dts/p1022ds.dts
> > @@ -475,14 +475,14 @@
> >   		};
> >
> >   		sata@18000 {
> > -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
> > +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
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
I agree to put to them to separate patches, but should we 
pull in the separate patches to one candidate tree to make
the function work?
Thanks.
Roy

