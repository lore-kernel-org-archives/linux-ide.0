From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Sata-MV, Intergated Sata Device Support
Date: Mon, 25 Feb 2008 18:40:51 -0500
Message-ID: <47C35203.20402@garzik.org>
References: <1176673884.5109.30.camel@Desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55792 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756120AbYBYXkx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 18:40:53 -0500
In-Reply-To: <1176673884.5109.30.camel@Desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jon@ngndg.com, LKML <linux-kernel@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Saeed Bishara <saeed@marvell.com>

Jon Li wrote:
> Hello,
> 
> I am curious as to whether there are plans to add support for integrated
> sata devices.  I personally want to add support for a 60x1C0 based
> device (pci:id = 0x5182).  I think adding support should be relatively
> simple, except for a few issues outlined below.
> 
> In the original mvSata.c (ver3.4) that has 0x5182 support, the config
> space is as such:
> 
> case MV_SATA_DEVICE_ID_5182:
>         pAdapter->numberOfChannels = MV_SATA_5182_PORT_NUM;
>         pAdapter->numberOfUnits = 1;
>         pAdapter->portsPerUnit = 2;
>         pAdapter->sataAdapterGeneration = MV_SATA_GEN_IIE;
>         /*The integrated sata core chip based on 60x1 C0*/
>         pAdapter->chipIs60X1C0 = MV_TRUE;
>         pAdapter->hostInterface = MV_HOST_IF_INTEGRATED;
>         pAdapter->mainMaskOffset = 0x20024; /*the iobaseaddress is
> 0x60000*/
>         pAdapter->mainCauseOffset = 0x20020;
>         break;
> 
> I have not yet figured out how all these values are defined in sata-mv.c
> (ver 0.8).  Specifically, where do I define "numberOfChannels" which
> should equal 2, and "numberOfUnits" which obviously equals 1?
> 
> I have a current config space (not completed) for sata-mv.c which is:
> 
> 	{  /* chip_5182 */
> 		.sht		= &mv_sht,
> 		.flags		= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
> 				   MV_FLAG_DUAL_HC),
> 		.pio_mask	= 0x1f,	/* pio0-4 */
> 		.udma_mask	= 0x7f,	/* udma0-6 */
> 		.port_ops	= &mv6_ops,
> 	},
> 
> I believe according to the new structure in sata-mv.c,
> HC_MAIN_IRQ_CAUSE_OFS should equal 0x20020 and HC_MAIN_IRQ_MASK_OFS
> should equal 0x20024 for the 0x5182 device.
> 
> My final question is how to implement the MV_HOST_IF_INTEGRATED flag?
> Is this already implemented and renamed in sata-mv.c?  Or do I need to
> also add the routines?

I just wanted to point the current sata_mv hackers to this message from 
April 2007...

	Jeff



