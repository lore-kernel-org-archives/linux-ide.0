From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC]hpt366/ide-probe  reset drive on probe error.
Date: Fri, 08 May 2009 18:57:39 +0400
Message-ID: <4A044863.5090805@ru.mvista.com>
References: <4A0052EB.6040502@hiramoto.org> <200905081550.11297.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34590 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752344AbZEHO5P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 10:57:15 -0400
In-Reply-To: <200905081550.11297.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Karl Hiramoto <karl@hiramoto.org>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>Hi,

>>Part of this patch (htp366.c) is commented in an #if 0   in older 
>>kernels.   2.6.11 for sure.

    ... and for a reason.

>>I have an ARM IXP4xx based board with CompactFlash slot that this patch 
>>fixes some issues for.    I think the case, is only with a warm boot, 
>>where the drive was busy before the board was reset.   There is  no 
>>BIOS, only the redboot loader which loads the kernel.

>>A few questions:

>>1.  Would this be considerd to be brought into mainline?

> When it comes to ide-probe.c changes: yes given that you split them on
> smaller patches.  hpt366.c change also seems to be correct on the first
> glance but I think that Sergei's opinion would be more suited here.

    Frankly speaking, I don't quite understand this patch.

[...]

>>--
>>Karl
>>
>>diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
>>index 3377766..ba4b802 100644
>>--- a/drivers/ide/hpt366.c
>>+++ b/drivers/ide/hpt366.c
>>@@ -1280,6 +1280,31 @@ static u8 hpt3xx_cable_detect(ide_hwif_t *hwif)
>> 	return (scr1 & ata66) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
>> }
>> 
>>+/** routine to reset disk
>>+ *
>>+ * Since SUN Cobalt is attempting to do this operation, I should disclose
>>+ * this has been a long time ago Thu Jul 27 16:40:57 2000 was the patch date
>>+ * HOTSWAP ATA Infrastructure.

    This comment doesn't really belong to resetproc() method, it rather 
belongs to (now gone) tristate() method.

>>+ */
>>+
>>+static void hpt3xx_reset (ide_drive_t *drive)

    No spaces allowed before '('. Use scripts/checkpatch.pl please.

>>+{
>>+	ide_hwif_t *hwif = drive->hwif;
>>+	struct pci_dev *dev = to_pci_dev(hwif->dev);
>>+	unsigned long high_16;
>>+	u8 reset;
>>+	u8 reg59h = 0;
>>+
>>+	printk(KERN_INFO "%s reset drive channel %d\n", __func__, hwif->channel);
>>+	high_16 = pci_resource_start(dev, 4);

    Useless variable.

>>+
>>+	reset = hwif->channel ? 0x80 : 0x40;

    These HighPoint's "soft reset" (WTF does that mean I wonder?) bits are 
not the same between HPT366 and HPT370, so this code doesn't look right...

>>+
>>+	pci_read_config_byte(dev, 0x59, &reg59h);
>>+	pci_write_config_byte(dev, 0x59, reg59h|reset);
>>+	pci_write_config_byte(dev, 0x59, reg59h);
>>+}
>>+
>> static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
>> {
>> 	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
>>@@ -1406,6 +1431,7 @@ static const struct ide_port_ops hpt3xx_port_ops = {
>> 	.set_pio_mode		= hpt3xx_set_pio_mode,
>> 	.set_dma_mode		= hpt3xx_set_mode,
>> 	.quirkproc		= hpt3xx_quirkproc,
>>+	.resetproc		= hpt3xx_reset,
>> 	.maskproc		= hpt3xx_maskproc,
>> 	.mdma_filter		= hpt3xx_mdma_filter,
>> 	.udma_filter		= hpt3xx_udma_filter,
>>diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
>>index 7f264ed..09295b4 100644
>>--- a/drivers/ide/ide-probe.c
>>+++ b/drivers/ide/ide-probe.c
>>@@ -367,6 +367,7 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
>> {
>> 	ide_hwif_t *hwif = drive->hwif;
>> 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
>>+	const struct ide_port_ops *port_ops = hwif->port_ops;
>> 	u16 *id = drive->id;
>> 	int rc;
>> 	u8 present = !!(drive->dev_flags & IDE_DFLAG_PRESENT), stat;
>>@@ -427,9 +428,20 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
>> 		/* ensure drive IRQ is clear */
>> 		stat = tp_ops->read_status(hwif);
>> 
>>-		if (rc == 1)
>>+		if (rc == 1) {
>> 			printk(KERN_ERR "%s: no response (status = 0x%02x)\n",
>> 					drive->name, stat);
>>+
>>+			if (port_ops->resetproc) {
>>+				port_ops->resetproc(drive);
>>+				msleep(50);

    Karl, why are you calling resetproc() without doing a reset? What this 
achieves?

>>+			}
>>+			tp_ops->dev_select(drive);
>>+			msleep(50);
>>+			tp_ops->exec_command(hwif, ATA_CMD_DEV_RESET);
>>+			(void)ide_busy_sleep(hwif, WAIT_WORSTCASE, 0);
>>+			rc = ide_dev_read_id(drive, cmd, id);
>>+		}
>> 	} else {
>> 		/* not present or maybe ATAPI */
>> 		rc = 3;

> Since the current code in ide-probe.c looks like this:

> 		stat = tp_ops->read_status(hwif);
> 
> 		if (stat == (ATA_BUSY | ATA_DRDY))
> 			return 4;
> 
> 		if (rc == 1 && cmd == ATA_CMD_ID_ATAPI) {
> 			printk(KERN_ERR "%s: no response (status = 0x%02x), "
> 					"resetting drive\n", drive->name, stat);
> 			msleep(50);
> 			tp_ops->dev_select(drive);
> 			msleep(50);
> 			tp_ops->exec_command(hwif, ATA_CMD_DEV_RESET);
> 			(void)ide_busy_sleep(hwif, WAIT_WORSTCASE, 0);
> 			rc = ide_dev_read_id(drive, cmd, id);
> 		}
> 
> 		/* ensure drive IRQ is clear */
> 		stat = tp_ops->read_status(hwif);
> 
> 		if (rc == 1)
> 			printk(KERN_ERR "%s: no response (status = 0x%02x)\n",
> 					drive->name, stat);

> I would really prefer fixing ATAPI case while we are at it
> (+ this would also get rid of code duplication).

> IOW:

> - in patch #1 we would add ->resetproc call

    I would first like to hear an explanation of what it does...

> - in patch #2 we would remove 'cmd == ATA_CMD_ID_ATAPI' check

    Why? Does issuing ATA_CMD_DEV_RESET to hard drives make sense?

> Care to revise your patch?

> Thanks,
> Bart

MBR, Sergei
