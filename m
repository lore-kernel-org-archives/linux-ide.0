From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [patch][0/6] ide: sanitize PIO code, take 2
Date: Mon, 13 Sep 2004 14:16:37 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409131416.37972.bzolnier@elka.pw.edu.pl>
References: <200409110026.20064.bzolnier@elka.pw.edu.pl> <4144EB28.6070401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:48063 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S267391AbUIMOZn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Sep 2004 10:25:43 -0400
In-Reply-To: <4144EB28.6070401@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>

On Monday 13 September 2004 02:34, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > - bugfix: use sg->length instead of sg_dma_len(sg)
> >   (found thanks to rmk's concerns)
> 
> Details?

Unlike libata we don't use DMA API for PIO.

> IIRC this breaks ia64 and/or other platforms?

No pci_[un]map_sg() so sg->length won't be ever changed.

Bartlomiej
