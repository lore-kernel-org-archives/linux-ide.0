From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: Promise SATAII150 TX4 ide errors
Date: Sun, 18 Sep 2005 22:03:17 +1000
Message-ID: <432D5785.8010709@eyal.emu.id.au>
References: <430E4AB0.2060600@eyal.emu.id.au> <4313E433.1080602@pobox.com>	<43223709.8090002@eyal.emu.id.au> <x3kfysdq846.fsf@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:14229 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751115AbVIRMD3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Sep 2005 08:03:29 -0400
In-Reply-To: <x3kfysdq846.fsf@Psilocybe.Update.UU.SE>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thorild Selen <thorild@Update.UU.SE>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Thorild Selen wrote:
> If you search a bit in the linux-ide and linux-kernel mailing list
> archives, you will find that several people before have had problems
> with SATA150-TX4 and SATAII150-TX4 (see for example posts by Jim
> Ramsay, Joerg Sommrey and me).

Having sorted out the raidreconf I now have a working raid.

Well, sort of working, I now started seeing i/o errors that cause
the raid to stop and required a re-assemble. It looks very much
like the other reports, except that my details vary a bit.
Here is what I get:

Sep 18 10:11:10 eyal kernel: [4294756.244000] irq 16: nobody cared (try booting with the "irqpoll" option)
Sep 18 10:11:10 eyal kernel: [4294756.244000]  [__report_bad_irq+42/160] __report_bad_irq+0x2a/0xa0
Sep 18 10:11:10 eyal kernel: [4294756.244000]  [handle_IRQ_event+48/112] handle_IRQ_event+0x30/0x70
Sep 18 10:11:10 eyal kernel: [4294756.244000]  [note_interrupt+128/240] note_interrupt+0x80/0xf0
Sep 18 10:11:10 eyal kernel: [4294756.244000]  [__do_IRQ+283/288] __do_IRQ+0x11b/0x120
Sep 18 10:11:10 eyal kernel: [4294756.244000]  [do_IRQ+70/112] do_IRQ+0x46/0x70
Sep 18 10:11:10 eyal kernel: [4294756.244000]  =======================
Sep 18 10:11:10 eyal kernel: [4294756.244000]  [common_interrupt+26/32] common_interrupt+0x1a/0x20
Sep 18 10:11:10 eyal kernel: [4294756.244000]  [default_idle+0/48] default_idle+0x0/0x30
Sep 18 10:11:10 eyal kernel: [4294756.244000]  [default_idle+35/48] default_idle+0x23/0x30
Sep 18 10:11:10 eyal kernel: [4294756.244000]  [cpu_idle+112/128] cpu_idle+0x70/0x80
Sep 18 10:11:10 eyal kernel: [4294756.244000]  [start_kernel+366/400] start_kernel+0x16e/0x190
Sep 18 10:11:10 eyal kernel: [4294756.244000]  [unknown_bootoption+0/480] unknown_bootoption+0x0/0x1e0
Sep 18 10:11:10 eyal kernel: [4294756.244000] handlers:
Sep 18 10:11:10 eyal kernel: [4294756.244000] [pg0+945037568/1068864512] (usb_hcd_irq+0x0/0x70 [usbcore])
Sep 18 10:11:10 eyal kernel: [4294756.244000] [pg0+945383264/1068864512] (ata_interrupt+0x0/0x120 [libata])
Sep 18 10:11:10 eyal kernel: [4294756.244000] [pg0+945587408/1068864512] (pdc_interrupt+0x0/0x1c0 [sata_promise])
Sep 18 10:11:10 eyal kernel: [4294756.244000] [pg0+946374608/1068864512] (dc395x_interrupt+0x0/0x90 [dc395x])
Sep 18 10:11:10 eyal kernel: [4294756.244000] [pg0+946191904/1068864512] (e1000_intr+0x0/0x100 [e1000])
Sep 18 10:11:10 eyal kernel: [4294756.244000] Disabling IRQ #16

Sep 18 10:11:39 eyal kernel: [4294785.495000] ata4: command timeout
Sep 18 10:11:39 eyal kernel: [4294785.520000] ATA: abnormal status 0xFF on port 0xF8A4829C
Sep 18 10:11:39 eyal kernel: [4294785.538000] ata4: status=0xff { Busy }
Sep 18 10:11:39 eyal kernel: [4294785.551000] SCSI error : <3 0 0 0> return code = 0x8000002
Sep 18 10:11:39 eyal kernel: [4294785.569000] sdd: Current: sense key: Aborted Command
Sep 18 10:11:39 eyal kernel: [4294785.586000]     Additional sense: Scsi parity error
Sep 18 10:11:39 eyal kernel: [4294785.603000] end_request: I/O error, dev sdd, sector 625137215
Sep 18 10:11:39 eyal kernel: [4294785.622000] raid5: Disk failure on sdd1, disabling device. Operation continuing on 3 devices

Then /dev/sdc goes down the same way (it is on the TX4 too) and the raid5
goes offline.

[trim]

> The only fix I know of is grabbing the SCSI bits from 2.6.10, which
> can be compiled into a later kernel.  2.6.10 doesn't contain the bug,
> but (the kernel.org) 2.6.10 should be avoided due to security
> issues. There are important fixes in later SCSI code which should
> probably be applied if you attempt this.

Looking at sata_promise.c, comparing 2.6.10 to 2.6.13 shows very
little change:
	- a few new devices added to the table
	- a new device type 'board_20619'
	- new code for the new type in pdc_ata_init_one() which is in
	fact identical to the older 'board_20319
	- handling of pci_dev_busy condition
	- one line added in the interrupt handler:
		writel(mask, mmio_base + PDC_INT_SEQMASK);

There was no more changes in the -ac series.

The maintainer may be able to judge if any of these could lead to
these errors.

So this may be due to changes outside the device driver, e.g. the
ide/scsi layers.

I cannot reliably reproduce the failure, but at least once it happened
very soon after a boot when there was not much activity on the raid.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
