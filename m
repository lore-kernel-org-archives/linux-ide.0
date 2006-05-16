From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 07/11] libata-eh-fw: implement freeze/thaw
Date: Tue, 16 May 2006 18:15:27 +0800
Message-ID: <4469A63F.3040705@tw.ibm.com>
References: <11473504441058-git-send-email-htejun@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:41119 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751743AbWEPKPa
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 06:15:30 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4GAFU4Q014210
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 06:15:30 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4GAFTrI177692
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 04:15:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4GAFSde024865
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 04:15:29 -0600
In-Reply-To: <11473504441058-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Freezing is performed atomic w.r.t. host_set->lock and once frozen
> LLDD is not allowed to access the port or any qc on it.  Also, libata
> makes sure that no new qc gets issued to a frozen port.
> 
> A frozen port is thawed after a reset operation completes
> successfully, so reset methods must do its job while the port is
> frozen.  During initialization all ports get frozen before requesting
> IRQ, so reset methods are always invoked on a frozen port.
> 
> Optional ->freeze and ->thaw operations notify LLDD that the port is
> being frozen and thawed, respectively.  LLDD can disable/enable
> hardware interrupt in these callbacks if the controller's IRQ mask can
> be changed dynamically.  If the controller doesn't allow such
> operation, LLDD can check for frozen state in the interrupt handler
> and ack/clear interrupts unconditionally while frozen.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |   26 ++++++++++-
>  drivers/scsi/libata-eh.c   |  103 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/libata.h     |    4 ++
>  3 files changed, 131 insertions(+), 2 deletions(-)
> 
> ce9d6dcb786c6bc5e65dc4cd20be3af0bc5e1d69
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 7483518..436ff5b 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -987,6 +987,12 @@ unsigned ata_exec_internal(struct ata_de
>  
>  	spin_lock_irqsave(&ap->host_set->lock, flags);
>  
> +	/* no internal command while frozen */
> +	if (ap->flags & ATA_FLAG_FROZEN) {
> +		spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +		return AC_ERR_SYSTEM;
> +	}
> +
>  	/* initialize internal qc */
>  
>  	/* XXX: Tag 0 is used for drivers with legacy EH as some
> @@ -2564,8 +2570,11 @@ void ata_std_postreset(struct ata_port *
>  		ata_scr_write(ap, SCR_ERROR, serror);
>  
>  	/* re-enable interrupts */
> -	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
> -		ata_irq_on(ap);
> +	if (!ap->ops->error_handler) {
> +		/* FIXME: hack. create a hook instead */
> +		if (ap->ioaddr.ctl_addr)
> +			ata_irq_on(ap);
> +	}
>  
>  	/* is double-select really necessary? */
>  	if (classes[0] != ATA_DEV_NONE)
> @@ -2680,6 +2689,8 @@ int ata_drive_probe_reset(struct ata_por
>  {
>  	int rc = -EINVAL;
>  
> +	ata_eh_freeze_port(ap);
> +
>  	if (probeinit)
>  		probeinit(ap);
>  
> @@ -2724,6 +2735,9 @@ int ata_drive_probe_reset(struct ata_por
>  	if (rc == 0) {
>  		if (postreset)
>  			postreset(ap, classes);
> +
> +		ata_eh_thaw_port(ap);
> +
>  		if (classes[0] == ATA_DEV_UNKNOWN)
>  			rc = -ENODEV;
>  	}


With the new ata_drive_probe_reset(), my old Acer 787E drive still got "irq nobody cared"
when probed. (dmesg attached. The problem only seen on this drive; other CD-ROM drives works ok.)
The pata_pdc2027x driver has been converted to the ->probe_reset() interface.
Is there anything else I should do for pata_pdc2027x driver to avoid the "irq nobody cared"?

--
albert


May 16 17:26:45 p4ht-s kernel: ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 5 (level, low) -> IRQ 5
May 16 17:26:45 p4ht-s kernel: pata_pdc2027x 0000:02:05.0: PLL input clock 16731 kHz
May 16 17:26:45 p4ht-s kernel: ata5: PATA max UDMA/133 cmd 0xE0A917C0 ctl 0xE0A91FDA bmdma 0xE0A91000 irq 5
May 16 17:26:45 p4ht-s kernel: ata6: PATA max UDMA/133 cmd 0xE0A915C0 ctl 0xE0A91DDA bmdma 0xE0A91008 irq 5
May 16 17:26:46 p4ht-s kernel: ata5.00: ATAPI, max UDMA/33
May 16 17:26:46 p4ht-s kernel: ata5.01: ATAPI, max UDMA/33
May 16 17:26:46 p4ht-s kernel: ata5.00: configured for UDMA/33
May 16 17:26:46 p4ht-s kernel: ata5.01: configured for UDMA/33
May 16 17:26:46 p4ht-s kernel: scsi4 : pata_pdc2027x
May 16 17:26:47 p4ht-s kernel: irq 5: nobody cared (try booting with the "irqpoll" option)
May 16 17:26:47 p4ht-s kernel:  <c013b1c4> __report_bad_irq+0x24/0x7f   <c013b296> note_interrupt+0x77/0x21d

Message from syslogd@p4ht-s at Tue May 16 17:26:47 2006 ...
p4ht-s kernel: Disabling IRQ #5
May 16 17:26:47 p4ht-s kernel:  <c013ac7d> handle_IRQ_event+0x2e/0x5a   <c013ad73> __do_IRQ+0xca/0xd7
May 16 17:26:47 p4ht-s kernel:  <c01047b8> do_IRQ+0x53/0x8b  
May 16 17:26:47 p4ht-s kernel:  =======================
May 16 17:26:47 p4ht-s kernel:  <c0102f7e> common_interrupt+0x1a/0x20   <c011f599> __do_softirq+0x37/0x95
May 16 17:26:47 p4ht-s kernel:  <c010483f> do_softirq+0x4f/0x60  
May 16 17:26:47 p4ht-s kernel:  =======================
May 16 17:26:47 p4ht-s kernel:  <c011f485> irq_exit+0x37/0x39   <c01047bf> do_IRQ+0x5a/0x8b
May 16 17:26:47 p4ht-s kernel:  <e087ff2a> ata_std_softreset+0x0/0xd0 [libata]   <c0102f7e> common_interrupt+0x1a/0x20
May 16 17:26:47 p4ht-s kernel:  <e087ff2a> ata_std_softreset+0x0/0xd0 [libata]   <c019007b> proc_readfd+0x214/0x254
May 16 17:26:47 p4ht-s kernel:  <e0885737> ata_altstatus+0x2a/0x2e [libata]   <e087eaef> ata_std_dev_select+0x23/0x47 [libata]
May 16 17:26:47 p4ht-s kernel:  <e087eb25> ata_devchk+0x12/0xaa [libata]   <e087ff2a> ata_std_softreset+0x0/0xd0 [libata]
May 16 17:26:47 p4ht-s kernel:  <e087ff5d> ata_std_softreset+0x33/0xd0 [libata]   <e087d504> sata_scr_read+0xe/0x2b [libata]
May 16 17:26:47 p4ht-s kernel:  <e087d504> sata_scr_read+0xe/0x2b [libata]   <e087ff2a> ata_std_softreset+0x0/0xd0 [libata]
May 16 17:26:47 p4ht-s kernel:  <e087d6b9> ata_do_reset+0x1f/0x5f [libata]   <e0a8a4f2> pdc2027x_probeinit+0x0/0x5c [pata_pdc2027x]
May 16 17:26:47 p4ht-s kernel:  <e087ee80> ata_drive_probe_reset+0x107/0x139 [libata]   <e087ff2a> ata_std_softreset+0x0/0xd0 [libata]
May 16 17:26:47 p4ht-s kernel:  <e0a8a5ae> pdc2027x_probe_reset+0x60/0x65 [pata_pdc2027x]   <e0881575> ata_std_postreset+0x0/0x136 [libata]
May 16 17:26:47 p4ht-s kernel:  <e0882555> ata_device_add+0x421/0x721 [libata]   <e0a8a449> pdc2027x_init_one+0x29f/0x348 [pata_pdc2027x]
May 16 17:26:47 p4ht-s kernel:  <c01e2ce6> pci_device_probe+0x40/0x5b   <c0241135> driver_probe_device+0x3b/0xb0
May 16 17:26:47 p4ht-s kernel:  <c0241299> __driver_attach+0x82/0x84   <c0240727> bus_for_each_dev+0x39/0x57
May 16 17:26:47 p4ht-s kernel:  <c0241012> driver_attach+0x16/0x1a   <c0241217> __driver_attach+0x0/0x84
May 16 17:26:47 p4ht-s kernel:  <c02409f3> bus_add_driver+0x66/0x116   <c02415fa> driver_register+0x41/0xb4
May 16 17:26:47 p4ht-s kernel:  <c01e2937> __pci_register_driver+0x65/0x86   <c013296f> sys_init_module+0x114/0x175b
May 16 17:26:47 p4ht-s kernel:  <e087d915> ata_port_start+0x0/0x7e [libata]   <c0102db3> syscall_call+0x7/0xb
May 16 17:26:47 p4ht-s kernel: handlers:
May 16 17:26:47 p4ht-s kernel: [<c027279c>] (usb_hcd_irq+0x0/0x51)
May 16 17:26:47 p4ht-s kernel: [<c027279c>] (usb_hcd_irq+0x0/0x51)
May 16 17:26:47 p4ht-s kernel: [<e0882ad1>] (ata_interrupt+0x0/0x1af [libata])
May 16 17:26:47 p4ht-s kernel: Disabling IRQ #5
May 16 17:27:09 p4ht-s samba(pam_unix)[2647]: session opened for user albertcc by (uid=0)
May 16 17:27:17 p4ht-s kernel: ata6.00: qc timeout (cmd 0xa1)
May 16 17:27:17 p4ht-s kernel: ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
May 16 17:27:47 p4ht-s kernel: ata6.00: qc timeout (cmd 0xa1)
May 16 17:27:47 p4ht-s kernel: ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)

May 16 17:28:18 p4ht-s kernel: ata6.00: qc timeout (cmd 0xa1)
May 16 17:28:18 p4ht-s kernel: ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
May 16 17:28:18 p4ht-s kernel: ata6.00: limiting speed to PIO0
May 16 17:28:18 p4ht-s kernel: ata6.00: disabled
May 16 17:28:18 p4ht-s kernel: scsi5 : pata_pdc2027x
May 16 17:28:23 p4ht-s kernel: ata5.00: command 0xa0 timeout, stat 0x58 host_stat 0x0
May 16 17:28:23 p4ht-s kernel: ata5: no sense translation for status: 0x40
May 16 17:28:23 p4ht-s kernel: ata5: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
May 16 17:28:29 p4ht-s kernel: ata5.01: command 0xa0 timeout, stat 0x58 host_stat 0x0
May 16 17:28:29 p4ht-s kernel: ata5: no sense translation for status: 0x40
May 16 17:28:29 p4ht-s kernel: ata5: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00

