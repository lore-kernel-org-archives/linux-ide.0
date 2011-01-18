From: Zang Roy-R61911 <R61911@freescale.com>
Subject: RE: [PATCH] ATA: Add FSL sata v2 controller support
Date: Tue, 18 Jan 2011 11:43:39 +0000
Message-ID: <2239AC579C7D3646A720227A37E02681090699@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
 <4D342C6E.6000608@ru.mvista.com>
 <2239AC579C7D3646A720227A37E0268109001B@039-SN1MPN1-004.039d.mgd.msft.net>
 <4D357918.4040001@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:32814 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab1ARLnq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2011 06:43:46 -0500
In-Reply-To: <4D357918.4040001@ru.mvista.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Xu Lei-B33228 <B33228@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Gala Kumar-B11780 <B11780@freescale.com>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> Sent: Tuesday, January 18, 2011 19:27 PM
> To: Zang Roy-R61911
> Cc: Sergei Shtylyov; Xu Lei-B33228; linuxppc-dev@lists.ozlabs.org; Gala Kumar-
> B11780; jgarzik@pobox.com; linux-ide@vger.kernel.org
> Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
> 
> Hello.
> 
> On 18-01-2011 6:01, Zang Roy-R61911 wrote:
> 
> >>> In FSL sata v2 block, the snoop bit of PRDT Word3 description
> >>> information is at bit28 instead of bit22.
> 
> >>> This patch adds FSL sata v2 probe and resolve this difference.
> 
> >>> Signed-off-by: Xulei<B33228@freescale.com>
> 
> > [snip]
> 
> >>> diff --git a/arch/powerpc/boot/dts/p1022ds.dts
> >> b/arch/powerpc/boot/dts/p1022ds.dts
> >>> index 2bbecbb..9ad41dd 100644
> >>> --- a/arch/powerpc/boot/dts/p1022ds.dts
> >>> +++ b/arch/powerpc/boot/dts/p1022ds.dts
> >>> @@ -475,14 +475,14 @@
> >>>    		};
> >>>
> >>>    		sata@18000 {
> >>> -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
> >>> +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
> >>>    			reg =<0x18000 0x1000>;
> >>>    			cell-index =<1>;
> >>>    			interrupts =<74 0x2>;
> >>>    		};
> >>>
> >>>    		sata@19000 {
> >>> -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
> >>> +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
> >>>    			reg =<0x19000 0x1000>;
> >>>    			cell-index =<2>;
> >>>    			interrupts =<41 0x2>;
> 
> >>      Please put this into the separate patch and push thru the PPC tree.
> 
> > I agree to put to them to separate patches, but should we
> > pull in the separate patches to one candidate tree to make
> > the function work?
> 
>     I don't understand. What is "candidate tree"?

Powerpc or ide git repository for upstream to mainline.
It is odd that patches for one function in different trees.
Thanks.
Roy

