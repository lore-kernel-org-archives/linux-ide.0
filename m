From: Dan Williams <dan.j.williams@gmail.com>
Subject: [sata_vsc] irq nobody cared problem
Date: Mon, 12 Dec 2005 18:58:22 -0700
Message-ID: <e9c3a7c20512121758q532d2ddds8e655d47b670428b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:55441 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932348AbVLMB6X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Dec 2005 20:58:23 -0500
Received: by wproxy.gmail.com with SMTP id i21so1365612wra
        for <linux-ide@vger.kernel.org>; Mon, 12 Dec 2005 17:58:23 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Hello I am attempting to use the sata_vsc driver.  When loading the
module I receive "irq25 nobody cared" messages indefinitely.  The
problem arises from the line:

if (qc && (!(qc->tf.ctl & ATA_NIEN)))

Debug shows that qc->tf.ctl & ATA_NIEN == 1

>From what I can glean from the code we should not be receiving
interrupts because according to ata_host_intr() only DMA interrupts
are handled.

I had success with the Intel maintained non-libata driver from
http://sourceforge.net/projects/gd31244.  However I would like to
understand where sata_vsc is going wrong.

Not sure if it is relevant, but vsc_sata_interrupt() is only seeing
interrupts reported on the first port, ports 2 and 3 which are also
attached to disks don't take this branch:

if (int_status & ((u32) 0xFF << (8 * i)))

Configuration details:
Arch: Intel IOP (ARM based)
HBA: IQ3124H
Kernel: v2.6.14.3

Regards,

Dan
