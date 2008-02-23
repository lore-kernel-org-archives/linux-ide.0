From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Date: Sat, 23 Feb 2008 18:48:10 +0100
Message-ID: <19f34abd0802230948n3b98b7d2kd67ca9c2f8fbbd47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:8050 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbYBWRsO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 12:48:14 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1283833wra.23
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 09:48:11 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

I am experiencing a strange problem with 2.6.23.15-137.fc8 (Fedora 8)
kernel. Everything works fine, but if I provide the "nosmp" option to
the kernel, I get some (S)ATA errors and the system does not boot.

Here is a screenshot:
http://folk.uio.no/vegardno/DSCF2543.JPG

Handwritten summary:
scsi0 : ahci
scsi1 : ahci
ata1: SATA max UDMA/133 cmd 0xf884c100 ctl 0x00000000 bmdma 0x000...
ata2: SATA max UDMA/133 cmd 0xf884c180 ctl 0x00000000 bmdma 0x000...
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: port is slow to respond, please be patient (Status 0x80)
ata1: COMRESET failed (errno=-16)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
...

I don't see the connection between (no-)smp and ata. Something with
interrupt routing/IPI, missing irq ack? Booting another !SMP kernel
works fine. The problem also exists in 2.6.24-rc2.


Kind regards,
Vegard Nossum
