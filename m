From: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Subject: Re: Kernel Oops with 2.6.15
Date: Wed, 04 Jan 2006 10:29:12 +0100
Message-ID: <43BB9568.6010000@bj-ig.de>
References: <43BA8AEE.8010608@bj-ig.de> <43BB3CBA.5010908@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tower.bj-ig.de ([194.127.182.2]:34719 "EHLO fs.bj-ig.de")
	by vger.kernel.org with ESMTP id S1030187AbWADJ3I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jan 2006 04:29:08 -0500
In-Reply-To: <43BB3CBA.5010908@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Albert Lee schrieb:
> It looks like the command is running in PIO polling thread.
> The timeout handler is called and the qc is cleared.
> So, the PIO polling thread got NULL qc.
> 
> Could you post more trace before the timeout occurs, thanks,

Sure. Here it is:

Jan  3 15:21:32 DatenGrab kernel: ata1: command timeout
Jan  3 15:21:32 DatenGrab kernel: ATA: abnormal status 0xFF on port 
0xE006821C
Jan  3 15:21:32 DatenGrab kernel: ata1: translated ATA stat/err 0xff/00 
to SCSI SK/ASC/ASCQ 0xb/47/00
Jan  3 15:21:32 DatenGrab kernel: ata1: status=0xff { Busy }
Jan  3 15:21:32 DatenGrab kernel: ATA: abnormal status 0xFF on port 
0xE006821C
Jan  3 15:21:32 DatenGrab kernel: ATA: abnormal status 0xFF on port 
0xE006821C
Jan  3 15:21:32 DatenGrab kernel: ATA: abnormal status 0xFF on port 
0xE006821C
Jan  3 15:21:32 DatenGrab kernel: ATA: abnormal status 0xFF on port 
0xE006821C
Jan  3 15:21:35 DatenGrab kernel: ata1: unknown timeout, cmd 0xb0 stat 0xff
Jan  3 15:21:35 DatenGrab kernel: ata1: translated ATA stat/err 0xff/00 
to SCSI SK/ASC/ASCQ 0xb/47/00
Jan  3 15:21:35 DatenGrab kernel: ata1: status=0xff { Busy }
Jan  3 15:21:35 DatenGrab kernel: Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_block,line=3216
Jan  3 15:21:35 DatenGrab kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000014
Jan  3 15:21:35 DatenGrab kernel:  printing eip:
Jan  3 15:21:35 DatenGrab kernel: e02d9a3e
Jan  3 15:21:35 DatenGrab kernel: *pde = 00000000
Jan  3 15:21:35 DatenGrab kernel: Oops: 0000 [#1]

