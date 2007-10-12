From: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: RE: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps SATA Controller
Date: Fri, 12 Oct 2007 22:31:06 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B582F@zch01exm26.fsl.freescale.net>
References: <1192196849-24758-1-git-send-email-leoli@freescale.com> <20071012145522.29dd7413@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:35702 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbXJLObQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Oct 2007 10:31:16 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l9CEV8ho006752
	for <linux-ide@vger.kernel.org>; Fri, 12 Oct 2007 07:31:08 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9CEV66Z020816
	for <linux-ide@vger.kernel.org>; Fri, 12 Oct 2007 09:31:07 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <20071012145522.29dd7413@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, Kalra Ashish-B00888 <ashish.kalra@freescale.com>

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
> Sent: Friday, October 12, 2007 9:55 PM
> To: Li Yang-r58472
> Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org; 
> linuxppc-dev@ozlabs.org; Kalra Ashish-B00888; Li Yang-r58472
> Subject: Re: [PATCH v2] drivers/ata: add support to Freescale 
> 3.0Gbps SATA Controller
> 
> > +	cd = pp->cmdentry + tag;
> > +
> > +	memcpy(fis, &cd->sfis, 6 * 4);	/* should we use 
> memcpy_from_io() */
> 
> If cd->sfis points at memory over the PCI bus (eg mmio or 
> memory on the controller card) then you need to use 
> ioread/_io type functions. If
> cd->sfis points into host memory where the FIS is delivered 
> by DMA from
> the card you will be fine if it was allocated with an 
> _coherent allocator

Thanks for the clarification.  So the code here is ok, that we use
command descriptor from dma_alloc_coherent().  :)

- Leo
