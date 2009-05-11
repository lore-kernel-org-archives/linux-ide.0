From: Tejun Heo <teheo@novell.com>
Subject: Re: sata_inic162x for help
Date: Mon, 11 May 2009 12:10:29 +0900
Message-ID: <4A079725.1030509@novell.com>
References: <4A062879.7090301@novell.com> <4A04C04F.8030106@novell.com> <6529177.841681241588784941.JavaMail.coremail@bj163app14.163.com> <12087558.131021241843439832.JavaMail.coremail@bj163app14.163.com> <31860758.69421242004829355.JavaMail.coremail@app152.163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=x-gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:57400 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbZEKDJW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 May 2009 23:09:22 -0400
In-Reply-To: <31860758.69421242004829355.JavaMail.coremail@app152.163.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ivorhuang_hjd <ivorhuang_hjd@163.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

ivorhuang_hjd wrote:
> Hello tejun,
> I attach a hard disk to the sata port.I follow your suggestion to do
> that and the hard disk can not be list

Okay, so, it's not a weird device which doesn't support
INIT_DEV_PARAMS.

> in the system.the log is :
> [    0.980937] ata1: SATA max UDMA/133 mmio m4096@0x90000000
> <mailto:m4096@0x90000000> PORT 0x90000000 irq 17
> [    0.988362] ata2: SATA max UDMA/133 mmio m4096@0x90000000
> <mailto:m4096@0x90000000> PORT 0x90000040 irq 17
> [    1.344512] ata1: SATA link down (SStatus 0 SControl 300)
> [    1.856516] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.862752] err happen
> [    1.865228] ata2.00: ATA-0: , , max PIO0
> [    1.869177] ata2.00: 0 sectors, multi 0, CHS 0/0/0
> [    1.874021] ata2.00: applying bridge limits
> [    1.878293] err happen
> [    1.880856] ata2.00: configured for PIO0
> [    1.885377] scsi 1:0:0:0: Direct-Access     ATA                      
> n/a  PQ: 0 ANSI: 5
> [    1.894782] sd 1:0:0:0: [sda] Very big device. Trying to use READ
> CAPACITY(16).
> [    1.902302] sd 1:0:0:0: [sda] 0 512-byte hardware sectors: (0 B/0 B)
> [    1.908861] sd 1:0:0:0: [sda] Write Protect is off
> [    1.914060] sd 1:0:0:0: [sda] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
> [    1.924325] sd 1:0:0:0: [sda] Attached SCSI disk
>  
> I think the problem is that the dirver can not execute sata command
> properly,for the program exit at this:
>  sata_inic162x.c line 578 :
> if (!(tf.command & ATA_ERR))
>   return false;
> Can you tell me what cause this?

There can be many different causes for such failures.  The interesting
thing is that INIT_DEV_PARAMS is a NODATA command so it's more likely
something is else wrong.  Looking at the above log, it seems like the
IDENTIFY data is all zero which can explain ATA_ERR failure as
INIT_DEV_PARAMS would have been issued with the wrong parameters.

The difference between the old version and the current version is that
now sata_inic162x uses DMA transfer everything including PIO commands
like IDENTIFY.  It looks like for whatever reason DMA transfer isn't
working on your machine.

Thanks.

-- 
tejun
