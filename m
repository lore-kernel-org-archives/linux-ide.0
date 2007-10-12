From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
Subject: RE: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps SATA Controller
Date: Fri, 12 Oct 2007 20:06:52 +0530
Message-ID: <2A6F278C5B66C4459AF4013E77A40CD3FCB95E@zin33exm20.fsl.freescale.net>
References: <20071012145522.29dd7413@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:37715 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbXJLOhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Oct 2007 10:37:03 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l9CEau6A009153
	for <linux-ide@vger.kernel.org>; Fri, 12 Oct 2007 07:36:56 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net [10.232.192.5])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9CEarmm012266
	for <linux-ide@vger.kernel.org>; Fri, 12 Oct 2007 09:36:55 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <20071012145522.29dd7413@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, Li Yang-r58472 <LeoLi@freescale.com>, Kalra Ashish-B00888 <ashish.kalra@freescale.com>

This should be fine, as cd->sfis is allocated in host memory using a
_coherent allocator and the SATA-2 controller is
DMA'ing the D2H FIS into it.

Ashish  

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Friday, October 12, 2007 7:25 PM
To: Li Yang-r58472
Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org;
linuxppc-dev@ozlabs.org; Kalra Ashish-B00888; Li Yang-r58472
Subject: Re: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps
SATA Controller

> +	cd = pp->cmdentry + tag;
> +
> +	memcpy(fis, &cd->sfis, 6 * 4);	/* should we use
memcpy_from_io() */

If cd->sfis points at memory over the PCI bus (eg mmio or memory on the
controller card) then you need to use ioread/_io type functions. If
cd->sfis points into host memory where the FIS is delivered by DMA from
the card you will be fine if it was allocated with an _coherent
allocator


Alan
