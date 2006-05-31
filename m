From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH, review] IDE driver for MIPS Toshiba RBTX4939
Date: Wed, 31 May 2006 21:33:23 +0400
Message-ID: <447DD363.1070206@ru.mvista.com>
References: <20050929162228.GS18074@smtp.west.cox.net> <58cb370e0510030917q2bcb1790g6b9cd0456525bfae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:30356 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751762AbWEaReT
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 13:34:19 -0400
In-Reply-To: <58cb370e0510030917q2bcb1790g6b9cd0456525bfae@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> On 9/29/05, Tom Rini <trini@kernel.crashing.org> wrote:

>>Hello.  I'm submitting, mainly for review (questions, comments, etc) the
>>IDE driver for the MIPS-based Toshiba RBTX4939.  In some private emails
>>with Bartlomiej about the ide-dma changes, I understand there's at least
>>one problem with the driver (happy to fix with a pointer to a good
>>example).  And I see real quickly there's a few style things a
>>Lindent'ing would fix.  Thanks.

>>Signed-off-by: Hiroshi DOYU <hdoyu@mvista.com>
>>Signed-off-by: Tom Rini <trini@kernel.crashing.org>

>>Index: linux-2.6.10/drivers/ide/ide-cd.c
>>===================================================================
>>--- linux-2.6.10.orig/drivers/ide/ide-cd.c
>>+++ linux-2.6.10/drivers/ide/ide-cd.c
>>@@ -678,6 +678,13 @@ static int cdrom_decode_status(ide_drive
>>        err = HWIF(drive)->INB(IDE_ERROR_REG);
>>        sense_key = err >> 4;
>>
>>+#if defined(CONFIG_BLK_DEV_IDE_TX4939)
>>+        if (IS_IDE_TX4939) {
>>+               extern void tx4939_ide_softreset(ide_drive_t*);
>>+               tx4939_ide_softreset(drive);
>>+        }
>>+#endif
>>+

> Why is this needed?

> Moreover if you really need to hook into device driver please add
> generic interface (i.e. hwif->atapi_softreset) not chipset specific #fidefs.

>>        if (rq == NULL) {
>>                printk("%s: missing rq in cdrom_decode_status\n", drive->name);
>>                return 1;
>>@@ -3254,7 +3261,12 @@ int ide_cdrom_setup (ide_drive_t *drive)
>>        info->changer_info      = NULL;
>>        info->last_block        = 0;
>>        info->start_seek        = 0;
>>-
>>+#ifdef CONFIG_BLK_DEV_IDE_TX4939
>>+       {
>>+               extern void tx4939_ide_cdrom_setup(ide_drive_t *drive);
>>+               tx4939_ide_cdrom_setup(drive);
>>+       }
>>+#endif

> ditto

    Not sure that this was needed at all. At laest I've manget to do witjout 
it in another, alike Toshiba driver (still hoping to submit it some day). 
Maybe I'll try to resubmit this driver as well since the ATAPI support in it 
appeared to be buggy anyway...

>>Index: linux-2.6.10/drivers/ide/ide-dma.c
>>===================================================================
>>--- linux-2.6.10.orig/drivers/ide/ide-dma.c
>>+++ linux-2.6.10/drivers/ide/ide-dma.c
>>@@ -856,7 +856,8 @@ int ide_mapped_mmio_dma (ide_hwif_t *hwi
>>        printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
>>
>>        hwif->dma_base = base;
>>-       if (hwif->cds->extra && hwif->channel == 0)
>>+
>>+       if (hwif->cds && hwif->cds->extra && hwif->channel == 0)
>>                hwif->dma_extra = hwif->cds->extra;
>>
>>        if(hwif->mate)
>>@@ -875,7 +876,7 @@ int ide_iomio_dma (ide_hwif_t *hwif, uns
>>                return 1;
>>        }
>>        hwif->dma_base = base;
>>-       if ((hwif->cds->extra) && (hwif->channel == 0)) {
>>+       if (hwif->cds && (hwif->cds->extra) && (hwif->channel == 0)) {
>>                request_region(base+16, hwif->cds->extra, hwif->cds->name);
>>                hwif->dma_extra = hwif->cds->extra;
>>        }

    This is due to erroneous use of ide_setup_dma(), should disappear.

>>Index: linux-2.6.10/drivers/ide/ide.c
>>===================================================================
>>--- linux-2.6.10.orig/drivers/ide/ide.c
>>+++ linux-2.6.10/drivers/ide/ide.c
>>@@ -2151,6 +2151,15 @@ static void __init probe_for_hwifs (void
>>                swarm_ide_probe();
>>        }
>> #endif /* CONFIG_BLK_IDE_SWARM */
>>+#ifdef CONFIG_BLK_DEV_IDE_TX4939
>>+       {
>>+               extern void tx4939_ide_init(int ch);
>>+               tx4939_ide_init(0);
>>+#ifdef CONFIG_TOSHIBA_TX4939_MPLEX_ATA1
>>+               tx4939_ide_init(1);
>>+#endif

> CONFIG_TOSHIBA_TX4939_MPLEX_ATA1 should be checked
> inside ide-tx4939.c and tx4939_ide_init() should take 'void' argument.

    Yes, this was horrible. As well as any Toshiba IDE driver seen by me so 
far... :-)

>>Index: linux-2.6.10/drivers/ide/mips/ide-tx4939.c
>>===================================================================
>>--- /dev/null
>>+++ linux-2.6.10/drivers/ide/mips/ide-tx4939.c

>>+/* wait for transfer end */
>>+static u16 wait_transfer_end[2];
>>+
>>+#define IS_ATAPI(drive) ((drive)->media == ide_cdrom || (drive)->media == ide_scsi)

> What about ide_optical / ide_floppy / ide_tape?

    This driver is prepared to handle only CD-ROMs I guess...

>>+#define GET_CH(hwif) (hwif->irq == TX4939_IRQ_ATA(0) ? 0 : 1)
> 
> What about using hwif->channel instead?

>>+void tx4939_ide_softreset(ide_drive_t * drive)
>>+{
>>+       int ch = GET_CH(HWIF(drive));

> Please don't use HWIF() and HWHROUP() macros.

    Hm, what's wrong with them (I stuck to using them in the HighPoint driver 
rewrite)?

>>+       sc_port = (!is_slave) ?
>>+               data_port + TX4939_ATA_SYSTEM_CONTROL1_OFFSET :
>>+               data_port + TX4939_ATA_SYSTEM_CONTROL2_OFFSET;
>>+
>>+       if (!hwif->channel) {   /* primary */

> Why only primary channel is tuned?

    You won't believe: it's single channel, and that's how Toshiba deals with 
this. :-)
    Worse still: this controller has only _one_ timing register for both 
master and slave, and doesn't define selectproc!  Though wait, they prefer to 
handle this in tx4939_ide_outb(). The driver seems even more broken-minded 
than I initially thought... And that tuneproc() stupidity where they're 
clearing the  DMA mode...

>>+       err = ide_config_drive_speed(drive, speed);
>>+
>>+       return err;
>>+}
>>+
>>+/* called from ide_cdrom_setup */
>>+void tx4939_ide_cdrom_setup(ide_drive_t * drive)

> Some comment why this is needed would be helpful.

    To set the sector size, IIUC. The stupid DMA engine relies on that.

>>+{
>>+       unsigned int ch = GET_CH(HWIF(drive));
>>+       ide_hwif_t *hwif = HWIF(drive);
>>+       int is_slave = (&hwif->drives[1] == drive);
>>+
>>+       if (!is_slave)
>>+               reg_wr16(&tx4939_ataptr(ch)->xfer_cnt1, CD_FRAMESIZE / 2);      /* word, not byte */
>>+       else
>>+               reg_wr16(&tx4939_ataptr(ch)->xfer_cnt2, CD_FRAMESIZE / 2);
>>+}
>>+
>>+/* called from cdrom_transfer_packet_bytes */

> This is no such function in the current kernel tree.

    I guess the driver was taken from 2.4, and thrown into 2.6...

>>+static void
>>+tx4939_ide_atapi_output_bytes(ide_drive_t * drive, void *buffer,
>>+                               unsigned int bytecount)

> Some comment why this is needed would be helpful.

    To feed the ATAPI packet to device. That thing is totally broken-minded -- 
makes ATAPI device non-writeable. And in addition, it's not even necessary, 
IIUC... Toshiba just can't do it... :-(

>>+               reg_wr16(&tx4939_ataptr(ch)->sec_cnt, nframes);

>>+               if (!is_slave)
>>+                       reg_wr16(&tx4939_ataptr(ch)->xfer_cnt1, CD_FRAMESIZE / 2); /* word, not byte */
>>+               else
>>+                       reg_wr16(&tx4939_ataptr(ch)->xfer_cnt2, CD_FRAMESIZE / 2);

> Can't tx4939_ide_cdrom_setup() be used here?

    Sure, it can. But actually, one shouldn't even bother with the sector 
sizes leaving tham 512, IIUC...

>>+       hwif->mwdma_mask = 0x07;
>>+       hwif->swdma_mask = 0x07;
>>+
>>+       hwif->mmio = 0;
>>+
>>+       /* cable(PDIAGN) check */
>>+       if (!(hwif->udma_four)) {
>>+               unsigned int pdiagn;
>>+               /* bit13(PDIAGN) = 0:(80pin cable) 1:(40pin cable) */
>>+               pdiagn = (reg_rd16(&tx4939_ataptr(ch)->sysctl1) & TX4939_ATA_SC_PDIAGN);
>>+               hwif->udma_four = pdiagn ? 0 : 1;
>>+       }

> Please move cable detection into a separate function.

    What's the point? Cable detection is not the driver method for a long time 
already...

>>+       hwif->atapi_output_bytes = &tx4939_ide_atapi_output_bytes;

    Never ever think of hooking this...

>>+       dma_base = TX4939_ATA_REG(ch) + TX4939_ATA_DMA_BASE_OFFSET  - mips_io_port_base;
>>+       ide_setup_dma(hwif, dma_base, 8);

> ide_setup_dma() also requires CONFIG_BLK_DEV_IDEDMA_PCI
> ("depends on BLK_DEV_IDEDMA_PCI" in Kconfig) and it also needs
> hwif->pci_dev for mapping S/G table but TX4939 doesn't have PCI
> associated device, right?.

    Right, that code is just b0rked...

> BTW Is there any documentation available for TX4939?

    The datasheet is here:

http://www.semicon.toshiba.co.jp/td/en/64bit_Microprocessor/TX49/en_20051108_TX4939XBG-400_datasheet.pdf

MBR, Sergei
