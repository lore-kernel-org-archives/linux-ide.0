From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 0/15] IDE quilt tree updated
Date: Fri, 19 Jan 2007 01:30:58 +0100
Message-ID: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:62361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932788AbXASA1A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jan 2007 19:27:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so322530uga
        for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 16:26:59 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Hi,

I've just updated IDE quilt tree:
	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/


New patches:

* IDE driver for Delkin/Lexar/ASKA/Workbit/etc. CardBus CF adapters
  (Mark Lord <mlord@pobox.com>)

* ACPI support for IDE devices
  (Hannes Reinecke <hare@suse.de>)

* ide: unregister ide-pnp driver on unload
  (Tejun Heo <htejun@gmail.com>)

* via82cxxx/pata_via: correct PCI_DEVICE_ID_VIA_SATA_EIDE ID and add support
  for CX700 and 8237S
  (Josepch Chan <josephchan@via.com.tw>)

* rework of the code selecting the best DMA transfer mode (~500 LOCs less)
  (me)

* some misc fixes/cleanups (me)

diffstat:
 68 files changed, 3310 insertions(+), 2495 deletions(-)


I'm sending only new patches for review/comments.

If you would like to see the full quilt series (or to get combined patch)
against 2.6.20-rc5, they are available here:

       http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/releases/

Thanks,
Bart
