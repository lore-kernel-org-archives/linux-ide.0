From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: Use IGN_SIMPLEX for ALi
Date: Wed, 13 May 2009 16:15:37 +0200
Message-ID: <200905131615.38013.bzolnier@gmail.com>
References: <20090513135855.11205.36917.stgit@t61.ukuu.org.uk> <200905131532.38811.bzolnier@gmail.com> <20090513144904.1fd2cca9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:16050 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbZEMOLr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 10:11:47 -0400
Received: by an-out-0708.google.com with SMTP id d40so1032257and.1
        for <linux-ide@vger.kernel.org>; Wed, 13 May 2009 07:11:48 -0700 (PDT)
In-Reply-To: <20090513144904.1fd2cca9@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Wednesday 13 May 2009 15:49:04 Alan Cox wrote:
> > [ Sigh, this issue seems to go back to:
> > 
> >   commit 669a5db411d85a14f86cd92bc16bf7ab5b8aa235
> >   Author: Jeff Garzik <jeff@garzik.org>
> >   Date:   Tue Aug 29 18:12:40 2006 -0400
> > 
> >     [libata] Add a bunch of PATA drivers. ]
> 
> No its quite recent actually - broke around 2.6.27
> 
> The libata drivers try and reset the simplex bits to check if a device is
> merely in simplex mode by configuration. Unfortunately on the ALi if you
> put the device into a power saving mode and bring it back the simplex
> bits get corrupted and the register becomes unwritable (even to restore)
> 
> Somewhere around 2.6.27 something started rudely dumping the device into
> power saving mode outside of the ATA layer on certain PCs.
> 
> So we switch to ignoring the bit in the first place on this chip.

Ok, thanks for explaining it.

BTW you may consider removing ata_pci_bmdma_clear_simplex() call
from ali_init_chipset() now (before somebody decides to fix the code
to check the former's function return value).
