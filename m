From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: porting IDE patches to PATA driver
Date: Fri, 26 Jun 2009 17:21:43 +0100
Message-ID: <20090626172143.3fe6a59c@lxorguk.ukuu.org.uk>
References: <323951117.20090625100956@web.de>
	<20090625092324.2dd4de5a@lxorguk.ukuu.org.uk>
	<14164712.20090625103834@web.de>
	<20090625100542.525dba02@lxorguk.ukuu.org.uk>
	<951976828.20090625123021@web.de>
	<20090625122958.510c28ad@lxorguk.ukuu.org.uk>
	<96179821.20090626152440@web.de>
	<20090626144639.4bc822b8@lxorguk.ukuu.org.uk>
	<792909512.20090626164052@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48800 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752114AbZFZQUU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jun 2009 12:20:20 -0400
In-Reply-To: <792909512.20090626164052@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Martynov <andrei.martynov@web.de>
Cc: linux-ide@vger.kernel.org

> Correct, libata does call corresponding interface and the functions
> are defined for the cpu. But this architecture is buggy. It is
> necessary to clean (write back) complete cache before DMA write
> operation even if the corresponding range is already cleaned,
> otherwise few bytes in the written block are corrupted at random
> offset. I've spent many days playing with dma interface and even
> calculating md5sum of every written block before I had to accept this
> fact.

In which case you ultimately want to fix the architecture defintions for
the DMA cohrency really but thats a side issue as it doesn't explain the
MWDMA problem. The source you posted has MWDMA undefined which makes me
wonder if it matches the binary your dmesg is from. It's also possible
some of the other fixes in that code are relevant to MWDMA - certainly
your driver looks sane.

> controller switches to a specific DVD-LOADER mode as soon as kernel
> sends any command to the slave device, so they had to patch sources
> and add a strange looking command
> 
> OUT_BYTE((head|drive->select.all) & ~(1<<4), IDE_SELECT_REG);
> 
> everywhere the slave device is accessed to cheat the controller and
> let it believe it talks to the master. Slave device remains active
> because it was already selected but the controller assumes we are
> talking to the master and does not switch to DVD-LOADER mode.

That can be done in a libata driver by providing your own exec_command
functions but again could wait. Try something like

static void my_sff_exec_command(struct ata_port *ap, const struct
	ata_taskfile *tf)
{
	iowrite8(tf->command, ap->ioaddr.command_addr);
	if (tf->flags & ATA_TFLAG_DEVICE)
		iowrite8(tf->device & ~ATA_DEV1, ap->ioaddr.device_addr);
	ata_sff_pause(ap);
}

	.sff_exec_command = my_sff_exec_command,


