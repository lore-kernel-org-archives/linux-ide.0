From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: IOMEGA IDE ZIP (ATAPI) drive
Date: Tue, 20 Mar 2007 18:16:35 +0800
Message-ID: <45FFB483.5080705@tw.ibm.com>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <45F7E34B.6020206@gmail.com> <45F7F90B.6070709@rtr.ca> <45F7FD13.2070907@gmail.com> <45F9C4B2.20906@rtr.ca> <45FAAA22.7060000@tw.ibm.com> <45FAB418.2070402@rtr.ca> <45FAD204.2060700@tw.ibm.com> <45FB095F.1020009@rtr.ca> <45FB5E50.4030006@tw.ibm.com> <45FEAB63.70307@rtr.ca>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:36550 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965242AbXCTKQs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Mar 2007 06:16:48 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2KAGmee029018
	for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 06:16:48 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2KAGlPn063790
	for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 04:16:47 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2KAGkEH016808
	for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 04:16:47 -0600
In-Reply-To: <45FEAB63.70307@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, Stanislav Brabec <sbrabec@novell.com>, jeff@garzik.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Mark Lord wrote:
> Albert Lee wrote:
> 
>> Mark Lord wrote:
>> ..
>>
>>> I patched the above in, and it was NEVER hit.
>>
>>
>> Do you mean no "wait for DRQ" messages at all?
>> Is the HSM violation still seen?
> 
> 
> The code you sent me to patch in was never hit.
> The "wait for DRQ" message therefore never gets output.
> The exact same set of HSM violation messages still appear.
> 
> Of course this makes perfect sense -- the HSM messages
> are not being generated in response to any command,
> but rather in response to ejecting a disk -- which I think
> causes the drive to generate an unsolicited event.
> 

Hi Mark,

Could you please apply the attached debug patch (against 2.6.21-rc4).
(BTW, the zip 100 must be connected to ata4.)
Hopefully we could have more clue about the HSM violation.

--
thanks,

albert


diff -Nrup linux-2.6.21-rc4/drivers/ata/libata-core.c linux-2.6.21-rc4-mod/drivers/ata/libata-core.c
--- linux-2.6.21-rc4/drivers/ata/libata-core.c	2007-03-16 08:20:01.000000000 +0800
+++ linux-2.6.21-rc4-mod/drivers/ata/libata-core.c	2007-03-20 18:04:15.000000000 +0800
@@ -4350,8 +4350,9 @@ int ata_hsm_move(struct ata_port *ap, st
 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
 fsm_start:
-	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
+	if (ap->print_id == 4)
+		printk(KERN_ERR "ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+		       ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -5071,8 +5072,14 @@ inline unsigned int ata_host_intr (struc
 	struct ata_eh_info *ehi = &ap->eh_info;
 	u8 status, host_stat = 0;
 
-	VPRINTK("ata%u: protocol %d task_state %d\n",
-		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
+	if (ap->print_id == 4) {
+		printk(KERN_ERR "ata%u: protocol %d task_state %d\n",
+		       ap->print_id, qc->tf.protocol, ap->hsm_task_state);
+
+		host_stat = ap->ops->bmdma_status(ap);
+		printk(KERN_ERR "ata%u: host_stat 0x%X\n", ap->print_id, host_stat);
+	}
+
 
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {
@@ -5118,11 +5125,17 @@ inline unsigned int ata_host_intr (struc
 
 	/* check altstatus */
 	status = ata_altstatus(ap);
+	if (ap->print_id == 4)
+		printk(KERN_ERR "ata%u: dev_altstatus 0x%X\n",
+		       ap->print_id, status);
 	if (status & ATA_BUSY)
 		goto idle_irq;
 
 	/* check main status, clearing INTRQ */
 	status = ata_chk_status(ap);
+	if (ap->print_id == 4)
+		printk(KERN_ERR "ata%u: dev_status 0x%X\n",
+		       ap->print_id, status);
 	if (unlikely(status & ATA_BUSY))
 		goto idle_irq;
 
diff -Nrup linux-2.6.21-rc4/drivers/ata/libata-scsi.c linux-2.6.21-rc4-mod/drivers/ata/libata-scsi.c
--- linux-2.6.21-rc4/drivers/ata/libata-scsi.c	2007-03-16 08:20:01.000000000 +0800
+++ linux-2.6.21-rc4-mod/drivers/ata/libata-scsi.c	2007-03-20 18:05:38.000000000 +0800
@@ -2773,17 +2773,17 @@ static inline ata_xlat_func_t ata_get_xl
 static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 				     struct scsi_cmnd *cmd)
 {
-#ifdef ATA_DEBUG
 	struct scsi_device *scsidev = cmd->device;
 	u8 *scsicmd = cmd->cmnd;
 
-	DPRINTK("CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
-		ap->print_id,
-		scsidev->channel, scsidev->id, scsidev->lun,
-		scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
-		scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
-		scsicmd[8]);
-#endif
+	if (ap->print_id == 4) {
+		printk(KERN_ERR "CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
+		       ap->print_id,
+		       scsidev->channel, scsidev->id, scsidev->lun,
+		       scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
+		       scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
+		       scsicmd[8]);
+	}
 }
 
 static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,

