From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: New MSI support in sata_sil24 still broken in 2.6.33-rc3
Date: Wed, 06 Jan 2010 18:59:37 -0600
Message-ID: <4B4531F9.3060108@gmail.com>
References: <64bb37e1001060137h597322e8s4305b7cc1c91527e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:48749 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826Ab0AGA7k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jan 2010 19:59:40 -0500
In-Reply-To: <64bb37e1001060137h597322e8s4305b7cc1c91527e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vivek Mahajan <vivek.mahajan@freescale.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 01/06/2010 03:37 AM, Torsten Kaiser wrote:
> After activating the MSI support by adding sata_sil24.msi=1 to the
> kernel command line, the first write to a drive attached to the SiI
> 3132 controller results in the following errors:
>
> [  138.950074] ata2.00: exception Emask 0x0 SAct 0xf SErr 0x0 action 0x6 frozen
> [  138.961023] ata2.00: failed command: WRITE FPDMA QUEUED
> [  138.970034] ata2.00: cmd 61/00:00:a5:95:4a/04:00:01:00:00/40 tag 0
> ncq 524288 out
> [  138.970037]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)

Looking at the code in sata_sil24 and the SiI3132 datasheet, there's a 
control bit which doesn't seem to be handled in the driver, global 
control register bit 30: "MSI Acknowledge (W). Writing a one to this bit 
acknowledges a Message Signaled Interrupt and permits generation of 
another MSI. This bit is cleared immediately after the acknowledgement 
is recognized by the control logic, hence the bit will always be read as 
a zero. If all interrupt conditions are removed subsequent to an MSI, it 
is not necessary to assert this Acknowledge; another MSI will be 
generated when an interrupt condition occurs."

The way the interrupt handler for this driver works is that we check the 
global IRQ status register, and then based on what ports indicated an 
interrupt in that register, we check the individual port command 
completion registers. The issue would seem to be that if a port got an 
interrupt condition in between these two operations, we'd miss it, and 
the MSI logic described above then wouldn't generate any more interrupts 
since we didn't remove all interrupt conditions.

Can you try this patch and see if it helps? (Might be whitespace damaged 
but hopefully you can apply manually in that case.)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 1370df6..d3d8dec 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -102,6 +102,7 @@ enum {
         HOST_CTRL_STOP          = (1 << 18), /* latched PCI STOP */
         HOST_CTRL_DEVSEL        = (1 << 19), /* latched PCI DEVSEL */
         HOST_CTRL_REQ64         = (1 << 20), /* latched PCI REQ64 */
+       HOST_CTRL_MSIACK        = (1 << 30), /* MSI acknowledge */
         HOST_CTRL_GLOBAL_RST    = (1 << 31), /* global reset */

         /*
@@ -1168,6 +1169,7 @@ static irqreturn_t sil24_interrupt(int irq, void 
*dev_instance)
                                        ": interrupt from disabled port 
%d\n", i);
                 }

+       writel(IRQ_STAT_4PORTS | HOST_CTRL_MSIACK, host_base + HOST_CTRL);
         spin_unlock(&host->lock);
   out:
         return IRQ_RETVAL(handled);
