From: Mark Lord <lkml@rtr.ca>
Subject: Re: sata_Re: sata_mv success on 2.6.16-rc6-mm2
Date: Sun, 19 Mar 2006 16:13:37 -0500
Message-ID: <200603191613.37386.lkml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:58801 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750910AbWCSVNm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Mar 2006 16:13:42 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, sander@humilis.net, linux-ide@vger.kernel.org, jgarzik@favonius.humilis.net

Andrew Morton wrote:
> Sander <sander@humilis.net> wrote:
..
>> [   86.569852] ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 
86:3e01 87:4063 88:007f
>> [   86.569856] ata5: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
>> [   86.570840] BUG: warning at 
drivers/scsi/libata-core.c:3884/__ata_qc_complete()
>> [   86.570902] 
>> [   86.570903] Call Trace: <IRQ> <ffffffff80401694>{__ata_qc_complete+98}
>> [   86.571046]        <ffffffff8040939e>{mv_interrupt+626} 
<ffffffff8023bf2c>{handle_IRQ_event+41}
>> [   86.571208]        <ffffffff8023bffa>{__do_IRQ+155} 
<ffffffff8020c13b>{do_IRQ+59}
>> [   86.571365]        <ffffffff80209d64>{ret_from_intr+0} <EOI> 
<ffffffff804eccd2>{__reacquire_kernel_lock+39}
>> [   86.571552]        <ffffffff804eb9bd>{thread_return+166} 
<ffffffff804ebfe5>{schedule_timeout+138}
>> [   86.571713]        <ffffffff8022a66c>{process_timeout+0} 
<ffffffff804eaeaf>{wait_for_completion_timeout+137}
>> [   86.571878]        <ffffffff8021cc6f>{default_wake_function+0} 
<ffffffff80407402>{ata_exec_command+36}
>> [   86.572042]        <ffffffff804038b8>{ata_exec_internal+266} 
<ffffffff80404473>{ata_set_mode+667}
>> [   86.575479]        <ffffffff8023c4d1>{request_irq+130} 
<ffffffff804049f4>{ata_device_add+1163}
>> [   86.575639]        <ffffffff80409a41>{mv_init_one+1547} 
<ffffffff8036c8b2>{pci_device_probe+221}
>> [   86.575799]        <ffffffff803b999d>{driver_probe_device+82} 
<ffffffff803b9a52>{__driver_attach+0}
>> [   86.575959]        <ffffffff803b9aa8>{__driver_attach+86} 
<ffffffff803b8f5a>{bus_for_each_dev+67}
>> [   86.576121]        <ffffffff803b925a>{bus_add_driver+116} 
<ffffffff8036c918>{pci_bus_match+0}
>> [   86.576279]        <ffffffff8036c418>{__pci_register_driver+85} 
<ffffffff8020720c>{init+455}
>> [   86.576438]        <ffffffff8020a6b6>{child_rip+8} 
<ffffffff80207045>{init+0}
>> [   86.576582]        <ffffffff8020a6ae>{child_rip+0}
> 
> This is:
> 
> void __ata_qc_complete(struct ata_queued_cmd *qc)
> {
> 	WARN_ON(qc == NULL);	/* ata_qc_from_tag _might_ return NULL */
> 	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
> 
> complaining that ATA_QCFLAG_ACTIVE is not set.

I am also working on stability for sata_mv now, and here is a patch
that *may* fix the above error.

Signed-Off-By Mark Lord <mlord@pobox.com>

--- sata_mv.c.alignment	2006-03-19 15:14:29.000000000 -0500
+++ sata_mv.c	2006-03-19 15:12:49.000000000 -0500
@@ -1180,7 +1180,6 @@
 	u32 hc_irq_cause;
 	int shift, port, port0, hard_port, handled;
 	unsigned int err_mask;
-	u8 ata_status = 0;
 
 	if (hc == 0) {
 		port0 = 0;
@@ -1198,6 +1197,7 @@
 		hc,relevant,hc_irq_cause);
 
 	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
+		u8 ata_status = 0;
 		ap = host_set->ports[port];
 		hard_port = port & MV_PORT_MASK;	/* range 0-3 */
 		handled = 0;	/* ensure ata_status is set if handled++ */
