From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [ANNOUNCE] IDE quilt tree updated
Date: Sat, 03 Feb 2007 14:44:11 +0100
Message-ID: <20070203134411.2491.57713.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:1462 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbXBCNjS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 08:39:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so974778uga
        for <linux-ide@vger.kernel.org>; Sat, 03 Feb 2007 05:39:17 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Hi,

I've just updated IDE quilt tree:
	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/


New patches:

* ide-floppy: Fix unformatted media crash
  (Alan Cox <alan@redhat.com>)

* ide: clear bmdma status in ide_intr() for ICHx controllers (revised #4)
* ide: remove clearing bmdma status from cdrom_decode_status() (rev #4)
  (Albert Lee <albertcc@tw.ibm.com>)

* siimage: PIO1/2 taskfile transfer overclocking fix
* pdc202xx_old: fix PIO mode setup
* sl82c105: DMA support fixes
  (Sergei Shtylyov <sshtylyov@ru.mvista.com>)

+ some patches got fixed according to the feedback from Sergei

Also the order of the patches in the series file was changed to be more
like this: fixes first, then new drivers/features and cleanups at the end.

diffstat:
 62 files changed, 3349 insertions(+), 2496 deletions(-)

If you would like to see the full quilt series (or to get combined patch)
against 2.6.20-rc7, they are available here:

       http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/releases/

Oh, and IDE tree TODO is now available here:

	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/TODO

Thanks,
Bart
