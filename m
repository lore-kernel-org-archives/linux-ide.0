From: Franck Jullien <franck.jullien@gmail.com>
Subject: Problem with Marvell 6121
Date: Mon, 3 Sep 2012 14:55:04 +0200
Message-ID: <CAJfOKBx2jYpcZ7iQnU_wV6dayOxa=yqBnvH9T4cvbt5ABHJupw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50660 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177Ab2ICMzF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2012 08:55:05 -0400
Received: by qcro28 with SMTP id o28so3324932qcr.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Sep 2012 05:55:04 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm using a Marvell 6121 SATA controller on a custom board and this is
what I get at Linux (2.6.26) startup:

ahci 0000:06:00.0: controller can't do NCQ, turning off CAP_NCQ
ahci 0000:06:00.0: MV_AHCI HACK: port_map 7 -> 3
ahci 0000:06:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x3 impl IDE mode
ahci 0000:06:00.0: flags: 64bit stag led pmp slum part
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
ata1: SATA max UDMA/133 abar m1024@0xbf7ffc00 port 0xbf7ffd00 irq 67
ata2: SATA max UDMA/133 abar m1024@0xbf7ffc00 port 0xbf7ffd80 irq 67
ata3: DUMMY
ata1: SATA link down (SStatus 101 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)

The ata1 status says the "Interface is active state" and "Device
present detected but Phy communication is not etablished". What does
it mean ?

The SATA controller is connected to a CFAST card.

I don't know why the link is not up. Do you have any idea ?

BR,
Franck.
