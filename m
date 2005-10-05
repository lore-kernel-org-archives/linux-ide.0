From: Nick Pasich <newsletters@NickAndBarb.net>
Subject: no device found for TX4000
Date: Wed, 5 Oct 2005 11:05:23 -0700
Message-ID: <20051005180223.GA17900@10.1.0.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.horizonsd.org ([64.154.95.82]:37998 "EHLO
	mail.horizonsd.org") by vger.kernel.org with ESMTP id S1030306AbVJESFd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Oct 2005 14:05:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


Jeff,


I'm running Slackware 10.1 and have compiled linux-2.6.13.3 kernel
with the sata_promise.c as kernel resident.


I received the following in the kernel log:

********************************************************************************
Oct  4 16:51:24 Server05 kernel: ata1: PATA max UDMA/133 cmd 0xF0800200 ctl 0xF0
Oct  4 16:51:24 Server05 kernel: ata2: PATA max UDMA/133 cmd 0xF0800280 ctl 0xF0
Oct  4 16:51:24 Server05 kernel: ata3: PATA max UDMA/133 cmd 0xF0800300 ctl 0xF0
Oct  4 16:51:24 Server05 kernel: ata4: PATA max UDMA/133 cmd 0xF0800380 ctl 0xF0
Oct  4 16:51:24 Server05 kernel: ata1: no device found (phy stat 00000000)
Oct  4 16:51:24 Server05 kernel: scsi1 : sata_promise
Oct  4 16:51:24 Server05 kernel: ata2: no device found (phy stat 00000000)
Oct  4 16:51:24 Server05 kernel: scsi2 : sata_promise
Oct  4 16:51:24 Server05 kernel: ata3: no device found (phy stat 00000000)
Oct  4 16:51:24 Server05 kernel: scsi3 : sata_promise
Oct  4 16:51:24 Server05 kernel: ata4: no device found (phy stat 00000000)
Oct  4 16:51:24 Server05 kernel: scsi4 : sata_promise
********************************************************************************



I then compiled sata_promise.c as a module and received the same message
on a modprobe....


Any help would be appreciated.....


        ---( Nick Pasich )---




