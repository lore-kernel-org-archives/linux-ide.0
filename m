From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 16/20] ata_piix: add EFAR SLC90E66 support
Date: Tue, 8 Feb 2011 13:13:21 +0000
Message-ID: <20110208131321.6ceb9a43@lxorguk.ukuu.org.uk>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122534.19110.89437.sendpatchset@linux-mhg7.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40996 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752954Ab1BHNJu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 08:09:50 -0500
In-Reply-To: <20110208122534.19110.89437.sendpatchset@linux-mhg7.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 08 Feb 2011 13:25:34 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> >From 11bed7feff5de752c9440ca58b232846b20e2ed6 Mon Sep 17 00:00:00 2001
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Tue, 8 Feb 2011 12:39:28 +0100
> Subject: [PATCH 16/20] ata_piix: add EFAR SLC90E66 support
> 
> Add EFAR SLC90E66 support to ata_piix and remove no longer
> needed pata_efar driver.

Jeff specifically asked that these were not all folded into ata_piix
originally. This also makes memory usage higher and the system less
efficient as these are all motherboard chipsets (except an obscure dual
PIIX4 setup) so you are loading more not less code.

It also leads to hideous uglies in the main code paths like this :

+	unsigned int has_sitre	= (dev->vendor != 0x8086 ||
+				   dev->device != 0x1230);

which also has exactly zero comments.

and it gets better as we go on...

+	unsigned int is_radisys	= (dev->vendor ==
  PCI_VENDOR_ID_RADISYS &&
+				   dev->device == 0x8201);
+	unsigned int has_sitre	= (dev->vendor !=
  PCI_VENDOR_ID_INTEL ||
+				   dev->device != 0x1230) && !is_radisys;


Folding these together just makes no sense at all. The PIO/DMA folds
internally do look sensible, but really should be tested before anything
goes in. The current code works - its slower than it should be because of
core libata bugs, but it works.

Alan
