From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: Fix ATAPI DMA lost irq problem with CDB intr
 devices
Date: Mon, 22 Jan 2007 14:47:18 +0000
Message-ID: <20070122144718.137ce8eb@localhost.localdomain>
References: <45AF57BE.7060505@tw.ibm.com>
	<58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>
	<45B12318.9000704@gmail.com>
	<45B467A9.6040404@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34726 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751841AbXAVOte (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jan 2007 09:49:34 -0500
In-Reply-To: <45B467A9.6040404@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>

> Instead of adding PCI IDs to the blacklist, could we just unconditionally
> clear the dma_status:INTR in ide_dma_start()?

Possibly. I did the patch to be as safe as possible close to an actual
release. If someone wants to do the general legacy IDE layer testing with
assorted controllers/drives then it would probably be the best approach.
