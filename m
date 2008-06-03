From: vb <vb@vsbe.com>
Subject: Mounting CF flash card in 2.6.25
Date: Mon, 2 Jun 2008 19:06:18 -0700
Message-ID: <f608b67d0806021906g3020db3bve6515cbc8c7d99b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:38872 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbYFCCGT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 22:06:19 -0400
Received: by py-out-1112.google.com with SMTP id p76so629373pyb.10
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2008 19:06:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello linux-ide people,

I am trying to bring up a system with a CF card (wired in True IDE
mode) on a powerpc platform under 2.6.25 control.

The following flags are enabled in the config (among many others, naturally):

CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y
CONFIG_SCSI_WAIT_SCAN=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_PATA_PLATFORM=y
CONFIG_PATA_OF_PLATFORM=y


I am trying to bring up a system initrd, as I have a CF card installed
with the appropriate userland on it. When the kernel boots up I see
the following (again, along with a lot of other stuff):

scsi0 : pata_platform
ata1: PATA max PIO6 mmio cmd 0xfc000000 ctl 0xfc00020c irq 20
ata1.00: CFA: CF 512MB, 06/07/29, max PIO4
ata1.00: 1028160 sectors, multi 0: LBA
ata1.00: configured for PIO
ata1.00: configured for PIO
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      CF 512MB         06/0 PQ: 0 ANSI: 5


which tells me that the card is being recognized. However, there is no
appropriate device get created in the /dev directory. Examining
major_names[] I see that only

ramdisk
loop
mtdblock

are created, but there is nothing of the kind /dev/{ata,scsi,ide}, so
attempts to mount the CF fail.

I must be missing something very basic, but I just can't get what it
is, and don't seem to be able to find any documentation on how this is
supposed to work.

I see that there are drivers for CF cards in
drivers/ata/pata_{pcmcia,rb500_cf,ixp4xx_cf}.c, but I was under
impression that the one in pata_of_platform is supposed to do for a
generic CF card.

What needs to be done to get the device created and mapped to  a
generic CF card?

I would really appreciate any hints here, as this thing makes me
slowly lose the remains of the sanity I once had:-)

Thank you in advance,

Vadim

PS. And I promise to write a Wiki page or HOWTO once this issue is resolved.
