From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Sun, 21 Jun 2009 15:33:41 +0200
Message-ID: <200906211533.41452.bzolnier@gmail.com>
References: <200906202352.33894.elendil@planet.nl> <20090620.171945.140676687.davem@davemloft.net> <200906211446.38598.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f224.google.com ([209.85.220.224]:64438 "EHLO
	mail-fx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbZFUN14 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Jun 2009 09:27:56 -0400
In-Reply-To: <200906211446.38598.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 21 June 2009 14:46:37 Frans Pop wrote:
> On Sunday 21 June 2009, David Miller wrote:
> > From: Frans Pop <elendil@planet.nl>
> > Date: Sat, 20 Jun 2009 23:52:33 +0200
> >
> > > ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14
> > > (serialized) irq 14: nobody cared (try booting with the "irqpoll"
> > > option) Call Trace:
> [...]
> > diff --git a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
> > index 80b777e..f98ba24 100644
> > --- a/drivers/ide/cmd64x.c
> > +++ b/drivers/ide/cmd64x.c
> > @@ -425,8 +425,7 @@ static const struct ide_port_info cmd64x_chipsets[]
> > __devinitdata = { .enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
> >  		.port_ops	= &cmd64x_port_ops,
> >  		.dma_ops	= &cmd648_dma_ops,
> > -		.host_flags	= IDE_HFLAG_SERIALIZE |
> > -				  IDE_HFLAG_ABUSE_PREFETCH,
> > +		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
> >  		.pio_mask	= ATA_PIO5,
> >  		.mwdma_mask	= ATA_MWDMA2,
> >  		.udma_mask	= ATA_UDMA2,
> 
> This patch (tested on top of 2.6.30) gets rid of one of the two "nobody cared"
> errors and also makes the system run at normal speed again. But I'm still
> left with one error:
> 
> cmd64x 0000:01:03.0: IDE controller (0x1095:0x0646 rev 0x03)
> cmd64x 0000:01:03.0: 100% native mode on irq 14
>     ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027
>     ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f
> hda: ST34342A, ATA DISK drive
> hda: MWDMA2 mode selected
> hdc: Maxtor 6E040L0, ATA DISK drive
> hdd: CD-ROM 56X/AKH, ATAPI CD/DVD-ROM drive
> hdc: MWDMA2 mode selected
> hdd: bad DMA info in identify block
> ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14
> irq 14: nobody cared (try booting with the "irqpoll" option)
> Call Trace:
>  [000000000048b594] note_interrupt+0x160/0x1e8
>  [000000000048bcc4] handle_fasteoi_irq+0x9c/0xc8
>  [0000000000429e60] handler_irq+0xb0/0xe8
>  [00000000004208b4] tl0_irq5+0x14/0x20
>  [0000000000455e80] __do_softirq+0x58/0x17c
>  [0000000000429d84] do_softirq+0x50/0x7c
>  [0000000000455bb0] irq_exit+0x38/0x88
>  [000000000042e710] timer_interrupt+0x70/0x88
>  [00000000004209d4] tl0_irq14+0x14/0x20
>  [000000000048ae04] request_threaded_irq+0x64/0x12c
>  [00000000005ff3c4] ide_host_register+0x4e4/0x6a8
>  [00000000006044bc] ide_pci_init_one+0xc8/0xf8
>  [000000001001271c] cmd64x_init_one+0x88/0x9c [cmd64x]
>  [0000000000588cb4] local_pci_probe+0x10/0x24
>  [0000000000588e38] pci_device_probe+0x4c/0x84
>  [00000000005ee2c8] driver_probe_device+0xa0/0x164
> handlers:
> [<00000000005fb72c>] (ide_intr+0x8/0x234)
> Disabling IRQ #14
> ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 14

I wonder if the weird hdd device could be a problem here (does it use DMA
under pata_cmd64x, also please send 'hdparm --Istdout /dev/hdd' output)..

Could you check if it helps if we skip ide1 for debug purposes:

---
 drivers/ide/ide-probe.c |    3 +++
 1 file changed, 3 insertions(+)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1359,6 +1359,9 @@ int ide_host_register(struct ide_host *h
 	ide_hwif_t *hwif, *mate = NULL;
 	int i, j = 0;
 
+	/* setup only port 0 */
+	host->ports[1] = NULL;
+
 	ide_host_for_each_port(i, hwif, host) {
 		if (hwif == NULL) {
 			mate = NULL;
