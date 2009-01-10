From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017
 ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 10:41:14 +0000
Message-ID: <20090110104114.633cacd8@lxorguk.ukuu.org.uk>
References: <200901091334.55823.borntraeger@de.ibm.com>
	<20090109124412.619330ea@lxorguk.ukuu.org.uk>
	<200901101009.13699.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39608 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753442AbZAJKlM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jan 2009 05:41:12 -0500
In-Reply-To: <200901101009.13699.borntraeger@de.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

> I did some printk debugging. 
> __atapi_pio_bytes is called with bytes=18. That means with 32bit transfers
> there is a 2 byte trailing transfer, which triggers this WARN_ON.

Ouch.. that means all that someone issued a multiple segment data
transfer with a 2 byte aligned chunk in the middle.

That is a bit of a suprise because we set blk_queue_dma_alignment to 3 so
the block layer should never hand us an sg list in that form. That means
we've either got a block layer bug or someone somewhere is generating
invalid sg lists internally to libata.

Can you dump qc->cdb[] and see what command is getting issued in the
broken form ?

Alan
