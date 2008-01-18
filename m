From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Fri, 18 Jan 2008 17:14:49 +0300
Message-ID: <4790B459.3000407@ru.mvista.com>
References: <200801172150.57059.asalnikov@ru.mvista.com> <20080117232303.3f34c87a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5462 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757460AbYARON7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Jan 2008 09:13:59 -0500
In-Reply-To: <20080117232303.3f34c87a@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Anton Salnikov <asalnikov@ru.mvista.com>, linux-ide@vger.kernel.org, bzolnier@gmail.com

Hello.

Alan Cox wrote:

>>This is Palmchip BK3710 IDE controller support for kernel version 2.6.24-rc8.
>>The IDE controller logic supports PIO, multiword DMA and ultra-DMA modes.
>>Supports interface to compact Flash (CF) configured in True-IDE mode.

> New drivers should really be going at least parallel into drivers/ata and
> legacy IDE.

    Alas, it's unlikely that we can spend more time on developing libata 
equivalent which we don't need at this point.

>>+struct palm_bk3710_ideconfigregs {
>>+	unsigned short idetimp __attribute__((packed));
>>+	unsigned short idetims __attribute__((packed));
>>+	unsigned char sidetim;
>>+	unsigned short slewctl __attribute__((packed));
>>+	unsigned char idestatus;
>>+	unsigned short udmactl __attribute__((packed));
>>+	unsigned short udmatim __attribute__((packed));
>>+	unsigned char rsvd0[4];
>>+	unsigned int miscctl __attribute__((packed));
>>+	unsigned int regstb __attribute__((packed));

> NAK - the size of an unsigned int in the kernel isn't defined. All the
> packed stuff is also horribly platform dependant. True the driver is ARM
> only currently but that doesn't make it a good idea.

> Can't you use defined offsets ?

>>+struct palm_bk3710_ideregs {
>>+	struct palm_bk3710_dmaengineregs dmaengine;

> So why are only some packed ?

>>+		/* udmatim Register */
>>+		palm_bk3710_base->config.udmatim &= 0xFFF0;
>>+		palm_bk3710_base->config.udmatim |= level;

> Direct memory access to I/O space - should be using read/write functions

    Sigh, I was anticipationg that somebody would say that... :-)

>>+	if (mate && mate->present) {
>>+		u8 mode2 = ide_get_best_pio_mode(mate, 255, 4);

> If the pair device is present but not in the best mode it can do this
> will be wrong surely ?

    Why?  ATA/PI says in the note to the table "Register transfer to/from device":

5 Mode shall be selected no higher than the *highest* mode supported by the 
*slowest* device.

    Some other drivers are already using the same code (I'm not even sure it's 
needed here -- never saw the chip documentation).

>>+	if (!request_region(mem->start, 8, palm_bk3710_hwif->name)) {
>>+		printk(KERN_ERR "Error, ports in use.\n");
>>+		return -EBUSY;
>>+	}
>>+
>>+	palm_bk3710_hwif->dmatable_cpu = dma_alloc_coherent(
>>+				NULL,
>>+				PRD_ENTRIES * PRD_BYTES,
>>+				&palm_bk3710_hwif->dmatable_dma,
>>+				GFP_ATOMIC);
>>+
>>+	if (!palm_bk3710_hwif->dmatable_cpu) {

> Leaks the reserved region

    My bad -- I've managed to overlook this while reviewing.

>>+		printk(KERN_ERR "Error, unable to allocate DMA table.\n");
>>+		return -ENOMEM;
>>+	}

>>-static void ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
>>+void ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
>> {
>> 	/* issue cmd to drive */
>> 	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, 
>>dma_timer_expiry);
>> }
>>+EXPORT_SYMBOL(ide_dma_exec_cmd);

> These are not needed the NULL default request will fill them in for you

    It won't -- we can *not* call ide_setup_dma() which fills them out as this 
is not a PCI chip.

MBR, Sergei
