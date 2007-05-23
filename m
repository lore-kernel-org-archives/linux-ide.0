From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide/pci/serverworks.c: Fix corruption/timeouts with MegaIDE in RAID mode
Date: Thu, 24 May 2007 01:44:40 +0200
Message-ID: <200705240144.40334.bzolnier@gmail.com>
References: <20070516133715.23194a96@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:3439 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760738AbXEXBYC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 21:24:02 -0400
Received: by ug-out-1314.google.com with SMTP id 70so758438ugb
        for <linux-ide@vger.kernel.org>; Wed, 23 May 2007 18:24:00 -0700 (PDT)
In-Reply-To: <20070516133715.23194a96@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Wednesday 16 May 2007, Alan Cox wrote:
> It turns out from customer reports to Red Hat and some PCI dumps that the
> MegaIDE in RAID mode doesn't provide the drive tuning data that the
> serverworks driver expects but sometimes does provide something that
> fools the code.
> 
> For the RAID class case skip the oem setup and don't trust the BIOS data.
> We then tune from scratch and this sorts it out. (This has been confirmed
> on an afflicted IBM blade)
> 
> [libata serverworks.c never trusts the BIOS in the first place so is
> accidentally immune]
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied, thanks

> --- drivers/ide/pci/serverworks.c~	2007-05-16 13:10:16.428324088 +0100
> +++ drivers/ide/pci/serverworks.c	2007-05-16 13:10:16.428324088 +0100

-p1 patch fooled quilt import (fixed by hand)
