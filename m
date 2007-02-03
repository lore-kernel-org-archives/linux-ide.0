From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/15] ide: fix UDMA/MWDMA/SWDMA masks
Date: Sat, 03 Feb 2007 19:30:00 +0300
Message-ID: <45C4B888.9050006@ru.mvista.com>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>	 <20070119003226.14846.87052.sendpatchset@localhost.localdomain>	 <45B4E401.6070208@ru.mvista.com> <58cb370e0702021606v4efa6143lf060e6aab9782c35@mail.gmail.com> <45C3D9CE.8020202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5006 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1946490AbXBCQaJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Feb 2007 11:30:09 -0500
In-Reply-To: <45C3D9CE.8020202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>Index: b/drivers/ide/pci/cmd64x.c
>>>===================================================================
>>>--- a/drivers/ide/pci/cmd64x.c
>>>+++ b/drivers/ide/pci/cmd64x.c
>>>@@ -695,9 +695,10 @@ static void __devinit init_hwif_cmd64x(i
>>>      hwif->swdma_mask = 0x07;
>>>
>>>      if (dev->device == PCI_DEVICE_ID_CMD_643)
>>>-             hwif->ultra_mask = 0x80;
>>>+             hwif->ultra_mask = 0x00;
>>>      if (dev->device == PCI_DEVICE_ID_CMD_646)
>>>-             hwif->ultra_mask = (class_rev > 0x04) ? 0x07 : 0x80;
>>>+             hwif->ultra_mask =
>>>+                     (class_rev == 0x05 || class_rev == 0x07) ? 0x07 : 0x00;
>>>      if (dev->device == PCI_DEVICE_ID_CMD_648)
>>>              hwif->ultra_mask = 0x1f;

>>   Hm, well, this doesn't look consistent with the changes in other drivers.
>>This driver asks for explicit hwif->cds->ultra_mask initializers, IMO...
>>   You'd only have to check for PCI-646 revisions < 5 then...

> reworked

    Thanks. :-)

>>>Index: b/drivers/ide/pci/piix.c
>>>===================================================================
>>>--- a/drivers/ide/pci/piix.c
>>>+++ b/drivers/ide/pci/piix.c
>>>              default:
>>>                      if (!hwif->udma_four)
>>>                              hwif->udma_four = piix_cable_detect(hwif);

>>   This one also certainly asks for explicit hwif->cds->ultra_mask
>>initializers... Thus almost all of this switch statement could go away...
  	
> Alas doing it now would make the nice DECLARE_PIIX_DEV() macro go away

    Why? Could add another argument to that macro...

> (=> a lot of duplicated code)... could be done in the future...

    Yes, of course.

> Thanks,
> Bart

MBR, Sergei
