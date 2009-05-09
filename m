From: Karl Hiramoto <karl@hiramoto.org>
Subject: Re: [RFC]hpt366/ide-probe  reset drive on probe error.
Date: Sat, 09 May 2009 14:09:05 +0200
Message-ID: <4A057261.3090404@hiramoto.org>
References: <4A0052EB.6040502@hiramoto.org> <200905081550.11297.bzolnier@gmail.com> <4A044863.5090805@ru.mvista.com> <4A044C25.6010709@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:59971 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbZEIMJt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 May 2009 08:09:49 -0400
Received: from spunkymail-a6.g.dreamhost.com (caiajhbdcbhh.dreamhost.com [208.97.132.177])
	by hapkido.dreamhost.com (Postfix) with ESMTP id EEEBD17A3F7
	for <linux-ide@vger.kernel.org>; Sat,  9 May 2009 05:10:05 -0700 (PDT)
In-Reply-To: <4A044C25.6010709@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Hello, I wrote:
>
>>>> +
>>>> +    reset = hwif->channel ? 0x80 : 0x40;
>
>>    These HighPoint's "soft reset" (WTF does that mean I wonder?) bits 
>> are not the same between HPT366 and HPT370, so this code doesn't look 
>> right...
>
>    Ah, these "soft" reset bits correspond to PRST_/SRST_ signals which 
> are really primary/secondary channel hard resets (RESET- signal). This 
> explains everything; and this patch is a pure hack then.
>
>>>> +
>>>> +    pci_read_config_byte(dev, 0x59, &reg59h);
>>>> +    pci_write_config_byte(dev, 0x59, reg59h|reset);
>>>> +    pci_write_config_byte(dev, 0x59, reg59h);
>>>> +}
>>>> +
>>>> static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
>>>> {
>>>>     struct hpt_info *info    = hpt3xx_get_info(hwif->dev);
>>>> @@ -1406,6 +1431,7 @@ static const struct ide_port_ops 
>>>> hpt3xx_port_ops = {
>>>>     .set_pio_mode        = hpt3xx_set_pio_mode,
>>>>     .set_dma_mode        = hpt3xx_set_mode,
>>>>     .quirkproc        = hpt3xx_quirkproc,
>>>> +    .resetproc        = hpt3xx_reset,
>>>>     .maskproc        = hpt3xx_maskproc,
>>>>     .mdma_filter        = hpt3xx_mdma_filter,
>>>>     .udma_filter        = hpt3xx_udma_filter,
>>>> diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
>>>> index 7f264ed..09295b4 100644
>>>> --- a/drivers/ide/ide-probe.c
>>>> +++ b/drivers/ide/ide-probe.c
>>>> @@ -367,6 +367,7 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
>>>> {
>>>>     ide_hwif_t *hwif = drive->hwif;
>>>>     const struct ide_tp_ops *tp_ops = hwif->tp_ops;
>>>> +    const struct ide_port_ops *port_ops = hwif->port_ops;
>>>>     u16 *id = drive->id;
>>>>     int rc;
>>>>     u8 present = !!(drive->dev_flags & IDE_DFLAG_PRESENT), stat;
>>>> @@ -427,9 +428,20 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
>>>>         /* ensure drive IRQ is clear */
>>>>         stat = tp_ops->read_status(hwif);
>>>>
>>>> -        if (rc == 1)
>>>> +        if (rc == 1) {
>>>>             printk(KERN_ERR "%s: no response (status = 0x%02x)\n",
>>>>                     drive->name, stat);
>>>> +
>>>> +            if (port_ops->resetproc) {
>>>> +                port_ops->resetproc(drive);
>>>> +                msleep(50);
>
>>    Karl, why are you calling resetproc() without doing a reset? What 
>> this achieves?
>
>    To reset the drives, apparently. But it's not the function of 
> resetproc(). We should try soft-reset instead.
>
Yes, to reset the drive that does not respond.

>>>> +            }
>>>> +            tp_ops->dev_select(drive);
>>>> +            msleep(50);
>>>> +            tp_ops->exec_command(hwif, ATA_CMD_DEV_RESET);
>>>> +            (void)ide_busy_sleep(hwif, WAIT_WORSTCASE, 0);
>>>> +            rc = ide_dev_read_id(drive, cmd, id);
>>>> +        }
>>>>     } else {
>>>>         /* not present or maybe ATAPI */
>>>>         rc = 3;
>
>>> Since the current code in ide-probe.c looks like this:
>
>>>         stat = tp_ops->read_status(hwif);
>>>
>>>         if (stat == (ATA_BUSY | ATA_DRDY))
>>>             return 4;
>>>
>>>         if (rc == 1 && cmd == ATA_CMD_ID_ATAPI) {
>>>             printk(KERN_ERR "%s: no response (status = 0x%02x), "
>>>                     "resetting drive\n", drive->name, stat);
>>>             msleep(50);
>>>             tp_ops->dev_select(drive);
>>>             msleep(50);
>>>             tp_ops->exec_command(hwif, ATA_CMD_DEV_RESET);
>>>             (void)ide_busy_sleep(hwif, WAIT_WORSTCASE, 0);
>>>             rc = ide_dev_read_id(drive, cmd, id);
>>>         }
>>>
>>>         /* ensure drive IRQ is clear */
>>>         stat = tp_ops->read_status(hwif);
>>>
>>>         if (rc == 1)
>>>             printk(KERN_ERR "%s: no response (status = 0x%02x)\n",
>>>                     drive->name, stat);
>
>>> I would really prefer fixing ATAPI case while we are at it
>>> (+ this would also get rid of code duplication).
>
>>> IOW:
>
>>> - in patch #1 we would add ->resetproc call
>
>>    I would first like to hear an explanation of what it does...
>
>    I have to NAK this resetproc() addition. It tries to do things that 
> it's not designed to do. We should instead try soft-resetting the 
> channel...

Where should the soft reset be done, for this to not be called a hack?   
should it be in ide_port_ops->reset_poll?
>
>>> Care to revise your patch?
>
>    I see no point in "revising" this hack now...

Why not reset the drive if it does not respond?  OK, you could blame 
this on a bugy board, or redboot that does not reset the drive on warm 
boot if it is busy.


--
Karl
