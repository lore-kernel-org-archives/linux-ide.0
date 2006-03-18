From: Andrew Morton <akpm@osdl.org>
Subject: Re: sata_mv success on 2.6.16-rc6-mm2  (was: Re: 2.6.16-rc6-mm2)
Date: Sat, 18 Mar 2006 11:57:37 -0800
Message-ID: <20060318115737.05aa167b.akpm@osdl.org>
References: <20060318044056.350a2931.akpm@osdl.org>
	<20060318151010.GA19568@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:64403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750876AbWCRUAi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Mar 2006 15:00:38 -0500
In-Reply-To: <20060318151010.GA19568@favonius>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sander@humilis.net
Cc: linux-ide@vger.kernel.org, jgarzik@favonius.humilis.net, lkml@rtr.ca

Sander <sander@humilis.net> wrote:
>
> Andrew Morton wrote (ao):
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/
> 
> Good news! This kernel lets me use eight Maxtor sata disks in raid5 over
> nForce4 and Marvell MV88SX6081.
> 

Well that sounds like progress.

> ...
>
> [   83.244314] BUG: warning at drivers/scsi/sata_mv.c:1896/__msleep()
> [   83.244362] 
> [   83.244362] Call Trace: <IRQ> <ffffffff80408d00>{__mv_phy_reset+242}
> [   83.244509]        <ffffffff804081ec>{mv_channel_reset+133} <ffffffff80409361>{mv_interrupt+565}
> [   83.244669]        <ffffffff8023bf2c>{handle_IRQ_event+41} <ffffffff8023bffa>{__do_IRQ+155}
> [   83.244828]        <ffffffff8020c13b>{do_IRQ+59} <ffffffff8020834c>{default_idle+0}
> [   83.244989]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff804eb96d>{thread_return+86}
> [   83.245172]        <ffffffff80208379>{default_idle+45} <ffffffff80208406>{cpu_idle+98}
> [   83.245329]        <ffffffff807c4018>{start_secondary+1224}

This is due to a -mm-only debug patch which generates a warning if any
kernel code does a busywait delay of more than one millisecond.

drivers/scsi/sata_mv.c:__msleep() is doing that.

> [   86.569852] ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:007f
> [   86.569856] ata5: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
> [   86.570840] BUG: warning at drivers/scsi/libata-core.c:3884/__ata_qc_complete()
> [   86.570902] 
> [   86.570903] Call Trace: <IRQ> <ffffffff80401694>{__ata_qc_complete+98}
> [   86.571046]        <ffffffff8040939e>{mv_interrupt+626} <ffffffff8023bf2c>{handle_IRQ_event+41}
> [   86.571208]        <ffffffff8023bffa>{__do_IRQ+155} <ffffffff8020c13b>{do_IRQ+59}
> [   86.571365]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff804eccd2>{__reacquire_kernel_lock+39}
> [   86.571552]        <ffffffff804eb9bd>{thread_return+166} <ffffffff804ebfe5>{schedule_timeout+138}
> [   86.571713]        <ffffffff8022a66c>{process_timeout+0} <ffffffff804eaeaf>{wait_for_completion_timeout+137}
> [   86.571878]        <ffffffff8021cc6f>{default_wake_function+0} <ffffffff80407402>{ata_exec_command+36}
> [   86.572042]        <ffffffff804038b8>{ata_exec_internal+266} <ffffffff80404473>{ata_set_mode+667}
> [   86.575479]        <ffffffff8023c4d1>{request_irq+130} <ffffffff804049f4>{ata_device_add+1163}
> [   86.575639]        <ffffffff80409a41>{mv_init_one+1547} <ffffffff8036c8b2>{pci_device_probe+221}
> [   86.575799]        <ffffffff803b999d>{driver_probe_device+82} <ffffffff803b9a52>{__driver_attach+0}
> [   86.575959]        <ffffffff803b9aa8>{__driver_attach+86} <ffffffff803b8f5a>{bus_for_each_dev+67}
> [   86.576121]        <ffffffff803b925a>{bus_add_driver+116} <ffffffff8036c918>{pci_bus_match+0}
> [   86.576279]        <ffffffff8036c418>{__pci_register_driver+85} <ffffffff8020720c>{init+455}
> [   86.576438]        <ffffffff8020a6b6>{child_rip+8} <ffffffff80207045>{init+0}
> [   86.576582]        <ffffffff8020a6ae>{child_rip+0}

This is:

void __ata_qc_complete(struct ata_queued_cmd *qc)
{
	WARN_ON(qc == NULL);	/* ata_qc_from_tag _might_ return NULL */
	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));

complaining that ATA_QCFLAG_ACTIVE is not set.

