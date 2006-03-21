From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_Re: sata_mv success on 2.6.16-rc6-mm2
Date: Tue, 21 Mar 2006 08:49:41 -0500
Message-ID: <44200475.4000903@rtr.ca>
References: <200603191613.37386.lkml@rtr.ca> <20060321102603.GA10403@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:55725 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030379AbWCUNti (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 08:49:38 -0500
In-Reply-To: <20060321102603.GA10403@favonius>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sander@humilis.net
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com

Sander wrote:
>
> [   83.489431] BUG: warning at drivers/scsi/sata_mv.c:1896/__msleep()
> [   83.489478] 
> [   83.489479] Call Trace: <IRQ> <ffffffff8040ad0b>{__mv_phy_reset+242}
> [   83.489624]        <ffffffff8040a1f7>{mv_channel_reset+133} <ffffffff8040b363>{mv_interrupt+556}
> [   83.489786]        <ffffffff8023c120>{handle_IRQ_event+41} <ffffffff8023c1ee>{__do_IRQ+155}
> [   83.489947]        <ffffffff8020c13b>{do_IRQ+59} <ffffffff8020834c>{default_idle+0}
> [   83.490108]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff804ed947>{thread_return+0}
> [   83.490290]        <ffffffff80208379>{default_idle+45} <ffffffff80208406>{cpu_idle+98}
> [   83.490446]        <ffffffff807c8018>{start_secondary+1224}
> [   87.443699] ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:007f
> [   87.443703] ata5: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
> [   87.444684] BUG: warning at drivers/scsi/libata-core.c:3884/__ata_qc_complete()
> [   87.444748] 
> [   87.444748] Call Trace: <IRQ> <ffffffff80403698>{__ata_qc_complete+98}
> [   87.444894]        <ffffffff8040b3a0>{mv_interrupt+617} <ffffffff8023c120>{handle_IRQ_event+41}
> [   87.445054]        <ffffffff8023c1ee>{__do_IRQ+155} <ffffffff8020c13b>{do_IRQ+59}
> [   87.445209]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff804eed04>{__reacquire_kernel_lock+41}
> [   87.445394]        <ffffffff804ed9ed>{thread_return+166} <ffffffff804ee015>{schedule_timeout+138}
> [   87.445552]        <ffffffff8022a860>{process_timeout+0} <ffffffff804ecedf>{wait_for_completion_timeout+137}
> [   87.445712]        <ffffffff8021ce63>{default_wake_function+0} <ffffffff80409406>{ata_exec_command+36}
> [   87.449155]        <ffffffff804058bc>{ata_exec_internal+266} <ffffffff80406477>{ata_set_mode+667}
> [   87.449316]        <ffffffff8023c6c5>{request_irq+130} <ffffffff804069f8>{ata_device_add+1163}
> [   87.449475]        <ffffffff8040ba5f>{mv_init_one+1575} <ffffffff8036cafe>{pci_device_probe+221}
> [   87.449639]        <ffffffff803bb8f1>{driver_probe_device+82} <ffffffff803bb9a6>{__driver_attach+0}
> [   87.449800]        <ffffffff803bb9fc>{__driver_attach+86} <ffffffff803baeae>{bus_for_each_dev+67}
> [   87.449960]        <ffffffff803bb1ae>{bus_add_driver+116} <ffffffff8036cb64>{pci_bus_match+0}
> [   87.450121]        <ffffffff8036c664>{__pci_register_driver+85} <ffffffff8020720c>{init+455}
> [   87.450279]        <ffffffff8020a6b6>{child_rip+8} <ffffffff80207045>{init+0}
> [   87.450423]        <ffffffff8020a6ae>{child_rip+0}
> [   87.473659] ata5: dev 0 configured for UDMA/133
> [   87.473703] scsi4 : sata_mv
> 
> It happens for every port and only during boot.
> 
> It doesn't seem to have any negative effect on the server.
> No crashes, no corruption.

Yeah, I haven't tracked that one down yet.  I don't see the traceback here,
but I do see zillions of sata_mv interrupts (sata errors) hitting the
driver before anything ever calls mv_qc_issue() for the first time.

I'm still puzzling over the best way to fix that,
perhaps by masking interrupts until mv_qc_issue() is called (?).

There's another related bug in mv_err_intr() when handling this,
in that it never clears the SATA error bits until after the first mv_qc_issue().

You could try (as a quick, though incomplete, hack):

--- sata_mv.old 2006-03-21 08:46:58.000000000 -0500
+++ sata_mv.c   2006-03-21 00:37:30.000000000 -0500
@@ -1109,7 +1109,7 @@

         edma_err_cause = readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);

-       if (EDMA_ERR_SERR & edma_err_cause)
+       //if (EDMA_ERR_SERR & edma_err_cause)
         {
                 serr = scr_read(ap, SCR_ERROR);
                 scr_write_flush(ap, SCR_ERROR, serr);

But the code really needs to check whether it's in EDMA mode first,
and then do the Right Things based on that.  Or possibly just unconditionally
cancel EDMA mode on error, and reset *everything* afterwards.  Much safer,
but time-consuming.

