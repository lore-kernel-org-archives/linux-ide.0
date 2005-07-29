From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Crash in ide_do_request() on card removal
Date: Fri, 29 Jul 2005 14:01:52 +0200
Message-ID: <42EA1AB0.6070001@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:26131 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S262560AbVG2MB5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jul 2005 08:01:57 -0400
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id 3D2022F016
	for <linux-ide@vger.kernel.org>; Fri, 29 Jul 2005 14:01:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 3192012157
	for <linux-ide@vger.kernel.org>; Fri, 29 Jul 2005 14:01:54 +0200 (CEST)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 546A41203F
	for <linux-ide@vger.kernel.org>; Fri, 29 Jul 2005 14:01:53 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi there,

when surprisingly removing a CF ATA card (without unmounting before) I sometimes 
get kernel crashes in ide_do_request() (linux-2.6.13-rc4 on ARM):

cardmgr[194]: shutting down socket 0
cardmgr[194]: executing: './ide stop hda'
cardmgr[194]: + umount -v /dev/hda1
Assertion '(hwgroup->drive)' failed in drivers/ide/ide-io.c:ide_do_request(1130)
Assertion '(drive)' failed in drivers/ide/ide-io.c:choose_drive(1035)
Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = c0e34000
[00000010] *pgd=20eb0031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in: ide_cs pcmcia at91_cf pcmcia_core
CPU: 0
PC is at ide_do_request+0x100/0x480
LR is at 0x1
pc : [<c00f9980>]    lr : [<00000001>]    Not tainted
...

As the assertions show "drive" is NULL (due to the card removal?) and thus the 
kernel crashes ...

Upon card removal the pcmcia cardmgr tries to unmount the drive which disapeared.

("sometimes" above means that the rest of the time the kernel is not dumping 
core, but the umount process hangs forever.)

Is this a kernel bug?

-- 
Steven
