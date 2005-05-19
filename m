From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: NULL pointer dereference in ide_drive_remove.
Date: Thu, 19 May 2005 15:35:38 +0200
Message-ID: <428C962A.2000308@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:61201 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S262494AbVESNfn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 May 2005 09:35:43 -0400
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id 2C87D2F017
	for <linux-ide@vger.kernel.org>; Thu, 19 May 2005 15:35:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 213851193C
	for <linux-ide@vger.kernel.org>; Thu, 19 May 2005 15:35:42 +0200 (CEST)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 6B9BB9A12
	for <linux-ide@vger.kernel.org>; Thu, 19 May 2005 15:35:41 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi there,

(This is my first post to this list! Bear with me.)

I am working on PCMCIA IDE on an embedded ARM board (2.6.12-rc4).

After doing

~ # umount /mnt/pcmcia
~ # cardctl eject

the board crashes with

Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = c08e8000
[00000010] *pgd=208ef031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in:
CPU: 0
PC is at ide_drive_remove+0x44/0x64
LR is at ide_drive_remove+0x48/0x64
...
Process cardctl (pid: 773, stack limit = 0xc0d54194)
...
Backtrace:
(ide_drive_remove+0x0/0x64) from (device_release_driver+0x70/0x80)
(device_release_driver+0x0/0x80) from (bus_remove_device+0x58/0x90)
(bus_remove_device+0x0/0x90) from (device_del+0x68/0x9c)

I added a few debug outputs and noticed that the call stack is

IDE: ide_unregister(639)
IDE: ide_unregister_subdriver(2094)
IDE: ide_unregister_subdriver(2096): drive=hda, driver=ide-disk
IDE: auto_remove_settings(1092)
IDE: ide_hwif_release_regions(494)
IDE: ide_drive_remove(2127)
IDE: ide_drive_remove(2133): ERROR: DRIVER(drive)=00000000 !!!

In ide_unregister_subdriver() I found

	drive->driver = NULL;

so of corse if ide_drive_remove() is called later DRIVER(drive) is NULL and 
DRIVER(drive)->cleanup(drive) crashes.

So maybe you want to do a check like

	if (DRIVER(drive))
		DRIVER(drive)->cleanup(drive);

in drivers/ide/ide.c:ide_drive_remove().

Please CC me as I am not subscribe to the list.

-- 
Steven
