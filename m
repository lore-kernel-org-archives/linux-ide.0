From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC]hpt366/ide-probe  reset drive on probe error.
Date: Fri, 08 May 2009 19:29:24 +0400
Message-ID: <4A044FD4.6050405@ru.mvista.com>
References: <4A0052EB.6040502@hiramoto.org> <200905081550.11297.bzolnier@gmail.com> <200905081557.20733.bzolnier@gmail.com> <200905081607.17340.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:35384 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751677AbZEHP26 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 11:28:58 -0400
In-Reply-To: <200905081607.17340.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Karl Hiramoto <karl@hiramoto.org>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>>diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
>>>>index 3377766..ba4b802 100644
>>>>--- a/drivers/ide/hpt366.c
>>>>+++ b/drivers/ide/hpt366.c
>>>>@@ -1280,6 +1280,31 @@ static u8 hpt3xx_cable_detect(ide_hwif_t *hwif)
>>>> 	return (scr1 & ata66) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
>>>> }
>>>> 
>>>>+/** routine to reset disk
>>>>+ *
>>>>+ * Since SUN Cobalt is attempting to do this operation, I should disclose
>>>>+ * this has been a long time ago Thu Jul 27 16:40:57 2000 was the patch date
>>>>+ * HOTSWAP ATA Infrastructure.
>>>>+ */
>>>>+
>>>>+static void hpt3xx_reset (ide_drive_t *drive)
>>>>+{
>>>>+	ide_hwif_t *hwif = drive->hwif;
>>>>+	struct pci_dev *dev = to_pci_dev(hwif->dev);
>>>>+	unsigned long high_16;
>>>>+	u8 reset;
>>>>+	u8 reg59h = 0;
>>>>+
>>>>+	printk(KERN_INFO "%s reset drive channel %d\n", __func__, hwif->channel);
>>>>+	high_16 = pci_resource_start(dev, 4);
>>>>+
>>>>+	reset = hwif->channel ? 0x80 : 0x40;
>>>>+
>>>>+	pci_read_config_byte(dev, 0x59, &reg59h);
>>>>+	pci_write_config_byte(dev, 0x59, reg59h|reset);
>>>>+	pci_write_config_byte(dev, 0x59, reg59h);
>>>>+}
>>>>+
>>>> static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
>>>> {
>>>> 	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
>>>>@@ -1406,6 +1431,7 @@ static const struct ide_port_ops hpt3xx_port_ops = {
>>>> 	.set_pio_mode		= hpt3xx_set_pio_mode,
>>>> 	.set_dma_mode		= hpt3xx_set_mode,
>>>> 	.quirkproc		= hpt3xx_quirkproc,
>>>>+	.resetproc		= hpt3xx_reset,
>>>> 	.maskproc		= hpt3xx_maskproc,
>>>> 	.mdma_filter		= hpt3xx_mdma_filter,
>>>> 	.udma_filter		= hpt3xx_udma_filter,
>>>>diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
>>>>index 7f264ed..09295b4 100644
>>>>--- a/drivers/ide/ide-probe.c
>>>>+++ b/drivers/ide/ide-probe.c
>>>>@@ -367,6 +367,7 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
>>>> {
>>>> 	ide_hwif_t *hwif = drive->hwif;
>>>> 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
>>>>+	const struct ide_port_ops *port_ops = hwif->port_ops;
>>>> 	u16 *id = drive->id;
>>>> 	int rc;
>>>> 	u8 present = !!(drive->dev_flags & IDE_DFLAG_PRESENT), stat;
>>>>@@ -427,9 +428,20 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
>>>> 		/* ensure drive IRQ is clear */
>>>> 		stat = tp_ops->read_status(hwif);
>>>> 
>>>>-		if (rc == 1)
>>>>+		if (rc == 1) {
>>>> 			printk(KERN_ERR "%s: no response (status = 0x%02x)\n",
>>>> 					drive->name, stat);
>>>>+
>>>>+			if (port_ops->resetproc) {
>>>>+				port_ops->resetproc(drive);
>>>>+				msleep(50);
>>>>+			}
>>>>+			tp_ops->dev_select(drive);
>>>>+			msleep(50);
>>>>+			tp_ops->exec_command(hwif, ATA_CMD_DEV_RESET);
>>>>+			(void)ide_busy_sleep(hwif, WAIT_WORSTCASE, 0);
>>>>+			rc = ide_dev_read_id(drive, cmd, id);
>>>>+		}
>>>> 	} else {
>>>> 		/* not present or maybe ATAPI */
>>>> 		rc = 3;
>>>
>>>Since the current code in ide-probe.c looks like this:
>>>
>>>		stat = tp_ops->read_status(hwif);
>>>
>>>		if (stat == (ATA_BUSY | ATA_DRDY))
>>>			return 4;
>>>
>>>		if (rc == 1 && cmd == ATA_CMD_ID_ATAPI) {
>>>			printk(KERN_ERR "%s: no response (status = 0x%02x), "
>>>					"resetting drive\n", drive->name, stat);
>>>			msleep(50);
>>>			tp_ops->dev_select(drive);
>>>			msleep(50);
>>>			tp_ops->exec_command(hwif, ATA_CMD_DEV_RESET);
>>>			(void)ide_busy_sleep(hwif, WAIT_WORSTCASE, 0);
>>>			rc = ide_dev_read_id(drive, cmd, id);
>>>		}
>>>
>>>		/* ensure drive IRQ is clear */
>>>		stat = tp_ops->read_status(hwif);
>>>
>>>		if (rc == 1)
>>>			printk(KERN_ERR "%s: no response (status = 0x%02x)\n",
>>>					drive->name, stat);
>>>
>>>I would really prefer fixing ATAPI case while we are at it
>>>(+ this would also get rid of code duplication).
>>>
>>>IOW:
>>>
>>>- in patch #1 we would add ->resetproc call
>>>
>>>- in patch #2 we would remove 'cmd == ATA_CMD_ID_ATAPI' check
>>
>>[ looking a bit closer at the code in ide-probe.c ]
>>
>>- in patch #2 we would move the ATAPI check to cover device selection/reset
>>  inside 'if ()' block

> Sigh, this is even more complicated...

> We should defer ->resetproc call until both drives are probed and do the
> port reset after probing both drives given that:

    We should just reset the port (and call resetproc() as a part of that). 
The resetproc() change should not be needed.

> - we didn't detect any devices

> and 

> - for one of devices do_probe() returned '1' (== "no response")

> Also it would greatly help to clean/fix return values of do_probe()
> and probe_for_drive() before doing the real changes.

    Sounds like the plan. :-)

> Thanks,
> Bart

MBR, Sergei
